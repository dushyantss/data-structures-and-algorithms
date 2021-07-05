package dushyant.lib.sort;

import java.util.Arrays;

/**
 * Created by Dushyant Singh Shekhawat
 * on 17-06-2016.
 */
public class CountingSortTest {
    public static void main(String[] args) {
        int[] arr = new int[]{5, 2, 7, 4, 1, 2, 3, 8, 9, 0};
        System.out.println(Arrays.toString(arr));
        int[] sorted = CountingSort.sort(arr, 9);
        System.out.println(Arrays.toString(sorted));

    }
}
