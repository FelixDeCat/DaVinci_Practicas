using System.Collections.Generic;
using System;
using UnityEngine;

public class Ejercicio2 : MonoBehaviour {

    Func<List<int>, int, Dictionary<int,int>> func1;
    Dictionary<int, int> dic1;
    List<int> list1;
    int entero1;

    Func<int, string> func2;
    int entero2;

    Func<List<int>, Func<int,List<int>>> func3;
    List<int> list3;
    //List<int> list3_copia;
    int entero3;

    void Llamadas()
    {
        ////////////////////////////////////////////////////////////////////

        //func1 = (list1, entero1) => { 
        //dic1[list1[entero1]] *= entero1; return dic1; };

        func1 = (list1, entero1) => {
            for (int i = 0; i < list1.Count; i++) { dic1.Add(i, i * entero1); }
            return dic1;
        };
        ////////////////////////////////////////////////////////////////////

        func2 = entero2 => 
        entero2 < 4 ? "Makind" : (entero2 < 100 ? "Machines" : "Sometig Else");

        ////////////////////////////////////////////////////////////////////

        //func3 = list3 => { return entero3 => 
        //{ list3_copia[entero3] = list3[entero3] * entero3; 
        // return list3_copia; }; };

        func3 = list3 => {
                return entero3 => {
                    for (int i = 0; i < list3.Count; i++) {
                        list3[i] = i * entero3; }
                    return list3;
                };
            };
    }
}
