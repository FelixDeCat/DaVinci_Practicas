using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ItemUI : MonoBehaviour {

    public int index;
    public string nombre;
    public int cant;

    public Text txt_index;
    public Text txt_nombre;
    public Text txt_cant;

    public void Refresh()
    {
        txt_index.text = index.ToString();
        txt_nombre.text = nombre;
        txt_cant.text = cant.ToString();
    }
}
