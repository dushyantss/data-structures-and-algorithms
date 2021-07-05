package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 *
 * This I will implement using Heap(The sole reason I did not put tArray in with heapsort and did not use a simple array)
 *
 */
public class PriorityQueue<T extends Comparable<T>> {
    Heap<T> heap;

    public PriorityQueue(){
        heap = new Heap<T>();
    }

    public void enqueue(T data){
        heap.add(data);
        reducePriority(heap.heapSize - 1, data);
    }

    public void reducePriority(int index, T newPriority) {
        heap.tArray.replace(index, newPriority);
        while (index > 0 && heap.tArray.get(heap.parent(index)).compareTo(heap.tArray.get(index)) > 0){
            T temp = heap.tArray.get(index);
            heap.tArray.replace(index, heap.tArray.get(heap.parent(index)));
            heap.tArray.replace(heap.parent(index), temp);

            index = heap.parent(index);
        }
    }

    public T dequeue(){
        T temp = heap.tArray.get(0);
        heap.tArray.replace(0, heap.tArray.get(heap.heapSize - 1));
        heap.tArray.replace(heap.heapSize - 1, temp);

        heap.heapSize--;

        heap.minHeapify(0 );

        return temp;
    }

    public T peek(){
        return heap.tArray.get(0);
    }

    public boolean isEmpty(){
        return heap.heapSize == 0;
    }
}
