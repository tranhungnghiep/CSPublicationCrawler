/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uit.tkorg.cspublicationcrawler.utility;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import uit.tkorg.cspublicationcrawler.constant.CSPublicationCrawlerConst;


/**
 *
 * @author THNghiep
 */
public class EmbeddedBrowser {
    
    // The Firefox driver supports javascript
    public static WebDriver driver;// = new FirefoxDriver();

    /**
     * getGeneratedSource
     * @param url
     * @return 
     */
    public static String getGeneratedSource(String url) {
        String htmlContent = null;
        try {
        // The Firefox driver supports javascript
//        public static WebDriver driver;// = new FirefoxDriver();

    // Go to the search result page
            driver.get(url);
            
            // Sleep a period
            long end = System.currentTimeMillis() + CSPublicationCrawlerConst.TIME_WAIT_FOR_SUGGESTION;
            while (System.currentTimeMillis() < end) {}

            htmlContent = driver.getPageSource();
            
//            driver.quit();
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
