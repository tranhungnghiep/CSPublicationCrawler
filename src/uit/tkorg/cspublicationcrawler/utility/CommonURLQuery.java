/**
 * 
 */
package uit.tkorg.cspublicationcrawler.utility;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import org.apache.commons.validator.UrlValidator;
import org.htmlparser.beans.StringBean;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;
import uit.tkorg.cspublicationcrawler.constant.CSPublicationCrawlerConst;

/**
 *
 * @author Tin, Tien, Cuong
 */
public class CommonURLQuery extends Thread {
    
    /**
     * getHTMLPageContent
     * @param link
     * @return 
     */
    public static String getHTMLPageContent(String link){
        String result = "";
        try {
            UrlValidator urlValidator = new UrlValidator();
            if (urlValidator.isValid(link)) {
                URL url = new URL(link);
                result = getHTMLPageContent(url);
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }
	
    /**
    *
    * @param source : URL to get HTML content
    * @return : String with HTML Tag
    * @throws IOException
    */
    public static String getHTMLPageContent(URL source) throws IOException {
        InputStream in = source.openStream();
        StringBuffer sb = new StringBuffer();
        byte[] buffer = new byte[256];
        while(true) {
            int bytesRead = in.read(buffer);
            if(bytesRead == -1) break;
            for (int i=0; i<bytesRead; i++)
                sb.append((char)buffer[i]);
        }
        return sb.toString();
    }

    /**
     * getHTMLPageContentWithUTF8
     * @param url
     * @return
     * @throws UnsupportedEncodingException
     * @throws IOException 
     */
    public static String getHTMLPageContentWithUTF8(URL url) throws Exception {
        StringBuilder builder = new StringBuilder();
        try {
            URLConnection urlc = url.openConnection();
            urlc.connect();
            if (urlc != null) {
                InputStream inputStream = urlc.getInputStream();
                if (inputStream != null) {
                    InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "UTF8");
                    BufferedReader buffer = new BufferedReader(inputStreamReader);
                    if (buffer != null) {
                        int byteRead;
                        while ((byteRead = buffer.read()) != -1)
                            builder.append((char) byteRead);
                    }
                    buffer.close();
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
            // Improve robustness to deal with MAS's DOS Defense approach.
            Thread.sleep(CSPublicationCrawlerConst.TIME_SLEEP_AFTER_EXCEPTION);
            return null;
        }

        // Improve robustness to deal with MAS's DOS Defense approach.
        Thread.sleep(CSPublicationCrawlerConst.TIME_SLEEP);
        return builder.toString();
    }

    /**
    * getHTMLPageContentWithoutTags
    * @param url : String URL
    * @return : String HTML content without HTML Tag
    */
    public static String getHTMLPageContentWithoutTags(String url) {
        String content = "";
        StringBean stringBean = new StringBean();
        stringBean.setURL(url);
        content = stringBean.getStrings();
        return content;
    }
}
