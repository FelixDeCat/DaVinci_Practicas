using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Runtime.Serialization;
using System;

public static class Serializacion
{
    //guarda datos de una clase a un archivo binario
    public static void SaveDataToDisk<T>(this T classToSerialize, string path, bool encripted)
    {
        if(encripted)
        {
            //se crea el archivo a partir del path dado
            BinaryFormatter bf = new BinaryFormatter();
            FileStream file = File.Create(path);

            //se escriben los datos en binario en el archivo
            bf.Serialize(file, classToSerialize);

            //cerramos
            file.Close();
        }
        else
        {
            //se crea archivo de texto  a partir del path dado
            StreamWriter file = File.CreateText(path);

            //creamos un nuevo string json
            string json = JsonUtility.ToJson(classToSerialize, true);

            //guardamos los datos
            file.Write(json);

            //cerramos
            file.Close();
        }


    }

    //carga los datos de un binario a una clase
    public static T LoadDataFromDisk<T>(string path, bool encripted)
    {
        //chequeo si el path existe
        if (File.Exists(path))
        {
            if(encripted)
            {
                //se abre el archivo a partir del path dado
                BinaryFormatter bf = new BinaryFormatter();
                FileStream file = File.Open(path, FileMode.Open);

                //se deseralizan los datos del binario
                T newClass = (T)bf.Deserialize(file);

                //cerramos y retornamos la clase
                file.Close();
                return newClass;
            }
            else
            {
                //abrimos el archivo .json y cargamos el string
                string fileToLoad = File.ReadAllText(path);

                //devolvemos la clase contenida
                return JsonUtility.FromJson<T>(fileToLoad);
            }
        }
        else return default(T);
    }

    //////////////////////////////////////////////////////////////////////////////////////

    public class Aux<T>
    {
        public List<T> list;
    }

    //guarda datos de una clase a un archivo binario
    public static void SaveListToDisk<T>(this List<T> listToSerialize, string path, bool encripted)
    {
        if (encripted) {
            BinaryFormatter bf = new BinaryFormatter();
            FileStream file = File.Create(path);

            Aux<T> aux = new Aux<T>();
            aux.list = listToSerialize;

            bf.Serialize(file, aux);
            file.Close();
        }
        else {
            StreamWriter file = File.CreateText(path);

            Aux<T> aux = new Aux<T>();
            aux.list = listToSerialize;

            string json = JsonUtility.ToJson(aux, true);
            file.Write(json);
            file.Close();
        }
    }



    //carga los datos de un binario a una clase
    public static List<T> LoadListFromDisk<T>(string path, bool encripted)
    {

        if (File.Exists(path))
        {
            if (encripted)
            {
                BinaryFormatter bf = new BinaryFormatter();
                FileStream file = File.Open(path, FileMode.Open);
                List<T> newClass = (List<T>)bf.Deserialize(file);

                file.Close();
                return newClass;
            }
            else
            {
                string fileToLoad = File.ReadAllText(path);
                return JsonUtility.FromJson<List<T>>(fileToLoad);
            }
        }
        else return default(List<T>);
    }
}

