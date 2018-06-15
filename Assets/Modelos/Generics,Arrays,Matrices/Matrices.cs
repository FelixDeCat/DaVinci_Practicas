using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Matrices : MonoBehaviour
{
    int[,] array2D = new int[3, 2] { { 9, 99 }, { 3, 33 }, { 5, 55 } };
    int[,,] array3D = new int[,,] { { { 1, 2, 3 } }, { { 4, 5, 6 } } };

	
	// Update is called once per frame
	void Update ()
    {
        if (Input.GetKeyUp(KeyCode.Alpha1))
        {
            for (int f = 0; f < array2D.GetLength(0); f++)
            {
                for (int c = 0; c < array2D.GetLength(1); c++)
                {
                    Debug.Log(array2D[f, c]);
                }
                Debug.Log("****");
            }
        }

        if (Input.GetKeyUp(KeyCode.Alpha2))
        {
            for (int f = 0; f < array3D.GetLength(0); f++)
            {
                for (int c = 0; c < array3D.GetLength(1); c++)
                {
                    for (int z = 0; z < array3D.GetLength(2); z++)
                    {
                        Debug.Log(array3D[f, c,z]);
                    }
                }
                Debug.Log("****");
            }
        }

                
    }
}
