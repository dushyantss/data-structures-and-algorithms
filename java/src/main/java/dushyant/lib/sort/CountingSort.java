package dushyant.lib.sort;

/**
 * Created by Dushyant Singh Shekhawat
 * on 17-06-2016.
 */
public class CountingSort {
    public static int[] sort(int[] arr, int maxVal) {
        int[] result = new int[arr.length], temp = new int[maxVal + 1];
        for (int i = 0; i < arr.length; i++) temp[arr[i]]++;
        for (int i = 1; i < temp.length; i++) temp[i] += temp[i - 1];
        for (int i = arr.length - 1; i >= 0; i--) {
            result[temp[arr[i]] - 1] = arr[i];
            temp[arr[i]]--;
        }

        return result;
    }
}
