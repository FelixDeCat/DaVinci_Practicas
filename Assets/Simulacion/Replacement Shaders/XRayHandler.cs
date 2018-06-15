using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class XRayHandler : MonoBehaviour
{
    public Shader XRayShader;
    public Color color;
  

    bool _xRayActive = false;
	
	void OnEnable ()
    {
        Shader.SetGlobalColor("_XRayColor", color);
    
	}
	
	
	void Update ()
    {
		if (!_xRayActive && Input.GetKeyUp(KeyCode.Space))
        {
            GetComponent<Camera>().SetReplacementShader(XRayShader, "");
            _xRayActive = true;
            return;
        }

        if (_xRayActive && Input.GetKeyUp(KeyCode.Space))
        {
            GetComponent<Camera>().ResetReplacementShader();
            _xRayActive = false;
            

        }
	}
}
