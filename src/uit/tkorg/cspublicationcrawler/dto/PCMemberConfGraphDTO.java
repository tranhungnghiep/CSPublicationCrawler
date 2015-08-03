/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package uit.tkorg.cspublicationcrawler.dto;

import edu.uci.ics.jung.graph.UndirectedSparseGraph;

/**
 *
 * @author Administrator
 * -------------------
 * @author Nghiep H. Tran
 * @since 19/08/2011 : add Constructor
 */
public class PCMemberConfGraphDTO {
    private String confName;
    private UndirectedSparseGraph graph;

    public PCMemberConfGraphDTO() {
    }

    public PCMemberConfGraphDTO(String confName, UndirectedSparseGraph graph) {
        this.confName = confName;
        this.graph = graph;
    }

    public String getConfName() {
        return confName;
    }

    public void setConfName(String confName) {
        this.confName = confName;
    }

    public UndirectedSparseGraph getGraph() {
        return graph;
    }

    public void setGraph(UndirectedSparseGraph graph) {
        this.graph = graph;
    }

}
