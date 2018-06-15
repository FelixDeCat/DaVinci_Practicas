using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class Practica2 : MonoBehaviour
{
    public bool execute;

    public List<CharacterModel> characteres = new List<CharacterModel>();

    private void Awake()
    {
        if (!execute) return;

        characteres.Add(new CharacterModel("Superman", 1000, Color.red, new Vector2(1, 1), new Vector2(0, 0)));
        characteres.Add(new CharacterModel("Pepe", 100, Color.blue, new Vector2(1, 1), new Vector2(0, 0)));
        characteres.Add(new CharacterModel("Laura", 200, Color.white, new Vector2(1, 1), new Vector2(0, 0)));
        characteres.Add(new CharacterModel("Graviton", 100, Color.red, new Vector2(1, 1), new Vector2(0, 0)));
        characteres[0].Damage(200);
        characteres[1].Damage(95);
        characteres[2].Damage(20);
        characteres[3].Damage(99);
        Ejecutar(Ejercicio1);
        Ejecutar(Ejercicio2);
        Ejecutar(Ejercicio3);
        Ejecutar(Ejercicio4);
        Ejecutar(Ejercicio5);
        Ejecutar(Ejercicio6);
        Ejecutar(Ejercicio7);
        Ejecutar(Ejercicio8);
    }

    void Ejecutar(Action a)
    {
        Debug.Log("----- " + a.Method.Name + " -----");
        a();
    }
    void Ejercicio1()
    {
        var chars = characteres.Select(ch => ch.name);
        foreach (var s in chars) Debug.Log(s);
    }
    void Ejercicio2()
    {
        var chars = characteres.Select(ch => ch.hp);
        foreach (var hp in chars) Debug.Log(hp);
    }
    void Ejercicio3()
    {
        var chars = characteres.Select(ch => ch.State());
        foreach (var state in chars) { Debug.Log(state); }
    }
    void Ejercicio4()
    {
        var chars = characteres
            .Where(ch => ch.IsCritic())
            .Select(ch => ch.State());
        foreach (var state in chars) Debug.Log(state);
    }
    void Ejercicio5()
    {
        var fac = characteres.Select(ch => ch.Faction());
        foreach (var f in fac) Debug.Log(f);
    }

    void Ejercicio6()
    {
        var HEnemysDamaged = characteres
            .Where(ch => ch.Faction() == CharacterModel.Faction.Enemy)
            .Where(ch => !ch.IsOk())
            .Select(ch => ch.name + " is " + ch.State());

        foreach (var e in HEnemysDamaged) Debug.Log(e);
    }

    void Ejercicio7()
    {
        var des = characteres
            .Where(ch => ch.Faction().IsEnemy())
            .Select(ch => "Attack " + ch.name + "... is Enemy");
        foreach (var s in des) Debug.Log(s);
    }

    void Ejercicio8()
    {
        var des = characteres
            .Where(ch => ch.IsCritic())
            .Select(ch => "Attack " + ch.name + "... is weak");
        foreach (var s in des) Debug.Log(s);
    }

    void Ejercicio9()
    {
        var des = characteres
            .Where(ch => !ch.Faction().IsEnemy())
            .Where(ch => !ch.IsCritic())
            .Select(ch => "Attack " + ch.name + "... is nerfed");
        foreach (var s in des) Debug.Log(s);
    }

    void Ejercicio10()
    {
        var des = characteres
            .Where(ch => !ch.Faction().IsAlly())
            .Where(ch => ch.IsCritic())
            .Select(ch => "Attack " + ch.name + "... is a poor clog");
        foreach (var s in des) Debug.Log(s);
    }

    //EJERCICIO 1: Select & Where
    public class CharacterModel
    {
        public string name;
        public int maxHP;
        public int hp;
        public Color color;
        public Vector2 position;
        public Vector2 facing;
        public CharacterModel(string name, int maxHP, Color color, Vector2 position, Vector2 facing)
        {
            this.name = name;
            this.maxHP = maxHP;
            hp = maxHP;
            this.color = color;
            this.position = position;
            this.facing = facing;
        }
        public void Damage(int dam) { hp -= dam; }
        public enum Health { Damaged, OK, NearDeath };
        public enum Faction { Ally, Neutral, Enemy };
        public enum Decision { Ignore, Follow, Attack }
    }

    /*Escriba utilizando LINQ funciones que reciban un IEnumerable<CharacterModel> y retornen: 
    1.	Una lista de nombres
    2.	Una lista de HP’s
    3.	Una lista con las condiciones de cada personaje, usando el enum Health
        a.OK: de 90% a 100% hp
        b.Damaged: de 10% a 90% hp
        c.NearDeath: debajo de 10% de hp
    4.  Una lista de condiciones de HP (enum Health) de personajes, manteniendo solo los que tengan hp debajo del 10%
        a.Extra: En este punto, el orden cambia en algo?
    5.	Una lista con las facciones, usando el enum Faction : Rojos = enemigos, azules = amigos, el resto son neutrales.
    6.	Una lista que contenga la condición de HP (enum Health) de los personajes, excluyendo los que estén “OK”, solamente evaluando personajes de la facción roja.
    7.	Lista de decisiones: Atacar a los enemigos, ignorar al resto.
    8.	Lista de decisiones: Atacar a cualquiera que esté por debajo de 10% de hp, ignorar al resto.
    9.	Lista de decisiones: Atacar a cualquiera que esté por arriba de 10% de hp, sin evaluar a aquellos que sean enemigos, ignorar al resto.
    10.	Lista de decisiones: atacar a enemigos y neutrales que estén por debajo de 10% HP, ignorar al resto.*/


    //EJERCICIO 2: Tipos Compuestos
    //2.a)
    //Vea el siguiente forEach;

    void PrintStatus(IEnumerable<CharacterModelAndHealth> characters)
    {
        var conditions = characters.Select(character =>
        {
            var hpPercent = character.model.hp / (float)character.model.maxHP;
            character.health = hpPercent < 0.1 ? CharacterModel.Health.NearDeath : hpPercent < 0.9 ? CharacterModel.Health.Damaged : CharacterModel.Health.OK;
            return character;
        });
        foreach (var status in conditions) Debug.Log("Name:" + status.model.name + " status:" + status.health);
    }

    //Si quiera imprimir el nombre del personaje, una solución sería crear una nueva clase:
    public class CharacterModelAndHealth
    {
        public CharacterModel model;
        public CharacterModel.Health health;
        public CharacterModelAndHealth(CharacterModel model, CharacterModel.Health health)
        {
            this.model = model;
            this.health = health;
        }
    }

    //    Arregle la consulta y el foreach para que funcionen con “CharacterModelAndHealth”. La variable “conditions” debería ser del tipo “IEnumerable<CharacterModelAndHealth>”.
    //2.b)
    //SE PUEDEN UTILIZAR TIPOS ANÓNIMOS SI SE PREFIERE
    //Como explicamos en clase, si por cada vez que tengo que asociar elementos de esa forma creo una nueva clase, vamos a generar demasiadas clases sin, realmente, la necesidad de hacerlo.
    //Utilice tuplas para hacer la consulta del ejercicio “2.a”, utilizando tuplas del tipo Tuple<Character, Health>
}


