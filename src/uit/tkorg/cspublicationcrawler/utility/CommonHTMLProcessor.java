/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uit.tkorg.cspublicationcrawler.utility;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;

/**
 *
 * @author Nghiep
 */
public class CommonHTMLProcessor {
    /**
     * get element's html content by selector
     * @param htmlContent
     * @param divID
     * @return element to string content
     */
    public static String getElementHTMLContent(String htmlContent, String selector) {
    	Element getdata = null;
    	
        try {
            if (htmlContent != null) {
                Document doc = Jsoup.parse(htmlContent);
                getdata = doc.select(selector).first();
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

    	if(getdata == null)
            return null;
        
        return getdata.toString();
    }

    /**
     * get element's text by selector
     * @param htmlContent
     * @param divID
     * @return element to string content
     */
    public static String getElementText(String htmlContent, String selector) {
    	Element getdata = null;
    	
        try {
            if (htmlContent != null) {
                Document doc = Jsoup.parse(htmlContent);
                getdata = doc.select(selector).first();
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

    	if(getdata == null)
            return null;
        
        return getdata.text();
    }

    /**
     * get element by selector
     * @param htmlContent
     * @param divID
     * @return element to string content
     */
    public static Element getElement(String htmlContent, String selector) {
    	Element getdata = null;
    	
        try {
            if (htmlContent != null) {
                Document doc = Jsoup.parse(htmlContent);
                getdata = doc.select(selector).first();
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

        return getdata;
    }
    
    /**
     * 
     * @param htmlContent
     * @param selector
     * @return 
     */
    public static Elements getElements(String htmlContent, String selector) {
    	Elements getdata = null;
    	
        try {
            if (htmlContent != null) {
                Document doc = Jsoup.parse(htmlContent);
                getdata = doc.select(selector);
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

        return getdata;
    }
}


