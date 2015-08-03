/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uit.tkorg.cspublicationcrawler.controller;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import org.openqa.selenium.firefox.FirefoxDriver;
import uit.tkorg.cspublicationcrawler.bo.*;
import uit.tkorg.cspublicationcrawler.constant.CSPublicationCrawlerConst;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;
import uit.tkorg.cspublicationcrawler.utility.EmbeddedBrowser;

/**
 *
 * @author Loc Do
 * @author Nghiep Tran
 * Task: 1) read patterns.
 *       2) create query/request to the MAS site.
 *       3) get HTML content.
 *       4) parse the HTML content, extract information.
 *       5) save the information to the database.
 */
public class MASController {

    public static void main(String args[]) {
        try {
            MASCrawlerBO masCrawlerBO = new MASCrawlerBO();
            
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
            Calendar cal = Calendar.getInstance();

            System.out.println("**********************************************************");
            System.out.println("BEGIN CRAWLING.");
            System.out.println("**********************************************************");
            cal = Calendar.getInstance();
            System.out.println(dateFormat.format(cal.getTime()));
            CSPublicationCrawlerLogger.logger.warning("**********************************************************");
            CSPublicationCrawlerLogger.logger.warning("BEGIN CRAWLING.");
            CSPublicationCrawlerLogger.logger.warning("**********************************************************");
            CSPublicationCrawlerLogger.logger.warning(dateFormat.format(cal.getTime()));

            if (CSPublicationCrawlerConst.CRAWLING_FUNCTION == 1) { // Crawl in each and every subdomain.
                String subdomains[] = {"Algorithms & Theory", //0 - 270,781 - Completed
                            "Security & Privacy", //1 - 62,115 - Completed
                            "Hardware & Architecture", //2 - 150,510 - Completed
                            "Software Engineering", //3 - 175,090 - Completed
                            "Artificial Intelligence", //4 - 325,714 - Completed
                            "Machine Learning & Pattern Recognition", //5 - 108,481 - Completed
                            "Data Mining", //6 - 67,576 - Completed
                            "Information Retrieval", //7 - 51,115 - Completed
                            "Natural Language & Speech", //8 - 220,620 - Completed
                            "Graphics", //9 - 59,947 - Crawling
                            "Computer Vision", //10 - 60,897
                            "Human-Computer Interaction", //11 - 80,019
                            "Multimedia", //12 - 80,688
                            "Networks & Communications", //13 - 235,769
                            "World Wide Web", //14 - 35,940
                            "Distributed & Parallel Computing", //15 - 117,953
                            "Operating Systems", //16 - 25,401
                            "Databases", //17 - 142,674
                            "Real-Time & Embedded Systems", //18 - 33,380
                            "Simulation", //19 - 27,682
                            "Bioinformatics & Computational Biology", //20 - 55,734
                            "Scientific Computing", //21 - 184,088
                            "Computer Education", //22 - 49,165
                            "Programming Languages"}; //23 - 70,570
                // -> about 57 days to finish crawling from subdomain 9.

                // firstSubdomain: the first subdomain in subdomains array to crawl.
                // lastSubdomain: the last subdomain in subdomains array to crawl.
                // lastSubdomain = -1 means crawl to the last subdomain in subdomain array.
                // firstSubdomain should be assigned 0, lastSubdomain should be assigned -1 at the begin.
                // start: (the first publication to crawl - 1)
                // end: the last publication to crawl
                // end = 0 means crawl to the last publication in this subdomain
                // start & end should be assigned 0 at the begin
                int firstSubdomain = 9;
                int lastSubdomain = -1;
                int start = 0;
                int end = 0;

                if ((lastSubdomain <= -1) || (lastSubdomain >= subdomains.length))
                    lastSubdomain = subdomains.length - 1;
                else if (lastSubdomain < firstSubdomain)
                    lastSubdomain = subdomains.length + lastSubdomain;

                for (int i = firstSubdomain; i <= lastSubdomain; i++) {
                    try {
                        String subdomain = subdomains[i % subdomains.length];
                        System.out.println("************************************");
                        System.out.println("BEGIN CRAWLING FOR SUBDOMAIN: " + subdomain);
                        System.out.println("************************************");
                        cal = Calendar.getInstance();
                        System.out.println(dateFormat.format(cal.getTime()));
                        CSPublicationCrawlerLogger.logger.warning("************************************");
                        CSPublicationCrawlerLogger.logger.warning("BEGIN CRAWLING FOR SUBDOMAIN: " + subdomain);
                        CSPublicationCrawlerLogger.logger.warning("************************************");
                        CSPublicationCrawlerLogger.logger.warning(dateFormat.format(cal.getTime()));

                        masCrawlerBO.crawl(subdomain, start, end);

                        cal = Calendar.getInstance();
                        System.out.println(dateFormat.format(cal.getTime()));
                        System.out.println("************************************");
                        System.out.println("END CRAWLING FOR SUBDOMAIN: " + subdomain);
                        System.out.println("************************************");
                        CSPublicationCrawlerLogger.logger.warning(dateFormat.format(cal.getTime()));
                        CSPublicationCrawlerLogger.logger.warning("************************************");
                        CSPublicationCrawlerLogger.logger.warning("END CRAWLING FOR SUBDOMAIN: " + subdomain);
                        CSPublicationCrawlerLogger.logger.warning("************************************");

                        start = 0;
                        end = 0;
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
                        Object[] arrObj = ex.getStackTrace();
                        if (arrObj != null)
                            for (Object stackTraceElement : arrObj)
                                CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
                        // Continue crawling error subdomain.
                        i--;
                    }
                }
            }
            else if (CSPublicationCrawlerConst.CRAWLING_FUNCTION == 2) { // Crawl with author based approach.
                if (CSPublicationCrawlerConst.STEP != 2) {
// Bước 1.
                    System.out.println("************************************");
                    System.out.println("BEGIN PHASE 1: Crawl author based information");
                    System.out.println("************************************");
                    cal = Calendar.getInstance();
                    System.out.println(dateFormat.format(cal.getTime()));
                    CSPublicationCrawlerLogger.logger.warning("************************************");
                    CSPublicationCrawlerLogger.logger.warning("BEGIN PHASE 1: Crawl author based information");
                    CSPublicationCrawlerLogger.logger.warning("************************************");
                    CSPublicationCrawlerLogger.logger.warning(dateFormat.format(cal.getTime()));

                    EmbeddedBrowser.driver = new FirefoxDriver();
                    masCrawlerBO.crawlAuthorBased();
                    EmbeddedBrowser.driver.quit();

                    cal = Calendar.getInstance();
                    System.out.println(dateFormat.format(cal.getTime()));
                    System.out.println("************************************");
                    System.out.println("END PHASE 1: Crawl author based information");
                    System.out.println("************************************");
                    CSPublicationCrawlerLogger.logger.warning(dateFormat.format(cal.getTime()));
                    CSPublicationCrawlerLogger.logger.warning("************************************");
                    CSPublicationCrawlerLogger.logger.warning("END PHASE 1: Crawl author based information");
                    CSPublicationCrawlerLogger.logger.warning("************************************");
                }
                if (CSPublicationCrawlerConst.STEP != 1) {
// Bước 2.
                    System.out.println("************************************");
                    System.out.println("BEGIN PHASE 2: Update data");
                    System.out.println("************************************");
                    cal = Calendar.getInstance();
                    System.out.println(dateFormat.format(cal.getTime()));
                    CSPublicationCrawlerLogger.logger.warning("************************************");
                    CSPublicationCrawlerLogger.logger.warning("BEGIN PHASE 2: Update data");
                    CSPublicationCrawlerLogger.logger.warning("************************************");
                    CSPublicationCrawlerLogger.logger.warning(dateFormat.format(cal.getTime()));

                    masCrawlerBO.updateDataAuthorBased();

                    cal = Calendar.getInstance();
                    System.out.println(dateFormat.format(cal.getTime()));
                    System.out.println("************************************");
                    System.out.println("END PHASE 2: Update data");
                    System.out.println("************************************");
                    CSPublicationCrawlerLogger.logger.warning(dateFormat.format(cal.getTime()));
                    CSPublicationCrawlerLogger.logger.warning("************************************");
                    CSPublicationCrawlerLogger.logger.warning("END PHASE 2: Update data");
                    CSPublicationCrawlerLogger.logger.warning("************************************");
                }
            }
            else {
                // Not a function.
            }
            cal = Calendar.getInstance();
            System.out.println(dateFormat.format(cal.getTime()));
            System.out.println("**********************************************************");
            System.out.println("END CRAWLING.");
            System.out.println("**********************************************************");
            CSPublicationCrawlerLogger.logger.warning(dateFormat.format(cal.getTime()));
            CSPublicationCrawlerLogger.logger.warning("**********************************************************");
            CSPublicationCrawlerLogger.logger.warning("END CRAWLING.");
            CSPublicationCrawlerLogger.logger.warning("**********************************************************");
        } catch(Exception ex) {
                ex.printStackTrace();
                CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
                Object[] arrObj = ex.getStackTrace();
                if (arrObj != null)
                    for (Object stackTraceElement : arrObj)
                        CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
        }
    }
}
