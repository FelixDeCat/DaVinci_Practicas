using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Foo <T>
{
    T value;

    public Foo(T setValue)
    {
        value = setValue;
    }

    public T GetValue()
    {
        return value;
    }

    public void ChangeValue(T newValue)
    {
        value = newValue;
    }
}
