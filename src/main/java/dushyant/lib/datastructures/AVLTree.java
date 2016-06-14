package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 14-06-2016.
 *
 * This tree does not support duplicate as that would cause too many issues with delete(which one?), successor(whose?),
 * etc since I am using a the data as a means of operation and not the node containing the data
 */
public class AVLTree<T extends Comparable<T>> {

    public class Node{
        T data;

        //every Node will have height > 0
        int height = 1;
        Node left, right, parent;

        public Node(T data){
            this.data = data;
        }

        public Node(T data, Node parent){
            this.data = data;
            this.parent = parent;
        }
    }

    private Node root;

    public AVLTree(){}

    public AVLTree(T[] arr){
        for (T t : arr) {
            insert(t);
        }
    }

    public void insert(T data){
        if(root == null){
            root = new Node(data);
            return;
        }

        // get node location
        Node temp = root, parent = null;
        while (temp != null){
            parent = temp;
            if(data.compareTo(temp.data) == 0) return; // do nothing if duplicate
            else if(data.compareTo(temp.data) > 0) temp = temp.right;
            else temp = temp.left;
        }

        //insert new node at appropriate position
        if(data.compareTo(parent.data) > 0) parent.right = new Node(data, parent);
        else parent.left = new Node(data, parent);

        //go up the tree till it reaches root, does not change height or is no longer balanced
        while (parent != null && heightChange(parent) && heightBalanced(parent)){
            changeHeight(parent);
            parent = parent.parent;
        }

        if (parent != null && !heightBalanced(parent)) {
            doBalance(parent);
        }
    }

    public void delete(T data){
        //first we check if the data is present
        Node node = root, parent = null;
        while (node != null){
            if(data.compareTo(node.data) == 0) break;
            else if(data.compareTo(node.data) > 0) node = node.right;
            else node = node.left;
        }

        if(node == null){
            System.out.println("No such key exists");
            return;
        }

        //now we check if the data is in a leaf node, a parent with one child or with two
        //and then do the appropriate deletion steps
        parent = nodeDeletion(node);

        //till this point we have not changed any heights, so even though the parent node might
        //need a height changed since it's child was deleted we will do so later so that we can
        //compare the old height to new one to know if we can stop as height does not need to change
        deletionBalance(parent);
    }


    public T max(){
        Node node = root;
        while (node.right != null){
            node = node.right;
        }
        return node.data;
    }

    public T min(){
        Node node = root;
        while (node.left != null){
            node = node.left;
        }
        return node.data;
    }

    public T successor(T data){
        Node node = root;
        while (true) {
            if(data.compareTo(node.data) == 0) break;
            else if(data.compareTo(node.data) > 0) node = node.right;
            else node = node.left;
        }
        T result = null;

        if(node != null){
            result  = getSuccessor(node).data;
        }
        return result;
    }

    public T predecessor(T data){
        Node node = root;
        while (true) {
            if(data.compareTo(node.data) == 0) break;
            else if(data.compareTo(node.data) > 0) node = node.right;
            else node = node.left;
        }
        T result = null;

        if(node != null){
            result  = getPredecessor(node).data;
        }
        return result;
    }

    public boolean contains(T data){
        boolean result = false;
        Node node = root;
        while (node != null) {
            if(data.compareTo(node.data) == 0){
                result = true;
                break;
            }else if(data.compareTo(node.data) > 0) node = node.right;
            else node = node.left;
        }
        return result;
    }

    public void inOrder(){
        inOrder(root);
        System.out.println();
    }

    public void print(){
        System.out.println();
        printBinaryTree(root, 0);
    }

    //Helper Methods
    //******************************************************************************//
    private void printBinaryTree(Node node, int level){
        if(node==null)
            return;
        printBinaryTree(node.right, level+1);
        if(level!=0){
            for(int i=0;i<level-1;i++)
                System.out.print("|\t");
            System.out.println("|-------"+node.data);
        }
        else
            System.out.println(node.data);
        printBinaryTree(node.left, level+1);
    }

    private void inOrder(Node node){
        if(node != null){
            inOrder(node.left);
            System.out.print(node.data + " ");
            inOrder(node.right);
        }
    }

    private int height(Node node){
        return node != null ? node.height : 0;
    }

    private boolean heightChange(Node parent) {
        return !(height(parent.left) == height(parent.right));
    }

    private boolean heightChangeDeletion(Node parent){
        return (height(parent.left) == height(parent.right));
    }

    private boolean heightBalanced(Node parent) {
        return (Math.abs(height(parent.left) - height(parent.right)) < 2);
    }

