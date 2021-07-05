package dushyant.lib.sort;

import java.util.Arrays;

/**
 * Created by Dushyant Singh Shekhawat
 * on 17-06-2016.
 */
public class RadixSortTest {
    public static void main(String[] args) {
        int[] arr = new int[]{5312, 4212, 753, 4, 111, 2312, 31, 832, 9432, 1230};
        System.out.println(Arrays.toString(arr));
        RadixSort.sort(arr);
        System.out.println(Arrays.toString(arr));
    }
}
