package dushyant.lib.sort;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 */
public class HeapSortTest {
    public static void main(String[] args) {
        String[] arr = {"Hello", "This ", "is a test string.", "so it may or may", "not work"};
        HeapSort.sort(arr).print();
        String[] arr2 = {"c", "d", "a", "beta", "bandar"};
        HeapSort.sort(arr2).print();
    }
}
