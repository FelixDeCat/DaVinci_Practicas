using MySql.Data.MySqlClient;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.Data;


public class Login : MonoBehaviour {

    [Header("Login and Register")]
    public Text userField;
    public Text passField;

    [Header("Estados de Amistad")]
    public InputField input_user1;
    public InputField input_user2;
    public Text txt_amistadResultado;

    MySqlAdmin _DBAdmin;
    private void Start(){
        _DBAdmin = FindObjectOfType<MySqlAdmin>();
        //input_user1.text = "pablo";
        //input_user2.text = "juan";
        Clase2.instancia._myEvent += MostrarResultado;
        //LogIn("juan", "123");
    }

    public void Btn_ConsultaAmistad() {
        txt_amistadResultado.text = EstadoDeAmistad(input_user1.text, input_user2.text);
        //Clase2.instancia.CheckUser(input_user1.text, input_user2.text);
    }

    void MostrarResultado(string s) { txt_amistadResultado.text = s; }

    public void Register()
    {
        MySqlDataReader res2 = _DBAdmin.ExecuteQuery(_DBAdmin.CreateQuery(DBQueries.CHECK_USERNAME, userField.text));
        if (!res2.HasRows) {
            res2.Close();
            MySqlDataReader res3 = _DBAdmin.ExecuteQuery(_DBAdmin.CreateQuery(DBQueries.REGISTER_REQUEST, userField.text, passField.text));
            res3.Close();
            print("New User Created.");
        }
        else {
            res2.Close();
            print("Username already taken.");
        }
    }

    public void BUTTON_Login()
    {
        LogIn(userField.text, passField.text);
    }

    public void LogIn(string _username, string _pass) {
        MySqlDataReader res = _DBAdmin.ExecuteQuery(_DBAdmin.CreateQuery(DBQueries.CHECK_USERNAME, _username));
        print(res.HasRows ? "Log In Successful!" : "Incorrect username or password.");
        res.Close();
    }
    void TableTesting()
    {
        //llamado con query normal o un stored procedure
        MySqlDataReader res = _DBAdmin.ExecuteQuery("CALL GETUSERS()");
        DataTable dat = new DataTable();//Esto pertenece a System.Data.dll
        //cargo el resultado de la query en la tabla
        dat.Load(res);

        //recorro la tabla, recordar que la tabla es una matriz
        //ROWS son las filas que tengo por lo cual puedo acceder a cada fila en un subindice
        //si quiero ver el contenido de una COLUMNA específica
        //accededo usando un indice (0,1,2, etc) 
        //o el string con el nombre ("user", "pass", etc)
        for (int i = 0; i < dat.Rows.Count; i++)
            print(dat.Rows[i]["username"]);
    }

    string EstadoDeAmistad(string _user1, string _user2)
    {
        string temp = "";
        MySqlDataReader resAmistades = _DBAdmin.ExecuteQuery(_DBAdmin.CreateQuery(DBStoreProcedure.AMISTADES_REQUEST,_user1, _user2));

        DataTable dt = new DataTable();
        dt.Load(resAmistades);
        temp = dt.Rows[0][0].ToString();

        resAmistades.Close();
        return temp;
    }
}
