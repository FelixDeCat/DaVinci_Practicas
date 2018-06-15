[System.Serializable]
public class Hero {
    public string nombre = "defaultName";
    public HeroData stats;
    public virtual void ModifyValues(HeroData hd) { stats = hd; }
}
