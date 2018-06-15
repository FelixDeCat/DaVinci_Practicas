using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HeroModelUI : MonoBehaviour {

    public string nombre;
    public int index;
    public string infoExtra;

    public Text txt_nombre;
    public Text txt_index;
    public Text txt_infoextra;

    public bool showData;

    public void BTN_SelectHero()
    {
        if (!showData) UserManager.instancia.AddHeroeForCurrentUser(index);
        else UserManager.instancia.MostrarItems(index);
    }

    public void Refresh() {
        txt_nombre.text = nombre;
        txt_index.text = index.ToString();
        txt_infoextra.text = infoExtra;
    }

}
