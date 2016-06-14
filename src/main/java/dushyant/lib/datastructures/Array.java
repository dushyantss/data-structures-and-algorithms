package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 *
 * This will be a dynamic array which will increase and decrease in size
 * but that is all it will do, rest of its functions I'd like to keep just like
 * an array
 */
public class Array<T> {
    private T[] arr;

    //the position where we can insert a new value
    private int index;

    private static final int DEFAULT_SIZE = 10;
    private static final int ARRAY_SIZE_MULTIPLIER = 2;

    public Array(int size){
        arr = (T[]) new Object[size];
    }

    public Array(){
        arr = (T[]) new Object[DEFAULT_SIZE];
    }

    public void add(T data){

        if(index < arr.length){
            arr[index++] = data;
        }else {
            copyToNew(index*ARRAY_SIZE_MULTIPLIER);
            arr[index++] = data;
        }
    }

    public void replace(int index, T data){
        arr[index] = data;
        if(index > this.index){
            this.index = index;
        }
    }

    public T get(int index){
        return arr[index];
    }

    public int getLength(){
        return arr.length;
    }

    public int getIndex(){
        return index;
    }

    public void remove(T data){
        int pos = -1;
        for (int i = 0; i <= index ; i++) {
            if (arr[i].equals(data)) {
                pos = i;
                break;
            }
        }
        if(pos >= 0){
            index--;
            for (int i = pos; i < index; i++) {
                arr[i] = arr[i+1];
            }
        }
    }

    public void trimToSize(){
        copyToNew(index);
    }

    private void copyToNew(int size) {
        T[] temp = arr;
        int minLength = Math.min(temp.length, arr.length);
        arr = (T[]) new Object[size];
        for (int i = 0; i < minLength; i++) {
            arr[i] = temp[i];
        }
    }

    public void print(){
        for (T t :
                arr) {
            System.out.print(t + " , ");
        }
        System.out.println("END");
    }
}
