package dushyant.lib.sort;

import java.util.Comparator;

/**
 * Created by Dushyant Singh Shekhawat
 * on 12-06-2016.
 *
 * The basic idea behind the sort is to take each element and push it to
 * the beginning of the array till there is a value smaller than it.
 *
 * We do this by moving the elements bigger than it forward, one step at a time in the
 * while loop.
 */

public class InsertionSort {

    /***
     *
     * @param arr the array to be sorted
     * @param <T> the type of elements in the array, must extend Comparable
     */
    public static<T extends Comparable<T>> void sort(T[] arr){
        T key;
        int j;

        //for each value in the array, pull it to the start of the array
        //till there is a value smaller than it
        for(int i = 1; i < arr.length; i++){
            key = arr[i];
            j = i - 1;

            //now that we have a key, we compare it to the values before it and if they are larger
            //we move them forward one space and create space for either our key or the next value,
            //if it is larger than the key
            while (j >= 0 && arr[j].compareTo(key) > 0){
                arr[j+1] = arr[j];
                j--;
            }
            //now we put the key in the empty space created
            arr[j+1] = key;
        }
    }

    public static <T> void sort(T[] arr, Comparator<T> comparator) {
        T key;
        int j;

        //for each value in the array, pull it to the start of the array
        //till there is a value smaller than it
        for(int i = 1; i < arr.length; i++){
            key = arr[i];
            j = i - 1;

            //now that we have a key, we compare it to the values before it and if they are larger
            //we move them forward one space and create space for either our key or the next value,
            //if it is larger than the key
            while (j >= 0 && comparator.compare(arr[j], key) > 0){
                arr[j+1] = arr[j];
                j--;
            }
            //now we put the key in the empty space created
            arr[j+1] = key;
        }
    }

    //These methods will have code duplication. I am providing them
    //only because of improved performance
    //******************************************************************//

    public static void sort(int[] arr){
        int key, j;

        //for each value in the array, pull it to the start of the array
        //till there is a value smaller than it
        for(int i = 1; i < arr.length; i++){
            key = arr[i];
            j = i - 1;

            //now that we have a key, we compare it to the values before it and if they are larger
            //we move them forward one space and create space for either our key or the next value,
            //if it is larger than the key
            while (j >= 0 && arr[j] > key){
                arr[j+1] = arr[j];
                j--;
            }
            //now we put the key in the empty space created
            arr[j+1] = key;
        }
    }

    public static void sort(long[] arr){
        long key ;
        int j;

        //for each value in the array, pull it to the start of the array
        //till there is a value smaller than it
        for(int i = 1; i < arr.length; i++){
            key = arr[i];
            j = i - 1;

            //now that we have a key, we compare it to the values before it and if they are larger
            //we move them forward one space and create space for either our key or the next value,
            //if it is larger than the key
            while (j >= 0 && arr[j] > key){
                arr[j+1] = arr[j];
                j--;
            }
            //now we put the key in the empty space created
            arr[j+1] = key;
        }
    }

    public static void sort(float[] arr){
        float key;
        int j;

        //for each value in the array, pull it to the start of the array
        //till there is a value smaller than it
        for(int i = 1; i < arr.length; i++){
            key = arr[i];
            j = i - 1;

            //now that we have a key, we compare it to the values before it and if they are larger
            //we move them forward one space and create space for either our key or the next value,
            //if it is larger than the key
            while (j >= 0 && arr[j] > key){
                arr[j+1] = arr[j];
                j--;
            }
            //now we put the key in the empty space created
            arr[j+1] = key;
        }
    }

    public static void sort(double[] arr){
        double key;
        int j;

        //for each value in the array, pull it to the start of the array
        //till there is a value smaller than it
        for(int i = 1; i < arr.length; i++){
            key = arr[i];
            j = i - 1;

            //now that we have a key, we compare it to the values before it and if they are larger
            //we move them forward one space and create space for either our key or the next value,
            //if it is larger than the key
            while (j >= 0 && arr[j] > key){
                arr[j+1] = arr[j];
                j--;
            }
            //now we put the key in the empty space created
            arr[j+1] = key;
        }
    }

    public static void sort(char[] arr){
        char key;
        int j;

        //for each value in the array, pull it to the start of the array
        //till there is a value smaller than it
        for(int i = 1; i < arr.length; i++){
            key = arr[i];
            j = i - 1;

            //now that we have a key, we compare it to the values before it and if they are larger
            //we move them forward one space and create space for either our key or the next value,
            //if it is larger than the key
            while (j >= 0 && arr[j] > key){
                arr[j+1] = arr[j];
                j--;
            }
            //now we put the key in the empty space created
            arr[j+1] = key;
        }
    }

    public static void sort(short[] arr){
        short key;
        int j;

        //for each value in the array, pull it to the start of the array
        //till there is a value smaller than it
        for(int i = 1; i < arr.length; i++){
            key = arr[i];
            j = i - 1;

            //now that we have a key, we compare it to the values before it and if they are larger
            //we move them forward one space and create space for either our key or the next value,
            //if it is larger than the key
            while (j >= 0 && arr[j] > key){
                arr[j+1] = arr[j];
                j--;
            }
            //now we put the key in the empty space created
            arr[j+1] = key;
        }
    }
}
