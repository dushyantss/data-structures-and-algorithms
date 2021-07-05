package dushyant.lib.sort;

/**
 * Created by Dushyant Singh Shekhawat
 * on 12-06-2016.
 *
 * This is just there because I might need it, so i have not made manu implementations
 * like I did in insertion sort
 *
 * I could make an even faster implementation by making the temp arrays instance variables
 * but then I'd have to make this class work by instantiation. Since, I am only going to use
 * insertion sort or quickSort. That would be unnecessary work to implement a feature.
 * Will do so in the future if the need arises
 */
public class MergeSort {

    public static <T extends Comparable<T>> void sort(T[] arr){
        mergeSort(arr, 0, arr.length - 1);
    }

    private static <T extends Comparable<T>> void mergeSort(T[] arr, int p, int r) {
        if(p < r){
            int q = (p + r)/2;
            mergeSort(arr, p, q);
            mergeSort(arr, q + 1, r);
            merge(arr, p, q, r);
        }
    }

    /***
     *
     * @param arr The main array to be sorted
     * @param p the index to start merging at
     * @param q the mid value(last index of first and first index of the second subarray
     * @param r the last index
     * @param <T> The type of objects contained in arr
     */
    private static <T extends Comparable<T>> void merge(T[] arr, int p, int q, int r){
        int n1 = q - p + 1;
        int n2 = r - q;

        T[] arr1 = arr.clone();
        T[] arr2 = arr.clone();

        for (int i = 0; i < n1; i++) {
            arr1[i] = arr[p + i];
        }

        for (int i = 0; i < n2; i++) {
            arr2[i] = arr[q + i + 1];
        }

        //i is left counter, j = right counter
        int i = 0, j = 0;
        for (int k = p; k <= r; k++) {
            if(i >= n1){
                while (j < n2){
                    arr[k++] = arr2[j++];
                }
            }else if(j >= n2){
                while (i < n1){
                    arr[k++] = arr1[i++];
                }
            }else if(arr1[i].compareTo(arr2[j]) <= 0){
                arr[k] = arr1[i++];
            }else{
                arr[k] = arr2[j++];
            }
        }
    }
}
