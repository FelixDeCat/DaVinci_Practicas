using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeroManager : MonoBehaviour {

    public static HeroManager instancia;
    string path;
    public List<Hero> heroes_models = new List<Hero>();

    public GameObject model;
    public Transform parent;

    void Awake()
    {
        instancia = this;
        path = "Assets/Resources/" + "Heroes" + ".txt";
    }

    private void Start()
    {
        LoadHereoes();
        ShowHeroes(parent, heroes_models, false);
    }

    

    public void ShowHeroes(Transform _parent, List<Hero> list_heros, bool onlyShow)
    {
        foreach (Transform t in _parent) { Destroy(t.gameObject); }

        for (int i = 0; i < list_heros.Count; i++)
        {
            GameObject go = GameObject.Instantiate(model);
            go.transform.SetParent(_parent);
            go.transform.position = new Vector3(0, 0, 0);
            go.transform.localScale = new Vector3(1, 1, 1);

            HeroModelUI ui = go.GetComponent<HeroModelUI>();
            ui.nombre = list_heros[i].nombre + " clase <" + list_heros[i].stats.nameHeroType + ">";
            ui.index = i;
            ui.showData = onlyShow;
            ui.infoExtra =
                "Salud: " + list_heros[i].stats.health + "\n" +
                "velocidad: " + list_heros[i].stats.speed + "\n" +
                "velocidad de ataque: " + list_heros[i].stats.attackSpeed + "\n" +
                "Daño: " + list_heros[i].stats.damage + "\n" +
                "Mana: " + list_heros[i].stats.mana;
            ui.Refresh();
        }
    }

    public class HeroSaver { public List<Hero> list; }
    public virtual void SaveHeroes() {
        HeroSaver ul = new HeroSaver();
        ul.list = heroes_models;
        ul.SaveDataToDisk(path, false);
    }
    public virtual void LoadHereoes() {
        HeroSaver ul = new HeroSaver();
        ul = Serializacion.LoadDataFromDisk<HeroSaver>(path, false);
        heroes_models = ul.list;
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.S))
        {
            SaveHeroes();
        }
        if (Input.GetKeyDown(KeyCode.L))
        {
            LoadHereoes();
        }
    }
}
