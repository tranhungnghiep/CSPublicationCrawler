/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uit.tkorg.cspublicationcrawler.bo;

import edu.uci.ics.jung.graph.UndirectedSparseGraph;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import uit.tkorg.cspublicationcrawler.dbaccess.AuthorMapper;
import uit.tkorg.cspublicationcrawler.dbaccess.AuthorPaperMapper;
import uit.tkorg.cspublicationcrawler.dto.AuthorDTO;
import uit.tkorg.cspublicationcrawler.dto.CrawlAuthorDTO;
import uit.tkorg.cspublicationcrawler.dto.InputConferenceDTO;
import uit.tkorg.cspublicationcrawler.dto.InputPaperDTO;
import uit.tkorg.cspublicationcrawler.dto.PCMemberConfGraphDTO;
import uit.tkorg.cspublicationcrawler.graph.CoAuthorGraphEdge;
import uit.tkorg.cspublicationcrawler.graph.CoAuthorGraphVertex;
import uit.tkorg.cspublicationcrawler.utility.CommonTextFileUtility;
import uit.tkorg.cspublicationcrawler.utility.HashMapUtility;

/**
 * @author Huynh Ngoc Tin
 *
 */
public class CoAuthorGraphBO {
    /**
     * buildCoAuthorGraph
     * @param authorNameList
     * @param depthLevel
     * @return
     * @throws Exception
     */
    public UndirectedSparseGraph buildCoAuthorGraph(ArrayList authorNameList, String depthLevel) throws Exception {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar cal = Calendar.getInstance();
        System.out.println(dateFormat.format(cal.getTime()));
        System.out.print("**************************************************************************" );
        System.out.print("-----BEGIN BUILDING NETWORK FOR " +  authorNameList.size() + " AUTHORS:" );
        System.out.print("**************************************************************************" );
        for (int m=0; m<authorNameList.size(); m++) {
            System.out.print(authorNameList.get(m) + ";");
        }
        UndirectedSparseGraph graph = new UndirectedSparseGraph();
        AuthorMapper authorMapper = new AuthorMapper();
        AuthorPaperMapper authorPaperMapper = new AuthorPaperMapper();
        
        try {
            ArrayList notQueryAuthorList = new ArrayList();
            ArrayList alreadyQueryAuthorList = new ArrayList();
            CrawlAuthorDTO queryingAuthorDTO = new CrawlAuthorDTO();
            if (authorNameList != null) {
                for (int i=0; i<authorNameList.size(); i++) {
                    int curAuthorID = authorMapper.getIDObj((String) authorNameList.get(i));
                    if (curAuthorID != -1) { // found in author in DB
                        queryingAuthorDTO = new CrawlAuthorDTO();
                        queryingAuthorDTO.setAuthorID(curAuthorID);
                        queryingAuthorDTO.setAuthorName((String) authorNameList.get(i));
                        queryingAuthorDTO.setCrawlDepthLevel(1);
                        notQueryAuthorList.add(queryingAuthorDTO);
                    }
                }
            }

            // Begin of Query & Building CoAuthorGraph Progress
            while ((notQueryAuthorList != null) && (notQueryAuthorList.size() > 0)) {
                queryingAuthorDTO = (CrawlAuthorDTO) notQueryAuthorList.get(0);

                // Check if the depth level is reached and stop the progress of Query & Building CoAuthorGraph.
                if (!depthLevel.equalsIgnoreCase("Unlimited")) {
                    int curQueryDepthLevel = queryingAuthorDTO.getCrawlDepthLevel();
                    if (curQueryDepthLevel > Integer.parseInt(depthLevel)){
                        notQueryAuthorList.clear();
                        break;
                    }
                }

                // Check if author existed in the graph or not --> Add new Vertex to CoAuthorGraph
                CoAuthorGraphVertex queryAuthorVertex = null;
                boolean existInGraph = false;
                Collection vertices = graph.getVertices();
                Iterator iter = vertices.iterator();
                while (iter != null && iter.hasNext()) {
                    CoAuthorGraphVertex authorVertex = (CoAuthorGraphVertex) iter.next();
                    int authorVertexID = authorVertex.getAuthorId();
                    if (queryingAuthorDTO.getAuthorID() == authorVertexID) {
                        existInGraph = true;
                        queryAuthorVertex = authorVertex;
                        break;
                    }
                }
                
                if (!existInGraph) { // add to graph if author not exist in the graph
                    queryAuthorVertex = calculatePropertyForAuthorVertex(queryingAuthorDTO.getAuthorID(), queryingAuthorDTO.getAuthorName());
                    graph.addVertex(queryAuthorVertex);
                }

                // get the co-cothor list of the Querying author to add to the list 'notQueryAuthorList'
                ArrayList paperIDList = authorPaperMapper.getIDPaperListOfAnAuthor(queryingAuthorDTO.getAuthorID());
                ArrayList coAuthorList = authorPaperMapper.getCoAuthorDTOList(paperIDList, queryingAuthorDTO.getAuthorID());
                if (coAuthorList != null) {
                    for (int i=0; i<coAuthorList.size(); i++){
                        AuthorDTO coAuthorDTO = (AuthorDTO) coAuthorList.get(i);
                        int curCoAuthorID = coAuthorDTO.getIdAuthor();
                        String curCoAuthorName = coAuthorDTO.getAuthorName();
                        // Check if this author exist in the 'notQueryAuthorList' or not
                        boolean found = false;
                        for (int j=0; j<notQueryAuthorList.size(); j++) {
                            CrawlAuthorDTO notQueryAuthorDTO = (CrawlAuthorDTO) notQueryAuthorList.get(j);
                            if (curCoAuthorID == notQueryAuthorDTO.getAuthorID()) {
                                found = true;
                                break;
                            }
                        }

                        // Check if this author exist in the 'alreadyQueryAuthorList' or not
                        for (int k=0; k<alreadyQueryAuthorList.size(); k++) {
                            CrawlAuthorDTO alreadyQueryAuthorDTO = (CrawlAuthorDTO) alreadyQueryAuthorList.get(k);
                            if (curCoAuthorID == alreadyQueryAuthorDTO.getAuthorID()) {
                                found = true;
                                break;
                            }
                        }

                        // add a new co-author into the 'notQueryAuthorList' list.
                        if (found == false) {
                            CrawlAuthorDTO newQueryAuthorDTO = new CrawlAuthorDTO();
                            newQueryAuthorDTO.setAuthorID(curCoAuthorID);
                            newQueryAuthorDTO.setAuthorName(curCoAuthorName);
                            newQueryAuthorDTO.setCrawlDepthLevel(queryingAuthorDTO.getCrawlDepthLevel() + 1);
                            notQueryAuthorList.add(newQueryAuthorDTO);
                        }

                        // Check if author existed in the graph or not --> Add new Vertex to CoAuthorGraph
                        existInGraph = false;
                        vertices = graph.getVertices();
                        iter = vertices.iterator();
                        CoAuthorGraphVertex curAuthorVertex = null;
                        while (iter != null && iter.hasNext()) {
                            curAuthorVertex = (CoAuthorGraphVertex) iter.next();
                            int authorVertexID = curAuthorVertex.getAuthorId();
                            if (curCoAuthorID == authorVertexID) {
                                existInGraph = true;
                                break;
                            }
                        }

                        if (!existInGraph) { // add to graph if author not exist in the graph
                            CoAuthorGraphVertex coAuthorVertex = null;
                            coAuthorVertex = calculatePropertyForAuthorVertex(curCoAuthorID, curCoAuthorName);
                            graph.addVertex(coAuthorVertex);
                            CoAuthorGraphEdge newEdge = new CoAuthorGraphEdge();
                            newEdge.setFirstAuthorID(queryingAuthorDTO.getAuthorID());
                            newEdge.setSecondAuthorID(curCoAuthorID);
                            newEdge.setFirstAuthorName(queryingAuthorDTO.getAuthorName());
                            newEdge.setSecondAuthorName(curCoAuthorName);
                            graph.addEdge(newEdge , queryAuthorVertex, coAuthorVertex);
                        }
                        else {
                            // Kiem tra xem co canh chua --> them canh cua 2 dinh
                            if (queryAuthorVertex != null && curAuthorVertex != null) {
                                CoAuthorGraphEdge newEdge = new CoAuthorGraphEdge();
                                newEdge.setFirstAuthorID(queryingAuthorDTO.getAuthorID());
                                newEdge.setSecondAuthorID(curCoAuthorID);
                                newEdge.setFirstAuthorName(queryingAuthorDTO.getAuthorName());
                                newEdge.setSecondAuthorName(curCoAuthorName);
                                graph.addEdge(newEdge , queryAuthorVertex, curAuthorVertex);
                            }
                        }
                    } // emd of for (...) of coAuthorList
                }

                alreadyQueryAuthorList.add(queryingAuthorDTO);
                // remove the first queryAuthorDTO in the 'notQueryAuthorList' list
                notQueryAuthorList.remove(0);
            } // end of while (...)

            // clear all list
            notQueryAuthorList.clear();
            alreadyQueryAuthorList.clear();
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            authorMapper.closeConnection();
            authorPaperMapper.closeConnection();
        }

        cal = Calendar.getInstance();
        System.out.println(dateFormat.format(cal.getTime()));
        System.out.print("**************************************************************************" );
        System.out.print("-----END BUILDING NETWORK FOR " +  authorNameList.size() + " AUTHORS." );
        System.out.print("**************************************************************************" );
        return graph;
    }

