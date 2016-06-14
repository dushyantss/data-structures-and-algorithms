package dushyant.lib.sort;

import dushyant.lib.datastructures.Array;
import dushyant.lib.datastructures.Heap;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 */
public class HeapSort {
    public static<T extends Comparable<T>> Array<T> sort(T[] arr){
        Heap<T> heap = new Heap<T>(arr);
        heap.buildMaxHeap();
        T temp;
        for (int i = heap.heapSize - 1; i > 0 ; i--) {
            temp = heap.tArray.get(0);
            heap.tArray.replace(0, heap.tArray.get(i));
            heap.tArray.replace(i, temp);

            heap.heapSize--;
            heap.maxHeapify(0);
        }
        return heap.tArray;
    }

    public static<T extends Comparable<T>> Array<T> sortReverse(T[] arr){
        Heap<T> heap = new Heap<T>(arr);
        heap.buildMinHeap();
        T temp;
        for (int i = heap.heapSize-1; i > 0 ; i--) {
            temp = heap.tArray.get(0);
            heap.tArray.replace(0, heap.tArray.get(i));
            heap.tArray.replace(i, temp);

            heap.heapSize--;
            heap.minHeapify(0);
        }
        return heap.tArray;
    }
}
