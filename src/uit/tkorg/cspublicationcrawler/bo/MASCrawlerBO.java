package uit.tkorg.cspublicationcrawler.bo;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Hashtable;
import org.apache.commons.validator.UrlValidator;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.dom4j.Document;
import uit.tkorg.cspublicationcrawler.constant.MASPatterns;
import uit.tkorg.cspublicationcrawler.utility.CommonHTMLProcessor;
import uit.tkorg.cspublicationcrawler.utility.CommonStringUtility;
import uit.tkorg.cspublicationcrawler.utility.CommonURLQuery;
import uit.tkorg.cspublicationcrawler.dbaccess.*;
import uit.tkorg.cspublicationcrawler.dto.*;
import uit.tkorg.cspublicationcrawler.bo.*;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;
import uit.tkorg.cspublicationcrawler.constant.CSPublicationCrawlerConst;
import uit.tkorg.cspublicationcrawler.utility.EmbeddedBrowser;

/**
 * @author Nghiep
 * @author Loc Do
 * This class contains main method to crawl objects from MAS website.
 */

public class MASCrawlerBO extends Thread {

    /**
     * crawlAuthorBased: crawl all data for a list of authors in DB. Special case: some organizations in HCMC.
     * This crawling approach can not get information about subdomain of publication.
     * @throws Exception 
     */
    public void crawlAuthorBased() throws Exception {
        OrgMapper mapperOrg = new OrgMapper();
        AuthorMapper mapperAuthor = new AuthorMapper();
        AuthorInstanceMapper mapperAuthorInstance = new AuthorInstanceMapper();
        
        ArrayList<OrgDTO> orgList = null;
        ArrayList<AuthorDTO> authorList = null;
        
        try {
            CSPublicationCrawlerLogger.logger.warning("BEGIN");
            orgList = mapperOrg.getOrgList(0, 10);
            for (int i = 0; i < orgList.size(); i++) {
                OrgDTO orgDTO = orgList.get(i);
                CSPublicationCrawlerLogger.logger.warning((i + 1) + ". ORG: " + orgDTO.getOrgName());
                authorList = mapperAuthor.getAuthorListByOrgId(orgDTO.getIdOrg());
                for (int j = 0; j < authorList.size(); j++) {
                    AuthorDTO authorDTO = authorList.get(j);
                    CSPublicationCrawlerLogger.logger.warning((j + 1) + ". AUTHOR: " + authorDTO.getAuthorName());
                    String authorSearchResult = crawlMASAuthorSearchResult(authorDTO.getAuthorName());

                    // Get suggested author url.
                    ArrayList lstSuggestedAuthorURL = MASPageAnalyzeBO.getListSuggestedAuthorURL(authorSearchResult);
                    
                    // Go through suggested author url list.
                    for (int k = 0; k < lstSuggestedAuthorURL.size(); k++) {
                        String suggestedAuthorURL = (String) lstSuggestedAuthorURL.get(k);
                        
                        // Get and save author instance list.
                        boolean maldata = false;
                        do {
                            int idAuthorInstance = mapperAuthorInstance.isExisted(suggestedAuthorURL);
                            if (idAuthorInstance == -1) {
                                AuthorDTO dtoAuthor = MASPageAnalyzeBO.generateAuthorDTOFromHTMLContent(suggestedAuthorURL);
                                AuthorInstanceDTO dtoAuthorInstance = new AuthorInstanceDTO();
                                dtoAuthorInstance.setIdAuthor(authorDTO.getIdAuthor());
                                dtoAuthorInstance.setAuthorInstanceName(dtoAuthor.getAuthorName());
                                dtoAuthorInstance.setEmailAddress(dtoAuthor.getEmailAddress());
                                dtoAuthorInstance.setImage(dtoAuthor.getImage());
                                dtoAuthorInstance.setWebsite(dtoAuthor.getWebsite());
                                dtoAuthorInstance.setUrl(dtoAuthor.getUrl());
                                dtoAuthorInstance.setH_index(dtoAuthor.getH_index());
                                dtoAuthorInstance.setG_index(dtoAuthor.getG_index());
                                dtoAuthorInstance.setIdOrg(dtoAuthor.getIdOrg());
                                // Improve robustness to deal with bad data source.
                                // Check if dtoAuthorInstance is valid.
                                if (dtoAuthorInstance.getAuthorInstanceName() != null) {
                                    // Insert new Author.
                                    idAuthorInstance = mapperAuthorInstance.insertNewAuthorInstance(dtoAuthorInstance);
                                }
                            }
                            if (idAuthorInstance == -1)
                                maldata = true;
                        } while (maldata);
                    }
                }
            }
        }
        catch(Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
            throw ex;
        }
        finally {
            mapperOrg.closeConnection();
            mapperAuthor.closeConnection();
            mapperAuthorInstance.closeConnection();
        }

    }
    
