using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class myStack<T>
{
    MyList<T> internalList;

    
    public myStack()
    {
        internalList = new MyList<T>();
    }
	
    /// <summary>
    /// Agregar un elemento al stack
    /// </summary>
    /// <param name="element"></param>
    public void Push(T element)
    {
        internalList.Add(element);
    }

    /// <summary>
    /// Devuelve el ultimo elemento sacandolo de la lista
    /// </summary>
    /// <returns></returns>
    public T Pop()
    {
        if (internalList.Count() <= 0)
            return default(T);

        var value = internalList.last;
        Debug.Log("value " + value.GetValue());
        internalList.Remove(internalList.last.GetValue());
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

        return internalList.last.GetValue();
    }

    /// <summary>
    /// Nos cuenta la cantidad de elementos en la lista
    /// </summary>
    public void Count()
    {
        Debug.Log("Tengo "+internalList.Count()+" elementos en mi stack");
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
