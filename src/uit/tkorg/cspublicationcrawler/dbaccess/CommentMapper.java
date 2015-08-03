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
import uit.tkorg.cspublicationcrawler.dto.CommentDTO;

/**
 * NOTE: trouble with isExisted function.
 * @author Loc Do
 * @since 14/08/2011: Create
 * @version 1.0
 */
public class CommentMapper extends MapperDB {
    public CommentMapper() throws Exception {
        super();
    }

    public CommentMapper(Connection con) {
        super(con);
    }
    
    /**
     * insert a new Comment object into the DB
     * @param CommentDTO
     * @return the last inserted Comment id
     * @throws Exception
     */
    public int insertObj(CommentDTO objDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO cspublicationcrawler.Comment(rating,"
                    + " content, idPaper)");                                          
            sql.append(" VALUES(?,?,?)");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            if (objDTO.getRating() == -1)
                stmt.setNull(1, java.sql.Types.INTEGER);
            else
                stmt.setInt(1, objDTO.getRating());
            stmt.setString(2, objDTO.getContent());
            stmt.setInt(3, objDTO.getIdPaper());
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
     * check if the specified Comment exist in the DB
     * @param CommentDTO
     * @return -1 if not found
     * @return  1 if found existed
     * @throws Exception
     */
    public int isExisted(CommentDTO objDTO) throws Exception {        
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.Comment");
            sql.append(" WHERE idComment=?");
            Connection con = this.getConnection();
            if (con != null) {
                PreparedStatement stmt = con.prepareStatement(sql.toString());
                stmt.setInt(1, objDTO.getIdComment());
                ResultSet rs = stmt.executeQuery();
                stmt.close();
                if ((rs != null) && (rs.next())) {
                    idObj = rs.getInt("idComment");                    
                }

            }
        }
        catch (Exception e) {
            System.out.println(e.toString());
            throw e;
        }

        return idObj;
    }

    
    /**
     * update the existing record in DB
     * @param CommentDTO
     * @return 1 if update successfully
     * @return 0 if update unsuccessfully
     * @throws Exception
     */
    public int updateObj(CommentDTO objDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("UPDATE cspublicationcrawler.Comment");                                          
            sql.append(" SET rating=?, content=?, idPaper=?");                    
            sql.append(" WHERE idComment=?");
            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            if (objDTO.getRating() == -1)
                stmt.setNull(1, java.sql.Types.INTEGER);
            else
                stmt.setInt(1, objDTO.getRating());
            stmt.setString(2, objDTO.getContent());
            stmt.setInt(3,objDTO.getIdPaper());
            stmt.setInt(4, objDTO.getIdComment());
            
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
