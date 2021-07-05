package dushyant.lib.graph;

import java.util.Arrays;

/**
 * Created by Dushyant Singh Shekhawat
 * on 17-06-2016.
 */
public class GraphTest {
    public static void main(String[] args) {
        Vertex a = new Vertex("a"), b = new Vertex("b"), c = new Vertex("c"), d = new Vertex("d"), e = new Vertex("e");
        a.neighbors.add(b);

        b.neighbors.add(c);

        c.neighbors.add(d);

        d.neighbors.add(e);

        e.neighbors.add(a);

        Vertex[] arr = {a, b, c, d, e};
        Graph graph = new Graph(Arrays.asList(arr));
        graph.BFS();
        graph.clearVisited();
        System.out.println("//////");
        graph.DFS();
    }
}
