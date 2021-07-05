package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 */
public class PriorityQueueTest {
    public static void main(String[] args) {
        PriorityQueue<Integer> pQueue = new PriorityQueue<>();
        pQueue.enqueue(23);
        pQueue.enqueue(12);
        pQueue.enqueue(1234);
        System.out.println(pQueue.dequeue());
        System.out.println(pQueue.dequeue());
        System.out.println(pQueue.dequeue());
    }
}
