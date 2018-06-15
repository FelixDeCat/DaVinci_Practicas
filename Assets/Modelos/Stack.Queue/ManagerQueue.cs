using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ManagerQueue : MonoBehaviour
{

    public int numAdd;

    QueueGen<int> queueInt;

    // Use this for initialization
    void Start()
    {
        queueInt = new QueueGen<int>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyUp(KeyCode.A))
        {
            queueInt.Enqueue(numAdd);
        }


        if (Input.GetKeyUp(KeyCode.S))
        {
            Debug.Log("El primero es " + queueInt.Peek());
        }


        if (Input.GetKeyUp(KeyCode.D))
        {
            Debug.Log("Saque el numero " + queueInt.Dequeue());
        }


        if (Input.GetKeyUp(KeyCode.F))
        {
            Debug.Log("Esta lleno " + queueInt.IsEmply());
        }


        if (Input.GetKeyUp(KeyCode.C))
        {
            queueInt.Count();
        }

    }
}
