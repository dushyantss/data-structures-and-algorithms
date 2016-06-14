package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 12-06-2016.
 *
 * this list adds new elements to the front
 */
public class SinglyLinkedList<T> {
    public class SingleEndedNode {
        T data;
        SingleEndedNode next;

        public SingleEndedNode(T data){
            this.data = data;
        }
    }

    public SingleEndedNode head;

    public SinglyLinkedList(){
        this.head = null;
    }

    public SinglyLinkedList(T data){
        this.head = new SingleEndedNode(data);
    }

    public void add(T data){
        SingleEndedNode singleEndedNode = new SingleEndedNode(data);
        singleEndedNode.next = head;
        head = singleEndedNode;
    }

    /***
     * not providing the data in the return type as we are already providing it
     * clarifying because that is how I have read remove should be, returning the removed node
     * @param data
     */
    public void remove(T data){
        SingleEndedNode parent = searchParent(data);

        if(parent == null){
            if(head == null){
                System.out.println("Empty list");
            }else{
                head = head.next;
            }

        }else if(parent.next != null){
            parent.next = parent.next.next;
        }//otherwise data did not match as parent.next is null
    }

    private SingleEndedNode searchParent(T data) {
        SingleEndedNode singleEndedNode = head, parent = null;
        while (singleEndedNode != null && singleEndedNode.data != data){
            parent = singleEndedNode;
            singleEndedNode = singleEndedNode.next;
        }
        return parent;
    }

    public SingleEndedNode search(T data) {
        SingleEndedNode temp = head;
        while (temp != null && temp.data != data){
            temp = temp.next;
        }

        return temp;
    }

    public void print(){
        SingleEndedNode singleEndedNode = head;
        while (singleEndedNode != null){
            System.out.println(singleEndedNode.data);
            singleEndedNode = singleEndedNode.next;
        }
    }

}
