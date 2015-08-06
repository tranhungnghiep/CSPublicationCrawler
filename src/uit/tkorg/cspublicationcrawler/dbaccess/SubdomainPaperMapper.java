/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uit.tkorg.cspublicationcrawler.dbaccess;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import uit.tkorg.cspublicationcrawler.controller.MASController;
import uit.tkorg.cspublicationcrawler.dto.SubdomainPaperDTO;
/**
 * NOTE: don't set the index value automatic increasing
 * @author Loc Do
 * @since 14/08/2011: Create
 * @version 1.0
 */
public class SubdomainPaperMapper extends MapperDB {
    public SubdomainPaperMapper() throws Exception {
        super();
    }

    public SubdomainPaperMapper(Connection con) {
        super(con);
    }
    
    /**
     * insert a new SubdomainPaper object into the DB
     * @param SubdomainPaperDTO
     * @return 1 --> success, -1 --> fail
     * @throws Exception
     */
    public int insertObj(SubdomainPaperDTO objDTO) throws Exception {
        int result = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" INSERT INTO cspublicationcrawler.Subdomain_Paper(idPaper, idSubdomain)");                                          
            sql.append(" VALUES(?, ?)");
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setInt(1, objDTO.getIdPaper());
            stmt.setInt(2, objDTO.getIdSubdomain());            
            stmt.execute();
            stmt.close();
            result = 1;
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
        return result;
    }
    
    /**
     * check if the specified SubdomainPaper exist in the DB
     * @param SubdomainPaperDTO
     * @return -1 if not found
     * @return  1 if found existed
     * @throws Exception
     */
    public int isExisted(SubdomainPaperDTO objDTO) throws Exception {        
        int found = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.Subdomain_Paper");
            sql.append(" WHERE idPaper=? AND idSubdomain=?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setInt(1, objDTO.getIdPaper());                
                stmt.setInt(2, objDTO.getIdSubdomain());
                        
                ResultSet rs = stmt.executeQuery();
                if ((rs != null) && (rs.next())) {
                    found = 1;
                }
                stmt.close();
            }
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

        return found;
    }
    
}
