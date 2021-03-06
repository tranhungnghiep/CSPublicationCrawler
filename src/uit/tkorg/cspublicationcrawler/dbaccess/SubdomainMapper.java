/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uit.tkorg.cspublicationcrawler.dbaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Vector;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;
import uit.tkorg.cspublicationcrawler.dto.SubdomainDTO;

/**
 *
 * @author Loc Do
 * @since 14/08/2011: Create
 * @version 1.0
  * -------------------
 * @author Nghiep H. Tran
 * @since 19/08/2011 : add method isExisted
 * ---------------------
 * @author Huong Tran
 * @since 29/08/2011 : edit method getListObj
 */

public class SubdomainMapper extends MapperDB {
    public SubdomainMapper() throws Exception {
        super();
    }

    public SubdomainMapper(Connection con) {
        super(con);
    }
    
    /**
     * get idSubdomain by subdomain name
     * @param objDTO
     * @return
     * @throws Exception 
     */
    public int isExisted(String subdomain) throws Exception {        
        int idObj = -1;
        
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.Subdomain sd");
            sql.append(" WHERE sd.subdomainName=?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, subdomain);                
                ResultSet rs = stmt.executeQuery();
                if ((rs != null) && (rs.next())) {
                    idObj = rs.getInt("idSubdomain");                    
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
     * insert a new Subdomain object into the DB    
     * @param SubdomainDTO
     * @return the last inserted Subdomain id
     * @throws Exception
     */
    public int insertObj(SubdomainDTO objDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO cspublicationcrawler.Subdomain(subdomainName, idDomain)");                                          
            sql.append(" VALUES(?, ?)");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, objDTO.getSubdomainName());
            stmt.setInt(2, objDTO.getIdDomain());
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
     * check if the specified conference exist in the DB
     * @param paperDTO
     * @return -1 if not found
     * @return  n if found existed
     * @throws Exception
     */
    public int isExisted(SubdomainDTO objDTO) throws Exception {        
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.Subdomain sd");
            sql.append(" WHERE sd.subdomainName=?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, objDTO.getSubdomainName());                
                ResultSet rs = stmt.executeQuery();
                if ((rs != null) && (rs.next())) {
                    idObj = rs.getInt("idSubdomain");                    
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
     * @param SubdomainDTO
     * @return 1 if update successfully
     * @return 0 if update unsuccessfully
     * @throws Exception
     */
    public int updateObj(SubdomainDTO objDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("UPDATE cspublicationcrawler.Subdomain sd");                                          
            sql.append(" SET sd.subdomainName=?, sd.idDomain=?");
            sql.append(" WHERE sd.idSubdomain=?");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, objDTO.getSubdomainName());
            stmt.setInt(2, objDTO.getIdDomain());
            stmt.setInt(3, objDTO.getIdSubdomain());
            
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
     * Get list objects in database
     * @return Hash
     * @throw Exception
     */
    public ResultSet getListObj(String domainName) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("SELECT * FROM cspublicationcrawler.Domain LEFT JOIN cspublicationcrawler.Subdomain");
            sql.append(" ON cspublicationcrawler.Domain.idDomain=cspublicationcrawler.Subdomain.idDomain WHERE cspublicationcrawler.Domain.domainName=?");
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, domainName);   
            ResultSet rs = stmt.executeQuery();
            return rs;
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
