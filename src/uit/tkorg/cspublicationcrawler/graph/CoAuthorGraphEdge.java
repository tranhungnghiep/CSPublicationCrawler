/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uit.tkorg.cspublicationcrawler.graph;

import java.util.ArrayList;

/**
 *
 * @author Tin Huynh
 */
public class CoAuthorGraphEdge {
    int id;
    int firstAuthorID;
    int secondAuthorID;
    String firstAuthorName;
    String secondAuthorName;

    public int getFirstAuthorID() {
        return firstAuthorID;
    }

    public void setFirstAuthorID(int firstAuthorID) {
        this.firstAuthorID = firstAuthorID;
    }

    public String getFirstAuthorName() {
        return firstAuthorName;
    }

    public void setFirstAuthorName(String firstAuthorName) {
        this.firstAuthorName = firstAuthorName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSecondAuthorID() {
        return secondAuthorID;
    }

    public void setSecondAuthorID(int secondAuthorID) {
        this.secondAuthorID = secondAuthorID;
    }

    public String getSecondAuthorName() {
        return secondAuthorName;
    }

    public void setSecondAuthorName(String secondAuthorName) {
        this.secondAuthorName = secondAuthorName;
    }
}
