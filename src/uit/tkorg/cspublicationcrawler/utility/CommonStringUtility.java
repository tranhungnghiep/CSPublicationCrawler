/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uit.tkorg.cspublicationcrawler.utility;

import java.util.ArrayList;

/**
 *
 * @author Huynh Ngoc Tin
 */
public class CommonStringUtility {
     /**
     * get the position list of the specified string in another string
     * @param strContent
     * @param subStr
     * @return
     */
    public static ArrayList getListIndexOfSubStringInString(String strContent, String subStr){
        int lastIndex = 0;
        ArrayList positionList = new ArrayList();
        while (lastIndex != -1) {
            lastIndex = strContent.indexOf(subStr, lastIndex + 1);
            if (lastIndex != -1){
                positionList.add(new Integer(lastIndex));
            }
        }

        return positionList;
    }

}
