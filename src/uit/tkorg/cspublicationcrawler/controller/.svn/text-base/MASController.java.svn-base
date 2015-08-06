/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uit.tkorg.cspublicationcrawler.controller;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import uit.tkorg.cspublicationcrawler.bo.*;
import java.util.logging.*;
import uit.tkorg.cspublicationcrawler.constant.CSPublicationCrawlerConst;

/**
 *
 * @author Loc Do
 * Task: 1) read patterns.
 *       2) create query/request to the MAS site.
 *       3) get HTML content.
 *       4) parse the HTML content, extract information.
 *       5) save the information to the database.
 */
public class MASController {

    public static Logger logger;
    public static Handler logHandler;
    static {
        try {
          boolean append = true;
          logHandler = new FileHandler("C:\\CrawlerLog\\Crawler.log", 10000000, 1000, append);
          logHandler.setLevel(Level.ALL);
          logHandler.setFormatter(new Formatter() {
             public String format(LogRecord logRecord) {
                StringBuffer strBuffer = new StringBuffer(10000);
                strBuffer.append("[ ");
                strBuffer.append(new java.util.Date());
                strBuffer.append(" ] - ");
                strBuffer.append(logRecord.getLevel());
                strBuffer.append(": ");
                strBuffer.append(formatMessage(logRecord));
                strBuffer.append('\n');
                return strBuffer.toString();
                }
              });
          logger = Logger.getLogger("CrawlerLogger");
          logger.setUseParentHandlers(false);
          logger.addHandler(logHandler);
          // Change LOGGING_LEVEL in Constant to WARNING in order to disable logging on normal info, only log important info.
          logger.setLevel(CSPublicationCrawlerConst.LOGGING_LEVEL);
        }
        catch (Exception ex) {
          ex.printStackTrace();
        }
    }   
    
    public static void main(String args[]) {
        String subdomain = "Algorithms & Theory";        
        MASCrawlerBO masCrawlerBO = new MASCrawlerBO();    
        System.out.println("**********************************************************");
        System.out.println("BEGIN CRAWLING FOR SUBDOMAIN: " + subdomain);
        System.out.println("**********************************************************");
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        System.out.println(dateFormat.format(cal.getTime()));
        logger.warning("**********************************************************");
        logger.warning("BEGIN CRAWLING FOR SUBDOMAIN: " + subdomain);
        logger.warning("**********************************************************");
        logger.warning(dateFormat.format(cal.getTime()));
        try {
            // start: (first publication to crawl - 1)
            // end: last publication to crawl
            // end = 0 means crawl to the last publication in this subdomain
            // start & end should be assigned 0 at the begin
            int start = 90000, end = 0;
            masCrawlerBO.crawl(subdomain, start, end);
        }
        catch(Exception ex) {
            ex.printStackTrace();
            logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    logger.severe("\tat " + stackTraceElement.toString());
        }
        cal = Calendar.getInstance();
        System.out.println(dateFormat.format(cal.getTime()));
        System.out.println("**********************************************************");
        System.out.println("END CRAWLING FOR SUBDOMAIN: " + subdomain);
        System.out.println("**********************************************************");
        logger.warning(dateFormat.format(cal.getTime()));
        logger.warning("**********************************************************");
        logger.warning("END CRAWLING FOR SUBDOMAIN: " + subdomain);
        logger.warning("**********************************************************");
    }
}
