using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Practica6 : MonoBehaviour {

    void Ejecutar(Action a) { Debug.Log("----- " + a.Method.Name + " -----"); a(); }

    public bool execute;

    /*
        1) IEnumerable<int> Cuenta5() -- genera los números 1,2,3,4,5 E imprimir
        2) IEnumerable<int> CuentaN(int n) --> generar los números de 1 a n (inclusive)
        3) Imprimir todos los números de cuentaN, pero uno por segundo.
    */

    void Awake()
    {
        if (!execute) return;
        StartCoroutine(ImprimeCuentaN());
    }

    //aca El IEnumerable de enteros
    public IEnumerable<int> Contador(int seed, int max)
    {
        for (int i = seed; i < max; i++)
        {
            yield return i;
        }
    }

    //acá el IEnumerator para la Coroutines
    public IEnumerator ImprimeCuentaN()
    {
        foreach (var elem in Contador(0,6))
        {
            elem.Debugear();
            yield return new WaitForSeconds(1);
        }
    }








    /*
    4) IEnum<int> FiboSeq() – Plantear un generador para la secuencia de Fibonacci(lazy/yield).
            fibo(0) = 0
            fibo(1) = 1
            fibo(x) = fibo(x-1) + fibo(x-2)
        5) Plantear un generator lazy llamado generate que
        a) inicie con un acumulador con una semilla tipo T
        b) tome una lambda T => T que infinitamente vaya "mutando" los valores del acum.
        c) a su vez, Generate vaya "pasando/cediendo" estos valores a medida que se piden
     */
}
