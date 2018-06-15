using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NodeDoble<T>
{
    T value;
    public NodeDoble<T> children;
    public NodeDoble<T> father;

    public void SetValue(T v)
    {
        value = v;
    }

    public T GetValue()
    {
        return value;
    }

    public void SetChildren(T newChildren)
    {
        var newNode = new NodeDoble<T>();
        newNode.SetValue(newChildren);
        children = newNode;
        children.father = this;
    }

    public void RemoveNode()
    {
        if(father != null)
            father.children = children;
        if(children != null)
            children.father = father;
    }
}
