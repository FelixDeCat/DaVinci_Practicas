using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FogController : MonoBehaviour {

    public Transform characterPosition;
    public Material fogMat;
	

	void Start () 
        {
		
	}
	
	// Update is called once per frame
	void Update () 
    {
        fogMat.SetVector("_CharacterPosition", characterPosition.position);
            }
}
