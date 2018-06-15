using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[ExecuteInEditMode]
public class ImpactDetector : MonoBehaviour {

    public Transform impactVector;

    Renderer rend;
    Material mat;

	void Start () 
    {
        rend = GetComponent<Renderer>();
        mat = rend.sharedMaterial;
	}
	
	
	void Update () 
    {
        mat.SetVector("_HitPosition", impactVector.position);
	}
}
