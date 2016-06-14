package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 12-06-2016.
 */
public class SinglyLinkedListTest {
    public static void main(String[] args) throws NoSuchFieldException {
        SinglyLinkedList<String> list = new SinglyLinkedList<>("Hello");
        list.add("how");
        list.add("are");
        list.add("you");
        list.add("?");
        list.print();
        list.remove("are");
        list.print();
        System.out.println(list.search("how").data);
    }
}
