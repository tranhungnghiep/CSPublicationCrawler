package uit.tkorg.cspublicationcrawler.dbaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import uit.tkorg.cspublicationcrawler.dto.AuthorInstanceDTO;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;

/**
 * @author Huynh Ngoc Tin
 *
 */
public class AuthorInstanceMapper extends MapperDB{
	
    public AuthorInstanceMapper() throws Exception {
        super();
    }

    public AuthorInstanceMapper(Connection con) {
        super(con);
            // TODO Auto-generated constructor stub
    }

    /**
     * insert a new instanceName for the specified author into the DB
     * @param authorDTO
     * @throws Exception
     */
    public int insertNewAuthorInstance(AuthorInstanceDTO authorInstanceDTO) throws Exception {
        try {
            StringBuffer sql = new StringBuffer();
            sql.append("INSERT INTO cspublicationcrawler.authorinstance(authorInstanceName, image, emailAddress, website, idOrg, h_index, g_index, url, idAuthor) ");
            sql.append(" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)");
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, authorInstanceDTO.getAuthorInstanceName());
            stmt.setString(2, authorInstanceDTO.getImage());
            stmt.setString(3, authorInstanceDTO.getEmailAddress());
            stmt.setString(4, authorInstanceDTO.getWebsite());
            if (authorInstanceDTO.getIdOrg() == -1)
                stmt.setNull(5, java.sql.Types.INTEGER);
            else 
                stmt.setInt(5, authorInstanceDTO.getIdOrg());
            if (authorInstanceDTO.getH_index() == -1)
                stmt.setNull(6, java.sql.Types.INTEGER);
            else
                stmt.setInt(6, authorInstanceDTO.getH_index());
            if (authorInstanceDTO.getG_index() == -1)
                stmt.setNull(7, java.sql.Types.INTEGER);
            else
                stmt.setInt(7, authorInstanceDTO.getG_index());
            stmt.setString(8, authorInstanceDTO.getUrl());
            if (authorInstanceDTO.getIdAuthor() == -1)
                stmt.setNull(9, java.sql.Types.INTEGER);
            else
                stmt.setInt(9, authorInstanceDTO.getIdAuthor());
            
            stmt.execute();

            // get the last inserted ID
            ResultSet rs = stmt.executeQuery("SELECT LAST_INSERT_ID()");
            int insertAuthorID = -1;
            if (rs != null && rs.next())
                insertAuthorID = rs.getInt(1);
            stmt.close();
            return insertAuthorID;
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
     * check If the authorinstance exist in DB
     * @param authorDTO
     * @return
     * @throws Exception
     */
    public int isExisted(AuthorInstanceDTO authorInstanceDTO) throws Exception {
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.authorinstance authorinstance");
            sql.append(" WHERE authorinstance.url = ? ");            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, authorInstanceDTO.getUrl());
            ResultSet rs = stmt.executeQuery();
            if ((rs != null) && (rs.next())) {
                idObj = rs.getInt("idAuthorInstance");
            }
            stmt.close();
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
     * Check if the authorinstance exist in DB
     * @param url
     * @return
     * @throws Exception 
     */
    public int isExisted(String url) throws Exception {        
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.authorinstance authorinstance");
            sql.append(" WHERE authorinstance.url = ? ");            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, url);
            ResultSet rs = stmt.executeQuery();
            if ((rs != null) && (rs.next())) {
                idObj = rs.getInt("idAuthorInstance");
            }
            stmt.close();
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
     * getIdAuthorByUrl
     * @param url
     * @return
     * @throws Exception 
     */
    public int getIdAuthorByUrl(String url) throws Exception {        
        int idObj = -1;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.authorinstance authorinstance");
            sql.append(" WHERE authorinstance.url = ? ");            
            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setString(1, url);
            ResultSet rs = stmt.executeQuery();
            if ((rs != null) && (rs.next())) {
                idObj = rs.getInt("idAuthor");
            }
            stmt.close();
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
     * updateObj
     * @param authorInstanceDTO
     * @return
     * @throws Exception 
     */
    public boolean updateObj(AuthorInstanceDTO authorInstanceDTO) throws Exception {
        boolean isUpdated = false;
        try {
          StringBuffer sql = new StringBuffer();
          sql.append("UPDATE cspublicationcrawler.authorinstance");
          sql.append(" SET");
          sql.append(" authorInstanceName=?,");
          sql.append(" image=?,");
          sql.append(" emailAddress=?,");
          sql.append(" website=?,");
          sql.append(" idOrg=?,");
          sql.append(" h_index=?,");
          sql.append(" g_index=?,");
          sql.append(" url=?");
          sql.append(" idAuthor=?");
          sql.append(" WHERE idAuthorInstance=?");
           
          PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
          stmt.setString(1, authorInstanceDTO.getAuthorInstanceName());          
          stmt.setString(2, authorInstanceDTO.getImage());
          stmt.setString(3, authorInstanceDTO.getEmailAddress());
          stmt.setString(4, authorInstanceDTO.getWebsite());
            if (authorInstanceDTO.getIdOrg() == -1)
                stmt.setNull(5, java.sql.Types.INTEGER);
            else 
              stmt.setInt(5, authorInstanceDTO.getIdOrg());
            if (authorInstanceDTO.getH_index() == -1)
                stmt.setNull(6, java.sql.Types.INTEGER);
            else
                stmt.setInt(6, authorInstanceDTO.getH_index());
            if (authorInstanceDTO.getG_index() == -1)
                stmt.setNull(7, java.sql.Types.INTEGER);
            else
                stmt.setInt(7, authorInstanceDTO.getG_index());
          stmt.setString(8, authorInstanceDTO.getUrl());
            if (authorInstanceDTO.getIdAuthor() == -1)
                stmt.setNull(9, java.sql.Types.INTEGER);
            else 
              stmt.setInt(9, authorInstanceDTO.getIdAuthor());
          stmt.setInt(10, authorInstanceDTO.getIdAuthorInstance());
            
          ResultSet rs = stmt.executeQuery();
          if ((rs != null) && (rs.next())) {
              isUpdated = true;
          }
          
          stmt.close();
            
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
        return isUpdated;
    }
     
    /**
     * getAuthorInstanceDTOByIdAuthorInstance
     * @param idAuthorInstance
     * @return
     * @throws Exception 
     */
    public AuthorInstanceDTO getAuthorInstanceDTOByIdAuthorInstance(int idAuthorInstance) throws Exception {
        AuthorInstanceDTO authorInstanceDTO = new AuthorInstanceDTO();
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.authorinstance authorinstance");
            sql.append(" WHERE authorinstance.idAuthorInstance = ?");

            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setInt(1, idAuthorInstance);

            ResultSet rs = stmt.executeQuery();
            if ((rs != null) && (rs.next())) {
                authorInstanceDTO.setIdAuthorInstance(idAuthorInstance);
                authorInstanceDTO.setAuthorInstanceName(rs.getString("authorInstanceName"));
                authorInstanceDTO.setEmailAddress(rs.getString("emailAddress"));
                authorInstanceDTO.setImage(rs.getString("image"));
                authorInstanceDTO.setWebsite(rs.getString("website"));
                authorInstanceDTO.setH_index(rs.getInt("h_index"));
                authorInstanceDTO.setG_index(rs.getInt("g_index"));
                authorInstanceDTO.setIdOrg(rs.getInt("idOrg"));
                authorInstanceDTO.setUrl(rs.getString("url"));
                authorInstanceDTO.setIdAuthor(rs.getInt("idAuthor"));
            }

            rs.close();
            stmt.close();
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

        return authorInstanceDTO;
    }

    /**
     * getAuthorInstanceDTOByIdAuthor
     * @param idAuthor
     * @return
     * @throws Exception 
     */
    public ArrayList<AuthorInstanceDTO> getAuthorInstanceDTOByIdAuthor(int idAuthor) throws Exception {
        ArrayList<AuthorInstanceDTO> authorInstanceList = new ArrayList<AuthorInstanceDTO>();
        AuthorInstanceDTO authorInstanceDTO = null;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.authorinstance authorinstance");
            sql.append(" WHERE authorinstance.idAuthor = ?");

            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());
            stmt.setInt(1, idAuthor);

            ResultSet rs = stmt.executeQuery();
            while ((rs != null) && (rs.next())) {
                authorInstanceDTO = new AuthorInstanceDTO();
                authorInstanceDTO.setIdAuthorInstance(rs.getInt("idAuthorInstance"));
                authorInstanceDTO.setAuthorInstanceName(rs.getString("authorInstanceName"));
                authorInstanceDTO.setEmailAddress(rs.getString("emailAddress"));
                authorInstanceDTO.setImage(rs.getString("image"));
                authorInstanceDTO.setWebsite(rs.getString("website"));
                authorInstanceDTO.setH_index(rs.getInt("h_index"));
                authorInstanceDTO.setG_index(rs.getInt("g_index"));
                authorInstanceDTO.setIdOrg(rs.getInt("idOrg"));
                authorInstanceDTO.setUrl(rs.getString("url"));
                authorInstanceDTO.setIdAuthor(idAuthor);
                authorInstanceList.add(authorInstanceDTO);
            }

            rs.close();
            stmt.close();
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

        return authorInstanceList;
    }
    
    /**
     * getAuthorInstanceList
     * @return
     * @throws Exception 
     */
    public ArrayList<AuthorInstanceDTO> getAuthorInstanceList() throws Exception {
        ArrayList<AuthorInstanceDTO> authorInstanceList = new ArrayList<AuthorInstanceDTO>();
        AuthorInstanceDTO authorInstanceDTO = null;
        try {
            StringBuffer sql = new StringBuffer();
            sql.append(" SELECT * FROM cspublicationcrawler.authorinstance authorinstance");

            PreparedStatement stmt = getConnection().prepareStatement(sql.toString());

            ResultSet rs = stmt.executeQuery();
            while ((rs != null) && (rs.next())) {
                authorInstanceDTO = new AuthorInstanceDTO();
                authorInstanceDTO.setIdAuthorInstance(rs.getInt("idAuthorInstance"));
                authorInstanceDTO.setAuthorInstanceName(rs.getString("authorInstanceName"));
                authorInstanceDTO.setEmailAddress(rs.getString("emailAddress"));
                authorInstanceDTO.setImage(rs.getString("image"));
                authorInstanceDTO.setWebsite(rs.getString("website"));
                authorInstanceDTO.setH_index(rs.getInt("h_index"));
                authorInstanceDTO.setG_index(rs.getInt("g_index"));
                authorInstanceDTO.setIdOrg(rs.getInt("idOrg"));
                authorInstanceDTO.setUrl(rs.getString("url"));
                authorInstanceDTO.setIdAuthor(rs.getInt("idAuthor"));
                authorInstanceList.add(authorInstanceDTO);
            }

            rs.close();
            stmt.close();
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

        return authorInstanceList;
    }
}
