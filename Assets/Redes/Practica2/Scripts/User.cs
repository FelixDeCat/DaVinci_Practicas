using System.Collections.Generic;

[System.Serializable]
public class User {
    public string username;
    public List<Hero> heroes = new List<Hero>();
}
