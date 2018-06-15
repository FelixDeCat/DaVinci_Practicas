using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;
using System.Timers;

public class Practica5 : MonoBehaviour
{
    public bool execute;

    void Ejecutar(Action a) { Debug.Log("----- " + a.Method.Name + " -----"); a(); }

    List<int> lista = new List<int>();

    void Awake()
    {

        if (!execute) return;
        Ejecutar(Ej1);
        Ejecutar(Ej2);
        Ejecutar(Ej3);
        Ejecutar(Ej4);
        Ejecutar(Ej5);
        Ejecutar(Ej6);
        Ejecutar(Ej7);
        Ejecutar(Ej8);
        Ejecutar(Ej9);
        Ejecutar(Ej10);
        Ejecutar(Ej11);
    }

    public enum Obstaculo { obs_Rama, obs_Zaraza, obs_Tacho }

    public class obstaculo
    {
        string nombre;
        public Obstaculo this_Obstacle;
        List<Tuple<Obstaculo, float>> probabilidades;// <Obstaculo, probabilidad>
    }
    

    void Ej1() {
        lista.AgregarALaLista(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        lista.Aggregate(0, (x, y) => x + y).Debugear();
    }
    void Ej2() {
        lista.AgregarALaLista(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        lista.Aggregate(5, (x, y) => x + y).Debugear();
    }
    void Ej3() {
        lista.AgregarALaLista(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        lista.Aggregate(0, (x, y) => x * y).Debugear();
    }
    void Ej4() {
        lista.AgregarALaLista(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
    }
    void Ej5() { }
    void Ej6() { }
    void Ej7() { }
    void Ej8() { }
    void Ej9() { }
    void Ej10() { }
    void Ej11() { }

}