    /**
     * updateDataAuthorBased
     * @throws Exception 
     */
    public void updateDataAuthorBased() throws Exception {
        AuthorInstanceMapper mapperAuthorInstance = new AuthorInstanceMapper();
        PaperMapper mapperPaper = new PaperMapper();
        PaperPaperMapper mapperPaperPaper = new PaperPaperMapper();
        KeywordMapper mapperKeyword = new KeywordMapper();
        PaperKeywordMapper mapperPaperKeyword = new PaperKeywordMapper();
        AuthorMapper mapperAuthor = new AuthorMapper();
        AuthorPaperMapper mapperAuthorPaper = new AuthorPaperMapper();
        
        try {
            ArrayList<AuthorInstanceDTO> listAuthorInstance = mapperAuthorInstance.getAuthorInstanceList();
            for (int i = 0; i < listAuthorInstance.size(); i++) {
                // Get and save Pubblication url list.
                String strPublicationListURL = MASPatterns.MAS_PUBLICATION_OF_AUTHOR_QUERY_PATTERN + listAuthorInstance.get(i).getUrl().substring(8);
                if ((strPublicationListURL != null) && (strPublicationListURL.compareTo("") != 0)) {
                    String publicationListHTMLContent = crawlHTMLContentMAS(strPublicationListURL);
                    if (publicationListHTMLContent != null) {
                        int noPub = MASPageAnalyzeBO.getNumberCitations(publicationListHTMLContent);
                        int startPublication = 0, endPublication = 0;
                        while (startPublication < noPub) {
                            endPublication = (startPublication + CSPublicationCrawlerConst.ITEM_LIST_SIZE < noPub) ? (startPublication + CSPublicationCrawlerConst.ITEM_LIST_SIZE) : noPub;
                            startPublication++;

                            publicationListHTMLContent = crawlHTMLContentMAS(strPublicationListURL, startPublication, endPublication);
                            ArrayList lstPublicationURL = MASPageAnalyzeBO.getListCitationURL(publicationListHTMLContent);
                            if (lstPublicationURL.size() == 0) { // In some cases, such as there is only 1 publication, MAS does not support start and end.
                                publicationListHTMLContent = crawlHTMLContentMAS(strPublicationListURL);
                                lstPublicationURL = MASPageAnalyzeBO.getListCitationURL(publicationListHTMLContent);
                            }
                            if (lstPublicationURL != null) {
                                for(int p = 0; p < lstPublicationURL.size(); p++) {
                                    String strPublicationURL = (String) lstPublicationURL.get(p);
                                    int idPaper = mapperPaper.isExisted(strPublicationURL);
                                    if (idPaper == -1) {
                                        PaperDTO dtoPaper = new PaperDTO();
                                        dtoPaper.setUrl(strPublicationURL);
                                        dtoPaper.setIdJournal(-1);
                                        dtoPaper.setIdConference(-1);
                                        dtoPaper.setIdMagazine(-1);
                                        dtoPaper.setVersion(-1);
                                        dtoPaper.setYear(-1);
                                        mapperPaper.insertObj(dtoPaper);
                                    }
                                }
                            }
                            startPublication = endPublication;
                        }
                    }
                }
            }
            
            ArrayList listPublicationURL = mapperPaper.getPublicationUrlList();
            // Xét mỗi pub's url, kiểm tra, cập nhật.
            for(int l = 0; l < listPublicationURL.size(); l++) {
                String strPubURL = (String) listPublicationURL.get(l);
                CSPublicationCrawlerLogger.logger.warning((l + 1) + ". " + strPubURL);
                int pubExist[] = mapperPaper.checkExistingStatusOfPublication(strPubURL);
                int idPaper = pubExist[1];
                if (pubExist[0] == 2) { 
                    // All metadata of publication existed. No need to update anything.
                }
                else {
                    // Cập nhật thông tin cơ bản của 1 publication
                    // Trong hàm này đồng thời cập nhật thông tin cho các bảng mà paper trực tiếp chỉ đến nếu cần.
                    String strPubHTMLContent = crawlHTMLContentMAS(strPubURL);
                    PaperDTO dtoPaper = MASPageAnalyzeBO.generatePaperDTOFromHTMLContent(strPubHTMLContent, idPaper, strPubURL);

                    // Improve robustness to deal with bad data source.
                    if (dtoPaper.getTitle() != null) {
                        String title = dtoPaper.getTitle(); //For later update
                        dtoPaper.setTitle(null); //Firstly, set title null because error may happen.
                        if (pubExist[0] == 0) {
                            // Publication does not exist in DB. Insert a new publication.
                            idPaper = mapperPaper.insertObj(dtoPaper);
                        }
                        else {
                            // Only PublicationURL existed in DB. Update paper with full data.
                            mapperPaper.updateObj(dtoPaper);
                        }

                        // Update keywords of publication
                        ArrayList lstKeywordURL = MASPageAnalyzeBO.getListKeywordURL(strPubHTMLContent);
                        if (lstKeywordURL != null && lstKeywordURL.size() > 0) {
                            for (int m = 0; m < lstKeywordURL.size(); m++ ) {
                                String strKeywordURL = (String) lstKeywordURL.get(m);
                                if ((strKeywordURL != null) && (strKeywordURL.compareTo("") != 0)) {
                                    int idKeyword = mapperKeyword.isExisted(strKeywordURL);
                                    if (idKeyword == -1) {
                                        KeywordDTO dtoKeyword = MASPageAnalyzeBO.generateKeywordDTOFromHTMLContent(strKeywordURL);
                                        // Improve robustness to deal with bad data source.
                                        if (dtoKeyword.getKeyword() != null) {
                                            // Insert new keyword.
                                            idKeyword = mapperKeyword.insertObj(dtoKeyword);
                                        }
                                    }
                                    PaperKeywordDTO dtoPaperKeyword = new PaperKeywordDTO(idPaper, idKeyword);
                                    if (mapperPaperKeyword.isExisted(dtoPaperKeyword) == -1) {
                                        // Insert link Paper-Keyword.
                                        mapperPaperKeyword.insertObj(dtoPaperKeyword);
                                    }
                                }
                            }
                        }

                        // Update authors of publication
                        ArrayList lstAuthorURL = MASPageAnalyzeBO.getListAuthorURL(strPubHTMLContent);
                        if (lstAuthorURL != null && lstAuthorURL.size() > 0) {
                            for (int n = 0; n < lstAuthorURL.size(); n++) {
                                String strAuthorURL = (String) lstAuthorURL.get(n);
                                if ((strAuthorURL != null) && (strAuthorURL.compareTo("") != 0)) {
                                    int idAuthor = mapperAuthorInstance.getIdAuthorByUrl(strAuthorURL);
                                    if (idAuthor != -1) {
                                        AuthorPaperDTO dtoAuthorPaper = new AuthorPaperDTO(idAuthor, idPaper);
                                        if (mapperAuthorPaper.isExisted(dtoAuthorPaper) == -1) {
                                            // Insert link Author-Paper.
                                            mapperAuthorPaper.insertObj(dtoAuthorPaper);
                                        }
                                    }
                                    else {
                                        boolean maldata = false;
                                        do {
                                            idAuthor = mapperAuthor.isExisted(strAuthorURL);
                                            if (idAuthor == -1) {
                                                AuthorDTO dtoAuthor = MASPageAnalyzeBO.generateAuthorDTOFromHTMLContent(strAuthorURL);
                                                // Improve robustness to deal with bad data source.
                                                // Check if dtoAuthor is valid.
                                                if (dtoAuthor.getAuthorName() != null) {
                                                    // Insert new Author.
                                                    idAuthor = mapperAuthor.insertObj(dtoAuthor);
                                                }
                                            }
                                            if (idAuthor != -1) {
                                                AuthorPaperDTO dtoAuthorPaper = new AuthorPaperDTO(idAuthor, idPaper);
                                                if (mapperAuthorPaper.isExisted(dtoAuthorPaper) == -1) {
                                                    // Insert link Author-Paper.
                                                    mapperAuthorPaper.insertObj(dtoAuthorPaper);
                                                }
                                            }
                                            else 
                                                maldata = true;
                                        } while (maldata);
                                    }
                                }
                            }
                        }

                        // Update citation of publication
                        String strCitationListURL = MASPageAnalyzeBO.getCitationListOfPub(strPubHTMLContent);
                        if ((strCitationListURL != null) && (strCitationListURL.compareTo("") != 0)) {
                            String citationListHTMLContent = crawlHTMLContentMAS(strCitationListURL);
                            if (citationListHTMLContent != null) {
                                int noCitation = MASPageAnalyzeBO.getNumberCitations(citationListHTMLContent);
                                int startCitation = 0, endCitation = 0, citationCount = 0;
                                while (startCitation < noCitation) {
                                    endCitation = (startCitation + CSPublicationCrawlerConst.ITEM_LIST_SIZE < noCitation) ? (startCitation + CSPublicationCrawlerConst.ITEM_LIST_SIZE) : noCitation;
                                    startCitation++;

                                    citationListHTMLContent = crawlHTMLContentMAS(strCitationListURL, startCitation, endCitation);
                                    ArrayList lstCitationURL = MASPageAnalyzeBO.getListCitationURL(citationListHTMLContent);
                                    if (lstCitationURL.size() == 0) { // In some cases, such as there is only 1 publication, MAS does not support start and end.
                                        citationListHTMLContent = crawlHTMLContentMAS(strCitationListURL);
                                        lstCitationURL = MASPageAnalyzeBO.getListCitationURL(citationListHTMLContent);
                                    }
                                    if (lstCitationURL != null) {
                                        for(int p = 0; p < lstCitationURL.size(); p++) {   
                                            citationCount++;
                                            String strCitationURL = (String) lstCitationURL.get(p);
                                            int idCitation = mapperPaper.isExisted(strCitationURL);
                                            if (idCitation == -1) {
                                                PaperDTO dtoPaperCitation = new PaperDTO();
                                                dtoPaperCitation.setUrl(strCitationURL);
                                                dtoPaperCitation.setIdJournal(-1);
                                                dtoPaperCitation.setIdConference(-1);
                                                dtoPaperCitation.setIdMagazine(-1);
                                                dtoPaperCitation.setVersion(-1);
                                                dtoPaperCitation.setYear(-1);
                                                idCitation = mapperPaper.insertObj(dtoPaperCitation);
                                            }

                                            PaperPaperDTO dtoPaperPaper = new PaperPaperDTO(idCitation, idPaper, null);
                                            if (mapperPaperPaper.isExisted(dtoPaperPaper) == -1) {
                                                mapperPaperPaper.insertObj(dtoPaperPaper);
                                            }
                                        }
                                    }
                                    startCitation = endCitation;
                                }
                            }
                        }

                        //Update paper, set title. Finish update this paper.
                        dtoPaper.setIdPaper(idPaper);
                        dtoPaper.setTitle(title);
                        mapperPaper.updateObj(dtoPaper);
                    }
                }
            }
        }
        catch(Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
            throw ex;
        }
        finally {
            mapperAuthorInstance.closeConnection();
            mapperPaperPaper.closeConnection();
            mapperPaper.closeConnection();
            mapperKeyword.closeConnection();
            mapperPaperKeyword.closeConnection();
            mapperAuthor.closeConnection();
            mapperAuthorPaper.closeConnection();
        }
    }

