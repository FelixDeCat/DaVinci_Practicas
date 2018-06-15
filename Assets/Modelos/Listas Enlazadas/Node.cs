using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Node<T>
{
    T value;
    public Node<T> next;

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
        var newNode = new Node<T>();
        newNode.SetValue(newChildren);
        next = newNode;
    }
}