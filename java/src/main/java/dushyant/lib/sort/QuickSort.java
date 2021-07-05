package dushyant.lib.sort;

/**
 * Created by Dushyant Singh Shekhawat
 * on 17-06-2016.
 * <p>
 * This quicksort is the original(sort) quicksort and the CLRS(sort2)
 */
public class QuickSort {

    public static <T extends Comparable<T>> void sort(T[] arr) {
        sort(arr, 0, arr.length - 1);
    }

    // This will be a simple one without random pivot as I do not expect malicious input
    private static <T extends Comparable<T>> void sort(T[] arr, int low, int high) {
        if (low < high) {
            int mid = partition(arr, low, high);
            sort(arr, low, mid - 1);
            sort(arr, mid + 1, high);
        }
    }

    private static <T extends Comparable<T>> int partition(T[] arr, int low, int high) {
        int mid = (low + high) / 2, i = low, j = high;
        T pivot = arr[mid];
        while (true) {
            while (arr[j].compareTo(pivot) > 0) j--;
            while (arr[i].compareTo(pivot) < 0) i++;
            if (i == j) break;
            T temp = arr[j];
            arr[j] = arr[i];
            arr[i] = temp;
        }
        return i;
    }


    //This will be the CLRS method for sorting this is kind of like moving your hand through sand and the bigger pieces
    //are moved by your hand
    public static <T extends Comparable<T>> void sort2(T[] arr) {
        sort2(arr, 0, arr.length - 1);
    }

    private static <T extends Comparable<T>> int partition2(T[] arr, int low, int high) {
        T pivot = arr[high], temp = null;
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (arr[j].compareTo(pivot) <= 0) {
                i++;
                temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
        temp = arr[i + 1];
        arr[i + 1] = arr[high];
        arr[high] = temp;

        return i + 1;
    }

    private static <T extends Comparable<T>> void sort2(T[] arr, int low, int high) {
        if (low < high) {
            int pivot = partition2(arr, low, high);
            sort2(arr, low, pivot - 1);
            sort2(arr, pivot + 1, high);
        }
    }
}
