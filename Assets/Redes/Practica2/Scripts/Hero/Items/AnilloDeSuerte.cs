using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnilloDeSuerte : Item {

    protected override void InitValues()
    {
        nombre = "Anillo de Suerte";
        cant = 1;
        _actionType = ActionType.active;
    }

    protected override void ActionToRealize()
    {
        //accion que realiza al tenerlo activo
        //ejemplo aumenta la probabilidad de encontrar algo bueno en cofres
    }

    public override void AwakeAction() { base.AwakeAction(); }
    public override void ExecuteAction() { base.ExecuteAction(); }
}
