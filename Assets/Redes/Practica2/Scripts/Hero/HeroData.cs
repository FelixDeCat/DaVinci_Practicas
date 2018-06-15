[System.Serializable]
public class HeroData
{
    public string nameHeroType;

    public string skillsUnlocked;

    public int health;
    public int mana;
    public int level;

    public int stregth;
    public int dextery;
    public int agility;
    public int damage;
    public int speed;
    public int attackSpeed;

    public bool isHardMode;

    public Item[] items = new Item[10];
}
