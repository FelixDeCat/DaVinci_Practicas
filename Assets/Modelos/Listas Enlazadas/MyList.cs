using UnityEngine;
public class MyList<T> {
    public Node<T> first;
    public Node<T> last;
    void Initialization(T element) {
        first = new Node<T>();
        last = new Node<T>();
        first.SetValue(element);
        last = first;
    }
    public void Add(T element) {
        if (first == null) Initialization(element);
        else {
            last.SetChildren(element);
            last = last.next;
        }
    }
    public int Count() {
        int value = 0;
        var current = first;
        if (current == null) return 0;
        else value = 1;
        while (current != null) {
            value++;
            current = current.next;
        }
        return (value - 1);
    }
    public void Remove(T element) {
        if (first == null) return;
        Node<T> elementToRemove = null;
        Node<T> elementBefore = first;
        var current = first;
        if (first.GetValue().Equals(element)) {
            first = first.next;
            last = first;
            return;
        }
        while (current.next != null) {
            if (current.next.GetValue().Equals(element)) {
                elementBefore = current;
                elementToRemove = current.next;
                break;
            }
            current = current.next;
        }
        if (elementToRemove != null) {
            elementBefore.next = elementToRemove.next;
            if (elementToRemove.next != null) last = elementToRemove.next;
            else last = elementBefore;
            elementToRemove = null;
        }
        else Debug.Log("No se encontro");
    }
}