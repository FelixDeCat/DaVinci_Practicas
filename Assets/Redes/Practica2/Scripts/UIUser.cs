using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UIUser : MonoBehaviour {

    UserManager userM;

    public int index;

    private void Start()
    {
        userM = GameObject.FindObjectOfType<UserManager>();
    }

    public void BUTTON_EnterUser()
    {
        userM.EnterInUser(index);
    }
}
