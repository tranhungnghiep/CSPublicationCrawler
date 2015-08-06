/**
 * 
 */
package uit.tkorg.cspublicationcrawler.bo;

import java.util.ArrayList;
import java.util.HashMap;
import uit.tkorg.cspublicationcrawler.controller.MASController;
import uit.tkorg.cspublicationcrawler.dbaccess.AuthorMapper;
import uit.tkorg.cspublicationcrawler.dbaccess.AuthorPaperMapper;

/**
 * @author Huynh Ngoc Tin
 *
 */
public class AuthorPaperBO {
    /**
     * insert a new author into the DB
     * @param authorDTO
     * @throws Exception
     */
    public void insertNewAuthorPaper(int authorID, int paperID, int author_OrderNum) throws Exception {
        AuthorPaperMapper mapper = null;
        try {
            mapper = new AuthorPaperMapper();
            mapper.insertObj(authorID, paperID);
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
        finally {
            mapper.closeConnection();
        }
    }

    /**
     * get the list CoAuthor of the specified author
     * @param authorName
     * @return
     * @throws Exception
     */
    public ArrayList getCoAuthorList(String authorName) throws Exception {
        ArrayList coAuthorList = new ArrayList();
        ArrayList paperIDList = new ArrayList();
        AuthorMapper authormapper = null;
        AuthorPaperMapper authorPaperMapper = null;
        try {
            authormapper = new AuthorMapper();
            authorPaperMapper = new AuthorPaperMapper();
            int authorID = authormapper.getIDObj(authorName);
            if (authorID != -1) {
                // get all papers relate to this authorID
                paperIDList = authorPaperMapper.getIDPaperListOfAnAuthor(authorID);
                coAuthorList = authorPaperMapper.getCoAuthorDTOList(paperIDList, authorID);
            }

            return coAuthorList;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            authormapper.closeConnection();
            authorPaperMapper.closeConnection();
        }
    }
    
     /**
     * get the list CoAuthor of the specified author (base on authorID)
     * @param authorName
     * @return
     * @throws Exception
     */
    public ArrayList getCoAuthorList(int authorID) throws Exception {
        ArrayList coAuthorList = new ArrayList();
        ArrayList paperIDList = new ArrayList();
        AuthorMapper authormapper = null;
        AuthorPaperMapper authorPaperMapper = null;
        try {
            authormapper = new AuthorMapper();
            authorPaperMapper = new AuthorPaperMapper();
            // get all papers relate to this authorID
            paperIDList = authorPaperMapper.getIDPaperListOfAnAuthor(authorID);
            coAuthorList = authorPaperMapper.getCoAuthorDTOList(paperIDList, authorID);
            return coAuthorList;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            authormapper.closeConnection();
            authorPaperMapper.closeConnection();
        }
    }

    /**
     * check if the importAuthorID and insertPaperID existed in 'authorpaper' table or not.
     * @param importAuthorID
     * @param insertPaperID
     * @return
     * @throws Exception
     */
    public boolean isAuthorPaperExist(int importAuthorID, int insertPaperID) throws Exception {
        AuthorPaperMapper mapper = null;
        try {
            mapper = new AuthorPaperMapper();
            return mapper.isExisted(importAuthorID, insertPaperID) != -1;
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            mapper.closeConnection();
        }
    }

    /**
     * Metrics #1: getTotalPaperInEachConfOfAuthorList
     * @param authorIDList
     * @return
     * @throws Exception
     */
    public HashMap getTotalPaperInEachConfOfAuthorList(ArrayList authorIDList) throws Exception {
        AuthorPaperMapper mapper = null;
        try {
            mapper = new AuthorPaperMapper();
            return mapper.getTotalPaperInEachConfOfAuthorList(authorIDList);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            mapper.closeConnection();
        }
    }

    /**
     * Metrics #1: getTotalPaperInEachJourOfAuthorList
     * @param authorIDList
     * @return
     * @throws Exception
     */
    public HashMap getTotalPaperInEachJourOfAuthorList(ArrayList authorIDList) throws Exception {
        AuthorPaperMapper mapper = null;
        try {
            mapper = new AuthorPaperMapper();
            return mapper.getTotalPaperInEachJourOfAuthorList(authorIDList);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            mapper.closeConnection();
        }
    }

    /**
     * getTotalPaperOfAuthor(String authorName)
     * @param authorName
     * @return
     * @throws Exception
     */
    public double getTotalPaperOfAuthor(String authorName) throws Exception {
        AuthorMapper authorMapper = new AuthorMapper();
        AuthorPaperMapper authorPaperMapper = new AuthorPaperMapper();
        try {
            int authorID = authorMapper.getIDObj(authorName);
            return authorPaperMapper.countTotalPaperOfAnAuthor(authorID);
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            authorMapper.closeConnection();
            authorPaperMapper.closeConnection();
        }
    }
}
