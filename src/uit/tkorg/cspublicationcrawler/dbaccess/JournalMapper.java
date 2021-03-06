/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uit.tkorg.cspublicationcrawler.dbaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;
import uit.tkorg.cspublicationcrawler.dto.JournalDTO;

/**
 *
 * @author Huynh Ngoc Tin
 */
/**
 * 
 * @author Loc Do
 * @since 12/08/2011: fix with new database
 * @since 20/08/2011: add isExisted(url)
 * @version 1.1
 */
public class JournalMapper extends MapperDB {
    public JournalMapper() throws Exception {
        super();
    }

    public JournalMapper(Connection con) {
        super(con);
    }

    /**
     * check if the specified conference exist in the DB
     * @param paperDTO
     * @return
     * @throws Exception
     */
    public int isExisted(JournalDTO journalDTO) throws Exception {
        //boolean isExist = false;
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.journal journal");
            sql.append(" WHERE journal.url = ?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, journalDTO.getUrl());                
                ResultSet rs = stmt.executeQuery();
                if ((rs != null) && (rs.next())) {
                    idObj = rs.getInt("idJournal");
                }
                stmt.close();
            }
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

        return idObj;
    }

    /**
     * Check if existed
     * @param url
     * @return
     * @throws Exception 
     */
        public int isExisted(String url) throws Exception {
        //boolean isExist = false;
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.journal journal");
            sql.append(" WHERE journal.url = ?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, url);
                ResultSet rs = stmt.executeQuery();
                if ((rs != null) && (rs.next())) {
                    idObj = rs.getInt("idJournal");
                }
                stmt.close();
            }
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

        return idObj;
    }
        
     /**
     * insert a new conference into the DB
     * @param authorDTO
     * @throws Exception
     */
    public int insertObj(JournalDTO journalDTO) throws Exception {                
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO cspublicationcrawler.journal(journalName, website, yearStart, yearEnd, organization, url) ");
            sql.append(" VALUES(?, ?, ?, ?, ?, ?)");
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, journalDTO.getJournalName());
            stmt.setString(2, journalDTO.getWebsite());
            if (journalDTO.getYearStart() == -1)
                stmt.setNull(3, java.sql.Types.INTEGER);
            else
                stmt.setInt(3, journalDTO.getYearStart());
            if (journalDTO.getYearEnd() == -1)
                stmt.setNull(4, java.sql.Types.INTEGER);
            else
                stmt.setInt(4, journalDTO.getYearEnd());
            stmt.setString(5, journalDTO.getOrganization());
            stmt.setString(6, journalDTO.getUrl());
            stmt.execute();

            // get the last inserted ID
            ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID()");
            int insertidJournal = -1;
            if (rs != null && rs.next())
                insertidJournal = rs.getInt(1);

            stmt.close();
            return insertidJournal;
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
    }
    
    /**
     * update existing Journal record 
     * @param journalDTO
     * @return number of affected row
     * @throw
     */
    public int updateObj(JournalDTO journalDTO) throws Exception {
    	 try {
    	     StringBuffer sql = new StringBuffer();
             sql.append("UPDATE cspublicationcrawler.journal");
             sql.append(" SET journalName=?, website=?, yearStart=?, yearEnd=?, organization=?, url=?");    		
             sql.append(" WHERE idJournal=?");
    		 
             PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
             stmt.setString(1, journalDTO.getJournalName());
             stmt.setString(2, journalDTO.getWebsite());
            if (journalDTO.getYearStart() == -1)
                stmt.setNull(3, java.sql.Types.INTEGER);
            else
                stmt.setInt(3, journalDTO.getYearStart());
            if (journalDTO.getYearEnd() == -1)
                stmt.setNull(4, java.sql.Types.INTEGER);
            else
                stmt.setInt(4, journalDTO.getYearEnd());
             stmt.setString(5, journalDTO.getOrganization());
             stmt.setString(6, journalDTO.getUrl());
             stmt.setInt(7, journalDTO.getIdJournal());
             
             Boolean isOk = stmt.execute();
             stmt.close();
             
             if (isOk) return 1; 
             else return 0;
         } catch (Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
            throw ex;
    	 }   
    }
}
