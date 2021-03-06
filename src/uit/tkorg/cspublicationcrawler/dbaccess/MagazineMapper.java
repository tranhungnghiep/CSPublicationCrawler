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
import uit.tkorg.cspublicationcrawler.dto.MagazineDTO;

/**
 *
 * @author Loc Do
 * @since 14/08/2011: Create
 * @since 20/08/2011: fix with new URL, add isExisted(url)
 * @version 1.1
 */
public class MagazineMapper extends MapperDB {
    public MagazineMapper() throws Exception {
        super();
    }

    public MagazineMapper(Connection con) {
        super(con);
    }
    
    /**
     * insert a new Magazine object into the DB
     * @param MagazineDTO
     * @return the last inserted Magazine id
     * @throws Exception
     */
    public int insertObj(MagazineDTO objDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO cspublicationcrawler.Magazine(magazineName, website,"
                    + " yearStart, yearEnd, organization, url)");                                          
            sql.append(" VALUES(?,?,?,?,?,?)");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, objDTO.getMagazineName());
            stmt.setString(2, objDTO.getWebsite());
            if (objDTO.getYearStart() == -1)
                stmt.setNull(3, java.sql.Types.INTEGER);
            else
                stmt.setInt(3, objDTO.getYearStart());
            if (objDTO.getYearEnd() == -1)
                stmt.setNull(4, java.sql.Types.INTEGER);
            else
                stmt.setInt(4, objDTO.getYearEnd());
            stmt.setString(5, objDTO.getOrganization());
            stmt.setString(6, objDTO.getUrl());
            stmt.execute();

            // get the last inserted ID
            ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID()");
            int insertedID = -1;
            if (rs != null && rs.next())
                insertedID = rs.getInt(1);

            stmt.close();
            return insertedID;
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
     * check if the specified Magazine exist in the DB
     * @param MagazineDTO
     * @return -1 if not found
     * @return  n if found existed
     * @throws Exception
     */
    public int isExisted(MagazineDTO objDTO) throws Exception {        
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.Magazine");
            sql.append(" WHERE url=?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, objDTO.getUrl());                
                ResultSet rs = stmt.executeQuery();
                if ((rs != null) && (rs.next())) {
                    idObj = rs.getInt("idMagazine");                
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
            sql.append(" SELECT * FROM cspublicationcrawler.Magazine");
            sql.append(" WHERE url=?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, url);                
                ResultSet rs = stmt.executeQuery();
                if ((rs != null) && (rs.next())) {
                    idObj = rs.getInt("idMagazine");                
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
     * update the existing record in DB
     * @param MagazineDTO
     * @return 1 if update successfully
     * @return 0 if update unsuccessfully
     * @throws Exception
     */
    public int updateObj(MagazineDTO objDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("UPDATE cspublicationcrawler.Magazine");                                          
            sql.append(" SET magazineName=?, website=?, yearStart=?,"
                    +  " yearEnd=?, organization=?,url=?");                     
            sql.append(" WHERE idMagazine=?");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, objDTO.getMagazineName());
            stmt.setString(2, objDTO.getWebsite());
            if (objDTO.getYearStart() == -1)
                stmt.setNull(3, java.sql.Types.INTEGER);
            else
                stmt.setInt(3, objDTO.getYearStart());
            if (objDTO.getYearEnd() == -1)
                stmt.setNull(4, java.sql.Types.INTEGER);
            else
                stmt.setInt(4, objDTO.getYearEnd());
            stmt.setString(5, objDTO.getOrganization()); 
            stmt.setString(6, objDTO.getUrl());
            stmt.setInt(7,objDTO.getIdMagazine());
            
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
}