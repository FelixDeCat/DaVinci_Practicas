using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Flecha : Item {

    protected override void InitValues()
    {
        nombre = "Flecha";
        cant = 1;
        _actionType = ActionType.consumible;
    }

    protected override void ActionToRealize()
    {
        //accion que realiza al usar la flecha
    }

    public override void AwakeAction() { base.AwakeAction(); }
    public override void ExecuteAction() { base.ExecuteAction(); }
}
