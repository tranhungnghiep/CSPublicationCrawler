/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uit.tkorg.cspublicationcrawler.constant;

/**
 * @author tiendv
 * ------------------
 * @author Tran Hung Nghiep
 * @since 17/08/2011
 * @version 1.1
 * @action: 
 */
public class MASPatterns {

    public MASPatterns() {
    }

    //Patterns used for new aproach
    
    //General
    public static int MAX_NUMBER_SHOW_IN_PAGE = 100;
    public static String A = "a";
    public static String AND = "&";
    public static String START = "start";
    public static String END = "end";
    public static String HREF = "href";
    public static String HREF_CLOSE = "</a>";
    public static String HTML_TAB = "\\<.*?>";
    public static String HTML_TAB_OTHER = "&nbsp;";
    public static String LI_CLOSE = "</li>";
    public static String DIV_CLOSE = "</div>";

    //Root
    public static String MAS_HOMEPAGE_URL = "http://academic.research.microsoft.com";
    public static String MAS_PUBLICATION_LIST_QUERY = "http://academic.research.microsoft.com/RankList?entitytype=1&topdomainid=2&subdomainid=";
    public static String MAS_CITATION_LIST_QUERY = "http://academic.research.microsoft.com/Detail?searchtype=5&entitytype=1&id=";
    public static String MAS_CITATION_CONTEXT_LIST_QUERY = "http://academic.research.microsoft.com/Detail?searchtype=7&entitytype=1&id=";
    public static String MAS_REF_LIST_QUERY = "http://academic.research.microsoft.com/Detail?searchtype=2&entitytype=1&id=";
    public static String MAS_RELATED_PUBLICATION_LIST_QUERY = "http://academic.research.microsoft.com/Detail?searchtype=8&entitytype=1&id=";
    public static String MAS_PUBLICATION_OF_AUTHOR_QUERY_PATTERN = "/Detail?entitytype=2&searchtype=2&id=";
    public static String MAS_SEARCH_AUTHOR_PRE = "/Search?searchdomain=2&s=0&query=author%3a%28";
    public static String MAS_SEARCH_AUTHOR_POST = "%29";
    public static String SUGGESTED_AUTHOR_DIV_ID = "ctl00_divSearchSuggestion";
    
    // Patterns to get the list of publications
    public static String PUBLICATION_COUNT_SPAN_ID = "ctl00_MainContent_SearchSummary_lblResultMessage";
    public static String PUBLICATION_ITEM_PRE_IN_LIST_A_ID = "ctl00_MainContent";    
    public static String PUBLICATION_ITEM_POST_IN_LIST_A_ID = "hypName";
    
    //Patterns to get publication
    public static String TITLE_SPAN_ID = "ctl00_MainContent_PaperItem_title";
    public static String ABSTRACT_SPAN_ID = "ctl00_MainContent_PaperItem_snippet";
    public static String YEAR_PUBLISHED_SPAN_ID = "ctl00_MainContent_PaperItem_lblYear";
    
    public static String CONFERENCE_A_ID = "ctl00_MainContent_PaperItem_HLConference";
    public static String JOURNAL_A_ID = "ctl00_MainContent_PaperItem_HLJournal";
    public static String YEAR_CONFERENCE_SPAN_ID = "ctl00_MainContent_PaperItem_YearConference";
    public static String YEAR_JOURNAL_SPAN_ID = "ctl00_MainContent_PaperItem_YearJournal";
    public static String PATTERN_PAGENUM_TO_PAGENUM = "(\\d+)-(\\d+)";
    public static String PATTERN_YEAR = "\\d{4}";
    public static String PATTERN_RANGE_YEAR = "(\\d{4})-(\\d{4})";
    
    public static String DOI_A_ID = "ctl00_MainContent_PaperItem_hypDOIText";
    
    public static String DOWNLOAD_PUBLICATION_PRE_A_ID = "ctl00_MainContent_PaperItem_downLoadList";
    public static String DOWNLOAD_PUBLICATION_POST_A_ID = "HyperLink1";
    
    //Patterns to get list of authors
    public static String AUTHOR_AREA_DIV_ID = "ctl00_MainContent_PaperItem_divPaper";
    public static String AUTHOR_URL_PATTERN = "/Author/";
    //Patterns to get author
    public static String AUTHOR_NAME_SPAN_ID = "ctl00_MainContent_AuthorItem_authorName";
    public static String AUTHOR_IMAGE_SPAN_ID = "ctl00_MainContent_AuthorItem_imgAuthorPhoto";
    public static String AUTHOR_WEBSITE_SPAN_ID = "ctl00_MainContent_AuthorItem_HomePage";
    public static String AUTHOR_ORG_SPAN_ID = "ctl00_MainContent_AuthorItem_affiliation";

    //Patterns to get list of citations
    public static String CITATION_A_ID = "ctl00_MainContent_CitationList_ctl00_HeaderLink";    
    //Patterns to get citation
    public static String ITEM_COUNT_ID = "ctl00_MainContent_SearchSummary_divSummary";
    public static String ITEM_IN_LIST_PRE_A_ID = "ctl00_MainContent_ObjectList";
    public static String ITEM_IN_LIST_POST_A_ID = "Title";
    
    //Patterns to get list of citation contexts
    public static String CITATION_CONTEXT_A_ID = "ctl00_MainContent_PaperCitationContextList_ctl00_HeaderLink";    

    //Patterns to get list of refs
    public static String REF_A_ID = "ctl00_MainContent_PaperList_ctl00_HeaderLink";
    
    //Patterns to get journal
    public static String JOURNAL_NAME_SPAN_ID = "ctl00_MainContent_JournalItem_name";
    public static String JOURNAL_WEBSITE_A_ID = "ctl00_MainContent_JournalItem_HomePage";
    public static String JOURNAL_YEAR_SPAN_ID = "ctl00_MainContent_JournalItem_detailInfo";
    
    //Patterns to get Conference
    public static String CONFERENCE_NAME_SPAN_ID = "ctl00_MainContent_ConferenceItem_name";
    public static String CONFERENCE_WEBSITE_A_ID = "ctl00_MainContent_ConferenceItem_HomePage";
    public static String CONFERENCE_YEAR_SPAN_ID = "ctl00_MainContent_ConferenceItem_detailInfo";
    public static String CONFERENCE_CFP_SPAN_ID = "ctl00_MainContent_ConferenceItem_hypConferenceCFP";

    //Patterns to get keyword
    public static String KEYWORD_HREF_PRE = "/Keyword/";
    public static String KEYWORD_NAME_SPAN_ID = "ctl00_MainContent_KeywodItem_name";
    public static String KEYWORD_STEMMINGS_SPAN_ID = "ctl00_MainContent_KeywodItem_ltrStemmings";

    //Patterns to get Organization
    public static String ORG_NAME_SPAN_ID = "ctl00_MainContent_OrganizationItem_name";
    public static String ORG_WEBSITE_SPAN_ID = "ctl00_MainContent_OrganizationItem_HomePage";
    public static String ORG_CONTINENT_DIV_CLASS = "continent";
    public static String ORG_H_INDEX_SPAN_ID = "ctl00_MainContent_OrganizationItem_detailInfo";
    
}
