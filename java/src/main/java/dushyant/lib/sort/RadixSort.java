package dushyant.lib.sort;

/**
 * Created by Dushyant Singh Shekhawat
 * on 17-06-2016.
 */
public class RadixSort {
    //e.g. for 43425 being the maxValue, maxValueDecimalPower == 5
    private static int findMax(int[] arr) {
        int max = arr[0];
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] > max) max = arr[i];
        }

        return max;
    }

    public static void sort(int[] arr) {
        int max = findMax(arr);

        for (int exp = 1; exp <= max; exp *= 10) {
            internalSort(arr, exp);
        }
    }

    public static void internalSort(int[] arr, int exp) {
        int[] output = new int[arr.length];
        int[] temp = new int[10];

        for (int i = 0; i < arr.length; i++) output[i] = arr[i];
        for (int i = 0; i < arr.length; i++) temp[(arr[i] / exp) % 10]++;
        for (int i = 1; i < temp.length; i++) temp[i] += temp[i - 1];
        for (int i = arr.length - 1; i >= 0; i--) {
            arr[temp[(output[i] / exp) % 10] - 1] = output[i];
            temp[(output[i] / exp) % 10]--;
        }
    }
}
