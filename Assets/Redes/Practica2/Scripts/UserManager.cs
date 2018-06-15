using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UserManager : MonoBehaviour {

    public static UserManager instancia;

    public List<User> users;

    public User currentUser;
    public string path;

    public GameObject model;
    public Transform parent;

    public Transform parentDebugHeroes;

    public Text txt_CurrentUser;
    public Text txt_CantHeroes;


    public GameObject model_item;
    public Transform parent_item;

    private void Awake()
    {
        instancia = this;
        users = new List<User>();
        path = "Assets/Resources/" + "Users" + ".txt";
    }

    private void Start()
    {
        LoadUsers();
        ShowUsers();
    }

    public void AddUser(string name)
    {
        User u = new User();
        u.username = name;

        currentUser = u;
        DebugCurrentUser();
        users.Add(u);
    }

    void DebugCurrentUser()
    {
        txt_CurrentUser.text = currentUser.username;
        txt_CantHeroes.text = "";
        foreach (Hero h in currentUser.heroes) { txt_CantHeroes.text += "("+ h.nombre + ")"; }

        HeroManager.instancia.ShowHeroes(parentDebugHeroes, currentUser.heroes, true);
    }
    public void AddHeroeForCurrentUser(int i)
    {
        Hero h = HeroManager.instancia.heroes_models[i];
        Debug.Log("AddHero: " + h.nombre + " at User: " + currentUser.username);
        currentUser.heroes.Add(h);
        DebugCurrentUser();
        SaveUsers();
    }

    private void Update() {
        if (Input.GetKeyDown(KeyCode.Z)) AddUser("Pepito");
        if (Input.GetKeyDown(KeyCode.X)) SaveUsers();
        if (Input.GetKeyDown(KeyCode.C)) LoadUsers();
    }

    public class UserLoader { public List<User> list; }
    public void SaveUsers() {
        UserLoader ul = new UserLoader();
        ul.list = users;
        ul.SaveDataToDisk(path, false);
    }
    public void LoadUsers() {
        UserLoader ul = new UserLoader();
        ul = Serializacion.LoadDataFromDisk<UserLoader>(path, false);
        users = ul.list;
    }

    public void EnterInUser(int i)
    {
        currentUser = users[i];
        DebugCurrentUser();
    }

    public void ShowUsers()
    {
        foreach (Transform t in parent) Destroy(t.gameObject);

        for (int i = 0; i < users.Count; i++)
        {
            GameObject go = GameObject.Instantiate(model);
            go.transform.SetParent(parent);
            go.transform.position = new Vector3(0, 0, 0);
            go.transform.localScale = new Vector3(1, 1, 1);

            go.gameObject.GetComponentsInChildren<Text>()[0].text = i.ToString();
            go.gameObject.GetComponentsInChildren<Text>()[1].text = users[i].username;

            go.gameObject.GetComponent<UIUser>().index = i;
        }
    }

    public void MostrarItems(int indexHeroe)
    {
        ShowItems(parent_item, currentUser.heroes[indexHeroe].stats.items);
    }

    public void ShowItems(Transform _parent, Item[] items)
    {
        foreach (Transform t in _parent) { Destroy(t.gameObject); }

        for (int i = 0; i < items.Length; i++)
        {
            GameObject go = GameObject.Instantiate(model_item);
            go.transform.SetParent(_parent);
            go.transform.position = new Vector3(0, 0, 0);
            go.transform.localScale = new Vector3(1, 1, 1);

            ItemUI ui = go.GetComponent<ItemUI>();
            ui.nombre = items[i].nombre;
            ui.index = i;
            ui.cant = items[i].cant;
            ui.Refresh();
        }
    }
}
