package uit.tkorg.cspublicationcrawler.bo;

import uit.tkorg.cspublicationcrawler.dbaccess.PaperMapper;
import uit.tkorg.cspublicationcrawler.dto.PaperDTO;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;

/**
 * @author Tin Huynh
 * @author Loc Do
 */
public class PaperBO {

    /**
     * check if the specified paper exist in the DB
     * @param paperDTO
     * @return
     * @throws Exception
     */
    public int isPaperExisted(PaperDTO paperDTO) throws Exception {
        PaperMapper mapper = null;
        try {
            mapper = new PaperMapper();
            return mapper.isExisted(paperDTO);
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

    /**
     * insert a new paper into the DB
     * @param paperDTO
     * @return
     * @throws Exception
     */
    public int insertNewPaper(PaperDTO paperDTO) throws Exception {
        PaperMapper mapper = null;
        try {
            mapper = new PaperMapper();
            return mapper.insertObj(paperDTO);
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
