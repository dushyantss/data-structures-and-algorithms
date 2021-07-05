package dushyant.lib.datastructures;

/**
 * Created by Dushyant Singh Shekhawat
 * on 13-06-2016.
 */
public class StackTest {
    public static void main(String[] args) {
        Stack<String> stack = new Stack<>();
        stack.push("Hello");
        stack.push("how");
        stack.push("are");
        stack.push("you");
        stack.push("doing");
        stack.push("?");
        while (!stack.isEmpty()) {
            System.out.println(stack.pop());
        }
        System.out.println(stack.isEmpty());
    }
}
