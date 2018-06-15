public class NodoPractica<T> {
    T value;
    public NodoPractica<T> next;
    public void SetValue(T val) { value = val; }
    public T GetValue() { return value; }
    public NodoPractica<T> GetChild() { return next; }
    public void SetChild(T newChildren) {
        NodoPractica<T> newNode = new NodoPractica<T>();
        newNode.SetValue(newChildren);
        next = newNode;
    }
}
