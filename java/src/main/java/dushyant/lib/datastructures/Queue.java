package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 *
 * Implementing this class using DoublyLinkedList to add at the end
 * This will be a basic queue, so elements will be added to the end
 * and will be removed at the front.
 */
public class Queue<T> {
    private DoublyLinkedList<T> list;

    public Queue(){
        list = new DoublyLinkedList<T>();
    }

    public void enqueue(T data) {
        list.addLast(data);
    }

    public T dequeue(){
        T data = null;
        if(list.head == list.tail){
            data = list.head.data;
            list.head = null;
            list.tail = null;
        }else if(list.head != null){
            data = list.head.data;
            list.head = list.head.next;
            list.head.prev = null;
        }
        return  data;
    }

    public T peek(){
        T data = null;
        if(list.head != null){
            data = list.head.data;
        }
        return data;
    }

    public boolean isEmpty(){
        return list.head == null;
    }
}
