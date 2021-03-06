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
import uit.tkorg.cspublicationcrawler.dto.OrgDTO;

/**
 *
 * @author Loc Do
 * @since 12/08/2011: Create
 * @since 20/08/2011: fix with new URL, add isExisted(url)
 * @version 1.2
 */
public class OrgMapper extends MapperDB {
    public OrgMapper() throws Exception {
        super();
    }

    public OrgMapper(Connection con) {
        super(con);
    }
    
    /**
     * insert a new Org object into the DB
     * @param orgDTO
     * @return the last inserted Org id
     * @throws Exception
     */
    public int insertObj(OrgDTO objDTO) throws Exception {
        int insertedID = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO cspublicationcrawler.Org(orgName, website,"
                    + " continent, idOrgParent, h_index, url)");                                          
            sql.append(" VALUES(?,?,?,?,?,?)");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, objDTO.getOrgName());
            stmt.setString(2, objDTO.getWebsite());
            stmt.setString(3, objDTO.getContinent());
            if (objDTO.getIdOrgParent() == -1)
                stmt.setNull(4, java.sql.Types.INTEGER);
            else 
                stmt.setInt(4, objDTO.getIdOrgParent());
            if (objDTO.getH_index() == -1)
                stmt.setNull(5, java.sql.Types.INTEGER);
            else
                stmt.setInt(5, objDTO.getH_index());
            stmt.setString(6, objDTO.getUrl());
            
            stmt.execute();

            // get the last inserted ID
            ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID()");
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
     * check if the specified org exist in the DB
     * @param orgDTO
     * @return -1 if not found
     * @return  n if found existed
     * @throws Exception
     */
    public int isExisted(OrgDTO objDTO) throws Exception {        
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.Org");
            sql.append(" WHERE url=?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, objDTO.getUrl());                
                ResultSet rs = stmt.executeQuery();
                if ((rs != null) && (rs.next())) {
                    idObj = rs.getInt("idOrg");
                    return idObj;
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
    
    public int isExisted(String url) throws Exception {        
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.Org");
            sql.append(" WHERE url=?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setString(1, url);                
                ResultSet rs = stmt.executeQuery();
                if ((rs != null) && (rs.next())) {
                    idObj = rs.getInt("idOrg");
                    return idObj;
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
     * @param OrgDTO
     * @return 1 if update successfully
     * @return 0 if update unsuccessfully
     * @throws Exception
     */
    public int updateObj(OrgDTO objDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("UPDATE cspublicationcrawler.Org");                                          
            sql.append(" SET orgName=?, website=?, continent=?,"
                     + " idOrgParent=?, h_index=?, url=?");
            sql.append(" WHERE idOrg=?");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, objDTO.getOrgName());
            stmt.setString(2, objDTO.getWebsite());
            stmt.setString(3, objDTO.getContinent());
            if (objDTO.getIdOrgParent() == -1)
                stmt.setNull(4, java.sql.Types.INTEGER);
            else 
                stmt.setInt(4, objDTO.getIdOrgParent());
            if (objDTO.getH_index() == -1)
                stmt.setNull(5, java.sql.Types.INTEGER);
            else
                stmt.setInt(5, objDTO.getH_index());
            stmt.setString(6, objDTO.getUrl());
            stmt.setInt(7,objDTO.getIdOrg());
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

    public ArrayList<OrgDTO> getOrgList(int offset, int limit) throws Exception {
        ArrayList<OrgDTO> orgList = new ArrayList<OrgDTO>();
        OrgDTO orgDTO = null;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.Org org");
            sql.append(" ORDER BY org.idOrg ASC LIMIT ?, ?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setInt(1, offset);
                stmt.setInt(2, limit);
                ResultSet rs = stmt.executeQuery();
                while ((rs != null) && (rs.next())) {
                    orgDTO = new OrgDTO();
                    orgDTO.setIdOrg(rs.getInt("idOrg"));
                    orgDTO.setIdOrgParent(rs.getInt("idOrgParent"));
                    orgDTO.setOrgName(rs.getString("orgName"));
                    orgDTO.setWebsite(rs.getString("website"));
                    orgDTO.setContinent(rs.getString("continent"));
                    orgDTO.setH_index(rs.getInt("h_index"));
                    orgDTO.setUrl(rs.getString("url"));
                    orgList.add(orgDTO);
                }
                rs.close();
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

        return orgList;
    }
}
