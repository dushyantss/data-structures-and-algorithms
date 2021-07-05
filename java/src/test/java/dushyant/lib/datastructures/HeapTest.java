package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 */
public class HeapTest {
    public static void main(String[] args) {
        String[] arr = {"Hello", "how", "Are", "you", "HUH"};
        Heap<String> heap = new Heap<>(arr);
        for (int i = 0; i < heap.tArray.getIndex(); i++) {
            System.out.println(heap.tArray.get(i));
        }
    }
}