    /**
     * calculate and initial properties/values of authorVertex of the CoAuthorGraph
     * @param authorName
     * @return
     * @throws Exception
     */
    public CoAuthorGraphVertex calculatePropertyForAuthorVertex(int authorID, String authorName) throws Exception {
        CoAuthorGraphVertex authorVertex = new CoAuthorGraphVertex();
        try {
            if (authorID != -1) {
                authorVertex.setAuthorId(authorID);
                authorVertex.setAuthorName(authorName);
            }
        }
        catch (Exception e) {
            throw e;
        }
        finally {
        }

        return authorVertex;
    }

    /**
     * getAuthorVertexIDListInGraph
     * @param graph
     * @return
     * @throws Exception
     */
    public ArrayList getAuthorVertexIDListInGraph(UndirectedSparseGraph graph) throws Exception {
        Collection vertices = graph.getVertices();
        Iterator iter = vertices.iterator();
        CoAuthorGraphVertex curAuthorVertex = null;
        ArrayList authorVertexIDList = new ArrayList();
        while (iter != null && iter.hasNext()) {
            curAuthorVertex = (CoAuthorGraphVertex) iter.next();
            int curAuthorVertexID = curAuthorVertex.getAuthorId();
            authorVertexIDList.add(new Integer(curAuthorVertexID));
        }

        return authorVertexIDList;
    }

