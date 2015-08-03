/**
 * @author Tin Huynh
 * @author Nghiep H. Tran
 * @author Loc Do
 */
package uit.tkorg.cspublicationcrawler.bo;

import uit.tkorg.cspublicationcrawler.dbaccess.AuthorInstanceMapper;
import uit.tkorg.cspublicationcrawler.dbaccess.AuthorMapper;
import uit.tkorg.cspublicationcrawler.dto.AuthorDTO;
import uit.tkorg.cspublicationcrawler.dbaccess.*;
import uit.tkorg.cspublicationcrawler.dto.*;
import uit.tkorg.cspublicationcrawler.bo.*;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;
    
public class AuthorBO {
    
    /**
     * get authorID from authorName
     * @param authorName
     * @return
     * @throws Exception
     */
    public int getAuthorID(String authorName) throws Exception {
        AuthorMapper mapper = null;
        try {
            mapper = new AuthorMapper();
            return mapper.getIDObj(authorName);
        }
        catch (Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
            throw ex;
        }
        finally {
            mapper.closeConnection();
        }
    }
}
