package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 14-06-2016.
 */
public class AVLTreeTest {
    public static void main(String[] args) {
        AVLTree<String> tree = new AVLTree<>();
        tree.insert("Hello");
        tree.insert("How");
        tree.insert("are");
        tree.insert("you");
        tree.insert("doing");
        tree.insert("?");
        tree.insert("if");
        tree.insert("you");
        tree.insert("need");
        tree.insert("anything");
        tree.insert("just");
        tree.insert("ask");
        tree.inOrder();
        tree.print();
        tree.delete("are");
        tree.print();
    }
}
