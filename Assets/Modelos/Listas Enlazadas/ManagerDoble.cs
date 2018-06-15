using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ManagerDoble : MonoBehaviour
{

    public MyListDoble<int> testList = new MyListDoble<int>();
    public int elementToRemove;

    void Start()
    {
        testList.Add(1);
        testList.Add(2);
        testList.Add(3);
        testList.Add(4);
    }

    void Update()
    {
        if (Input.GetKeyUp(KeyCode.Alpha1))
            Debug.Log("Tiene : " + testList.Count() + " elementos");

        if (Input.GetKeyUp(KeyCode.Alpha2))
            testList.Add(5);

        if (Input.GetKeyUp(KeyCode.Alpha3))
            testList.Remove(elementToRemove);

    }
}
