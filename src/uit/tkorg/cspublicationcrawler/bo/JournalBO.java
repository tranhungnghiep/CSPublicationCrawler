/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uit.tkorg.cspublicationcrawler.bo;

import java.util.ArrayList;
import java.util.HashMap;
import uit.tkorg.cspublicationcrawler.dbaccess.AuthorPaperMapper;
import uit.tkorg.cspublicationcrawler.dbaccess.JournalMapper;
import uit.tkorg.cspublicationcrawler.dto.JournalDTO;
import uit.tkorg.cspublicationcrawler.dbaccess.*;
import uit.tkorg.cspublicationcrawler.dto.*;
import uit.tkorg.cspublicationcrawler.bo.*;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;

/**
 * @author Huynh Ngoc Tin
 * @author Loc Do
 * @author Nghiep H. Tran
 */
public class JournalBO {
    
     /**
     * check if the specified journal exist in the DB
     * @param journalDTO
     * @return
     * @throws Exception
     */
    public int isJournalExisted(JournalDTO journalDTO) throws Exception {
        JournalMapper mapper = null;
        try {
            mapper = new JournalMapper();
            return mapper.isExisted(journalDTO);
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
     * insert a new journal into the DB
     * @param journalDTO
     * @return
     * @throws Exception
     */
    public int insertNewJournal(JournalDTO journalDTO) throws Exception {
        JournalMapper mapper = null;
        try {
            mapper = new JournalMapper();
            return mapper.insertObj(journalDTO);
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
     * get journalID from journalName and year
     * @param journalName
     * @param year
     * @return
     * @throws Exception
     */
    public int getJournalID(String journalName, int year) throws Exception {
        JournalMapper mapper = null;
        try {
            mapper = new JournalMapper();
            JournalDTO journal = new JournalDTO();
            journal.setJournalName(journalName);
            return mapper.isExisted(journal);
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
