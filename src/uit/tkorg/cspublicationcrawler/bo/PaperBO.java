package uit.tkorg.cspublicationcrawler.bo;

import uit.tkorg.cspublicationcrawler.dbaccess.PaperMapper;
import uit.tkorg.cspublicationcrawler.dto.PaperDTO;
import uit.tkorg.cspublicationcrawler.dbaccess.*;
import uit.tkorg.cspublicationcrawler.dto.*;
import uit.tkorg.cspublicationcrawler.bo.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import uit.tkorg.cspublicationcrawler.controller.MASController;

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
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
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
            MASController.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    MASController.logger.severe("\tat " + stackTraceElement.toString());
            throw ex;
        }
        finally {
            mapper.closeConnection();
        }
    }
	
	
}
