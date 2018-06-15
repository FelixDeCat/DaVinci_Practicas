using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ManagerStack : MonoBehaviour
{
    public int numAdd;

    myStack<int> stackInt;

    // Use this for initialization
	void Start ()
    {
        stackInt = new myStack<int>();	
	}
	
	// Update is called once per frame
	void Update ()
    {
        if (Input.GetKeyUp(KeyCode.A))
        {
            stackInt.Push(numAdd);
        }
           

        if (Input.GetKeyUp(KeyCode.S))
        {
            Debug.Log("El ultimo es " + stackInt.Peek());
        }
           

        if (Input.GetKeyUp(KeyCode.D))
        {
            Debug.Log("Saque el numero " + stackInt.Pop());
        }
           

        if (Input.GetKeyUp(KeyCode.F))
        {
            Debug.Log("Esta lleno " + stackInt.IsEmply());
        }
            

        if (Input.GetKeyUp(KeyCode.C))
        {
            stackInt.Count();
        }
           
    }
}
