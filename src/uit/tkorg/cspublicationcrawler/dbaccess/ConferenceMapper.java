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
import uit.tkorg.cspublicationcrawler.dto.ConferenceDTO;

/**
 *
 * @author Huynh Ngoc Tin
 */
/**
 * 
 * @author Loc Do
 * @since 12/08/2011: fix with new database
 * @since 12/08/2011: add isExisted(url)
 * @version 1.2
 */
public class ConferenceMapper extends MapperDB {
    public ConferenceMapper() throws Exception {
        super();
    }

    public ConferenceMapper(Connection con) {
        super(con);
    }

    /**
     * check if the specified conference exist in the DB
     * @param paperDTO
     * @return -1 if not exists
     *          n if existed
     * @throws Exception
     */
    public int isExisted(ConferenceDTO confDTO) throws Exception {        
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.conference conf");
            sql.append(" WHERE conf.url = ?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, confDTO.getUrl());                                
                ResultSet rs = stmt.executeQuery();
                
                if ((rs != null) && (rs.next())) {                    
                    idObj = rs.getInt("idConference");                                        
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
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.conference conf");
            sql.append(" WHERE conf.url = ?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, url);                                
                ResultSet rs = stmt.executeQuery();
                
                if ((rs != null) && (rs.next())) {                    
                    idObj = rs.getInt("idConference");                                        
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
     * @comment fix the 'organizedLocation' error in database
     * @param authorDTO
     * @throws Exception
     */
    public int insertObj(ConferenceDTO confDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO cspublicationcrawler.conference("
                     + "conferenceName, website, organization, organizedLocation, "
                     + "duration, yearStart, yearEnd, url)");
            sql.append(" VALUES(?, ?, ?, ?, ?, ?, ?, ?)");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, confDTO.getConferenceName());
            stmt.setString(2, confDTO.getWebsite());
            stmt.setString(3, confDTO.getOrganization());
            stmt.setString(4, confDTO.getOrganizedLocation());
            stmt.setString(5, confDTO.getDuration());
            if (confDTO.getYearStart() == -1)
                stmt.setNull(6, java.sql.Types.INTEGER);
            else
                stmt.setInt(6, confDTO.getYearStart());
            if (confDTO.getYearEnd() == -1)
                stmt.setNull(7, java.sql.Types.INTEGER);
            else
                stmt.setInt(7, confDTO.getYearEnd());
            stmt.setString(8 , confDTO.getUrl());
            stmt.execute();

            // get the last inserted ID
            ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID()");
            int insertConfID = -1;
            if (rs != null && rs.next())
                insertConfID = rs.getInt(1);

            stmt.close();
            return insertConfID;
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
     * update existing Conference record     
     * @param confDTO
     * @return number of affected row
     * @throw
     */
    public int updateObj(ConferenceDTO confDTO) throws Exception {
    	 try {
    	     StringBuffer sql = new StringBuffer();
             sql.append("UPDATE cspublicationcrawler.conference");
             sql.append(" SET conferenceName=?, website=?, organization=?,"
                      + " organizedLocation=?, duration=?,"
                      + " yearStart=?, yearEnd=?, url=?");    		
             sql.append(" WHERE idConference=?");
    		 
             PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
             stmt.setString(1, confDTO.getConferenceName());
             stmt.setString(2, confDTO.getWebsite());
             stmt.setString(3, confDTO.getOrganization());
             stmt.setString(4, confDTO.getOrganizedLocation());
             stmt.setString(5, confDTO.getDuration());
            if (confDTO.getYearStart() == -1)
                stmt.setNull(6, java.sql.Types.INTEGER);
            else
                stmt.setInt(6, confDTO.getYearStart());
            if (confDTO.getYearEnd() == -1)
                stmt.setNull(7, java.sql.Types.INTEGER);
            else
                stmt.setInt(7, confDTO.getYearEnd());
             stmt.setString(8, confDTO.getUrl());
             stmt.setInt(9, confDTO.getIdConference());
             
             Boolean isOk = stmt.execute();
             stmt.close();
             
             if (isOk) return 1; 
             else return 0;
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
     * getConferenceNameListForAuthorList     
     * @param authorIDList
     * @return confNameList
     * @throws Exception
     */
    public ArrayList getConferenceNameListForAuthorList(ArrayList authorIDList) throws Exception {
        ArrayList confNameList = new ArrayList();
        StringBuffer sqlStr1 = new StringBuffer();
        try {
            sqlStr1.append(" SELECT c.idConference, c.conferenceName");
            sqlStr1.append(" FROM cspublicationcrawler.conferencec, cspublicationcrawler.paper p");
            sqlStr1.append(" WHERE p.idConference = c.idConference AND p.idPaper IN ");
            sqlStr1.append(" (SELECT ap.idPaper FROM cspublicationcrawler.author_paper ap WHERE ap.idAuthor IN (");
            for (int i=0; i<authorIDList.size(); i++) {
                String curAuthorID = (String) authorIDList.get(i);
                if (i == authorIDList.size()-1)
                    sqlStr1.append(curAuthorID);
                else
                    sqlStr1.append(curAuthorID + ",");
            }
            sqlStr1.append(" ))");
            sqlStr1.append(" GROUP BY c.conferenceName");
            Connection conn = getConnection();
            PreparedStatement stmt1 = conn.prepareStatement(sqlStr1.toString());
            ResultSet rs1 = stmt1.executeQuery();

            while (rs1 != null && rs1.next()) {
                String confName = rs1.getString("conferenceName");
                confNameList.add(confName);
            }

            rs1.close();
            stmt1.close();
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
            return confNameList;
    }
}
