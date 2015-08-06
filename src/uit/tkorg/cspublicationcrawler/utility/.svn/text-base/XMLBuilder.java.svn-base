/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uit.tkorg.cspublicationcrawler.utility;

import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter; 

/**
 *
 * @author Tien, Cuong
 */
public class XMLBuilder {

    public static Document buildDocument(String authorName, String interest, Hashtable coAuthors,
                                    Hashtable conferences, Hashtable journals, ArrayList keyword,
                                    ArrayList publication) {

        if (interest == null) interest = "";
        Document document = DocumentHelper.createDocument();

        // root
        Element root = document.addElement("Author").addAttribute("name", authorName);
        root.addAttribute("interest", interest);

        // CoAuthor
        Element listCoAuthor;
        if (coAuthors != null) {
            listCoAuthor = root.addElement("COAUTHOR").addAttribute("count", String.valueOf(coAuthors.size()));
            Enumeration authorNames = coAuthors.keys();
            while(authorNames.hasMoreElements()) {
                String coAuthorName = (String) authorNames.nextElement();
                String coAuthorPubNum = (String) coAuthors.get(coAuthorName);
                Element coAuthor = listCoAuthor.addElement("AUTHOR").addAttribute("co-authored-publications", coAuthorPubNum);
                coAuthor.addText(coAuthorName);
            }
        }
        else
            listCoAuthor = root.addElement("COAUTHOR").addAttribute("count", "");

        // Conference
        Element listConference;
        if (conferences != null) {
            listConference = root.addElement("CONFERENCES").addAttribute("count", String.valueOf(conferences.size()));
            Enumeration confList = conferences.keys();
            while(confList.hasMoreElements()) {
                String confName = (String) confList.nextElement();
                String confPubNum = (String) conferences.get(confName);
                Element confElement = listConference.addElement("CONFERENCE").addAttribute("publications", confPubNum);
                confElement.addText(confName);
            }
        }
        else
            listConference = root.addElement("CONFERENCES").addAttribute("count", "0");

        // Journal
        Element listJournal;
        if (journals != null) {
            listJournal = root.addElement("JOURNALS").addAttribute("count", String.valueOf(journals.size()));
            Enumeration jourList = journals.keys();
            while(jourList.hasMoreElements()) {
                String jourName = (String) jourList.nextElement();
                String jourPubNum = (String) conferences.get(jourName);
                Element jourElement = listJournal.addElement("JOURNAL").addAttribute("publications", jourPubNum);
                jourElement.addText(jourName);
            }
        }
        else
            listJournal = root.addElement("JOURNALS").addAttribute("count", "0");

        // Keyword
        Element listKeyword;
        if (keyword != null) {
            listKeyword = root.addElement("KEYWORDS").addAttribute("count", String.valueOf(keyword.size()));
            for (int i = 0; i < keyword.size(); i++) {
                Element nameKeyword = listKeyword.addElement("KEYWORD").addText((String)(keyword.get(i)));
            }
        }
        else
            listKeyword = root.addElement("KEYWORDS").addAttribute("count", "0");

        // Publications
        Element listPublication;
        if (publication != null) {
            listPublication = root.addElement("PUBLICAITONS").addAttribute(
                            "count", String.valueOf(publication.size()));
            for (int i = 0; i < publication.size(); i++) {
            	if (i>=72) {
            		String test = (String) publication.get(i);
            		Element title = listPublication.addElement("PUBLICAITON").addText(test);
            	}
            	else {
            		Element title = listPublication.addElement("PUBLICAITON").addText((String)publication.get(i));
            	}
                    
            }
        }
        else
            listPublication = root.addElement("PUBLICAITONS").addAttribute("count", "0");

        return document;
    }

    /**
     *
     * @param document
     *            : XML file
     * @param path
     *            : place to save XML file
     * @throws IOException
     */

    public static void write(Document document, String path) throws IOException {         
        FileOutputStream fos = new FileOutputStream(path);
        OutputFormat format = OutputFormat.createPrettyPrint();
        XMLWriter writer = new XMLWriter(fos, format);
        writer.write(document);
        writer.flush();
    }
}

