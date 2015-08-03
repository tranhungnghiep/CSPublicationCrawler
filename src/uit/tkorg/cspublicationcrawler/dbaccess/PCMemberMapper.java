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
import uit.tkorg.cspublicationcrawler.dto.PCMemberDTO;

/**
 *
 * @author Loc Do
 * @since 14/08/2011: Create
 * @since 20/08/2011: delete affiliation
 * @version 1.0
 */
public class PCMemberMapper extends MapperDB {
    public PCMemberMapper() throws Exception {
        super();
    }

    public PCMemberMapper(Connection con) {
        super(con);
    }
    
    /**
     * insert a new PCMember object into the DB
     * @param PCMemberDTO
     * @return the last inserted PCMember id
     * @throws Exception
     */
    public int insertObj(PCMemberDTO objDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO cspublicationcrawler.PCMember(pcMemberName, "
                    + " image, emailAddress, website, organization)");                                          
            sql.append(" VALUES(?,?,?,?,?,?)");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, objDTO.getPcMemberName());            
            stmt.setString(2, objDTO.getImage());
            stmt.setString(3, objDTO.getEmailAddress());
            stmt.setString(4, objDTO.getWebsite());
            stmt.setString(5, objDTO.getOrganization());
            
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
     * check if the specified PCMember exist in the DB
     * @param PCMemberDTO
     * @return -1 if not found
     * @return  n if found existed
     * @throws Exception
     */
    public int isExisted(PCMemberDTO objDTO) throws Exception {        
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.PCMember");
            sql.append(" WHERE PCMemberName=?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, objDTO.getPcMemberName());                
                ResultSet rs = stmt.executeQuery();
                if ((rs != null) && (rs.next())) {
                    idObj = rs.getInt("idPCMember");                    
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
     * @param PCMemberDTO
     * @return 1 if update successfully
     * @return 0 if update unsuccessfully
     * @throws Exception
     */
    public int updateObj(PCMemberDTO objDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("UPDATE cspublicationcrawler.PCMember");                                          
            sql.append(" SET PCMemberName=?, image=?,"
                    +  " emailAddress=?, website=?, organization=?,");                     
            sql.append(" WHERE idPCMember=?");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, objDTO.getPcMemberName());            
            stmt.setString(2, objDTO.getImage());
            stmt.setString(3, objDTO.getEmailAddress());
            stmt.setString(4, objDTO.getWebsite());
            stmt.setString(5, objDTO.getOrganization());            
            stmt.setInt(6,objDTO.getIdPCMember());
            
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