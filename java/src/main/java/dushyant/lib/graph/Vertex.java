package dushyant.lib.graph;

import java.util.LinkedList;

/**
 * Created by Dushyant Singh Shekhawat
 * on 17-06-2016.
 */

public class Vertex {
    public String name;
    public LinkedList<Vertex> neighbors;
    public boolean visited;

    public Vertex(String name) {
        this(name, new LinkedList<>());
    }

    public Vertex(String name, LinkedList<Vertex> neighbors) {
        this.name = name;
        this.neighbors = neighbors;
    }

    public void addNeighbor(Vertex neighbor) {
        neighbors.add(neighbor);
    }

    public void removeNeighbor(Vertex neighbor) {
        neighbors.remove(neighbor);
    }
}
