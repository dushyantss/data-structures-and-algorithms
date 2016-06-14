package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 */
public class QueueTest {
    public static void main(String[] args) {
        Queue<String> queue = new Queue<>();
        queue.enqueue("Hello");
        queue.enqueue("how");
        queue.enqueue("are");
        queue.enqueue("you");
        queue.enqueue("doing");
        queue.enqueue("?");
        while (!queue.isEmpty()) {
            System.out.println(queue.dequeue());
        }
        System.out.println(queue.isEmpty());
    }
}
