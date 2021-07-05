package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 12-06-2016.
 * <p>
 *
 * This class will use my Array class
 */
public class Heap<T extends Comparable<T>> {
    public Array<T> tArray;
    public int heapSize;

    public Heap() {
        tArray = new Array<T>();
        heapSize = 0;
    }

    public Heap(T[] arr){
        this(arr, arr.length);
    }

    /***
     * Please ensure that heapSize is not more than arr.length
     * @param arr
     * @param heapSize
     */
    public Heap(T[] arr, int heapSize){
        tArray = new Array<T>(arr.length);
        for (int i = 0; i < arr.length; i++) {
            tArray.replace(i, arr[i]);
        }
        this.heapSize = heapSize;
    }

    public void add(T data){
        tArray.add(data);
        heapSize++;
    }

    //for max tArray
    //*************************************************************************//

    public void maxHeapify(int index){
        int left = left(index);
        int right = right(index);
        int largest = index;

        if(left < heapSize && tArray.get(left).compareTo(tArray.get(largest)) > 0){
            largest = left;
        }
        if(right < heapSize && tArray.get(right).compareTo(tArray.get(largest)) > 0){
            largest = right;
        }
        if(largest != index){
            T temp = tArray.get(index);
            tArray.replace(index, tArray.get(largest));
            tArray.replace(largest, temp);

            maxHeapify(largest);
        }
    }

    public Array<T> buildMaxHeap(){
        for (int i = heapSize/2; i >= 0 ; i--) {
            maxHeapify(i);
        }
        return tArray;
    }

    //for minHeap
    //*************************************************************************//
    public void minHeapify(int index){
        int left = left(index);
        int right = right(index);
        int smallest = index;

        if(left < heapSize && tArray.get(left).compareTo(tArray.get(smallest)) < 0){
            smallest = left;
        }
        if(right < heapSize && tArray.get(right).compareTo(tArray.get(smallest)) < 0){
            smallest = right;
        }
        if(smallest != index){
            T temp = tArray.get(index);
            tArray.replace(index, tArray.get(smallest));
            tArray.replace(smallest, temp);

            minHeapify(smallest);
        }
    }

    public Array<T> buildMinHeap(){
        for (int i = heapSize/2; i >= 0 ; i--) {
            minHeapify(i);
        }
        return tArray;
    }
    //Helper methods
    //*************************************************************************//

    public int parent(int child){
        return (child - 1)/2;
    }

    public int left(int parent){
        return parent*2 + 1;
    }

    public int right(int parent){
        return parent*2 + 2;
    }

}
