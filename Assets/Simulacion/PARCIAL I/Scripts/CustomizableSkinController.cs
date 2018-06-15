using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CustomizableSkinController : MonoBehaviour
{
    public Material material;

    public Slider[] colorA;
    public Slider[] colorB;
    public Slider[] colorC;

    public Slider shirtsSlider;
    public Slider shortsSlider;
    public Slider socksSlider;

    public Texture2D[] kits;

    Color _colorA = Color.black;
    Color _colorB = Color.black;
    Color _colorC = Color.black;

    void Awake()
    {
        SetConfigSliders();

        colorA[0].onValueChanged.AddListener(delegate { OnColorAUpdate(0); });
        colorA[1].onValueChanged.AddListener(delegate { OnColorAUpdate(1); });
        colorA[2].onValueChanged.AddListener(delegate { OnColorAUpdate(2); });
        colorB[0].onValueChanged.AddListener(delegate { OnColorBUpdate(0); });
        colorB[1].onValueChanged.AddListener(delegate { OnColorBUpdate(1); });
        colorB[2].onValueChanged.AddListener(delegate { OnColorBUpdate(2); });
        colorC[0].onValueChanged.AddListener(delegate { OnColorCUpdate(0); });
        colorC[1].onValueChanged.AddListener(delegate { OnColorCUpdate(1); });
        colorC[2].onValueChanged.AddListener(delegate { OnColorCUpdate(2); });

        shirtsSlider.onValueChanged.AddListener(delegate { OnShirtUpdate(); });
        shortsSlider.onValueChanged.AddListener(delegate { OnShortsUpdate(); });
        socksSlider.onValueChanged.AddListener(delegate { OnSocksUpdate(); });
    }

    Dictionary<int, int[]> dic = new Dictionary<int, int[]>();
    public void SetConfigSliders() {
        dic.Add(0, new int[4] { 0, 0, 0, 0 });
        dic.Add(1, new int[4] { 1, 0, 0, 0 });
        dic.Add(2, new int[4] { 0, 1, 0, 0 });
        dic.Add(3, new int[4] { 0, 0, 1, 0 });
        dic.Add(4, new int[4] { 0, 0, 0, 1 });
    }

    void SetValuesWithACode(string code, Slider valSlider)
    {
        int slider_val = (int)valSlider.value; /*{0,1,2,3,4}*/
        int[] array_que_necesito = dic[slider_val];

        for (int i = 0; i < valSlider.maxValue; i++) /* {0,1,2,3}*/
        {
            string val_toChange = code + i;
            material.SetFloat(val_toChange, array_que_necesito[i]);
        }
    }

    void OnShirtUpdate()
    {
        SetValuesWithACode("_Sldr_Camisa_", shirtsSlider);
    }

    void OnShortsUpdate()
    {
        SetValuesWithACode("_Sldr_Short_", shortsSlider);
    }

    void OnSocksUpdate()
    {
        SetValuesWithACode("_Sldr_Medias_", socksSlider);
    }

    #region Color Updates
    public void OnColorAUpdate(int index) {
        switch (index) {
            case 0: _colorA.r = colorA[index].value; break;
            case 1: _colorA.g = colorA[index].value; break;
            case 2: _colorA.b = colorA[index].value; break;
            default: break;
        }
        material.SetColor("_ColorA", _colorA);
    }
    public void OnColorBUpdate(int index) {
        switch (index) {
            case 0: _colorB.r = colorB[index].value; break;
            case 1: _colorB.g = colorB[index].value; break;
            case 2: _colorB.b = colorB[index].value; break;
            default: break;
        }
        material.SetColor("_ColorB", _colorB);
    }
    public void OnColorCUpdate(int index) {
        switch (index) {
            case 0: _colorC.r = colorC[index].value; break;
            case 1: _colorC.g = colorC[index].value; break;
            case 2: _colorC.b = colorC[index].value; break;
            default: break;
        }
        material.SetColor("_ColorC", _colorC);
    }
    #endregion
}
