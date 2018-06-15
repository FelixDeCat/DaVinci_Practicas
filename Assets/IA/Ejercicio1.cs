using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class Ejercicio1 : MonoBehaviour
{

    //delegate void D_Execute();
    //D_Execute execute;
    Action execute;

    //delegate void D_Attack(Character ch);
    //D_Attack attack;
    Action<Character> attack;
    Character chartest = new Character();

    //delegate int D_Count();
    //D_Count count;
    Func<int> count;

    //delegate int D_Process<T>();
    //D_Process<string> process;
    Func<int> process;

    //delegate bool D_IsAlive<G>(Character ch);
    //D_IsAlive<int> isAlive;
    Func<Character, bool> isAlive;

    //delegate int D_Process2<T>(T v);
    //D_Process2<string> process2;
    Func<object,int> process2;
    int jorge_entero;

    //delegate S D_Transform<T, S>(T element);
    //new D_Transform<object, string> transform;
    Func<object, string> transform;
    string pedro_cadena;

    //delegate List<S> D_ConvertElements<T, S>(List<T> elements, Func<T, S> converter);
    //D_ConvertElements<float, string> convertElement;
    Func<List<int>, Func<int, string>, List<string>> convertElement;
    List<int> lista_enteros;
    List<string> lista_strings;
    string pFloat_rString(float v) { return "Zxc"; }

    //delegate Func<T2,TR> D_Compose<T1,T2,TR> (Func<T1, TR> f, Func<T2, TR> g);
    //D_Compose<string, int, char> compose;
    Func<Func<string, char>, Func<int, char>, Func<int, char>> compose;
    char pInt_RChar(int v) { return 'a'; }
    char pString_Rchar(int v) { return 'b'; }

    //delegate HashSet<J> D_Enlist<J, T, Y>(Dictionary<J, Y> dic, Func<Y, T> fnc, Action<J> act);
    //D_Enlist<char, bool, byte> enlist;
    Func<Dictionary<char, byte>, Func<byte, bool>, Action<char>, HashSet<char>> enlist;
    HashSet<char> hashChar;
    Dictionary<char, byte> dictemp;
    bool FuncTemp(byte v) { return true; }
    void ActionTemp(char v) { }


    void Llamadas<T>()
    {
        execute = () => { };
        attack = chartest => { };
        count = () => { return 10; };
        process = () => { return 20; };//el string de D_Process<string> process ¿como lo usaría? o quedó en el Limbo?
        isAlive = chartest => { return true; };//lo mismo pero con el int
        process2 = pedro_cadena => { return 30; };
        transform = jorge => { return pedro_cadena; } ; 
        convertElement = (lista_enteros, pFloat_rString) => lista_strings;// a partir de este punto el InteliSense ya no me completa el segundo parametro
        compose = (pString_Rchar, pInt_RChar) =>  pInt_RChar;
        enlist = (dictemp, FuncTemp, ActionTemp) => hashChar;

    }

    void Execute() { }
    void Attack(Character ch) { }
    int Count() { return 10; }
    int Process<T>() { return 20; }
    bool IsAlive<G>(Character ch) { return true; }
    int Process<T>(T item) { return 30; }
    S Transform<T, S>(T element) { return (S)Convert.ChangeType(pedro_cadena, typeof(S)); }
    List<S> ConvertElements<T, S>(List<T> elements, Func<T, S> converter) { return new List<S>(); }
    Func<T2, TR> Compose<T1, T2, TR>(Func<T1, TR> f, Func<T2, T2> g) {
        return (Func<T2, TR>) Convert.ChangeType("asd", typeof(Func<T2,TR>));  }

    HashSet<J> Enlist<J, T, Y>(Dictionary<J, Y> dic, Func<Y, T> fnc, Action<J> act)
    { return (HashSet<J>)Convert.ChangeType(hashChar, typeof(HashSet<J>)); }


    float testfunc1(int a) { return 0.3f; }
    string testfunc2(string b) { return "caca"; }
    float testfunc3ret(string c) { return 0.4f; }


    public class Character { public string nombre; public int edad; }
}