    /**
     * main crawl method to call other method
     * @param subdomain
     * @return no return
     */
    public void crawl(String subdomain, int start, int end) throws Exception {
        AuthorMapper mapperAuthor = new AuthorMapper();
        AuthorPaperMapper mapperAuthorPaper = new AuthorPaperMapper();
        KeywordMapper mapperKeyword = new KeywordMapper();
        PaperMapper mapperPaper = new PaperMapper();
        PaperKeywordMapper mapperPaperKeyword = new PaperKeywordMapper();
        PaperPaperMapper mapperPaperPaper = new PaperPaperMapper();
        SubdomainMapper mapperSubdomain = new SubdomainMapper(); 
        SubdomainPaperMapper mapperSubdomainPaper = new SubdomainPaperMapper();
        try {
            int idSubdomain = mapperSubdomain.isExisted(subdomain);
            if (idSubdomain == -1) {
                System.out.println("SUBDOMAIN-ID IS NOT EXIST IN DATABASE");
                CSPublicationCrawlerLogger.logger.warning("SUBDOMAIN-ID IS NOT EXIST IN DATABASE");
                return;
            }
                
            String strPubListContent = crawlPubHTMLContentForSubdomain(idSubdomain);
            int noPub = MASPageAnalyzeBO.getTotalNumberOfPublications(strPubListContent); //tổng số pub, xét cho 1 subdomain nhất định        
            System.out.println(" TOTAL NUMBER OF PUBLICATION IS: " + noPub);
            CSPublicationCrawlerLogger.logger.warning(" TOTAL NUMBER OF PUBLICATION IS: " + noPub);
            if (end < noPub && end != 0)
                noPub = end;
            System.out.println(" NUMBER OF PUBLICATION WILL BE CRAWLED IS: " + (start + 1) + " TO " + noPub);
            CSPublicationCrawlerLogger.logger.warning(" NUMBER OF PUBLICATION WILL BE CRAWLED IS: " + (start + 1) + " TO " + noPub);
            
            //bắt đầu lấy tất cả các pub, theo nhóm CSPublicationCrawlerConst.ITEM_LIST_SIZE, về kiểm tra và cập nhật
            while(start < noPub) {
                end = (start + CSPublicationCrawlerConst.ITEM_LIST_SIZE < noPub) ? (start + CSPublicationCrawlerConst.ITEM_LIST_SIZE) : noPub; 
                start++;
//                System.out.println("************************************************************ ");
//                System.out.println(" START: " + start + "; " + "END: " + end);
//                System.out.println("************************************************************ ");                
                CSPublicationCrawlerLogger.logger.info("************************************************************ ");
                CSPublicationCrawlerLogger.logger.warning(" START: " + start + "; " + "END: " + end);
                CSPublicationCrawlerLogger.logger.info("************************************************************ ");
                strPubListContent = crawlPubHTMLContentForSubdomain(idSubdomain, start, end);    
                ArrayList listPublicationURL = MASPageAnalyzeBO.getListOfPublicationURL(strPubListContent);                

                // Xét mỗi pub's url, kiểm tra, cập nhật.
                for(int i=0; i<listPublicationURL.size(); i++) {
                    String strPubURL = (String) listPublicationURL.get(i); 
//                    System.out.println("************************************************************ ");
//                    System.out.println((start + i) + ". " + strPubURL);
//                    System.out.println("************************************************************ ");
                    CSPublicationCrawlerLogger.logger.info("************************************************************ ");
                    CSPublicationCrawlerLogger.logger.warning((start + i) + ". " + strPubURL);
                    CSPublicationCrawlerLogger.logger.info("************************************************************ ");
                    int pubExist[] = mapperPaper.checkExistingStatusOfPublication(strPubURL);
                    int idPaper = pubExist[1];
                    if (pubExist[0] == 2) { 
                        // all metadata of publication existed. Update SubDomain for this publication
//                        System.out.println("All metadata of this publication existed. Update Infor for PaperSubDomain");
                        CSPublicationCrawlerLogger.logger.info("All metadata of this publication existed. Update Infor for PaperSubDomain");
                        SubdomainPaperDTO dtoSubdomainPaper = new SubdomainPaperDTO(idPaper, idSubdomain);
                        if (mapperSubdomainPaper.isExisted(dtoSubdomainPaper) == -1) {
                            mapperSubdomainPaper.insertObj(dtoSubdomainPaper);
//                            System.out.println("PaperSubDomain is updated");
                        }
                        else {
//                            System.out.println("PaperSubDomain existed. No need to update");
                        }
                    }
                    else {
                        // Cập nhật thông tin cơ bản của 1 publication
                        // Trong hàm này đồng thời cập nhật thông tin cho các bảng mà paper trực tiếp chỉ đến nếu cần.
                        String strPubHTMLContent = crawlHTMLContentMAS(strPubURL);
                        PaperDTO dtoPaper = MASPageAnalyzeBO.generatePaperDTOFromHTMLContent(strPubHTMLContent, idPaper, strPubURL);
                        
                        // Improve robustness to deal with bad data source.
                        if (dtoPaper.getTitle() != null) {
                            String title = dtoPaper.getTitle(); //For later update
                            dtoPaper.setTitle(null); //Firstly, set title null because error may happen.
                            if (pubExist[0] == 0) {
                                // Publication does not exist in DB
//                                System.out.println("Insert a new publication");
                                CSPublicationCrawlerLogger.logger.info("Insert a new publication");
                                idPaper = mapperPaper.insertObj(dtoPaper);
                            }
                            else {
                                // Only PublicationURL existed in DB
//                                System.out.println("Only PublicationURL existed in DB. Update other metadata for this publication");
                                CSPublicationCrawlerLogger.logger.info("Only PublicationURL existed in DB. Update other metadata for this publication");
                                mapperPaper.updateObj(dtoPaper);
                            }

                            // Update subdomain of publication
//                            System.out.println("BEGIN updating subdomain of this publication");
                            CSPublicationCrawlerLogger.logger.info("BEGIN updating subdomain of this publication");
                            SubdomainPaperDTO dtoSubdomainPaper = new SubdomainPaperDTO(idPaper, idSubdomain);
                            if (mapperSubdomainPaper.isExisted(dtoSubdomainPaper) == -1) {
                                mapperSubdomainPaper.insertObj(dtoSubdomainPaper);
                            }
//                            System.out.println("END updating subdomain of this publication");
                            CSPublicationCrawlerLogger.logger.info("END updating subdomain of this publication");

                            // Update keywords of publication
//                            System.out.println("BEGIN updating keywords of this publication");
                            CSPublicationCrawlerLogger.logger.info("BEGIN updating keywords of this publication");
                            ArrayList lstKeywordURL = MASPageAnalyzeBO.getListKeywordURL(strPubHTMLContent);
                            if (lstKeywordURL != null && lstKeywordURL.size() > 0) {
                                for (int j=0; j<lstKeywordURL.size(); j++ ) {
                                    String strKeywordURL = (String) lstKeywordURL.get(j);
                                    if ((strKeywordURL != null) && (strKeywordURL.compareTo("") != 0)) {
                                        int idKeyword = mapperKeyword.isExisted(strKeywordURL);
                                        if (idKeyword == -1) {
                                            KeywordDTO dtoKeyword = MASPageAnalyzeBO.generateKeywordDTOFromHTMLContent(strKeywordURL);
                                            // Improve robustness to deal with bad data source.
                                            if (dtoKeyword.getKeyword() != null) {
                                                idKeyword = mapperKeyword.insertObj(dtoKeyword);
//                                                System.out.println("Insert new keyword:" + dtoKeyword.getKeyword());
                                                CSPublicationCrawlerLogger.logger.info("Insert new keyword:" + dtoKeyword.getKeyword());
                                            }
                                        }
                                        PaperKeywordDTO dtoPaperKeyword = new PaperKeywordDTO(idPaper, idKeyword);
                                        if (mapperPaperKeyword.isExisted(dtoPaperKeyword) == -1) {
//                                            System.out.println("Insert link between this keyword and this paper:" + dtoPaperKeyword.getIdKeyword());
                                            CSPublicationCrawlerLogger.logger.info("Insert link between this keyword and this paper:" + dtoPaperKeyword.getIdKeyword());
                                            mapperPaperKeyword.insertObj(dtoPaperKeyword);
                                        }
                                    }
                                }
                            }
//                            System.out.println("END updating keywords of this publication");
                            CSPublicationCrawlerLogger.logger.info("END updating keywords of this publication");

                            // Update authors of publication
//                            System.out.println("BEGIN updating authors of this publication");
                            CSPublicationCrawlerLogger.logger.info("BEGIN updating authors of this publication");
                            ArrayList lstAuthorURL = MASPageAnalyzeBO.getListAuthorURL(strPubHTMLContent);
                            if (lstAuthorURL != null && lstAuthorURL.size() > 0) {
                                for (int j=0; j<lstAuthorURL.size(); j++) {
                                    String strAuthorURL = (String) lstAuthorURL.get(j);
                                    if ((strAuthorURL != null) && (strAuthorURL.compareTo("") != 0)) {
                                        boolean maldata = false;
                                        do {
                                            int idAuthor = mapperAuthor.isExisted(strAuthorURL);
                                            if (idAuthor == -1) {
                                                AuthorDTO dtoAuthor = MASPageAnalyzeBO.generateAuthorDTOFromHTMLContent(strAuthorURL);
                                                // Check if dtoAuthor is valid.
                                                // Improve robustness to deal with bad data source.
                                                if (dtoAuthor.getAuthorName() != null) {
                                                    idAuthor = mapperAuthor.insertObj(dtoAuthor);
    //                                                System.out.println("Insert new author:" + dtoAuthor.getAuthorName());
                                                    CSPublicationCrawlerLogger.logger.info("Insert new author:" + dtoAuthor.getAuthorName());
                                                }
                                            }
                                            if (idAuthor != -1) {
                                                AuthorPaperDTO dtoAuthorPaper = new AuthorPaperDTO(idAuthor, idPaper);
                                                if (mapperAuthorPaper.isExisted(dtoAuthorPaper) == -1) {
                                                    mapperAuthorPaper.insertObj(dtoAuthorPaper);
        //                                            System.out.println("Insert link between this author and this paper:" + dtoAuthorPaper.getIdAuthor());
                                                    CSPublicationCrawlerLogger.logger.info("Insert link between this author and this paper:" + dtoAuthorPaper.getIdAuthor());
                                                }
                                            }
                                            else 
                                                maldata = true;
                                        } while(maldata);
                                    }
                                }
                            }
//                            System.out.println("END updating authors of this publication");
                            CSPublicationCrawlerLogger.logger.info("END updating authors of this publication");

                            // Update citation of publication
//                            System.out.println("BEGIN updating citation of this publication");
                            CSPublicationCrawlerLogger.logger.info("BEGIN updating citation of this publication");
                            String strCitationListURL = MASPageAnalyzeBO.getCitationListOfPub(strPubHTMLContent);
                            if ((strCitationListURL != null) && (strCitationListURL.compareTo("") != 0)) {
                                String citationListHTMLContent = crawlHTMLContentMAS(strCitationListURL);
                                if (citationListHTMLContent != null) {
                                    int noCitation = MASPageAnalyzeBO.getNumberCitations(citationListHTMLContent);
                                    int startCitation = 0, endCitation = 0, citationCount = 0;
                                    while (startCitation < noCitation) {
                                        endCitation = (startCitation + CSPublicationCrawlerConst.ITEM_LIST_SIZE < noCitation) ? (startCitation + CSPublicationCrawlerConst.ITEM_LIST_SIZE) : noCitation;
                                        startCitation++;

                                        citationListHTMLContent = crawlHTMLContentMAS(strCitationListURL, startCitation, endCitation);
                                        ArrayList lstCitationURL = MASPageAnalyzeBO.getListCitationURL(citationListHTMLContent);
                                        if (lstCitationURL.size() == 0) { // In some cases, such as there is only 1 publication, MAS does not support start and end.
                                            citationListHTMLContent = crawlHTMLContentMAS(strCitationListURL);
                                            lstCitationURL = MASPageAnalyzeBO.getListCitationURL(citationListHTMLContent);
                                        }
                                        if (lstCitationURL != null) {
                                            for(int j=0; j<lstCitationURL.size(); j++) {   
                                                citationCount++;
                                                String strCitationURL = (String) lstCitationURL.get(j);
                                                int idCitation = mapperPaper.isExisted(strCitationURL);
                                                if (idCitation == -1) {
                                                    PaperDTO dtoPaperCitation = new PaperDTO();
                                                    dtoPaperCitation.setUrl(strCitationURL);
                                                    dtoPaperCitation.setIdJournal(-1);
                                                    dtoPaperCitation.setIdConference(-1);
                                                    dtoPaperCitation.setIdMagazine(-1);
                                                    dtoPaperCitation.setVersion(-1);
                                                    dtoPaperCitation.setYear(-1);
                                                    idCitation = mapperPaper.insertObj(dtoPaperCitation);
//                                                    System.out.println(citationCount + "." + "Inserted citation:" + strCitationURL);
                                                    CSPublicationCrawlerLogger.logger.info(citationCount + "." + "Inserted citation:" + strCitationURL);
                                                }

                                                PaperPaperDTO dtoPaperPaper = new PaperPaperDTO(idCitation, idPaper, null);
                                                if (mapperPaperPaper.isExisted(dtoPaperPaper) == -1) {
                                                    mapperPaperPaper.insertObj(dtoPaperPaper);
//                                                    System.out.println(citationCount + "." + "CitationURL existed. Inserted CitationLink:" + strCitationURL);
                                                    CSPublicationCrawlerLogger.logger.info(citationCount + "." + "CitationURL existed. Inserted CitationLink:" + strCitationURL);
                                                }
                                            }
                                        }
                                        startCitation = endCitation;
                                    }
                                }
                            }
//                            System.out.println("END updating citation of this publication");
                            CSPublicationCrawlerLogger.logger.info("END updating citation of this publication");

                            // Update citation context of publication
                            /**
                             * Preserved for later development
                             * 
                            System.out.println("BEGIN updating citation context of this publication");
                            String strCitationContextListURL = MASPageAnalyzeBO.getCitationConTextListOfPub(strPubHTMLContent);
                            if ((strCitationContextListURL != null) && (strCitationContextListURL.compareTo("") != 0)) {
                                String strCitationContextListContent = crawlHTMLContentMAS(strCitationContextListURL);
                                int noCitationContext = MASPageAnalyzeBO.getNumberCitationContexts(strCitationContextListContent);
                                int startCitationContext = 0, endCitationContext = 0;
                                while (startCitationContext < noCitationContext) {
                                    endCitationContext = (startCitationContext + CSPublicationCrawlerConst.ITEM_LIST_SIZE < noCitationContext) ? (startCitationContext + CSPublicationCrawlerConst.ITEM_LIST_SIZE) : noCitationContext;
                                    startCitationContext++;
                                    strCitationContextListContent = crawlHTMLContentMAS(strCitationContextListURL, startCitationContext, endCitationContext);
                                    ArrayList lstCitationContextURL = MASPageAnalyzeBO.getListCitationContextURL(strCitationContextListContent);
                                    ArrayList lstCitationContextContent = MASPageAnalyzeBO.getListCitationContextContent(strCitationContextListContent);
                                    for(int j = 0; j < lstCitationContextURL.size(); j++) {   
                                        String strCitationContextURL = (String) lstCitationContextURL.get(j);
                                        String strCitationContextContent = (String) lstCitationContextContent.get(j);
                                        System.out.println("strCitationContextContent: " + strCitationContextContent);
                                        int idCitation = mapperPaper.isExisted(strCitationContextURL);
                                        if (idCitation != -1) {
                                            System.out.println("Citation exists: " + idCitation);
                                            PaperPaperDTO dtoPaperPaper = new PaperPaperDTO(idCitation, idPaper, strCitationContextContent);
                                            mapperPaperPaper.updateObj(dtoPaperPaper);
                                            System.out.println("Update citation context: " + idCitation + " - " + idPaper);
                                        }
                                    }
                                    startCitationContext = endCitationContext;
                                }
                            }
                            System.out.println("END updating citation context of this publication");
                            * *
                            */
                            
                            //Update paper, set title. Finish update this paper.
                            dtoPaper.setIdPaper(idPaper);
                            dtoPaper.setTitle(title);
                            mapperPaper.updateObj(dtoPaper);
                        }
                    }
                }

                start = end;
            }
        }
        catch(Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
            throw ex;
        }
        finally {
            mapperPaper.closeConnection();
            mapperSubdomain.closeConnection();
            mapperSubdomainPaper.closeConnection();
            mapperKeyword.closeConnection();
            mapperAuthor.closeConnection();
            mapperPaperKeyword.closeConnection();
            mapperAuthorPaper.closeConnection();
            mapperPaperPaper.closeConnection();
        }
    }

