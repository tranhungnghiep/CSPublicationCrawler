/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uit.tkorg.cspublicationcrawler.dto;

/**
 *
 * @author Administrator
 * -------------------
 * @author Nghiep H. Tran
 * @since 19/08/2011 : add Constructor
 */
public class AuthorInstanceDTO {
    private int idAuthorInstance;
    private String authorInstanceName = null;    
    private String image = null;
    private String emailAddress = null;
    private String website = null;
    private int idOrg;
    private int h_index;
    private int g_index;
    private String url;
    private int idAuthor;
    
    public AuthorInstanceDTO() {
    }

    /**
     * @return the idAuthorInstance
     */
    public int getIdAuthorInstance() {
        return idAuthorInstance;
    }

    /**
     * @param idAuthorInstance the idAuthorInstance to set
     */
    public void setIdAuthorInstance(int idAuthorInstance) {
        this.idAuthorInstance = idAuthorInstance;
    }

    /**
     * @return the authorInstanceName
     */
    public String getAuthorInstanceName() {
        return authorInstanceName;
    }

    /**
     * @param authorInstanceName the authorInstanceName to set
     */
    public void setAuthorInstanceName(String authorInstanceName) {
        this.authorInstanceName = authorInstanceName;
    }

    /**
     * @return the image
     */
    public String getImage() {
        return image;
    }

    /**
     * @param image the image to set
     */
    public void setImage(String image) {
        this.image = image;
    }

    /**
     * @return the emailAddress
     */
    public String getEmailAddress() {
        return emailAddress;
    }

    /**
     * @param emailAddress the emailAddress to set
     */
    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    /**
     * @return the website
     */
    public String getWebsite() {
        return website;
    }

    /**
     * @param website the website to set
     */
    public void setWebsite(String website) {
        this.website = website;
    }

    /**
     * @return the idOrg
     */
    public int getIdOrg() {
        return idOrg;
    }

    /**
     * @param idOrg the idOrg to set
     */
    public void setIdOrg(int idOrg) {
        this.idOrg = idOrg;
    }

    /**
     * @return the h_index
     */
    public int getH_index() {
        return h_index;
    }

    /**
     * @param h_index the h_index to set
     */
    public void setH_index(int h_index) {
        this.h_index = h_index;
    }

    /**
     * @return the g_index
     */
    public int getG_index() {
        return g_index;
    }

    /**
     * @param g_index the g_index to set
     */
    public void setG_index(int g_index) {
        this.g_index = g_index;
    }

    /**
     * @return the url
     */
    public String getUrl() {
        return url;
    }

    /**
     * @param url the url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * @return the idAuthor
     */
    public int getIdAuthor() {
        return idAuthor;
    }

    /**
     * @param idAuthor the idAuthor to set
     */
    public void setIdAuthor(int idAuthor) {
        this.idAuthor = idAuthor;
    }
}