    private Node doBalance(Node parent) {

        Node node = null;
        if(height(parent.right) > height(parent.left)){
            if(height(parent.right.right) > height(parent.right.left))node = rotateLeft(parent);
            else {
                rotateRight(parent.right);
                node = rotateLeft(parent);
            }
        } else{
            if(height(parent.left.left) > height(parent.left.right)) node = rotateRight(parent);
            else{
                rotateLeft(parent.left);
                node = rotateRight(parent);
            }
        }

        if(parent == root){
            root = node;
        }
        return node;
    }

    private void deletionBalance(Node parent){
        while (parent != null && (heightChangeDeletion(parent) || !heightBalanced(parent))) {

            while (parent != null && heightChangeDeletion(parent) && heightBalanced(parent)) {
                changeHeight(parent);
                parent = parent.parent;
            }
            if (parent != null && !heightBalanced(parent)) {
                parent = doBalance(parent);
            }
            parent = parent.parent;
        }
    }
    
    private Node nodeDeletion(Node node) {
        Node parent = node.parent;
        
        //Case: leaf
        if (isLeaf(node)) {
            parent = caseLeaf(node);
        }

        //Case: one child
        else if(hasOneChild(node)) {
            parent = caseOneChild(node);
        }
        
        //Case: two children
        else{
            parent = caseTwoChildren(node);
        }
        
        return parent;
    }

    private boolean isLeaf(Node node){
        return node.left == null && node.right == null;
    }
    
    private Node caseLeaf(Node node){
        Node parent = node.parent;
        if (parent == null) {
            root = null;
        } else {
            if (node.data.compareTo(parent.data) > 0) parent.right = null;
            else parent.left = null;
        }
        return parent;
    }
    
    private boolean hasOneChild(Node node){
        return (node.left == null && node.right != null) || (node.left != null && node.right == null);
    }

    private Node caseOneChild(Node node) {
        if(node.left != null){
            node.data = node.left.data;
            node.left = null;
        }else{
            node.data = node.right.data;
            node.right = null;
        }
        return node;
    }
    
    private Node caseTwoChildren(Node node){
        Node successor = getSuccessor(node);
        node.data = successor.data;
        node = successor.parent;

        if(successor == node.left) node.left = null;
        else node.right = null;

        return node;
    }

    private Node getSuccessor(Node node) {
        Node s = null;
        if(node.right != null){
            s = node.right;
            while (s.left != null){
                s = s.left;
            }
        }else{
            s = node.parent;

            while (s != null && node == s.right) {
                node = s;
                s = s.parent;
            }
        }
        return s;
    }

    private Node getPredecessor(Node node) {
        Node p = null;
        if(node.left != null){
            p = node.left;
            while (node.right != null){
                p = node.right;
            }
        }else{
            p = node.parent;

            while (p != null && node == p.left) {
                node = p;
                p = p.parent;
            }
        }
        return p;
    }

    private void changeHeight(Node parent){
        parent.height = Math.max(height(parent.left), height(parent.right)) + 1;
    }
    
    
    //this method will rotate left i.e. counterclockwise so the pivotNode will become the new left child and
    //its right child will become the new parent node(the previous position of pivotNode)
    //		  z                                 y
    //	 	 /  \                             /   \
    //		T1   y     Left Rotate(z)       z      x
    //			/  \   - - - - - - - ->    / \    / \
    //			T2   x                    T1  T2 T3  T4
    //				/ \
    //				T3  T4
    // Here the pivotNode is z
    private Node rotateLeft(Node pivotNode){
        Node y = pivotNode.right;

        if(pivotNode.parent != null){
            if(pivotNode.parent.left == pivotNode) pivotNode.parent.left = y;
            else pivotNode.parent.right = y;
        }
        y.parent = pivotNode.parent;
        pivotNode.parent = y;

        pivotNode.right = y.left;
        if(y.left != null) y.left.parent = pivotNode;
        y.left = pivotNode;


        changeHeight(pivotNode);
        changeHeight(y);
        return y;
    }

    //this method will rotate right i.e. clockwise along the pivotNode
    //		     z                                      y
    //			/ \                                   /   \
    //		   y   T4      Right Rotate (z)          x      z
    //		  / \          - - - - - - - - ->      /  \    /  \
    //		 x   T3                               T1  T2  T3  T4
    //		/ \
    //	   T1  T2
    // Here the pivotNode is z
    private Node rotateRight(Node pivotNode){
        Node y = pivotNode.left;

        if(pivotNode.parent != null){
            if(pivotNode.parent.left == pivotNode) pivotNode.parent.left = y;
            else pivotNode.parent.right = y;
        }
        y.parent = pivotNode.parent;
        pivotNode.parent = y;

        pivotNode.left = y.right;
        if(y.right != null) y.right.parent = pivotNode;
        y.right = pivotNode;

        changeHeight(pivotNode);
        changeHeight(y);

        return y;
    }

}