    /**
     * get HTML-content of the returned page
     * @param subdomain
     * @return htmlContent
     */
    public String crawlPubHTMLContentForSubdomain(int idSubdomain) throws Exception {
        String htmlContent = null;
        try {
            String urlString = MASPatterns.MAS_PUBLICATION_LIST_QUERY + idSubdomain;
            htmlContent = crawlGeneralHTMLContent(urlString);
        }
        catch (Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
        }
        
        return htmlContent;
    }
    
    /**
     * submit query to get publication list in a subdomain with range specified.
     * @param subdomain
     * @return htmlContent
     */
    public String crawlPubHTMLContentForSubdomain(int idSubdomain, int start, int end) throws Exception {
        String htmlContent = null;
        try {
            String urlString = MASPatterns.MAS_PUBLICATION_LIST_QUERY + idSubdomain
                    + MASPatterns.AND
                    + MASPatterns.START + "=" + start
                    + MASPatterns.AND
                    + MASPatterns.END + "=" + end;
            
            htmlContent = crawlGeneralHTMLContent(urlString);
        }
        catch (Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
        }
        
        return htmlContent;
    }
    
    /**
     * crawlHTMLContentMAS
     * @param strURL
     * @return 
     */
    public String crawlHTMLContentMAS(String strURL) throws Exception {
        String htmlContent = null;
        try {
            String urlString = MASPatterns.MAS_HOMEPAGE_URL + strURL;
            htmlContent = crawlGeneralHTMLContent(urlString);
        }
        catch (Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
        }
        
        return htmlContent;
    }
    
