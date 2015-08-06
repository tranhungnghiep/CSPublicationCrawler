/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uit.tkorg.cspublicationcrawler.bo;

import java.net.URL;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import uit.tkorg.cspublicationcrawler.dto.PaperDTO;
import uit.tkorg.cspublicationcrawler.constant.MASPatterns;
import uit.tkorg.cspublicationcrawler.utility.CommonHTMLProcessor;
import uit.tkorg.cspublicationcrawler.utility.CommonURLQuery;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import uit.tkorg.cspublicationcrawler.controller.MASController;
import uit.tkorg.cspublicationcrawler.dbaccess.ConferenceMapper;
import uit.tkorg.cspublicationcrawler.dbaccess.JournalMapper;
import uit.tkorg.cspublicationcrawler.dto.AuthorDTO;
import uit.tkorg.cspublicationcrawler.dto.ConferenceDTO;
import uit.tkorg.cspublicationcrawler.dto.JournalDTO;
import uit.tkorg.cspublicationcrawler.dto.KeywordDTO;
import uit.tkorg.cspublicationcrawler.dto.OrgDTO;

/**
 * Analyze html content crawled from mas
 * @author Tin Huynh
 * @author Nghiep H. Tran
 * @author Loc Do
 */
public class MASPageAnalyzeBO {

    /**
     * get a PaperDTO object
     * @param strPubHTMLContent
     * @return 
     */
    public static PaperDTO generatePaperDTOFromHTMLContent(String strPubHTMLContent, int idPaper, String strPubURL) throws Exception {
        PaperDTO dtoPaper = null;
        JournalDTO dtoJournal = null;
        ConferenceDTO dtoConference = null;
        JournalMapper mapperJournal = new JournalMapper();
        ConferenceMapper mapperConference = new ConferenceMapper();
        
        try {
            String doi = getDOI(strPubHTMLContent);
            String isbn = null;
            String title = getTitleOfPublication(strPubHTMLContent);
            String abstractContent = getAbstractOfPublication(strPubHTMLContent);
            String volume = getVolume(strPubHTMLContent);
            String pages = getPages(strPubHTMLContent);
            int year = getYearPublishOfPublication(strPubHTMLContent);
            String viewPublication = getViewPublication(strPubHTMLContent);
            String bibTex = null;
            String endNote = null;
            int idJournal = -1;
            int idConference = -1;
            int idMagazine = -1;
            int version = -1;
            String paperFile = null;

            // insert a new journal if not exist
            String journalURL = getJournalURL(strPubHTMLContent);
            if ((journalURL != null) && (journalURL.compareTo("") != 0)) {
                idJournal = mapperJournal.isExisted(journalURL);
                if (idJournal == -1) {
                    dtoJournal = generateJournalDTOFromHTMLContent(journalURL);
                    // Improve robustness to deal with bad data source.
                    if (dtoJournal.getJournalName() != null)
                        idJournal = mapperJournal.insertObj(dtoJournal);
                    System.out.println("Insert journal: " + idJournal);
                }
            }
            
            // insert a new conference if not exist
            String conferenceURL = MASPageAnalyzeBO.getConferenceURL(strPubHTMLContent);
            if ((conferenceURL != null) && (conferenceURL.compareTo("") != 0)) {
                idConference = mapperConference.isExisted(conferenceURL);
                if (idConference == -1) {
                    dtoConference = generateConferenceDTOFromHTMLContent(conferenceURL);
                    // Improve robustness to deal with bad data source.
                    if (dtoConference.getConferenceName() != null)
                        idConference = mapperConference.insertObj(dtoConference);
                    System.out.println("Insert conference: " + idConference);
                }
            }
            
            dtoPaper = new PaperDTO(idPaper, doi, isbn, strPubURL, title, abstractContent, volume, pages, year, viewPublication, bibTex, endNote, idJournal, idConference, idMagazine, version, paperFile);
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
            mapperJournal.closeConnection();
            mapperConference.closeConnection();
        }
        
        return dtoPaper;
     }
    
    /**
     * generateJournalDTOFromHTMLContent
     * @param journalURL
     * @return 
     */
    public static JournalDTO generateJournalDTOFromHTMLContent(String journalURL) throws Exception {
        JournalDTO dtoJournal = new JournalDTO();
        
        MASCrawlerBO masCrawlerBO = new MASCrawlerBO();
        String strJournalHTMLContent = masCrawlerBO.crawlGeneralHTMLContent(journalURL);
        dtoJournal.setJournalName(MASPageAnalyzeBO.getJournalName(strJournalHTMLContent));
        dtoJournal.setOrganization(null);
        dtoJournal.setUrl(journalURL);
        dtoJournal.setWebsite(MASPageAnalyzeBO.getJournalWebsite(strJournalHTMLContent));
        dtoJournal.setYearStart(MASPageAnalyzeBO.getJournalYearStart(strJournalHTMLContent));
        dtoJournal.setYearEnd(MASPageAnalyzeBO.getJournalYearEnd(strJournalHTMLContent));
        
        return dtoJournal;
    }
    
