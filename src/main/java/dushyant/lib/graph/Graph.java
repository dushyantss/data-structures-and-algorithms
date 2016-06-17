package dushyant.lib.graph;

import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

/**
 * Created by Dushyant Singh Shekhawat
 * on 17-06-2016.
 * <p>
 * This graph will be represented with adjacency list and
 * The graph class is immutable, as inserting a new vertex might change the neighbors of existing vertices. So,
 * be careful when doing such an operation.
 */

public class Graph {
    private List<Vertex> vertices;

    public Graph(List<Vertex> vertices) {
        this.vertices = vertices;
    }

    public void BFS() {
        BFS(vertices.get(0));
    }

    public void BFS(Vertex root) {
        root.visited = true;
        Queue<Vertex> queue = new LinkedList<>();
        queue.add(root);
        while (!queue.isEmpty()) {
            Vertex u = queue.poll();
            for (Vertex v :
                    u.neighbors) {
                if (!v.visited) {
                    visit(u, v);
                    v.visited = true;
                    queue.add(v);
                }
            }
        }
    }

    public void visit(Vertex parent, Vertex child) {
        System.out.println(parent.name + "'s child " + child.name);
    }
}
