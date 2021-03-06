/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uit.tkorg.cspublicationcrawler.bo;
import uit.tkorg.cspublicationcrawler.utility.CSPublicationCrawlerLogger;
import uit.tkorg.cspublicationcrawler.dto.*;
import uit.tkorg.cspublicationcrawler.dbaccess.OrgMapper;

/**
 * @author Nghiep H. Tran
 * @author Loc Do
 */
public class OrgBO {
    
    /**
     * find an org. if existed -> update, else insert
     * @param orgURL
     * @return 
     */
    public int findOrInsert(String orgURL) throws Exception {
        int idOrg = -1;
        OrgMapper mapperOrg = new OrgMapper();
        try {
            if ((orgURL == null) || (orgURL.compareTo("") == 0)) return idOrg;
            idOrg = mapperOrg.isExisted(orgURL);
            if (idOrg == -1) {
                OrgDTO dtoOrg = MASPageAnalyzeBO.generateOrgDTOFromHTMLContent(orgURL);
                // Improve robustness to deal with bad data source.
                if (dtoOrg.getOrgName() != null)
                    idOrg = mapperOrg.insertObj(dtoOrg);
            }
            
        } catch (Exception ex) {
            ex.printStackTrace();
            CSPublicationCrawlerLogger.logger.severe("EXCEPTION: " + ex.toString());
            Object[] arrObj = ex.getStackTrace();
            if (arrObj != null)
                for (Object stackTraceElement : arrObj)
                    CSPublicationCrawlerLogger.logger.severe("\tat " + stackTraceElement.toString());
        }
        finally {
            mapperOrg.closeConnection();
        }
        
        return idOrg;        
    }
}
