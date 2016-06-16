package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 14-06-2016.
 * <p>
 * This tree does not take duplicate entries
 */

public class RedBlackTree<T extends Comparable<T>> {
    private Node root;

    public RedBlackTree() {
    }

    public RedBlackTree(T data) {
        root = new Node(data);
    }

    /***
     * Cannot insert duplicate data
     *
     * @param data
     */
    public void insert(T data) {
        if (root == null) {
            root = new Node(data);
            root.color = Color.BLACK;
            return;
        }

        Node node = root, parent = null;
        while (node != null) {
            parent = node;
            if (data.compareTo(node.data) == 0)
                return; //do nothing when duplicate, can implement specific functions later
            else if (data.compareTo(node.data) < 0) node = node.left;
            else node = node.right;
        }

        //reusing the node reference for slight performance and because I like the name node, could use another name
        //if desired
        node = new Node(data, parent);
        if (data.compareTo(parent.data) > 0) parent.right = node;
        else parent.left = node;

        //now we fix any double red problems
        insertFix(node);
    }

    public void delete(T data) {
        //first we check if the data is present
        Node node = root;
        while (node != null) {
            if (data.compareTo(node.data) == 0) break;
            else if (data.compareTo(node.data) > 0) node = node.right;
            else node = node.left;
        }

        if (node == null) {
            System.out.println("No such key exists");
            return;
        }

        //now we check if the data is in a leaf node, a parent with one child or with two
        //and then do the appropriate deletion steps
        //also note that the only case where we would need to do fixup, i.e. there will be a
        //black node deleted is when we delete a black leaf node(which could be the original node
        //or the successor). In the other cases it is either a red leaf or a black node with a red child(you can check
        //these are the only possibilities.

        //So, I have included the fixup step in the leaf case where the leaf is black
        nodeDeletion(node);
    }

    public T max() {
        Node node = root;
        T data = null;
        while (node.right != null) {
            node = node.right;
        }
        data = node.data;
        return data;
    }

    public T min() {
        Node node = root;
        T data = null;
        while (node.left != null) {
            node = node.left;
        }
        data = node.data;
        return data;
    }

    public T successor(T data) {
        Node node = root;
        while (true) {
            if (data.compareTo(node.data) == 0) break;
            else if (data.compareTo(node.data) > 0) node = node.right;
            else node = node.left;
        }
        T result = null;

        if (node != null) {
            result = getSuccessor(node).data;
        }
        return result;
    }

    public T predecessor(T data) {
        Node node = root;
        while (true) {
            if (data.compareTo(node.data) == 0) break;
            else if (data.compareTo(node.data) > 0) node = node.right;
            else node = node.left;
        }
        T result = null;

        if (node != null) {
            result = getPredecessor(node).data;
        }
        return result;
    }

    public boolean contains(T data) {
        boolean result = false;
        Node node = root;
        while (node != null) {
            if (data.compareTo(node.data) == 0) {
                result = true;
                break;
            } else if (data.compareTo(node.data) > 0) node = node.right;
            else node = node.left;
        }
        return result;
    }

    public void inOrder() {
        inOrder(root);
        System.out.println();
    }

    public void print() {
        System.out.println();
        printBinaryTree(root, 0);
    }

    private void nodeDeletion(Node node) {
        //Case: leaf
        if (isLeaf(node)) {
            caseLeaf(node);
        }

        //Case: one child
        else if (hasOneChild(node)) {
            caseOneChild(node);
        }

        //Case: two children
        else {
            caseTwoChildren(node);
        }
    }

    private void caseLeaf(Node node) {
        Color originalColor = node.color;
        Node parent = node.parent;
        if (parent == null) {
            root = null;
            return;
        } else {
            if (node == parent.right) parent.right = null;
            else parent.left = null;
        }
        if (originalColor == Color.BLACK) {
            deleteFix(parent);
        }
    }

    //Helper Methods
    //*********************************************************************************//

    private void caseTwoChildren(Node node) {
        Node successor = getSuccessor(node);
        node.data = successor.data;
        nodeDeletion(successor);
    }

    private void caseOneChild(Node node) {
        if (node.left != null) {
            node.data = node.left.data;
            node.left = null;
        } else {
            node.data = node.right.data;
            node.right = null;
        }
    }

    private boolean hasOneChild(Node node) {
        return (node.left == null && node.right != null) || (node.left != null && node.right == null);
    }

    private boolean isLeaf(Node node) {
        return node.left == null && node.right == null;
    }

    /***
     * I am basically copying the CLRS implementation, So please refer to the book for explanation
     *
     * @param parent
     */
    private void deleteFix(Node parent) {
        Node node = null, sibling = null;
        while (node != root && color(node) == Color.BLACK) {
            if (node == parent.left) {
                if (deleteFixLeft(parent)) {       //only Case 2 can cause repetitions
                    node = parent;
                    parent = parent.parent;
                } else {
                    break;
                }
            } else {
                if (deleteFixRight(parent)) {
                    node = parent;
                    parent = parent.parent;
                } else {
                    break;
                }
            }
        }
    }

