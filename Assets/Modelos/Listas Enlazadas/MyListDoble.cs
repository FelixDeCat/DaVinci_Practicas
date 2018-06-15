using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MyListDoble<T>
{
    public NodeDoble<T> first;
    public NodeDoble<T> last;


    void Initialization(T element)
    {
        first = new NodeDoble<T>();
        last = new NodeDoble<T>();
        first.SetValue(element);
        last = first;
        first.children = last;
    }

    public void Add(T element)
    {
        if (first == null)
            Initialization(element);
        else
        {
            last.SetChildren(element);
            last = last.children;
        }

    }

    public int Count()
    {
        int value = 0;
        var current = first;

        if (current == null)
            return 0;
        else
            value = 1;

        while (current != null)
        {
            if (current.father != null)
                Debug.Log(current.GetValue() + " tiene como padre :" + current.father.GetValue());
            else
                Debug.Log(current.GetValue() + " tiene como padre : null");

            if (current.children != null)
                Debug.Log(current.GetValue() + " tiene como hijo :" + current.children.GetValue());
            else
                Debug.Log(current.GetValue() + " tiene como hijo : null");


            value++;
            current = current.children;
        }

        return (value - 1);
    }


    public void Remove(T element)
    {
        if (first == null)
            return;

        NodeDoble<T> elementToRemove = null;
        var current = first;

        if (first.GetValue().Equals(element))
        {
            first.RemoveNode();
            first = first.children;
            return;
        }

        while (current.children != null)
        {

            if (current.children.GetValue().Equals(element))
            {
                elementToRemove = current.children;
                break;
            }
            current = current.children;
        }

        if (elementToRemove != null)
        {
            elementToRemove.RemoveNode();
        }
    }
}
