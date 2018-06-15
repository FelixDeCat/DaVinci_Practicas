using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using System;
using UnityEngine.UI;

public class GenericSaveLoad<T>
{
    const string DOC_VACIO = "{\"array_objects\":[]}";
    string path = "";
    string _nombreDocumento;
    string textoConvertido;
    Text deb;
    ListObjs listaConvert;
    List<T> currentObjects;
    internal class ListObjs { public T[] array_objects; }

    public GenericSaveLoad(string documentName) { Initialize(documentName); }
    public GenericSaveLoad(string documentName, Text test) {
        Initialize(documentName);
        if (deb != null) test.text = "El nuevo path es: " + path;
    }

    void Initialize(string _s) {
        _nombreDocumento = _s;
        currentObjects = new List<T>();
        listaConvert = new ListObjs { array_objects = new T[2] };
        path = GetPathByName(_s);
    }

    string GetPathByName(string s) {
        string temp;
        temp = "C:/EditorDePremios/" + s + ".txt";
#if UNITY_ANDROID
        temp = Path.GetFullPath("mnt/sdcard/Archivos/" + s + ".txt");
#endif
        return temp;
    }

    ///////////////////////////////
    /// DEBUG
    ///////////////////////////////
    public string ComprobarContenidoEnString() {
        CargarTexto();
        return textoConvertido;
    }
    public string VerPath() { return path; }
    void Log(string s) { if (deb != null) deb.text += "\n"+ s; }

    ///////////////////////////////
    /// SAVE
    ///////////////////////////////
    public void Guardar(List<T> _list) {
        currentObjects = _list;
        listaConvert.array_objects = _list.ToArray();
        Serializar();
        GuardarTexto();
    }
    void Serializar() { textoConvertido = JsonUtility.ToJson(listaConvert); }
    void GuardarTexto() {
        File.WriteAllText(path, textoConvertido);
        Debug.LogWarning("TEXTO>> " + textoConvertido + " <<TEXTO");
    }
    ///////////////////////////////
    /// SAVE
    ///////////////////////////////
    public List<T> Cargar() {
        Log("Cargando");
        CargarTexto();
        ConvertirATipoDeObjeto();
        return currentObjects;
    }
    void CargarTexto()
    {
        Log("Comprobando");
        Comprobacion(path);
        textoConvertido = File.ReadAllText(path);
    }
    void ConvertirATipoDeObjeto()
    {
        listaConvert = JsonUtility.FromJson<ListObjs>(textoConvertido);
        foreach (T o in listaConvert.array_objects) { currentObjects.Add(o); }
    }
    string Comprobacion(string _path) {
        string temp = "";
        if (File.Exists(_path)) {
            Log("Existe");
            temp = File.ReadAllText(_path) == "" ? DOC_VACIO : File.ReadAllText(_path);
            File.WriteAllText(_path, temp);
        }
        else
        {
            Log("No existe, Creando");
            temp = DOC_VACIO;
            File.Create(_path);
            File.OpenWrite(_path);
            File.WriteAllText(_path, textoConvertido);
        }
        return temp;
    }
}