    /**
     * generateConferenceDTOFromHTMLContent
     * @param conferenceURL
     * @return 
     */
    public static ConferenceDTO generateConferenceDTOFromHTMLContent(String conferenceURL) throws Exception {
        ConferenceDTO dtoConference = new ConferenceDTO();
        MASCrawlerBO masCrawlerBO = new MASCrawlerBO();
        String strConferenceHTMLContent = masCrawlerBO.crawlGeneralHTMLContent(conferenceURL);
        
        dtoConference.setConferenceName(getConferenceName(strConferenceHTMLContent));
        dtoConference.setOrganization(null);
        dtoConference.setDuration(getConferenceDuration(strConferenceHTMLContent));
        dtoConference.setOrganizedLocation(getOrganizedLocation(strConferenceHTMLContent));
        dtoConference.setUrl(conferenceURL);
        dtoConference.setWebsite(getConferenceWebsite(strConferenceHTMLContent));
        dtoConference.setYearStart(getConferenceYearStart(strConferenceHTMLContent));
        dtoConference.setYearEnd(getConferenceYearEnd(strConferenceHTMLContent));
        
        return dtoConference;
    }
    
    /**
     * generateKeywordDTOFromHTMLContent
     * @param keywordURL
     * @return 
     */
    public static KeywordDTO generateKeywordDTOFromHTMLContent(String keywordURL) throws Exception {
        KeywordDTO dtoKeyword = new KeywordDTO();
        MASCrawlerBO masCrawlerBO = new MASCrawlerBO();
        String strKeywordHTMLContent = masCrawlerBO.crawlGeneralHTMLContent(keywordURL);
        dtoKeyword.setKeyword(getKeywordName(strKeywordHTMLContent));
        dtoKeyword.setStemmingVariations(getKeywordStemmingKeyword(strKeywordHTMLContent));
        dtoKeyword.setUrl(keywordURL);
        
        return dtoKeyword;
    }
    
    /**
     * generateAuthorDTOFromHTMLContent
     * @param authorURL
     * @return 
     */
    public static AuthorDTO generateAuthorDTOFromHTMLContent(String authorURL) throws Exception {
        AuthorDTO dtoAuthor = new AuthorDTO();
        MASCrawlerBO masCrawlerBO = new MASCrawlerBO();
        String strAuthorHTMLContent = masCrawlerBO.crawlGeneralHTMLContent(authorURL);
        
        dtoAuthor.setAuthorName(getAuthorName(strAuthorHTMLContent));
        dtoAuthor.setImage(getAuthorImage(strAuthorHTMLContent));
        dtoAuthor.setEmailAddress(null);
        dtoAuthor.setWebsite(getAuthorWebsite(strAuthorHTMLContent));
        dtoAuthor.setIdOrg(getAuthorOrgID(strAuthorHTMLContent));
        dtoAuthor.setG_index(getAuthorGIndex(strAuthorHTMLContent));
        dtoAuthor.setH_index(getAuthorHIndex(strAuthorHTMLContent));
        dtoAuthor.setUrl(authorURL);
        return dtoAuthor;
    }
    
    /**
     * generateOrgDTOFromHTMLContent
     * @param orgURL
     * @return 
     */
    public static OrgDTO generateOrgDTOFromHTMLContent(String orgURL) throws Exception {
        OrgDTO dtoOrg = new OrgDTO();
        MASCrawlerBO masCrawlerBO = new MASCrawlerBO();
        String strOrgHTMLContent = masCrawlerBO.crawlGeneralHTMLContent(orgURL);
        
        dtoOrg.setOrgName(getOrgName(strOrgHTMLContent));
        dtoOrg.setWebsite(getOrgWebsite(strOrgHTMLContent));
        dtoOrg.setContinent(getOrgContinent(strOrgHTMLContent));
        dtoOrg.setH_index(getOrgH_Index(strOrgHTMLContent));
        dtoOrg.setIdOrgParent(-1);
        dtoOrg.setUrl(orgURL);

        return dtoOrg;
    }
    
    /**
     * get Number of Publications in 1 pub list html content for 1 subdomain
     * @param htmlContent
     * @return numberOfPublication
     */
    public static int getTotalNumberOfPublications(String htmlContent) {
        int numberOfPublication = 0;
        String result = "";
        try {
            String id = "#" + MASPatterns.PUBLICATION_COUNT_SPAN_ID;
            String pubNumArea = CommonHTMLProcessor.getElementText(htmlContent, id);
            pubNumArea = pubNumArea.replaceAll(",", "");

            if (pubNumArea != null) {
                Pattern _pattern = Pattern.compile("\\d+");
                Matcher _matcher = _pattern.matcher(pubNumArea);

                while(_matcher.find()) {
                    result = _matcher.group().toString();
                }
                numberOfPublication = Integer.parseInt(result);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());         
        }

        return numberOfPublication;
    }

