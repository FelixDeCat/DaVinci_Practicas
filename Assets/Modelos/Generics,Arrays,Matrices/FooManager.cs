using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FooManager : MonoBehaviour
{
    public List<Foo<int>> myList= new List<Foo<int>>();

    public List<Foo<string>> myListString = new List<Foo<string>>();

    void Awake ()
    {
        myList.Add(new Foo<int>(Random.Range(0, 11)));
        myList.Add(new Foo<int>(Random.Range(0, 11)));
        myList.Add(new Foo<int>(Random.Range(0, 11)));
        myList.Add(new Foo<int>(Random.Range(0, 11)));


        myListString.Add(new Foo<string>("asd"));
        myListString.Add(new Foo<string>("qwe"));
        myListString.Add(new Foo<string>("zxc"));
    }
	

	void Update ()
    {
		if(Input.GetKeyUp(KeyCode.Alpha1))
        {
            foreach (var i in myList)
                Debug.Log(i.GetValue());
        }

        if (Input.GetKeyUp(KeyCode.Alpha2))
        {
            foreach (var i in myList)
                i.ChangeValue(Random.Range(0, 11));

            Debug.Log("Cambie los valores");
        }

        if (Input.GetKeyUp(KeyCode.Alpha3))
        {
            foreach (var i in myListString)
                Debug.Log(i.GetValue());
        }

    }
}