/////////////////////////////////////////////////////////////////
/// EXTENSIONES
/////////////////////////////////////////////////////////////////
public static class MyExtensions
{
    public static bool IsOk(this Practica2.CharacterModel ch) { return ch.hp > ch.maxHP * 0.9 ? true : false; }
    public static bool IsCritic(this Practica2.CharacterModel ch) { return ch.hp < ch.maxHP * 0.1 ? true : false; }
    public static Practica2.CharacterModel.Health State(this Practica2.CharacterModel ch) {
        return ch.hp > ch.maxHP * 0.9 ?
            Practica2.CharacterModel.Health.OK :
                (ch.hp > ch.maxHP * 0.1 ?
                Practica2.CharacterModel.Health.Damaged :
                Practica2.CharacterModel.Health.NearDeath);
    }
    public static Practica2.CharacterModel.Faction Faction(this Practica2.CharacterModel ch) {
        return ch.color == Color.red ?
            Practica2.CharacterModel.Faction.Enemy :
                (ch.color == Color.blue ?
                Practica2.CharacterModel.Faction.Ally :
                Practica2.CharacterModel.Faction.Neutral);
    }
    public static bool IsEnemy(this Practica2.CharacterModel.Faction fac) { return fac == Practica2.CharacterModel.Faction.Enemy ? true : false; }
    public static bool IsNeutral(this Practica2.CharacterModel.Faction fac) { return fac == Practica2.CharacterModel.Faction.Neutral ? true : false; }
    public static bool IsAlly(this Practica2.CharacterModel.Faction fac) { return fac == Practica2.CharacterModel.Faction.Ally ? true : false; }
}