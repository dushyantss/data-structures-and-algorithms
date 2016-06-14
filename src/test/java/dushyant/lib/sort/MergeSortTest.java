package dushyant.lib.sort;

import java.util.Arrays;

/**
 * Created by Dushyant Singh Shekhawat
 * on 12-06-2016.
 */
public class MergeSortTest {
    public static void main(String[] args) {
        String[] arr = {"Hello", "This ", "is a test string.", "so it may or may", "not work"};
        MergeSort.sort(arr);
        System.out.println(Arrays.toString(arr));
        String[] arr2 = {"c", "d", "a", "beta", "bandar"};
        MergeSort.sort(arr2);
        System.out.println(Arrays.toString(arr2));
    }
}
