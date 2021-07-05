package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 */
public class DoublyLinkedList<T> {
    public class DoubleEndedNode {
        public T data;
        public DoubleEndedNode next, prev;

        public DoubleEndedNode(T data){
            this.data = data;
        }

        public DoubleEndedNode(T data, DoubleEndedNode next, DoubleEndedNode prev){
            this.data = data;
            this.next = next;
            this.prev = prev;
        }
    }

    public DoubleEndedNode head;
    public DoubleEndedNode tail;

    public DoublyLinkedList(){
        head = null;
        tail = null;
    }

    public DoublyLinkedList(T data){
        head = new DoubleEndedNode(data);
        tail = head;
    }

    /***
     * adds to the front
     * @param data
     */
    public void add(T data){
        if(head == null){
            head = new DoubleEndedNode(data);
            tail = head;
            return;
        }
        head.prev = new DoubleEndedNode(data, head, null);
        head = head.prev;
    }

    /***
     * adds to the end
     * @param data
     */
    public void addLast(T data){
        if(head == null){
            head = new DoubleEndedNode(data);
            tail = head;
            return;
        }
        tail.next = new DoubleEndedNode(data, null, tail);
        tail = tail.next;
    }

    public void remove(T data){
        if(head == null){
            return;
        }
        DoubleEndedNode node = search(data);
        if(node.data == head.data){
            head = head.next;
            if(head == null){
                tail = null;
            }else{
                head.prev = null;
            }
        }else if(node.data == tail.data){
            tail = tail.prev;
            tail.next = null;
        }else if(node != null){
            node.prev.next = node.next;
            node.next.prev = node.prev;
        }
    }


    private DoubleEndedNode search(T data) {
        DoubleEndedNode node = null;
        while (node != null && node.data != data){
            node = node.next;
        }

        return  node;
    }

    public void print(){
        DoubleEndedNode node = head;
        while (node != null){
            System.out.println(node.data);
            node = node.next;
        }
    }
}
