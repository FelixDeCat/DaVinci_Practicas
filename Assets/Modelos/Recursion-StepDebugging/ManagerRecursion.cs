using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

public class ManagerRecursion : MonoBehaviour
{
    MyList<MyCube> allCube = new MyList<MyCube>();
    public MyCube prefabCube;
    public int amountCube;
    public float timer;

	void Start ()
    {
        StartCoroutine(StepDebuggingCreator(amountCube));
	}
	
    /// <summary>
    /// Creacion de cubos paso a paso
    /// </summary>
    /// <param name="c"></param>
    /// <returns></returns>
    IEnumerator StepDebuggingCreator(int c)
    {
        int i = 0;
        while(i<c)
        {
            CreateCube(i);
            yield return new WaitForSeconds(timer);
            i++;
        }
        
    }
    /// <summary>
    /// Funcion para crear cubos y ubicarlos
    /// </summary>
    /// <param name="i"></param>
    void CreateCube(int i)
    {
        var c = Instantiate(prefabCube);
        c.transform.position += Vector3.up * i;
        allCube.Add(c);
    }

    void Update()
    {
        if (Input.GetKeyUp(KeyCode.Space))
            Debug.Log("Total: "+TotalCount(allCube.first));

        if (Input.GetKeyUp(KeyCode.A))
            Debug.Log(allCube.Count());

        if (Input.GetKeyUp(KeyCode.B))
            StartCoroutine(RecursiveStep(10));
    }

    //Recursion basica en una lista para encontrar el valor del elemento y hacer una sumatoria.
    public int TotalCount(Node<MyCube> node)
    {
        if (node.next == null)
            return node.GetValue().value;
        else
        {
            return (TotalCount(node.next) + node.GetValue().value);
        }
           
    }

    public double factorial_Recursion(int number) {
        return number == 1 ? 1: number * factorial_Recursion(number - 1);
    }

    public IEnumerator RecursiveStep(int depth)
    {
        if (depth > 0)
            yield return StartCoroutine(RecursiveStep(depth - 1));

        yield return new WaitForSeconds(0.5f);
        Debug.Log("MyCoroutine is now finished at depth " + depth);
    }
}
