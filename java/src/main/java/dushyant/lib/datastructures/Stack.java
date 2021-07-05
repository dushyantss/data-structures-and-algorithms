package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 *
 * This stack is implemented using a SinglyLinkedList
 * I could use an array too but that would mean a max size of the stack
 * although it would take lesser space as no node object wrapping the data
 */
public class Stack<T> {
    private SinglyLinkedList<T> list;

    public Stack(){
        list = new SinglyLinkedList<T>();
    }

    public T pop(){
        T data = null;
        if(list.head != null){
            data = list.head.data;
            list.head = list.head.next;
        }
        return data;
    }

    public void push(T data){
        list.add(data);
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