    /**
     * get list of publication's url
     * @param htmlContent
     * @return 
     */
    public static ArrayList getListOfPublicationURL(String htmlContent) throws Exception {
        ArrayList listPublication = new ArrayList();
        Elements elements = null;

        try {
            elements = CommonHTMLProcessor.getElements(htmlContent, "a[id^=" + MASPatterns.PUBLICATION_ITEM_PRE_IN_LIST_A_ID + 
                                                        "]a[id$=" + MASPatterns.PUBLICATION_ITEM_POST_IN_LIST_A_ID + "]");
            if (elements != null)
                for (Element element : elements)
                    listPublication.add(element.attr("href"));
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }

        return listPublication;
    }

    /**
     * get DOI of paper from paper 's page
     * @param strPubHTMLContent
     * @return 
     */
    public static String getDOI(String strPubHTMLContent) {
        String doi = null;
        try {
            String id = "#" + MASPatterns.DOI_A_ID;
            doi = CommonHTMLProcessor.getElementText(strPubHTMLContent, id);
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());       
        }

        return doi;
    }

    /**
     * getTitleOfPublication
     * @param strPubHTMLContent
     * @return 
     */
    public static String getTitleOfPublication(String strPubHTMLContent) {
        String result = null;

        try {
            String id = "#" + MASPatterns.TITLE_SPAN_ID;
            result = CommonHTMLProcessor.getElementText(strPubHTMLContent, id);
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());        
        }

        return result;
    }

    /**
     * getAbstractOfPublication
     * @param strPubHTMLContent
     * @return 
     */
    public static String getAbstractOfPublication(String strPubHTMLContent) {
        String result = null;
        try {
            String id = "#" + MASPatterns.ABSTRACT_SPAN_ID;
            result = CommonHTMLProcessor.getElementText(strPubHTMLContent, id);
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }

        return result;
    }

    /**
     * volume, pages chỉ lấy cho journal. vẫn còn chưa chắc chắn!
     * @param strPubHTMLContent
     * @return 
     */
    public static String getVolume(String strPubHTMLContent) {
        String textContent = null;
        try {
            String id = "#" + MASPatterns.YEAR_JOURNAL_SPAN_ID;
            textContent = CommonHTMLProcessor.getElementText(strPubHTMLContent, id);

            if ((textContent != null) && (textContent.compareTo("") != 0) && (textContent.contains("vol"))) {
                int startIndex = textContent.indexOf("vol");
                int endIndex = 0;
                if (textContent.contains("no")) {
                    int indexOfNo = textContent.indexOf("no");
                    endIndex = textContent.indexOf(",", indexOfNo);
                    if (endIndex == -1) endIndex = textContent.length();
                }
                else {
                    endIndex = textContent.indexOf(",", startIndex);
                    if (endIndex == -1) endIndex = textContent.length();
                }

                textContent = textContent.substring(startIndex, endIndex);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }

        return textContent;
    }

    /**
     * 
     * @param strPubHTMLContent
     * @return 
     */
    public static String getPages(String strPubHTMLContent) {
        String result = null;
        try {
            String idOfYearTag = "#" + MASPatterns.YEAR_CONFERENCE_SPAN_ID;
            String strContainPageNumber = CommonHTMLProcessor.getElementText(strPubHTMLContent, idOfYearTag);
            if (strContainPageNumber == null || strContainPageNumber.equalsIgnoreCase("")) {
                idOfYearTag = "#" + MASPatterns.YEAR_JOURNAL_SPAN_ID;
                strContainPageNumber = CommonHTMLProcessor.getElementText(strPubHTMLContent, idOfYearTag);
                if (strContainPageNumber == null || strContainPageNumber.equalsIgnoreCase("")) {
                    idOfYearTag = "#" + MASPatterns.YEAR_PUBLISHED_SPAN_ID;
                    strContainPageNumber = CommonHTMLProcessor.getElementText(strPubHTMLContent, idOfYearTag);
                }
            }

            if (strContainPageNumber != null && strContainPageNumber.contains("pp")) {
                int index = strContainPageNumber.indexOf("pp");
                strContainPageNumber = strContainPageNumber.substring(index);
                if (strContainPageNumber != null) {
                    String pattern = MASPatterns.PATTERN_PAGENUM_TO_PAGENUM;
                    Pattern p = Pattern.compile(pattern);
                    Matcher m = p.matcher(strContainPageNumber);
                    if (m.find())
                        result = m.group(1) + "-" + m.group(2);
                }
            }
            
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }

        return result;
    }

    /**
     * getYearPublishOfPublication
     * @param strPubHTMLContent
     * @return 
     */
    public static int getYearPublishOfPublication(String strPubHTMLContent) {
        int year = -1;
        try {
            String idOfYearTab = "#" + MASPatterns.YEAR_CONFERENCE_SPAN_ID;
            String strContainPageNumber = CommonHTMLProcessor.getElementText(strPubHTMLContent, idOfYearTab);           
            if (strContainPageNumber == null || strContainPageNumber.equalsIgnoreCase("")) {
                idOfYearTab = "#" + MASPatterns.YEAR_JOURNAL_SPAN_ID;
                strContainPageNumber = CommonHTMLProcessor.getElementText(strPubHTMLContent, idOfYearTab);
                if (strContainPageNumber == null || strContainPageNumber.equalsIgnoreCase("")) {
                    idOfYearTab = "#" + MASPatterns.YEAR_PUBLISHED_SPAN_ID;
                    strContainPageNumber = CommonHTMLProcessor.getElementText(strPubHTMLContent, idOfYearTab);
                }
            }

            if (strContainPageNumber != null) {
                Pattern datePattern = Pattern.compile(MASPatterns.PATTERN_YEAR);
                Matcher m = datePattern.matcher(strContainPageNumber);
                while (m.find()) {
                    year = Integer.parseInt(m.group());
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

        if (year>1950 && year<2020)
            return year;
        else 
            return -1;
    }

    /**
     * result should be a string that includes all links to view a publication
     * @param strPubHTMLContent
     * @return 
     */
    public static String getViewPublication(String strPubHTMLContent) {
        String result = null;
        Elements elements = null;
        try {
            elements = CommonHTMLProcessor.getElements(strPubHTMLContent, "a[id^=" + MASPatterns.DOWNLOAD_PUBLICATION_PRE_A_ID + 
                    "]a[id$=" + MASPatterns.DOWNLOAD_PUBLICATION_POST_A_ID + "]");
            if (elements != null && elements.size() > 0) {
                String href = elements.get(0).attr("href");
                if ((href != null) && (href.compareTo("") != 0))
                result = href;
                for (int i = 1; i < elements.size(); i++) {
                    href = elements.get(i).attr("href");
                    if ((href != null) && (href.compareTo("") != 0)) {
                        if ((result != null) && (result.compareTo("") != 0))
                            result = result + ", " + href;
                        else
                            result = href; 
                    }
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
        
        return result;
    }
    
    /**
     * 
     * @param strPubHTMLContent
     * @return 
     */
    public static String getJournalURL(String strPubHTMLContent) {
        String result = null;
        Element element = null;
        try {
            element = CommonHTMLProcessor.getElement(strPubHTMLContent, "#" + MASPatterns.JOURNAL_A_ID);
            if (element != null) {
                String href = element.attr("href");
                if ((href != null) && (href.compareTo("") != 0)) {
                    result = href;
                    if (result.startsWith("../../"))
                        result = result.substring(5);
                    else if (result.startsWith("../"))
                        result = result.substring(2);
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
        
        return result;
    }
    
    /**
     * 
     * @param strPubHTMLContent
     * @return 
     */
    public static String getConferenceURL(String strPubHTMLContent) {
        String result = null;
        Element element = null;
        try {
            element = CommonHTMLProcessor.getElement(strPubHTMLContent, "#" + MASPatterns.CONFERENCE_A_ID);
            if (element != null) {
                String href = element.attr("href");
                if ((href != null) && (href.compareTo("") != 0)) {
                    result = href;
                    if (result.startsWith("../../"))
                        result = result.substring(5);
                    else if (result.startsWith("../"))
                        result = result.substring(2);
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
        
        return result;
    }

    /**
     * getJournalName
     * @param strJournalHTMLContent
     * @return 
     */
    public static String getJournalName(String strJournalHTMLContent) {
        String result = null;
        try {
            result = CommonHTMLProcessor.getElementText(strJournalHTMLContent, "#" + MASPatterns.JOURNAL_NAME_SPAN_ID);            
        }
        catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }
        
        return result;
    }

    /**
     * getConferenceName
     * @param strConferenceHTMLContent
     * @return 
     */
    public static String getConferenceName(String strConferenceHTMLContent) {
        String result = null;
        try {
            result = CommonHTMLProcessor.getElementText(strConferenceHTMLContent, "#" + MASPatterns.CONFERENCE_NAME_SPAN_ID);
        }
        catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }
        
        return result;
    }
        
    /**
     * 
     * @param strJournalHTMLContent
     * @return 
     */
    public static String getJournalWebsite(String strJournalHTMLContent) {
        String result = null;
        Element element = null;
        try {
            element = CommonHTMLProcessor.getElement(strJournalHTMLContent, "#" + MASPatterns.JOURNAL_WEBSITE_A_ID);
            if (element != null) {
                String href = element.attr("href");
                if ((href != null) && (href.compareTo("") != 0)) {
                    result = href;
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

        return result;
    }
    
    /**
     * getConferenceWebsite
     * @param strConferenceHTMLContent
     * @return 
     */
    public static String getConferenceWebsite(String strConferenceHTMLContent) {
        String result = null;
        Element element = null;
        try {
            element = CommonHTMLProcessor.getElement(strConferenceHTMLContent, "#" + MASPatterns.CONFERENCE_WEBSITE_A_ID);
            if (element != null) {
                String href = element.attr("href");
                if ((href != null) && (href.compareTo("") != 0)) {
                    result = href;
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

        return result;
    }
        
    /**
     * getJournalYearStart
     * @param strJournalHTMLContent
     * @return 
     */
    public static int getJournalYearStart(String strJournalHTMLContent) {
        String textContent = "";
        int yearStart = -1;
        try {
            textContent = CommonHTMLProcessor.getElementText(strJournalHTMLContent, "#" + MASPatterns.JOURNAL_YEAR_SPAN_ID);
            if (textContent != null) {
                String pattern = MASPatterns.PATTERN_RANGE_YEAR;
                Pattern p = Pattern.compile(pattern);
                Matcher m = p.matcher(textContent);
                if (m.find()) {
                    textContent = m.group(1);
                    yearStart = Integer.parseInt(textContent);            
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
        
        return yearStart;
    }
        
    /**
     * getJournalYearEnd
     * @param strJournalHTMLContent
     * @return 
     */
    public static int getJournalYearEnd(String strJournalHTMLContent) {
        String textContent = "";
        int yearEnd = -1;
        try {
            textContent = CommonHTMLProcessor.getElementText(strJournalHTMLContent, "#" + MASPatterns.JOURNAL_YEAR_SPAN_ID);
            if (textContent != null) {
                String pattern = MASPatterns.PATTERN_RANGE_YEAR;
                Pattern p = Pattern.compile(pattern);
                Matcher m = p.matcher(textContent);
                if (m.find()) {
                    textContent = m.group(2);
                    yearEnd = Integer.parseInt(textContent); 
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
        
        return yearEnd;
    }
        
    /**
     * getConferenceYearStart
     * @param strConferenceHTMLContent
     * @return 
     */
    public static int getConferenceYearStart(String strConferenceHTMLContent) {
        String textContent = "";
        int yearStart = -1;
        try {
            textContent = CommonHTMLProcessor.getElementText(strConferenceHTMLContent, "#" + MASPatterns.CONFERENCE_YEAR_SPAN_ID);
            if (textContent != null) {
                String pattern = MASPatterns.PATTERN_RANGE_YEAR;
                Pattern p = Pattern.compile(pattern);
                Matcher m = p.matcher(textContent);
                if (m.find()) {
                    textContent = m.group(1);
                    yearStart = Integer.parseInt(textContent);            
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
        
        return yearStart;
    }
        
    /**
     * getConferenceYearEnd
     * @param strConferenceHTMLContent
     * @return 
     */
    public static int getConferenceYearEnd(String strConferenceHTMLContent) {
        String textContent = "";
        int yearEnd = -1;
        try {
            textContent = CommonHTMLProcessor.getElementText(strConferenceHTMLContent, "#" + MASPatterns.CONFERENCE_YEAR_SPAN_ID);
            if (textContent != null) {
                String pattern = MASPatterns.PATTERN_RANGE_YEAR;
                Pattern p = Pattern.compile(pattern);
                Matcher m = p.matcher(textContent);
                if (m.find()) {
                    textContent = m.group(2);
                    yearEnd = Integer.parseInt(textContent); 
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
        
        return yearEnd;
    }
    
    /**
     * getConferenceDuration
     * @param strConferenceHTMLContent
     * @return 
     */
    public static String getConferenceDuration(String strConferenceHTMLContent) {
        String result = null;
        try {
            result = CommonHTMLProcessor.getElementText(strConferenceHTMLContent, "#" + MASPatterns.CONFERENCE_CFP_SPAN_ID);
            if ((result != null) && (result.compareTo("") != 0)) {
                int endIndex = result.indexOf(",");
                if (endIndex == -1) endIndex = result.length();
                result = result.substring(0, endIndex);
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
        
        return result;
    }

    /**
     * getOrganizedLocation
     * @param strConferenceHTMLContent
     * @return 
     */
    public static String getOrganizedLocation(String strConferenceHTMLContent) {
        String result = null;
        try {
            result = CommonHTMLProcessor.getElementText(strConferenceHTMLContent, "#" + MASPatterns.CONFERENCE_CFP_SPAN_ID);
            if ((result != null) && (result.compareTo("") != 0)) {
                int startIndex = result.indexOf(",");
                if (startIndex == -1) return null;
                else
                    result = result.substring(startIndex + 1);
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
        
        return result;
    }
    
    /**
     * list of keyword url in paper html page
     * @param strPubHTMLContent
     * @return 
     */
    public static ArrayList getListKeywordURL(String strPubHTMLContent) {
        ArrayList lstKeywordURL = new ArrayList();
        Elements elements = null;
        try {
            elements = CommonHTMLProcessor.getElements(strPubHTMLContent, "a[href^=" + MASPatterns.KEYWORD_HREF_PRE + "]");
            if (elements != null)
                for (Element element : elements) {
                    if (element != null) {
                        String href = element.attr("href");
                        if ((href != null) && (href.compareTo("") != 0)) {
                            lstKeywordURL.add(href);
                        }
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
        
        return lstKeywordURL;
    }
    
    /**
     * 
     * @param strPubHTMLContent
     * @return 
     */
    public static ArrayList getListAuthorURL(String strPubHTMLContent) {
        ArrayList lstAuthorURL = new ArrayList();
        String url = null;
        try {
            Element areaElement = CommonHTMLProcessor.getElement(strPubHTMLContent, "#" + MASPatterns.AUTHOR_AREA_DIV_ID);
            if (areaElement != null) {
                Elements elements = areaElement.select("a[href*=" + MASPatterns.AUTHOR_URL_PATTERN + "]");
            if (elements != null)
                for (Element element : elements) {
                    if (element != null) {
                        String href = element.attr("href");
                        if ((href != null) && (href.compareTo("") != 0)) {
                            url = href;
                            if (url.startsWith("http"))
                                url = url.substring(38);
                            lstAuthorURL.add(url);
                        }
                    }
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
        
        return lstAuthorURL;
    }
        

    /**
     * get url to go to list of citation of this paper
     * @param strPubHTMLContent
     * @return 
     */
    public static String getCitationListOfPub(String strPubHTMLContent) throws Exception {
        String result = null;
        Element element = null;
        
        try {
            element = CommonHTMLProcessor.getElement(strPubHTMLContent, "#" + MASPatterns.CITATION_A_ID);
            if (element != null) {
                String href = element.attr("href");
                if ((href != null) && (href.compareTo("") != 0)) {                
                    result = href;
                    if (result.startsWith("../../"))
                        result = result.substring(5);
                    else if (result.startsWith("../"))
                        result = result.substring(2);
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
        return result;
    }
    
    /**
     * 
     * @param strCitationListContent
     * @return 
     */
    public static int getNumberCitations(String strCitationListContent) {
        int numberOfCitation = 0;
        String result = "";
        try {
            result = CommonHTMLProcessor.getElementText(strCitationListContent, "#" + MASPatterns.ITEM_COUNT_ID);
            if (result != null && result.compareTo("") != 0) {
                int start = result.lastIndexOf("(") + 1;
                int end = result.lastIndexOf(")");
                if ((start != -1) && (end != -1)) {
                    result = result.substring(start, end);
                    numberOfCitation = Integer.parseInt(result);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }

        return numberOfCitation;
    }
    
    /**
     * getListCitationURL
     * @param strCitationListContent
     * @return 
     */
    public static ArrayList getListCitationURL(String strCitationListContent) {
        ArrayList lstCitationURL = new ArrayList();
        Elements elements = null;
        String result;
        try {
            elements = CommonHTMLProcessor.getElements(strCitationListContent, "a[id^=" + MASPatterns.ITEM_IN_LIST_PRE_A_ID + 
                    "]a[id$=" + MASPatterns.ITEM_IN_LIST_POST_A_ID + "]");
            if (elements != null)
                for (Element element : elements) {
                    if (element != null) {
                        String href = element.attr("href");
                        if ((href != null) && (href.compareTo("") != 0)) { 
                            result = href;
                            if (!result.startsWith("/"))
                                result = "/" + result;
                            lstCitationURL.add(result);
                        }
                    }
                }
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }

        return lstCitationURL;
    }

    /**
     * 
     * @param strPubHTMLContent
     * @return 
     */
    public static String getCitationConTextListOfPub(String strPubHTMLContent) {
        String result = null;
        Element element = null;
        
        try {
            element = CommonHTMLProcessor.getElement(strPubHTMLContent, "#" + MASPatterns.CITATION_CONTEXT_A_ID);
            if (element != null) {
                String href = element.attr("href");
                if ((href != null) && (href.compareTo("") != 0)) {                                     
                    result = href;
                    if (result.startsWith("../.."))
                        result = result.substring(5);
                    else if (result.startsWith("../"))
                        result = result.substring(2);
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
        
        return result;
    }
    

    /**
     * 
     * @param strCitationContextListContent
     * @return 
     */
    public static int getNumberCitationContexts(String strCitationContextListContent) {
        int numberOfCitationContext = 0;
        String result = "";

        try {
            result = CommonHTMLProcessor.getElementText(strCitationContextListContent, "#" + MASPatterns.ITEM_COUNT_ID);
            
            int start = result.lastIndexOf("(") + 1;
            int end = result.lastIndexOf(")");
            if ((start != -1) && (end != -1))
                result = result.substring(start, end);
            
            numberOfCitationContext = Integer.parseInt(result);
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }

        return numberOfCitationContext;
    }
    
    /**
     * 
     * @param strCitationContextListContent
     * @return 
     */
    public static ArrayList getListCitationContextURL(String strCitationContextListContent) {
        ArrayList lstCitationContextURL = new ArrayList();
        String result;

        Element tempElement = null;
        
        Elements elements = null;

        try {
            tempElement = CommonHTMLProcessor.getElement(strCitationContextListContent, "#" + "ctl00_divCenter");
            if (tempElement == null) return lstCitationContextURL;
            tempElement = tempElement.select("div[class=section-wrapper]").first();
            if (tempElement == null) return lstCitationContextURL;
            tempElement = tempElement.select("ul").first();
            if (tempElement == null) return lstCitationContextURL;
            elements = tempElement.children();

            if (elements != null)
                for (Element element : elements) {
                    tempElement = element.select("div").first();
                    if (tempElement == null) return lstCitationContextURL;
                    tempElement = tempElement.select("h3").first();
                    if (tempElement == null) return lstCitationContextURL;
                    tempElement = tempElement.select("a[id^=ctl00_MainContent_ObjectList").first();//lấy element chứa href thành công.
                    if (tempElement == null) return lstCitationContextURL;
                    
                    String href = tempElement.attr("href");
                    if ((href != null) && (href.compareTo("") != 0)) {                                     
                        result = href;                    
                        if (!result.startsWith("/")) {
                            result = "/" + result;
                            lstCitationContextURL.add(result);
                        }
                    }
                }
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }

        return lstCitationContextURL;
    }

    /**
     * 
     * @param strCitationContextListContent
     * @return 
     */
    public static ArrayList getListCitationContextContent(String strCitationContextListContent) {
        ArrayList lstCitationContextContent = new ArrayList();
        String result = null;

        Element tempElement = null;
        
        Elements elements = null;
        Elements elements1 = null;

        try {
            tempElement = CommonHTMLProcessor.getElement(strCitationContextListContent, "#" + "ctl00_divCenter");
            if (tempElement == null) return lstCitationContextContent;
            tempElement = tempElement.select("div[class=section-wrapper]").first();
            if (tempElement == null) return lstCitationContextContent;
            tempElement = tempElement.select("ul").first();
            if (tempElement == null) return lstCitationContextContent;
            elements = tempElement.children();

            if (elements != null)
                for (Element element : elements) {
                    tempElement = element.select("div").first();
                    if (tempElement == null) return lstCitationContextContent;
                    tempElement = tempElement.select("ul").first();
                    if (tempElement == null) return lstCitationContextContent;
                    elements1 = tempElement.children();

                    if ((elements1 != null) && (elements1.size() > 0)) {
                        String href = elements1.get(0).text();
                        if ((href != null) && (href.compareTo("") != 0))
                            result = href;
                        for (int i = 1; i < elements1.size(); i++) {
                            href = elements1.get(i).text();
                            if ((href != null) && (href.compareTo("") != 0)) {
                                if ((result != null) && (result.compareTo("") != 0))
                                    result = result + "|" + href;
                                else
                                    result = href; 
                            }                            
                        }
                        lstCitationContextContent.add(result);
                    }
                }
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }

        return lstCitationContextContent;
    }
    
    /**
     * Get the keyword name
     * @param keywordHTMLContent
     * @return 
     */
    public static String getKeywordName(String strKeywordHTMLContent) {
        String result = null;
        try {
            result = CommonHTMLProcessor.getElementText(strKeywordHTMLContent, "#" + MASPatterns.KEYWORD_NAME_SPAN_ID);
            if ((result != null) && (result.compareTo("") != 0)) 
                return result;
            else
                result = null;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }
        return result;
    }
    
    /**
     * Get the keyword stemmings variations
     * @param strKeywordHTMLContent
     * @return 
     */
    public static String getKeywordStemmingKeyword(String strKeywordHTMLContent) {
        String result = null;
        try {
            result = CommonHTMLProcessor.getElementText(strKeywordHTMLContent, "#" + MASPatterns.KEYWORD_STEMMINGS_SPAN_ID);
            if ((result != null) && (result.compareTo("") != 0)) 
                return result;
            else
                result = null;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }
        return result;
    }
    
    /**
     * Get Org Name
     * @param strConferenceHTMLContent
     * @return OrgName
     */
    public static String getOrgName(String strOrgHTMLContent) {
        String result = null;
        
        try {
            result = CommonHTMLProcessor.getElementText(strOrgHTMLContent, "#" + MASPatterns.ORG_NAME_SPAN_ID);
            if ((result != null) && (result.compareTo("") != 0)) 
                return result;
            else 
                result = null;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString()); 
        }                        
        return result;
    }
    
    /**
     * Get Org Website
     * @param strOrgHTMLContent
     * @return OrgWebsite
     */
    public static String getOrgWebsite(String strOrgHTMLContent) {
        String result = null;
        
        try {
            Element e = CommonHTMLProcessor.getElement(strOrgHTMLContent, "#" + MASPatterns.ORG_WEBSITE_SPAN_ID);
            if (e != null)
                result = e.attr("href");         
        }
        catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }
                        
        return result;
    }
    
    public static String getOrgContinent(String strOrgHTMLContent) {
        String result = null;
        
        try {
            result = CommonHTMLProcessor.getElementText(strOrgHTMLContent, "." + MASPatterns.ORG_CONTINENT_DIV_CLASS);
            if ((result != null) && (result.compareTo("") != 0)) 
                return result;
            else 
                result = null;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }
        
        return result;
    }
    
    /**
     * Get Org H_INDEX
     * @param strOrgHTMLContent
     * @return 
     */
    public static int getOrgH_Index(String strOrgHTMLContent) {
        int index = -1;
        String result = null;
        try {
            Element element = CommonHTMLProcessor.getElement(strOrgHTMLContent,"#" + MASPatterns.ORG_H_INDEX_SPAN_ID);
            if (element != null) {
                result = element.text();
                result = result.substring(result.indexOf("H-Index") + 9);
                index = Integer.parseInt(result);
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
        return index;
    }
    
    /**
     * Get name of the author
     * @param strAuthorHTMLContent
     * @return authorName
     */
    public static String getAuthorName(String strAuthorHTMLContent) {
        String result = null;
        try {
            result = CommonHTMLProcessor.getElementText(strAuthorHTMLContent, "#" + MASPatterns.AUTHOR_NAME_SPAN_ID);
            if ((result != null) && (result.compareTo("") != 0)) 
                return result;
            else 
                result = null;
        }
        catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }
        
        return result;
    }
    
    /**
     * Get image link of the author
     * @param strAuthorHTMLContent
     * @return link of the image     
     */
    public static String getAuthorImage(String strAuthorHTMLContent) {
        String result = null;
        try {
            Element link = CommonHTMLProcessor.getElement(strAuthorHTMLContent, "#" + MASPatterns.AUTHOR_IMAGE_SPAN_ID);
            if (link != null) {
                result = link.attr("src");            
                if ((result != null) && (result.compareTo("") != 0)) 
                    return result;
                else 
                    result = null;
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
        
        return result;
    }   
    
    /**
     * Get author's homepage
     * @param strAuthorHTMLContent
     * @return homepage's url  
     */
    public static String getAuthorWebsite(String strAuthorHTMLContent) {
        String result = null;
        try {
            Element link = CommonHTMLProcessor.getElement(strAuthorHTMLContent, "#" + MASPatterns.AUTHOR_WEBSITE_SPAN_ID);
            if (link != null) {
                result = link.attr("href");    
                if ((result != null) && (result.compareTo("") != 0)) 
                    return result;
                else 
                    result = null;
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
        
        return result;
    } 
    
    /**
     * Get id Org of author
     * @param strAuthorHTMLContent
     * @return 
     */
    public static int getAuthorOrgID(String strAuthorHTMLContent) {
        int idOrg = -1;
        String result = null;
        try {
            Element element = CommonHTMLProcessor.getElement(strAuthorHTMLContent, "#" + MASPatterns.AUTHOR_ORG_SPAN_ID);
            if (element != null) {
                String href = element.attr("href");
                String text = element.text();
                if ((href != null) && (href.compareTo("") != 0) && 
                        text != null && (text.trim()).compareTo("") != 0) {                                     
                    result = href;                  
                    if (result.startsWith("../../"))
                        result = result.substring(5);
                    else if (result.startsWith("../"))
                        result = result.substring(2);
                    
                    OrgBO boOrg = new OrgBO();
                    idOrg = boOrg.findOrInsert(result);
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
        return idOrg;
    }
    
    /**
     * Get the G-Index
     * @param strAuthorHTMLContent
     * @return G-Index
     */
    public static int getAuthorGIndex(String strAuthorHTMLContent) {
        int intGIndex = -1;
        String result = null;
        try {
            Element element = CommonHTMLProcessor.getElement(strAuthorHTMLContent,":containsOwn(G-Index:)");
            if (element != null) {
                result = element.text();
                intGIndex = Integer.parseInt(result.substring(result.indexOf(" ")+1));            
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }
        return intGIndex;
    }
    
    /**
     * Get the H-Index
     * @param strAuthorHTMLContent
     * @return H-Index
     */
    public static int getAuthorHIndex(String strAuthorHTMLContent) {
        int intHIndex = -1;
        String result = null;
        try {
            Element element = CommonHTMLProcessor.getElement(strAuthorHTMLContent,":containsOwn(H-Index:)");
            if (element != null) {
                result = element.text();
                intHIndex = Integer.parseInt(result.substring(result.indexOf(" ")+1));            
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
        }
        return intHIndex;
    }
    
    /**
     * @param htmlContent : string to find
     * @param _patternStr : pattern to match
     * @param position    : position to get
     * @return
     */
    public static String getPattern(String htmlContent, String _patternStr, int position) {
        String result = null;
        try {
            if (htmlContent != null) {
                Pattern pattern = Pattern.compile(_patternStr);
                Matcher matcher = pattern.matcher(htmlContent);
                matcher.find();
                result = matcher.group(position).toString();
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
        return result;
    }
       
}
