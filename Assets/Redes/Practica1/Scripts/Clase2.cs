using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class Clase2 : MonoBehaviour
{

    public static Clase2 instancia;

    public delegate void Ev_RecibiResultadoDeQuery(string s);
    public event Ev_RecibiResultadoDeQuery _myEvent;

    public delegate void RequestCallback(WWW www);

    void Awake()
    {
        instancia = this;
    }

    void Start()
    {
        //RegisterUser("Clase 1");
        //GetUsers();
        //CheckUser("pepe", "pablo");
    }

    void RegisterUser(string username)
    {
        WWWForm form = new WWWForm();
        form.AddField("username", username);
        StartCoroutine(DoRequest("http://localhost/Clase2/RegisterUser.php", form, PrintOnScreen));
    }

    public void CheckUser(string username, string pass)
    {
        WWWForm form = new WWWForm();
        form.AddField("user", username);
        form.AddField("pass", pass);
        StartCoroutine(DoRequest("http://localhost/Clase3/GetUsers.php?user="+username+"&pass="+pass, form, PrintOnScreen));
    }

    void GetUsers()
    {
        WWWForm form = new WWWForm();
        form.AddField("lala", 0);
        StartCoroutine(DoRequest("http://localhost/Clase2/GetUsers.php", form, PrintOnScreen));
    }


    void PrintOnScreen(WWW www)
    {
        if (www.text.Contains("-"))
        {
            string[] chain = www.text.Split('-');
            foreach (var item in chain)
                if (!item.Equals("") && !item.Equals(" "))
                    print(item);
        }
        else
            print(www.text);

        _myEvent(www.text);
    }

    IEnumerator DoRequest(string url, WWWForm form = null, RequestCallback callback = null)
    {
        WWW www = new WWW(url, form == null ? null : form.data);
        yield return www;


        if (callback != null)
            callback(www);
    }
}