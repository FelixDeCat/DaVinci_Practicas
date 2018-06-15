using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class QueueGen<T>
{

    MyList<T> internalList;


    public QueueGen()
    {
        internalList = new MyList<T>();
    }

    /// <summary>
    /// Agregar un elemento al Queue
    /// </summary>
    /// <param name="element"></param>
    public void Enqueue(T element)
    {
        internalList.Add(element);
    }

    /// <summary>
    /// Devuelve el primer elemento sacandolo de la lista
    /// </summary>
    /// <returns></returns>
    public T Dequeue()
    {
        if (internalList.Count() <= 0)
            return default(T);

        var value = internalList.first;
        Debug.Log("value " + value.GetValue());
        internalList.Remove(internalList.first.GetValue());
        return value.GetValue();
    }

    /// <summary>
    /// Devuelve el ultimo elemento
    /// </summary>
    /// <returns></returns>
    public T Peek()
    {
        if (internalList.Count() <= 0)
            return default(T);

        return internalList.first.GetValue();
    }

    /// <summary>
    /// Nos cuenta la cantidad de elementos en la lista
    /// </summary>
    public void Count()
    {
        Debug.Log("Tengo " + internalList.Count() + " elementos en mi queue");
    }

    /// <summary>
    /// Verificar si esta vacio
    /// </summary>
    /// <returns></returns>
    public bool IsEmply()
    {
        return internalList.Count() >= 1;
    }
}
