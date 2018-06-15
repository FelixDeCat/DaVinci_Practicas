using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Linq;

public static class MisExtensiones
{
    public static ICollection<T> AgregarALaLista<T>(this ICollection<T> collection, params T[] parametros)
    {
        collection.Clear();
        for (int i = 0; i < parametros.Length; i++) { collection.Add(parametros[i]); }
        return collection;
    }

    public static void DebugearContenido<T>(this ICollection<T> collection)
    {
        foreach(ICollection<T> v in collection) Debug.Log(v.ToString());
    }

    public static T Debugear<T>(this T val) { Debug.Log(val.ToString()); return val; }
    public static IEnumerable<T> Debugear<T>(this IEnumerable<T> val) { val.ToList().ForEach(x => Debug.Log(x)); return val; }


    public static int Sumame(this List<int> enteros)
    {
        int sum = 0;

        for (int i = 0; i < enteros.Count; i++)
        {
            sum = sum + enteros[1];
        }
        return sum;
    }

}
