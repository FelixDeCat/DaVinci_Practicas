using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Totem : Item {

    protected override void InitValues()
    {
        nombre = "Totem";
        cant = 1;
        _actionType = ActionType.manual;
    }

    protected override void ActionToRealize()
    {
        //accion que realiza el totem cuando se usa
        //ejemplo cura al player
    }

    public override void AwakeAction() { base.AwakeAction(); }
    public override void ExecuteAction() { base.ExecuteAction(); }
}
