[System.Serializable]
public class Item
{
    public string nombre;
    public int cant;

    public enum ActionType { active, manual, consumible }
    public ActionType _actionType;

    public virtual void AwakeAction() {
        InitValues();
        if (_actionType == ActionType.active) Activate();
    }

    public virtual void ExecuteAction() { Activate(); }

    protected  virtual void InitValues()
    {

    }

    protected virtual void ActionToRealize()
    {
        //esto lo va a heredar y ejecutar cada item por separado
    }

    void Activate()
    {
        ActionToRealize();
        //si una accion ACTIVE no hace falta desactivarla porque va a permanecer
        if(_actionType == ActionType.manual) Deactivate();
        if (_actionType == ActionType.consumible) Consume();
    }
    void Deactivate()
    {
        //si es una accion manual se va a re-activar con algun timer o con cualquier otra cosa en el escenario
        //por ejemplo un totem que se recarga cada cierto tiempo, o un totem que solo se recarga en predeterminado santuario
    }
    void Consume()
    {
        cant--;
        //if (cant <= 0) Object.Destroy(this);
    }
}
