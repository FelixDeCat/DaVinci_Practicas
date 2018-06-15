using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//[ExecuteInEditMode]
public class BlackHoleBehaviour : MonoBehaviour {

    public Material blackHoleMat;
    public float strenghtMultiplier;
    float strenght = 0;
    public float fallOff = 2;
    public Transform blackHolePosition;

    float _timer;
    float _duration;

	void Start ()
    {
		
	}
	
	
	void Update ()
    {
        blackHoleMat.SetVector("_BlackHoleLocation", blackHolePosition.position);

        strenght += Time.deltaTime;
        strenghtMultiplier += strenght/10;

        blackHoleMat.SetFloat("_Strenght", strenght * strenghtMultiplier);
	}
}
