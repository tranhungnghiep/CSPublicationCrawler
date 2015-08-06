/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package uit.tkorg.cspublicationcrawler.utility;
import java.io.BufferedWriter;
import java.io.FileWriter;

/**
 *
 * @author Tin Huynh
 */
public class CommonTextFileUtility {

    /**
     * writeTextFile
     * @param textFilePath
     * @param appendText
     */
    public static void writeTextFile(String textFilePath, String textContent) {
        try {
            // Create file
            FileWriter fstream = new FileWriter(textFilePath, false);
            BufferedWriter out = new BufferedWriter(fstream);
            out.write(textContent);
            //Close the output stream
            out.close();
        }
        catch (Exception e){//Catch exception if any
            System.err.println("Error: " + e.getMessage());
        }
    }

    /**
     * appendTextFile
     * @param textFilePath
     * @param appendText
     */
    public static void appendTextFile(String textFilePath, String appendText) {
        try {
            // Create file
            FileWriter fstream = new FileWriter(textFilePath, true);
            BufferedWriter out = new BufferedWriter(fstream);
            out.write(appendText);
            //Close the output stream
            out.close();
        }
        catch (Exception e){//Catch exception if any
            System.err.println("Error: " + e.getMessage());
        }
    }
}
