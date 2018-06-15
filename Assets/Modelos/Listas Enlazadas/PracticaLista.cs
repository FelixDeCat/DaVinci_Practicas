using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PracticaLista<T>
{
    public NodoPractica<T> first;
    public NodoPractica<T> last;

    void Inicialization(T val)
    {
        first = new NodoPractica<T>();
        last = new NodoPractica<T>();
        first.SetValue(val);
        last = first;
    }

    public void Add(T element)
    {
        if (first == null) Inicialization(element);
        else
        {
            last.SetChild(element);
            last = last.GetChild();
        }
    }

    public void Remove(T element)
    {
        if (first == null) return;
        NodoPractica<T> elementToRemove = null;
        NodoPractica<T> elementBefore = first;

        NodoPractica<T> current = first;

        if (first.GetValue().Equals(element))
        {
            first = first.next;
            last = first;
            return;
        }

        while (current.next != null)
        {
            if (current.next.GetValue().Equals(element))
            {
                elementBefore = current;
                elementToRemove = current.next;
                break;
            }
            current = current.next;
        }
        if (elementToRemove != null)
        {
            elementBefore.next = elementToRemove.next;
            if (elementToRemove.next != null)
            {
                last = elementToRemove.next;
            }
        }
        else
        {
            Debug.Log("No se encontro");
        }

    }
}