    /**
     * getOverlapVertexIDListOfTwoGraph
     * @param graph1
     * @param graph2
     * @return
     * @throws Exception
     */
    public ArrayList getOverlapVertexIDListOfTwoGraph(UndirectedSparseGraph graph1, UndirectedSparseGraph graph2) throws Exception {
        ArrayList overlapVertexIDList = new ArrayList();
        try {
            Collection verticesGraph1 = graph1.getVertices();
            Iterator iterGraph1 = verticesGraph1.iterator();
            CoAuthorGraphVertex curAuthorVertexGraph1 = null;
            while (iterGraph1 != null && iterGraph1.hasNext()) {
                curAuthorVertexGraph1 = (CoAuthorGraphVertex) iterGraph1.next();
                String curAuthorVertexNameGraph1 = curAuthorVertexGraph1.getAuthorName();
                int curAuthorVertexIDGraph1 = curAuthorVertexGraph1.getAuthorId();

                Collection verticesGraph2 = graph2.getVertices();
                Iterator iterGraph2 = verticesGraph2.iterator();
                CoAuthorGraphVertex curAuthorVertexGraph2 = null;
                while (iterGraph2 != null && iterGraph2.hasNext()) {
                    curAuthorVertexGraph2 = (CoAuthorGraphVertex) iterGraph2.next();
                    String curAuthorVertexNameGraph2 = curAuthorVertexGraph2.getAuthorName();
                    int curAuthorVertexIDgraph2 = curAuthorVertexGraph2.getAuthorId();
                    if ((curAuthorVertexIDGraph1 == curAuthorVertexIDgraph2) && (curAuthorVertexNameGraph1.equalsIgnoreCase(curAuthorVertexNameGraph2))) {
                        overlapVertexIDList.add(new Integer(curAuthorVertexIDGraph1));
                        break;
                    }
                }
            }
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        finally {
        }

        return overlapVertexIDList;
    }

    /**
     * countOverlapOfTwoGraphOnNodeName
     * @param graph1
     * @param graph2
     * @return
     * @throws Exception
     */
    public int countOverlapOfTwoGraphOnNodeName(UndirectedSparseGraph graph1, UndirectedSparseGraph graph2) throws Exception {
        int numberOfOverlapedNode = 0;
        try {
            Collection verticesGraph1 = graph1.getVertices();
            Iterator iterGraph1 = verticesGraph1.iterator();
            CoAuthorGraphVertex curAuthorVertexGraph1 = null;
            while (iterGraph1 != null && iterGraph1.hasNext()) {
                curAuthorVertexGraph1 = (CoAuthorGraphVertex) iterGraph1.next();
                String curAuthorVertexNameGraph1 = curAuthorVertexGraph1.getAuthorName();
                
                Collection verticesGraph2 = graph2.getVertices();
                Iterator iterGraph2 = verticesGraph2.iterator();
                CoAuthorGraphVertex curAuthorVertexGraph2 = null;
                while (iterGraph2 != null && iterGraph2.hasNext()) {
                    curAuthorVertexGraph2 = (CoAuthorGraphVertex) iterGraph2.next();
                    String curAuthorVertexNameGraph2 = curAuthorVertexGraph2.getAuthorName();
                    if (curAuthorVertexNameGraph1.equalsIgnoreCase(curAuthorVertexNameGraph2)) {
                        numberOfOverlapedNode += 1;
                        break;
                    }
                }
            }
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        finally {
        }

        return numberOfOverlapedNode;
    }

    /**
     * countTotalPaperInNetwork
     * @param authorIDList
     * @param confNameList
     * @return
     * @throws Exception
     */
    public double countTotalPaperOfAuthorIDList(ArrayList authorIDList, ArrayList confNameList) throws Exception {
        double totalPaperInNetwork = 0;
        AuthorPaperMapper authorPaperMapper = new AuthorPaperMapper();
        try {
            for (int i=0; i<confNameList.size(); i++) {
                String confName = (String) confNameList.get(i);
                double totalPaperInOneConference = 0;
                for (int j=0; j<authorIDList.size(); j++) {
                    int curAuthorID = ((Integer) authorIDList.get(j)).intValue() ;
                    double totalPaperOfAuthorInConf = authorPaperMapper.countTotalPaperInConfOfAnAuthor(curAuthorID, confName);
                    totalPaperInOneConference += totalPaperOfAuthorInConf;
                }
                totalPaperInNetwork += totalPaperInOneConference;
            }
        }
        catch (Exception e) {
            throw e;
        }
        finally {
            authorPaperMapper.closeConnection();
        }
        return totalPaperInNetwork;
    }

    /**
     * CalculateMetricAndExportToFile
     * @param inputConfList
     * @param fileName
     * @throws Exception
     */
    public void calculateMetricAndExportToFile(ArrayList inputConfList, String output_metric1_file, String output_metric2_file, String output_metric3_file,
                                                String output_metric4_file, String output_metric5_file, String output_metric6_file,
                                                String output_metric7_file, String output_metric8_file, String output_review_file) throws Exception {
        try {
            // get the list of conference name (16 conferences)
            ArrayList initConfNameList = new ArrayList();
            for (int i=0; i<inputConfList.size(); i++) {
                InputConferenceDTO inConfDTO = (InputConferenceDTO) inputConfList.get(i);
                initConfNameList.add(inConfDTO.getConfName());
            }

            //this.calculateMetric1(inputConfList, initConfNameList, output_metric1_file);
            //this.calculateMetric2(inputConfList, initConfNameList, output_metric2_file);
            //this.calculateMetric3(inputConfList, initConfNameList, output_metric3_file);
            //this.calculateMetricsWithPCMember(inputConfList, initConfNameList,
            //        output_metric4_file, output_metric5_file, output_metric6_file, output_metric7_file, output_metric8_file);

            this.writeSomeOutputResultsToReview_2(inputConfList, initConfNameList, output_review_file);
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        finally {
        }
    }

    /**
     * count the total paper in the network of each Conference (16 conference)
     * @param inputConfList
     * @param output_metric1_file
     * @throws Exception
     */
    public void calculateMetric1(ArrayList inputConfList, ArrayList initConfNameList, String output_metric1_file) throws Exception {
        System.out.println("-------------------------------------------------");
        System.out.println(" BEGIN-Calculating Metric #1 & write to the txt file");
        System.out.println("-------------------------------------------------");
        StringBuffer outStringBuffer = new StringBuffer();
        ConferenceBO confBO = new ConferenceBO();
        AuthorMapper authorMapper = new AuthorMapper();
        DecimalFormat df = new DecimalFormat("#.##########");
        try {
            // Loop through all conf in the list
            for (int i=0; i<inputConfList.size(); i++) {
                InputConferenceDTO inConfDTO = (InputConferenceDTO) inputConfList.get(i);
                String confName = inConfDTO.getConfName();
                outStringBuffer.append("###" + confName + "\n");
                System.out.println((i+1) + "." + confName);
                ArrayList inputPaperDTOList = inConfDTO.getPaperList();
                for (int j=0; j<inputPaperDTOList.size(); j++) {
                    InputPaperDTO inPaperDTO = (InputPaperDTO) inputPaperDTOList.get(j);
                    int depthLevel = inPaperDTO.getDepthLevelForCoAuthorNet();
                    ArrayList authorNameList = inPaperDTO.getAuthorNameList();
                    // build co-author network for authors in the current paper
                    System.out.println((j+1) + "." + inPaperDTO.getTitle());
                    System.out.println("Building co-author network for all authors of the paper");
                    UndirectedSparseGraph coAuthorGraph = buildCoAuthorGraph(authorNameList, String.valueOf(depthLevel));
                    ArrayList authorVertexIDList = getAuthorVertexIDListInGraph(coAuthorGraph);
                    System.out.println("Finish building graph");
                    outStringBuffer.append("#" + inPaperDTO.getTitle() + "\n");
                    outStringBuffer.append("Rank\t" + "ConfName" + "\t" + "Metric#1\t" + "Top1\t" + "Top2\t" + "Top3\t" + "Top4\t" + "Top5\t" + "\n");

                    // Calculate METRIC #1 for inPaperDTO
                    System.out.print("---- Begin calculating the metric #1 for paper: " + inPaperDTO.getTitle());
                    HashMap metric1_Conf_HashMap = confBO.calculateTotalPaperInEachConference(authorVertexIDList, initConfNameList);
                    metric1_Conf_HashMap = HashMapUtility.getSortedMapDescending(metric1_Conf_HashMap);
                    if (metric1_Conf_HashMap != null && metric1_Conf_HashMap.size() > 0) {
                        Set metric1Set = metric1_Conf_HashMap.entrySet();
                        Iterator confIter = metric1Set.iterator();
                        int order = 1;
                        while(confIter.hasNext()){
                            Map.Entry metric1_MapEntry = (Map.Entry)confIter.next();
                            outStringBuffer.append(String.valueOf(order) + "\t" + (String)metric1_MapEntry.getKey() + "\t" + metric1_MapEntry.getValue() + "\n");
                            order++;
                        }
                    }
                    outStringBuffer.append("\n");
                    System.out.print("---- End calculating the metric #1 for paper: " + inPaperDTO.getTitle());
                }
                outStringBuffer.append("\n\n");
            }

            // Write to Text File
            CommonTextFileUtility.writeTextFile(output_metric1_file, outStringBuffer.toString()); // metric 1
            System.out.println("-------------------------------------------------");
            System.out.println(" END-Calculating Metric #1 & write to the txt file");
            System.out.println("-------------------------------------------------");
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        finally {
            authorMapper.closeConnection();
        }
    }

    /**
     * count the total paper percentage in the network of each Conference (16 conference)
     * @param inputConfList
     * @param output_metric2_file
     * @throws Exception
     */
    public void calculateMetric2(ArrayList inputConfList, ArrayList initConfNameList, String output_metric2_file) throws Exception {
        System.out.println("-------------------------------------------------");
        System.out.println(" BEGIN-Calculating Metric #2 & write to the txt file");
        System.out.println("-------------------------------------------------");
        StringBuffer outStringBuffer = new StringBuffer();
        ConferenceBO confBO = new ConferenceBO();
        AuthorMapper authorMapper = new AuthorMapper();
        DecimalFormat df = new DecimalFormat("#.##########");
        try {
            // Loop through all conf in the list
            for (int i=0; i<inputConfList.size(); i++) {
                InputConferenceDTO inConfDTO = (InputConferenceDTO) inputConfList.get(i);
                String confName = inConfDTO.getConfName();
                outStringBuffer.append("###" + confName + "\n");
                System.out.println((i+1) + "." + confName);
                ArrayList inputPaperDTOList = inConfDTO.getPaperList();
                for (int j=0; j<inputPaperDTOList.size(); j++) {
                    InputPaperDTO inPaperDTO = (InputPaperDTO) inputPaperDTOList.get(j);
                    int depthLevel = inPaperDTO.getDepthLevelForCoAuthorNet();
                    ArrayList authorNameList = inPaperDTO.getAuthorNameList();
                    // build co-author network for authors in the current paper
                    System.out.println((j+1) + "." + inPaperDTO.getTitle());
                    System.out.println("Building co-author network for all authors of the paper");
                    UndirectedSparseGraph coAuthorGraph = buildCoAuthorGraph(authorNameList, String.valueOf(depthLevel));
                    ArrayList authorVertexIDList = getAuthorVertexIDListInGraph(coAuthorGraph);
                    System.out.println("Finish building graph");
                    outStringBuffer.append("#" + inPaperDTO.getTitle() + "\n");
                    outStringBuffer.append("Rank\t" + "ConfName" + "\t" + "Metric#2\t" + "Top1\t" + "Top2\t" + "Top3\t" + "Top4\t" + "Top5\t" + "\n");

                    // Calculate METRIC #2 for inPaperDTO
                    System.out.print("---- Begin calculating the metric #2 for paper: " + inPaperDTO.getTitle());
                    HashMap metric2_Conf_HashMap = confBO.calculateTotalConferencePercentage(authorVertexIDList, initConfNameList);
                    metric2_Conf_HashMap = HashMapUtility.getSortedMapDescending(metric2_Conf_HashMap);
                    if (metric2_Conf_HashMap != null && metric2_Conf_HashMap.size() > 0) {
                        Set metric2Set = metric2_Conf_HashMap.entrySet();
                        Iterator confIter = metric2Set.iterator();
                        int order = 1;
                        while(confIter.hasNext()){
                            Map.Entry metric2_MapEntry = (Map.Entry)confIter.next();
                            outStringBuffer.append(String.valueOf(order) + "\t" + (String)metric2_MapEntry.getKey() + "\t" + metric2_MapEntry.getValue() + "\n");
                            order++;
                        }
                    }
                    outStringBuffer.append("\n");
                    System.out.print("---- End calculating the metric #2 for paper: " + inPaperDTO.getTitle());
                }
                outStringBuffer.append("\n\n");
            }

            // Write to Text File
            CommonTextFileUtility.writeTextFile(output_metric2_file, outStringBuffer.toString()); // metric 2
            System.out.println("-------------------------------------------------");
            System.out.println(" END-Calculating Metric #2 & write to the txt file");
            System.out.println("-------------------------------------------------");
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        finally {
            authorMapper.closeConnection();
        }
    }

    /**
     * count the total paper percentage with Co-Author in the network of each Conference (16 conference)
     * @param inputConfList
     * @param output_metric3_file
     * @throws Exception
     */
    public void calculateMetric3(ArrayList inputConfList, ArrayList initConfNameList, String output_metric3_file) throws Exception {
        System.out.println("-------------------------------------------------");
        System.out.println(" BEGIN-Calculating Metric #3 for all papers");
        System.out.println("-------------------------------------------------");
        StringBuffer outStringBuffer = new StringBuffer();
        ConferenceBO confBO = new ConferenceBO();
        AuthorMapper authorMapper = new AuthorMapper();
        DecimalFormat df = new DecimalFormat("#.##########");
        try {
            // Loop through all conf in the list
            for (int i=0; i<inputConfList.size(); i++) {
                InputConferenceDTO inConfDTO = (InputConferenceDTO) inputConfList.get(i);
                String confName = inConfDTO.getConfName();
                outStringBuffer.append("###" + confName + "\n");
                System.out.println((i+1) + "." + confName);
                ArrayList inputPaperDTOList = inConfDTO.getPaperList();
                for (int j=0; j<inputPaperDTOList.size(); j++) {
                    InputPaperDTO inPaperDTO = (InputPaperDTO) inputPaperDTOList.get(j);
                    int depthLevel = inPaperDTO.getDepthLevelForCoAuthorNet();
                    ArrayList authorNameList = inPaperDTO.getAuthorNameList();
                    ArrayList initialAuthorIDList = authorMapper.getObjIDListFromNameList(authorNameList);
                    // build co-author network for authors in the current paper
                    System.out.println((j+1) + "." + inPaperDTO.getTitle());
                    System.out.println("Building co-author network for all authors of the paper");
                    UndirectedSparseGraph coAuthorGraph = buildCoAuthorGraph(authorNameList, String.valueOf(depthLevel));
                    ArrayList authorVertexIDList = getAuthorVertexIDListInGraph(coAuthorGraph);
                    System.out.println("Finish building graph");
                    outStringBuffer.append("#" + inPaperDTO.getTitle() + "\n");
                    outStringBuffer.append("Rank\t" + "ConfName\t" + "Metric#3\t" + "Top1\t" + "Top2\t" + "Top3\t" + "Top4\t" + "Top5\t" + "\n");

                    // Calculate METRIC #3 for inPaperDTO
                    System.out.print("---- Begin calculating the metric #3 for paper: " + inPaperDTO.getTitle());
                    HashMap metric3_Conf_HashMap = confBO.calculateTotalConfPercentWithCoAuthor(authorVertexIDList, initialAuthorIDList, initConfNameList);
                    metric3_Conf_HashMap = HashMapUtility.getSortedMapDescending(metric3_Conf_HashMap);
                    if (metric3_Conf_HashMap != null && metric3_Conf_HashMap.size() > 0) {
                        Set metric3Set = metric3_Conf_HashMap.entrySet();
                        Iterator confIter = metric3Set.iterator();
                        int order = 1;
                        while(confIter.hasNext()){
                            Map.Entry metric3_MapEntry = (Map.Entry)confIter.next();
                            outStringBuffer.append(String.valueOf(order) + "\t" + (String)metric3_MapEntry.getKey() + "\t" + metric3_MapEntry.getValue() + "\n");
                            order++;
                        }
                    }
                    outStringBuffer.append("\n");
                    System.out.print("---- End calculating the metric #3 for paper: " + inPaperDTO.getTitle());
                }
                outStringBuffer.append("\n\n");
            }

            // Write to Text File
            CommonTextFileUtility.writeTextFile(output_metric3_file, outStringBuffer.toString()); // metric 3
            System.out.println("-------------------------------------------------");
            System.out.println(" END-Calculating Metric #3 for all papers");
            System.out.println("-------------------------------------------------");
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        finally {
            authorMapper.closeConnection();
        }
    }

    /**
     * calculateMetricsWithPCMember (Metric 4, 5, 6, 7, 8)
     * @param inputConfList
     * @param initConfNameList
     * @param output_metric4_file
     * @param output_metric5_file
     * @param output_metric6_file
     * @param output_metric7_file
     * @param output_metric8_file
     * @throws Exception
     */
    public void calculateMetricsWithPCMember(ArrayList inputConfList, ArrayList initConfNameList, String output_metric4_file, String output_metric5_file,
                                                String output_metric6_file, String output_metric7_file, String output_metric8_file) throws Exception {
        System.out.println("-------------------------------------------------");
        System.out.println(" BEGIN-Calculating Metric #4, #5, #6, #7, #8");
        System.out.println("-------------------------------------------------");
        StringBuffer outStringBuffer4 = new StringBuffer(); // output_metric4_file
        StringBuffer outStringBuffer5 = new StringBuffer(); // output_metric5_file
        StringBuffer outStringBuffer6 = new StringBuffer(); // output_metric6_file
        StringBuffer outStringBuffer7 = new StringBuffer(); // output_metric7_file
        StringBuffer outStringBuffer8 = new StringBuffer(); // output_metric8_file
        
        ConferenceBO confBO = new ConferenceBO();
        AuthorMapper authorMapper = new AuthorMapper();
        DecimalFormat df = new DecimalFormat("#.##########");
        try {
            // build co-author network for pc-members all conferences
            ArrayList pcMemberGraphList = new ArrayList();
            for (int i=0; i<inputConfList.size(); i++) {
                System.out.println("-------------------------------------------------");
                System.out.println("BUILDING NETWORK FOR PCMEMBERS OF CONF NO." + (i+1));
                System.out.println("-------------------------------------------------");

                PCMemberConfGraphDTO pcMemberConfGraphDTO = new PCMemberConfGraphDTO();
                InputConferenceDTO inConfDTO = (InputConferenceDTO) inputConfList.get(i);
                ArrayList pcMemberNameList = inConfDTO.getPcMemberList();
                // hard code for level = 1 to build network for PC Members
                UndirectedSparseGraph pcMemberCoAuthorGraph = buildCoAuthorGraph(pcMemberNameList, "1");
                pcMemberConfGraphDTO.setConfName(inConfDTO.getConfName());
                pcMemberConfGraphDTO.setGraph(pcMemberCoAuthorGraph);
                pcMemberGraphList.add(pcMemberConfGraphDTO);

                System.out.println("-------------------------------------------------");
                System.out.println("END BUILDING NETWORK FOR PCMEMBERS OF CONF NO." + (i+1));
                System.out.println("-------------------------------------------------");
            }
            // End building co-author network for pc-members all conferences

            // Loop through all conf in the list
            for (int i=0; i<inputConfList.size(); i++) {
                InputConferenceDTO inConfDTO = (InputConferenceDTO) inputConfList.get(i);
                String confName = inConfDTO.getConfName();
                outStringBuffer4.append("###" + confName + "\n");
                outStringBuffer5.append("###" + confName + "\n");
                outStringBuffer6.append("###" + confName + "\n");
                outStringBuffer7.append("###" + confName + "\n");
                outStringBuffer8.append("###" + confName + "\n");
                System.out.println((i+1) + "." + confName);
                ArrayList inputPaperDTOList = inConfDTO.getPaperList();
                for (int j=0; j<inputPaperDTOList.size(); j++) {
                    InputPaperDTO inPaperDTO = (InputPaperDTO) inputPaperDTOList.get(j);
                    outStringBuffer4.append("#" + inPaperDTO.getTitle() + "\n");
                    outStringBuffer5.append("#" + inPaperDTO.getTitle() + "\n");
                    outStringBuffer6.append("#" + inPaperDTO.getTitle() + "\n");
                    outStringBuffer7.append("#" + inPaperDTO.getTitle() + "\n");
                    outStringBuffer8.append("#" + inPaperDTO.getTitle() + "\n");
                    int depthLevel = inPaperDTO.getDepthLevelForCoAuthorNet();
                    ArrayList authorNameList = inPaperDTO.getAuthorNameList();
                    ArrayList initialAuthorIDList = authorMapper.getObjIDListFromNameList(authorNameList);
                    
                    // build co-author network for authors in the current paper
                    System.out.println((j+1) + "." + inPaperDTO.getTitle());
                    System.out.println("Building co-author network for all authors of the paper");
                    UndirectedSparseGraph coAuthorGraph = buildCoAuthorGraph(authorNameList, String.valueOf(depthLevel));
                    ArrayList authorVertexIDList = getAuthorVertexIDListInGraph(coAuthorGraph);
                    System.out.println("Finish building graph");
                    // Calculate METRIC #4, #5, #6, #7, #8 for inPaperDTO - PCMembers of conference
                    System.out.print("---- Begin calculating the metric #4, #5, #6, #7, #8 for paper: " + inPaperDTO.getTitle());
                    HashMap metric4_Conf_HashMap = new HashMap();
                    HashMap metric5_Conf_HashMap = new HashMap();
                    HashMap metric6_Conf_HashMap = new HashMap();
                    HashMap metric7_Conf_HashMap = new HashMap();
                    HashMap metric8_Conf_HashMap = new HashMap();

                    for (int k=0; k<pcMemberGraphList.size(); k++) {
                        PCMemberConfGraphDTO pcMemberGraphDTO = (PCMemberConfGraphDTO) pcMemberGraphList.get(k);
                        String conferenceName = pcMemberGraphDTO.getConfName();
                        UndirectedSparseGraph pcMemberGraph = pcMemberGraphDTO.getGraph();
                        ArrayList overlapVertexIDList = getOverlapVertexIDListOfTwoGraph(coAuthorGraph, pcMemberGraph);

                        double metric4_val = overlapVertexIDList.size();
                        double metric5_val = metric4_val/(double)pcMemberGraph.getVertexCount();
                        double metric6_val = metric4_val/((double)pcMemberGraph.getVertexCount()+(double)coAuthorGraph.getVertexCount());

                        double totalPaperOfOverlapNodeInConf = confBO.calculateTotalPaperInOneConference(overlapVertexIDList, conferenceName);
                        double totalPaperOfPCMemberNetInConf = confBO.calculateTotalPaperInOneConference(getAuthorVertexIDListInGraph(pcMemberGraph), conferenceName);
                        double metric7_val = -1;
                        if (totalPaperOfPCMemberNetInConf !=0) metric7_val = metric5_val*totalPaperOfOverlapNodeInConf/totalPaperOfPCMemberNetInConf;
                        double totalPaperOfOverlapNode = countTotalPaperOfAuthorIDList(overlapVertexIDList, initConfNameList);
                        double metric8_val = -1;
                        if (totalPaperOfOverlapNode != 0) metric8_val = metric5_val*totalPaperOfOverlapNodeInConf/totalPaperOfOverlapNode;

                        metric4_Conf_HashMap.put(conferenceName, new Double(metric4_val));
                        metric5_Conf_HashMap.put(conferenceName, new Double(metric5_val));
                        metric6_Conf_HashMap.put(conferenceName, new Double(metric6_val));
                        metric7_Conf_HashMap.put(conferenceName, new Double(metric7_val));
                        metric8_Conf_HashMap.put(conferenceName, new Double(metric8_val));
                    }

                    metric4_Conf_HashMap = HashMapUtility.getSortedMapDescending(metric4_Conf_HashMap);
                    metric5_Conf_HashMap = HashMapUtility.getSortedMapDescending(metric5_Conf_HashMap);
                    metric6_Conf_HashMap = HashMapUtility.getSortedMapDescending(metric6_Conf_HashMap);
                    metric7_Conf_HashMap = HashMapUtility.getSortedMapDescending(metric7_Conf_HashMap);
                    metric8_Conf_HashMap = HashMapUtility.getSortedMapDescending(metric8_Conf_HashMap);
                    // Add top 16 conf after calculate METRIC #4
                    if (metric4_Conf_HashMap != null && metric4_Conf_HashMap.size() > 0) {
                        Set metric4_Set = metric4_Conf_HashMap.entrySet();
                        Iterator confIter = metric4_Set.iterator();
                        int order = 1;
                        while(confIter.hasNext()){
                            Map.Entry metric4_MapEntry = (Map.Entry)confIter.next();
                            outStringBuffer4.append(String.valueOf(order)  + "\t" + (String)metric4_MapEntry.getKey() + "\t"
                                    + df.format(metric4_MapEntry.getValue()) + "\n");
                            order++;
                        }
                    }

                    // Add top 16 conf after calculate METRIC #5
                    if (metric5_Conf_HashMap != null && metric5_Conf_HashMap.size() > 0) {
                        Set metric5_Set = metric5_Conf_HashMap.entrySet();
                        Iterator confIter = metric5_Set.iterator();
                        int order = 1;
                        while(confIter.hasNext()){
                            Map.Entry metric5_MapEntry = (Map.Entry)confIter.next();
                            outStringBuffer5.append(String.valueOf(order)  + "\t" + (String)metric5_MapEntry.getKey() + "\t"
                                    + df.format(metric5_MapEntry.getValue()) + "\n");
                            order++;
                        }
                    }

                    // Add top 16 conf after calculate METRIC #6
                    if (metric6_Conf_HashMap != null && metric6_Conf_HashMap.size() > 0) {
                        Set metric6_Set = metric6_Conf_HashMap.entrySet();
                        Iterator confIter = metric6_Set.iterator();
                        int order = 1;
                        while(confIter.hasNext()){
                            Map.Entry metric6_MapEntry = (Map.Entry)confIter.next();
                            outStringBuffer6.append(String.valueOf(order)  + "\t" + (String)metric6_MapEntry.getKey() + "\t"
                                    + df.format(metric6_MapEntry.getValue()) + "\n");
                            order++;
                        }
                    }

                    // Add top 16 conf after calculate METRIC #7
                    if (metric7_Conf_HashMap != null && metric7_Conf_HashMap.size() > 0) {
                        Set metric7_Set = metric7_Conf_HashMap.entrySet();
                        Iterator confIter = metric7_Set.iterator();
                        int order = 1;
                        while(confIter.hasNext()){
                            Map.Entry metric7_MapEntry = (Map.Entry)confIter.next();
                            outStringBuffer7.append(String.valueOf(order)  + "\t" + (String)metric7_MapEntry.getKey() + "\t"
                                    + df.format(metric7_MapEntry.getValue()) + "\n");
                            order++;
                        }
                    }

                    // Add top 16 conf after calculate METRIC #8
                    if (metric8_Conf_HashMap != null && metric8_Conf_HashMap.size() > 0) {
                        Set metric8_Set = metric8_Conf_HashMap.entrySet();
                        Iterator confIter = metric8_Set.iterator();
                        int order = 1;
                        while(confIter.hasNext()){
                            Map.Entry metric8_MapEntry = (Map.Entry)confIter.next();
                            outStringBuffer8.append(String.valueOf(order)  + "\t" + (String)metric8_MapEntry.getKey() + "\t"
                                    + df.format(metric8_MapEntry.getValue()) + "\n");
                            order++;
                        }
                    }
                    outStringBuffer4.append("\n\n");
                    outStringBuffer5.append("\n\n");
                    outStringBuffer6.append("\n\n");
                    outStringBuffer7.append("\n\n");
                    outStringBuffer8.append("\n\n");
                    // End METRIC #4, #5, #6, #7, #8 for inPaperDTO - PCMembers of conference
                }
                outStringBuffer4.append("\n\n");
                outStringBuffer5.append("\n\n");
                outStringBuffer6.append("\n\n");
                outStringBuffer7.append("\n\n");
                outStringBuffer8.append("\n\n");
            }

            // Write to Text File
            CommonTextFileUtility.writeTextFile(output_metric4_file, outStringBuffer4.toString()); // metric 4
            CommonTextFileUtility.writeTextFile(output_metric5_file, outStringBuffer5.toString()); // metric 5
            CommonTextFileUtility.writeTextFile(output_metric6_file, outStringBuffer6.toString()); // metric 6
            CommonTextFileUtility.writeTextFile(output_metric7_file, outStringBuffer7.toString()); // metric 7
            CommonTextFileUtility.writeTextFile(output_metric8_file, outStringBuffer8.toString()); // metric 8.
            
            System.out.println("-------------------------------------------------");
            System.out.println(" END-Calculating Metric #4, #5, #6, #7, #8");
            System.out.println("-------------------------------------------------");
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        finally {
            authorMapper.closeConnection();
        }
    }

    /**
     * writeSomeOutputResultsToReview
     * @param inputConfList
     * @param output_review_file
     * @throws Exception
     */
    public void writeSomeOutputResultsToReview_1(ArrayList inputConfList, ArrayList initConfNameList, String output_review_file) throws Exception {
        StringBuffer outStringBuffer = new StringBuffer();
        ConferenceBO confBO = new ConferenceBO();
        AuthorMapper authorMapper = new AuthorMapper();
        AuthorPaperMapper authorPaperMapper = new AuthorPaperMapper();
        DecimalFormat df = new DecimalFormat("#.##########");
        try {
            // Loop through all conf in the list
            for (int i=0; i<inputConfList.size(); i++) {
                InputConferenceDTO inConfDTO = (InputConferenceDTO) inputConfList.get(i);
                String confName = inConfDTO.getConfName();
                outStringBuffer.append("###" + confName + "\n");
                System.out.println((i+1) + "." + confName);
                ArrayList inputPaperDTOList = inConfDTO.getPaperList();
                for (int j=0; j<inputPaperDTOList.size(); j++) {
                     outStringBuffer.append("Papertitle\t" + "CorrectConf\t" + "CorrectSIG\t" + "Network_size\t" + "Total_paper_in_network\t" +
                        "No\t" + "Conf_name\t" + "Num_conf_paper_in_user_network\t" + "Num_common_user\t" + "Num_conf_paper_common_user\t" +
                        "Num_paper_in_common_user\t" + "Num_PC_members\t" + "Num_conf_paper_in_PC_network\t" + "\n");

                    InputPaperDTO inPaperDTO = (InputPaperDTO) inputPaperDTOList.get(j);
                    int depthLevel = inPaperDTO.getDepthLevelForCoAuthorNet();
                    ArrayList authorNameList = inPaperDTO.getAuthorNameList();
                    ArrayList initialAuthorIDList = authorMapper.getObjIDListFromNameList(authorNameList);
                    // build co-author network for authors in the current paper
                    System.out.println((j+1) + "." + inPaperDTO.getTitle());
                    System.out.println("Building co-author network for all authors of the paper");
                    UndirectedSparseGraph coAuthorGraph = buildCoAuthorGraph(authorNameList, String.valueOf(depthLevel));
                    ArrayList authorVertexIDList = getAuthorVertexIDListInGraph(coAuthorGraph);
                    System.out.println("Finish building graph");
                    for (int k=0; k<initConfNameList.size(); k++) {
                        outStringBuffer.append(inPaperDTO.getTitle() + "\t");
                        outStringBuffer.append(inPaperDTO.getConferenceName() + "\t");
                        outStringBuffer.append(inPaperDTO.getSigName() + "\t");
                        outStringBuffer.append(authorVertexIDList.size() + "\t");
                        // ....
                        outStringBuffer.append((k+1) + "\t");
                        outStringBuffer.append(initConfNameList.get(k) + "\t");
                        // ....
                    }
                    outStringBuffer.append("\n\n");
                }
                outStringBuffer.append("\n\n");
            }

            CommonTextFileUtility.writeTextFile(output_review_file, outStringBuffer.toString()); // review the output
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        finally {
            authorMapper.closeConnection();
            authorPaperMapper.closeConnection();
        }
    }

    /**
     * writeSomeOutputResultsToReview_2
     * @param inputConfList
     * @param output_review_file
     * @throws Exception
     */
    public void writeSomeOutputResultsToReview_2(ArrayList inputConfList, ArrayList initConfNameList, String output_review_file) throws Exception {
        System.out.println("-------------------------------------------------");
        System.out.println(" Begin-WriteSomeOutputResultsToReview");
        System.out.println("-------------------------------------------------");
        StringBuffer outStringBuffer = new StringBuffer();
        ConferenceBO confBO = new ConferenceBO();
        AuthorMapper authorMapper = new AuthorMapper();
        AuthorPaperMapper authorPaperMapper = new AuthorPaperMapper();
        DecimalFormat df = new DecimalFormat("#.##########");
        try {
            // Loop through all conf in the list
            for (int i=0; i<inputConfList.size(); i++) {
                InputConferenceDTO inConfDTO = (InputConferenceDTO) inputConfList.get(i);
                String confName = inConfDTO.getConfName();
                outStringBuffer.append("###" + confName + "\n");
                System.out.println((i+1) + "." + confName);
                ArrayList inputPaperDTOList = inConfDTO.getPaperList();
                for (int j=0; j<inputPaperDTOList.size(); j++) {
                    InputPaperDTO inPaperDTO = (InputPaperDTO) inputPaperDTOList.get(j);
                    outStringBuffer.append((j+1) + ". " + inPaperDTO.getTitle() + "\n");

                    int depthLevel = inPaperDTO.getDepthLevelForCoAuthorNet();
                    ArrayList authorNameList = inPaperDTO.getAuthorNameList();
                    ArrayList initialAuthorIDList = authorMapper.getObjIDListFromNameList(authorNameList);
                    // build co-author network for authors in the current paper
                    System.out.println((j+1) + "." + inPaperDTO.getTitle());
                    System.out.println("Building co-author network for all authors of the paper");
                    UndirectedSparseGraph coAuthorGraph = buildCoAuthorGraph(authorNameList, String.valueOf(depthLevel));
                    ArrayList authorVertexIDList = getAuthorVertexIDListInGraph(coAuthorGraph);
                    System.out.println("Finish building graph");

                    HashMap author_paper_HashMap = new HashMap();
                    for (int k=0; k<authorVertexIDList.size(); k++) {
                        int authorVertextID = ((Integer)authorVertexIDList.get(k)).intValue();
                        double totalPaperOfCurrentAuthor = 0;
                        for (int l=0; l<initConfNameList.size(); l++) {
                            String conferenceName = (String) initConfNameList.get(l);
                            totalPaperOfCurrentAuthor += authorPaperMapper.countTotalPaperInConfOfAnAuthor(authorVertextID, conferenceName);
                        }
                        String authorName = authorMapper.getObjName(authorVertextID);
                        author_paper_HashMap.put(authorName, new Double(totalPaperOfCurrentAuthor));
                    }

                    author_paper_HashMap = HashMapUtility.getSortedMapDescending(author_paper_HashMap);
                    // get top 20 authors with the highest number of papers in net
                    if (author_paper_HashMap != null && author_paper_HashMap.size() > 0) {
                        Set author_paper_Set = author_paper_HashMap.entrySet();
                        Iterator author_paper_Iter = author_paper_Set.iterator();
                        int order = 1;
                        while(author_paper_Iter.hasNext()){
                            Map.Entry author_paper_MapEntry = (Map.Entry)author_paper_Iter.next();
                            outStringBuffer.append(String.valueOf(order)  + "\t" + (String)author_paper_MapEntry.getKey() + "\t"
                                    + df.format(author_paper_MapEntry.getValue()) + "\n");
                            order++;
                            if (order == 21) break;
                        }
                    }

                    outStringBuffer.append("\n\n");
                }
                outStringBuffer.append("\n\n");
            }
            
            CommonTextFileUtility.writeTextFile(output_review_file, outStringBuffer.toString()); // review the output
            System.out.println("-------------------------------------------------");
            System.out.println(" End-WriteSomeOutputResultsToReview");
            System.out.println("-------------------------------------------------");
        }
        catch (Exception ex) {
            ex.printStackTrace();
        }
        finally {
            authorMapper.closeConnection();
            authorPaperMapper.closeConnection();
        }
    }
}
