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
import uit.tkorg.cspublicationcrawler.controller.MASController;
import uit.tkorg.cspublicationcrawler.constant.CSPublicationCrawlerConst;

/**
 * @author Nghiep
 * @author Loc Do
 * This class contains main method to crawl objects from MAS website.
 */

public class MASCrawlerBO extends Thread {

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
                MASController.logger.warning("SUBDOMAIN-ID IS NOT EXIST IN DATABASE");
                return;
            }
                
            String strPubListContent = crawlPubHTMLContentForSubdomain(idSubdomain);
            int noPub = MASPageAnalyzeBO.getTotalNumberOfPublications(strPubListContent); //tổng số pub, xét cho 1 subdomain nhất định        
            System.out.println(" TOTAL NUMBER OF PUBLICATION IS: " + noPub);
            MASController.logger.warning(" TOTAL NUMBER OF PUBLICATION IS: " + noPub);
            if (end < noPub && end != 0)
                noPub = end;
            System.out.println(" NUMBER OF PUBLICATION WILL BE CRAWLED IS: " + start + " TO " + noPub);
            MASController.logger.warning(" NUMBER OF PUBLICATION WILL BE CRAWLED IS: " + start + " TO " + noPub);
            
            //bắt đầu lấy tất cả các pub, theo nhóm 100, về kiểm tra và cập nhật
            while(start < noPub) {
                end = (start + 100 < noPub) ? (start + 100) : noPub; 
                start++;
                System.out.println("************************************************************ ");
                System.out.println(" START: " + start + "; " + "END: " + end);
                System.out.println("************************************************************ ");                
                MASController.logger.info("************************************************************ ");
                MASController.logger.warning(" START: " + start + "; " + "END: " + end);
                MASController.logger.info("************************************************************ ");
                strPubListContent = crawlPubHTMLContentForSubdomain(idSubdomain, start, end);    
                ArrayList listPublicationURL = MASPageAnalyzeBO.getListOfPublicationURL(strPubListContent);                

                // Xét mỗi pub's url, kiểm tra, cập nhật.
                for(int i=0; i<listPublicationURL.size(); i++) {     
                    String strPubURL = (String) listPublicationURL.get(i); 
                    System.out.println("************************************************************ ");
                    System.out.println((start + i) + ". " + strPubURL);
                    System.out.println("Manual: If error happen when crawl this publication, do the following steps: 1. Delete this publication in DB if fully exsist. 2. Crawl this publication again.");
                    System.out.println("************************************************************ ");
                    MASController.logger.info("************************************************************ ");
                    MASController.logger.warning((start + i) + ". " + strPubURL);
                    MASController.logger.warning("Manual: If error happen when crawl this publication, do the following steps: 1. Delete this publication in DB if fully exsist. 2. Crawl this publication again.");
                    MASController.logger.info("************************************************************ ");
                    int pubExist[] = mapperPaper.checkExistingStatusOfPublication(strPubURL);
                    int idPaper = pubExist[1];
                    if (pubExist[0] == 2) { 
                        // all metadata of publication existed. Update SubDomain for this publication
                        System.out.println("All metadata of this publication existed. Update Infor for PaperSubDomain");
                        MASController.logger.info("All metadata of this publication existed. Update Infor for PaperSubDomain");
                        SubdomainPaperDTO dtoSubdomainPaper = new SubdomainPaperDTO(idPaper, idSubdomain);
                        if (mapperSubdomainPaper.isExisted(dtoSubdomainPaper) == -1) {
                            mapperSubdomainPaper.insertObj(dtoSubdomainPaper);
                        }
                    }
                    else {
                        // Cập nhật thông tin cơ bản của 1 publication
                        // Trong hàm này đồng thời cập nhật thông tin cho các bảng mà paper trực tiếp chỉ đến nếu cần.
                        String strPubHTMLContent = crawlHTMLContentMAS(strPubURL);
                        PaperDTO dtoPaper = MASPageAnalyzeBO.generatePaperDTOFromHTMLContent(strPubHTMLContent, idPaper, strPubURL);
                        
                        // Improve robustness to deal with bad data source.
                        if (dtoPaper.getTitle() != null) {
                            if (pubExist[0] == 0) {
                                // Publication does not exist in DB
                                System.out.println("Insert a new publication");
                                MASController.logger.info("Insert a new publication");
                                idPaper = mapperPaper.insertObj(dtoPaper);
                            }
                            else {
                                // Only PublicationURL existed in DB
                                System.out.println("Only PublicationURL existed in DB. Update other metadata for this publication");
                                MASController.logger.info("Only PublicationURL existed in DB. Update other metadata for this publication");
                                mapperPaper.updateObj(dtoPaper);
                            }

                            // Update subdomain of publication
                            System.out.println("BEGIN updating subdomain of this publication");
                            MASController.logger.info("BEGIN updating subdomain of this publication");
                            SubdomainPaperDTO dtoSubdomainPaper = new SubdomainPaperDTO(idPaper, idSubdomain);
                            if (mapperSubdomainPaper.isExisted(dtoSubdomainPaper) == -1) {
                                mapperSubdomainPaper.insertObj(dtoSubdomainPaper);
                            }
                            System.out.println("END updating subdomain of this publication");
                            MASController.logger.info("END updating subdomain of this publication");

                            // Update keywords of publication
                            System.out.println("BEGIN updating keywords of this publication");
                            MASController.logger.info("BEGIN updating keywords of this publication");
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
                                                System.out.println("Insert new keyword:" + dtoKeyword.getKeyword());
                                                MASController.logger.info("Insert new keyword:" + dtoKeyword.getKeyword());
                                            }
                                        }
                                        PaperKeywordDTO dtoPaperKeyword = new PaperKeywordDTO(idPaper, idKeyword);
                                        if (mapperPaperKeyword.isExisted(dtoPaperKeyword) == -1) {
                                            System.out.println("Insert link between this keyword and this paper:" + dtoPaperKeyword.getIdKeyword());
                                            MASController.logger.info("Insert link between this keyword and this paper:" + dtoPaperKeyword.getIdKeyword());
                                            mapperPaperKeyword.insertObj(dtoPaperKeyword);
                                        }
                                    }
                                }
                            }
                            System.out.println("END updating keywords of this publication");
                            MASController.logger.info("END updating keywords of this publication");

                            // Update authors of publication
                            System.out.println("BEGIN updating authors of this publication");
                            MASController.logger.info("BEGIN updating authors of this publication");
                            ArrayList lstAuthorURL = MASPageAnalyzeBO.getListAuthorURL(strPubHTMLContent);
                            if (lstAuthorURL != null && lstAuthorURL.size() > 0) {
                                for (int j=0; j<lstAuthorURL.size(); j++) {
                                    String strAuthorURL = (String) lstAuthorURL.get(j);
                                    if ((strAuthorURL != null) && (strAuthorURL.compareTo("") != 0)) {
                                        int idAuthor = mapperAuthor.isExisted(strAuthorURL);
                                        if (idAuthor == -1) {
                                            AuthorDTO dtoAuthor = MASPageAnalyzeBO.generateAuthorDTOFromHTMLContent(strAuthorURL);
                                            // Check if dtoAuthor is valid.
                                            // Improve robustness to deal with bad data source.
                                            if (dtoAuthor.getAuthorName() != null) {
                                                idAuthor = mapperAuthor.insertObj(dtoAuthor);
                                                System.out.println("Insert new author:" + dtoAuthor.getAuthorName());
                                                MASController.logger.info("Insert new author:" + dtoAuthor.getAuthorName());
                                            }
                                        }
                                        AuthorPaperDTO dtoAuthorPaper = new AuthorPaperDTO(idAuthor, idPaper);
                                        if (mapperAuthorPaper.isExisted(dtoAuthorPaper) == -1) {
                                            mapperAuthorPaper.insertObj(dtoAuthorPaper);
                                            System.out.println("Insert link between this author and this paper:" + dtoAuthorPaper.getIdAuthor());
                                            MASController.logger.info("Insert link between this author and this paper:" + dtoAuthorPaper.getIdAuthor());
                                        }
                                    }
                                }
                            }
                            System.out.println("END updating authors of this publication");
                            MASController.logger.info("END updating authors of this publication");

                            // Update citation of publication
                            System.out.println("BEGIN updating citation of this publication");
                            MASController.logger.info("BEGIN updating citation of this publication");
                            String strCitationListURL = MASPageAnalyzeBO.getCitationListOfPub(strPubHTMLContent);
                            if ((strCitationListURL != null) && (strCitationListURL.compareTo("") != 0)) {
                                String citationListHTMLContent = crawlHTMLContentMAS(strCitationListURL);
                                if (citationListHTMLContent != null) {
                                    int noCitation = MASPageAnalyzeBO.getNumberCitations(citationListHTMLContent);
                                    int startCitation = 0, endCitation = 0, citationCount = 0;
                                    while (startCitation < noCitation) {
                                        endCitation = (startCitation + 100 < noCitation) ? (startCitation + 100) : noCitation;
                                        startCitation++;

                                        citationListHTMLContent = crawlHTMLContentMAS(strCitationListURL, startCitation, endCitation);
                                        ArrayList lstCitationURL = MASPageAnalyzeBO.getListCitationURL(citationListHTMLContent);
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
                                                    System.out.println(citationCount + "." + "Inserted citation:" + strCitationURL);
                                                    MASController.logger.info(citationCount + "." + "Inserted citation:" + strCitationURL);
                                                }

                                                PaperPaperDTO dtoPaperPaper = new PaperPaperDTO(idCitation, idPaper, null);
                                                if (mapperPaperPaper.isExisted(dtoPaperPaper) == -1) {
                                                    mapperPaperPaper.insertObj(dtoPaperPaper);
                                                    System.out.println("CitationURL existed. Inserted CitationLink:" + strCitationURL);
                                                    MASController.logger.info("CitationURL existed. Inserted CitationLink:" + strCitationURL);
                                                }
                                            }
                                        }
                                        startCitation = endCitation;
                                    }
                                }
                            }
                            System.out.println("END updating citation of this publication");
                            MASController.logger.info("END updating citation of this publication");

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
                                    endCitationContext = (startCitationContext + 100 < noCitationContext) ? (startCitationContext + 100) : noCitationContext;
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
                        }
                    }
                }

                start = end;
            }
        }
        catch(Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
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
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
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
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
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
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
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
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
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
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }
        
        return htmlContent;
    }    
}