    private boolean deleteFixLeft(Node parent) {
        Node sibling = parent.right;

        //case 1
        if (color(sibling) == Color.RED) {
            sibling.color = Color.BLACK;
            parent.color = Color.RED;
            rotateLeft(parent);
            sibling = parent.right;
        }

        // /case 2
        if (color(sibling.left) == Color.BLACK && color(sibling.right) == Color.BLACK) {
            sibling.color = Color.RED;
            return true;
        }

        //case 3
        else {
            if (color(sibling.right) == Color.BLACK) {
                if (sibling.left != null) {
                    sibling.left.color = Color.BLACK;
                }
                sibling.color = Color.RED;
                rotateRight(sibling);
                sibling = parent.right;
            }

            //case 4
            sibling.color = color(parent);
            if (parent != null) parent.color = Color.BLACK;
            if (sibling.right != null) sibling.right.color = Color.BLACK;
            rotateLeft(parent);
        }

        return false;
    }

    private boolean deleteFixRight(Node parent) {
        Node sibling = parent.left;

        //case 1
        if (color(sibling) == Color.RED) {
            sibling.color = Color.BLACK;
            parent.color = Color.RED;
            rotateRight(parent);
            sibling = parent.left;
        }

        // /case 2
        if (color(sibling.right) == Color.BLACK && color(sibling.left) == Color.BLACK) {
            sibling.color = Color.RED;
            return true;
        }

        //case 3
        else {
            if (color(sibling.left) == Color.BLACK) {
                if (sibling.right != null) {
                    sibling.right.color = Color.BLACK;
                }
                sibling.color = Color.RED;
                rotateLeft(sibling);
                sibling = parent.left;
            }

            //case 4
            sibling.color = color(parent);
            if (parent != null) parent.color = Color.BLACK;
            if (sibling.left != null) sibling.left.color = Color.BLACK;
            rotateRight(parent);
        }

        return false;
    }

    private void insertFix(Node node) {
        while (color(node.parent) == Color.RED) {
            if (node.parent == node.parent.parent.left) {
                if (insertFixLeft(node)) {
                    node = node.parent.parent;
                } else {
                    break;
                }
            } else {
                if (insertFixRight(node)) {
                    node = node.parent.parent;
                } else {
                    break;
                }
            }
        }
        root.color = Color.BLACK;
    }

    private boolean insertFixLeft(Node node) {
        Node uncle = node.parent.parent.right;

        if (color(uncle) == Color.RED) {
            node.parent.color = Color.BLACK;
            uncle.color = Color.BLACK;
            node.parent.parent.color = Color.RED;
            return true;
        } else {
            if (node == node.parent.right) {
                node = node.parent;
                rotateLeft(node);
            }
            node.parent.color = Color.BLACK;
            node.parent.parent.color = Color.RED;
            rotateRight(node.parent.parent);
        }
        return false;
    }

    private boolean insertFixRight(Node node) {
        Node uncle = node.parent.parent.left;

        if (color(uncle) == Color.RED) {
            node.parent.color = Color.BLACK;
            uncle.color = Color.BLACK;
            node.parent.parent.color = Color.RED;
            return true;
        } else {
            if (node == node.parent.left) {
                node = node.parent;
                rotateRight(node);
            }
            node.parent.color = Color.BLACK;
            node.parent.parent.color = Color.RED;
            rotateLeft(node.parent.parent);
        }
        return false;
    }

    private Color color(Node node) {
        return node != null ? node.color : Color.BLACK;
    }

    private void printBinaryTree(Node node, int level) {
        if (node == null)
            return;
        printBinaryTree(node.right, level + 1);
        if (level != 0) {
            for (int i = 0; i < level - 1; i++)
                System.out.print("|\t");
            System.out.println("|-------" + node.data);
        } else
            System.out.println(node.data);
        printBinaryTree(node.left, level + 1);
    }

    private void inOrder(Node node) {
        if (node != null) {
            inOrder(node.left);
            System.out.print(node.data + " ");
            inOrder(node.right);
        }
    }

    private Node getSuccessor(Node node) {
        Node s = null;
        if (node.right != null) {
            s = node.right;
            while (s.left != null) {
                s = s.left;
            }
        } else {
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
        if (node.left != null) {
            p = node.left;
            while (node.right != null) {
                p = node.right;
            }
        } else {
            p = node.parent;

            while (p != null && node == p.left) {
                node = p;
                p = p.parent;
            }
        }
        return p;
    }

    //Rotations
    private void rotateLeft(Node node) {
        Node y = node.right;

        if (node.parent == null) {
            root = y;
        } else {
            if (node.parent.left == node) node.parent.left = y;
            else node.parent.right = y;
        }

        y.parent = node.parent;

        node.right = y.left;
        if (y.left != null) {
            y.left.parent = node;
        }

        node.parent = y;
        y.left = node;
    }

    private void rotateRight(Node node) {
        Node y = node.left;

        if (node.parent == null) {
            root = y;
        } else {
            if (node.parent.left == node) node.parent.left = y;
            else node.parent.right = y;
        }

        y.parent = node.parent;

        node.left = y.right;
        if (y.right != null) {
            y.right.parent = node;
        }

        node.parent = y;
        y.right = node;
    }

    enum Color {RED, BLACK}

    private class Node {
        T data;
        Color color = Color.RED;
        Node left, right, parent;

        public Node(T data) {
            this.data = data;
        }

        public Node(T data, Node parent) {
            this.data = data;
            this.parent = parent;
        }
    }
}