    /**
     * crawlHTMLContentMAS
     * @param strURL
     * @param start
     * @param end
     * @return 
     */
    public String crawlHTMLContentMAS(String strURL, int start, int end) throws Exception {
        String htmlContent = null;  
        try {
            String urlString = MASPatterns.MAS_HOMEPAGE_URL + strURL
                    + MASPatterns.AND
                    + MASPatterns.START + "=" + start
                    + MASPatterns.AND
                    + MASPatterns.END + "=" + end;
             
            htmlContent = crawlGeneralHTMLContent(urlString);
        }
        catch (Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
        }
        
        return htmlContent;
    }
    
    /**
     * crawlGeneralHTMLContent
     * @param strURL
     * @return
     * @throws Exception 
     */
    public String crawlGeneralHTMLContent(String strURL) throws Exception {
        String htmlContent = null;
        try {
            UrlValidator urlValidator = new UrlValidator();
            if (urlValidator.isValid(strURL)) {
                URL urlSubmit = new URL(strURL);
                htmlContent = CommonURLQuery.getHTMLPageContentWithUTF8(urlSubmit);
                // Improve robustness to deal with internet connection error.
                // Check for sure that htmlContent has been got, and retry MAX_RETRY_TIMES time.
                for (int i = 0; i < CSPublicationCrawlerConst.MAX_RETRY_TIMES; i++) {
                    if (htmlContent == null)
                        htmlContent = CommonURLQuery.getHTMLPageContentWithUTF8(urlSubmit);
                }
            }
        }
        catch (Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
        }
        
        return htmlContent;
    }
    
    /**
     * crawlMASAuthorSearchResult
     * @param authorName
     * @return 
     */
    public String crawlMASAuthorSearchResult(String authorName) {
        String htmlContent = null;
        try {
            authorName = URLEncoder.encode(authorName, "utf-8").replace("+", "%20");
            String urlSearchAuthor = MASPatterns.MAS_HOMEPAGE_URL 
                    + MASPatterns.MAS_SEARCH_AUTHOR_PRE 
                    + authorName 
                    + MASPatterns.MAS_SEARCH_AUTHOR_POST;
            htmlContent = EmbeddedBrowser.getGeneratedSource(urlSearchAuthor);
        }
        catch (Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
        }
        return htmlContent;
    }
}
