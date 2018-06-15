// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/Parcial1/Mascara"
{
	Properties
	{
		_Mascara_Camisa("Mascara_Camisa", 2D) = "white" {}
		_Mascara_Medias("Mascara_Medias", 2D) = "white" {}
		_Mascara_Short("Mascara_Short", 2D) = "white" {}
		_D1("D1", 2D) = "white" {}
		_D2("D2", 2D) = "white" {}
		_D3("D3", 2D) = "white" {}
		_D4("D4", 2D) = "white" {}
		_D5("D5", 2D) = "white" {}
		_ColorA("ColorA", Color) = (1,0,0,1)
		_ColorB("ColorB", Color) = (0,1,0,1)
		_ColorC("ColorC", Color) = (0,0,1,1)
		_Sldr_Camisa_0("Sldr_Camisa_0", Range( 0 , 1)) = 0
		_Sldr_Camisa_1("Sldr_Camisa_1", Range( 0 , 1)) = 0
		_Sldr_Camisa_2("Sldr_Camisa_2", Range( 0 , 1)) = 1
		_Sldr_Camisa_3("Sldr_Camisa_3", Range( 0 , 1)) = 0
		_Sldr_Short_0("Sldr_Short_0", Range( 0 , 1)) = 0
		_Sldr_Short_1("Sldr_Short_1", Range( 0 , 1)) = 0
		_Sldr_Short_3("Sldr_Short_3", Range( 0 , 1)) = 0
		_Sldr_Short_2("Sldr_Short_2", Range( 0 , 1)) = 0
		_Sldr_Medias_0("Sldr_Medias_0", Range( 0 , 1)) = 0
		_Sldr_Medias_1("Sldr_Medias_1", Range( 0 , 1)) = 0
		_Sldr_Medias_2("Sldr_Medias_2", Range( 0 , 1)) = 0
		_Sldr_Medias_3("Sldr_Medias_3", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Mascara_Medias;
		uniform float4 _Mascara_Medias_ST;
		uniform float4 _ColorA;
		uniform sampler2D _D1;
		uniform float4 _D1_ST;
		uniform float4 _ColorB;
		uniform float4 _ColorC;
		uniform sampler2D _D2;
		uniform float4 _D2_ST;
		uniform float _Sldr_Medias_0;
		uniform sampler2D _D3;
		uniform float4 _D3_ST;
		uniform float _Sldr_Medias_1;
		uniform sampler2D _D4;
		uniform float4 _D4_ST;
		uniform float _Sldr_Medias_2;
		uniform sampler2D _D5;
		uniform float4 _D5_ST;
		uniform float _Sldr_Medias_3;
		uniform sampler2D _Mascara_Short;
		uniform float4 _Mascara_Short_ST;
		uniform float _Sldr_Short_0;
		uniform float _Sldr_Short_1;
		uniform float _Sldr_Short_2;
		uniform float _Sldr_Short_3;
		uniform sampler2D _Mascara_Camisa;
		uniform float4 _Mascara_Camisa_ST;
		uniform float _Sldr_Camisa_0;
		uniform float _Sldr_Camisa_1;
		uniform float _Sldr_Camisa_2;
		uniform float _Sldr_Camisa_3;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Mascara_Medias = i.uv_texcoord * _Mascara_Medias_ST.xy + _Mascara_Medias_ST.zw;
			float4 sample_Medias113 = tex2D( _Mascara_Medias, uv_Mascara_Medias );
			float4 ColorA79 = _ColorA;
			float2 uv_D1 = i.uv_texcoord * _D1_ST.xy + _D1_ST.zw;
			float4 tex2DNode46 = tex2D( _D1, uv_D1 );
			float4 ColorB80 = _ColorB;
			float4 ColorC88 = _ColorC;
			float4 temp_output_75_0 = ( ( ColorA79 * tex2DNode46.r ) + ( ColorB80 * tex2DNode46.g ) + ( ColorC88 * tex2DNode46.b ) );
			float2 uv_D2 = i.uv_texcoord * _D2_ST.xy + _D2_ST.zw;
			float4 tex2DNode177 = tex2D( _D2, uv_D2 );
			float4 temp_output_198_0 = ( ( ColorA79 * tex2DNode177.r ) + ( ColorB80 * tex2DNode177.g ) + ( ColorC88 * tex2DNode177.b ) );
			float4 lerpResult185 = lerp( ( sample_Medias113 * temp_output_75_0 ) , ( sample_Medias113 * temp_output_198_0 ) , _Sldr_Medias_0);
			float2 uv_D3 = i.uv_texcoord * _D3_ST.xy + _D3_ST.zw;
			float4 tex2DNode207 = tex2D( _D3, uv_D3 );
			float4 temp_output_217_0 = ( ( ColorA79 * tex2DNode207.r ) + ( ColorB80 * tex2DNode207.g ) + ( ColorC88 * tex2DNode207.b ) );
			float4 lerpResult186 = lerp( lerpResult185 , ( sample_Medias113 * temp_output_217_0 ) , _Sldr_Medias_1);
			float2 uv_D4 = i.uv_texcoord * _D4_ST.xy + _D4_ST.zw;
			float4 tex2DNode221 = tex2D( _D4, uv_D4 );
			float4 temp_output_231_0 = ( ( ColorA79 * tex2DNode221.r ) + ( ColorB80 * tex2DNode221.g ) + ( ColorC88 * tex2DNode221.b ) );
			float4 lerpResult189 = lerp( lerpResult186 , ( sample_Medias113 * temp_output_231_0 ) , _Sldr_Medias_2);
			float2 uv_D5 = i.uv_texcoord * _D5_ST.xy + _D5_ST.zw;
			float4 tex2DNode235 = tex2D( _D5, uv_D5 );
			float4 temp_output_245_0 = ( ( ColorA79 * tex2DNode235.r ) + ( ColorB80 * tex2DNode235.g ) + ( ColorC88 * tex2DNode235.b ) );
			float4 lerpResult251 = lerp( lerpResult189 , ( sample_Medias113 * temp_output_245_0 ) , _Sldr_Medias_3);
			float2 uv_Mascara_Short = i.uv_texcoord * _Mascara_Short_ST.xy + _Mascara_Short_ST.zw;
			float4 sample_Short114 = tex2D( _Mascara_Short, uv_Mascara_Short );
			float4 lerpResult266 = lerp( ( sample_Short114 * temp_output_75_0 ) , ( sample_Short114 * temp_output_198_0 ) , _Sldr_Short_0);
			float4 lerpResult264 = lerp( lerpResult266 , ( sample_Short114 * temp_output_217_0 ) , _Sldr_Short_1);
			float4 lerpResult268 = lerp( lerpResult264 , ( sample_Short114 * temp_output_231_0 ) , _Sldr_Short_2);
			float4 lerpResult270 = lerp( lerpResult268 , ( sample_Short114 * temp_output_245_0 ) , _Sldr_Short_3);
			float2 uv_Mascara_Camisa = i.uv_texcoord * _Mascara_Camisa_ST.xy + _Mascara_Camisa_ST.zw;
			float4 sample_Camisa115 = tex2D( _Mascara_Camisa, uv_Mascara_Camisa );
			float4 lerpResult257 = lerp( ( sample_Camisa115 * temp_output_75_0 ) , ( sample_Camisa115 * temp_output_198_0 ) , _Sldr_Camisa_0);
			float4 lerpResult255 = lerp( lerpResult257 , ( sample_Camisa115 * temp_output_217_0 ) , _Sldr_Camisa_1);
			float4 lerpResult259 = lerp( lerpResult255 , ( sample_Camisa115 * temp_output_231_0 ) , _Sldr_Camisa_2);
			float4 lerpResult261 = lerp( lerpResult259 , ( sample_Camisa115 * temp_output_245_0 ) , _Sldr_Camisa_3);
			o.Albedo = ( lerpResult251 + lerpResult270 + lerpResult261 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
667;91;842;560;-84.31111;-1374.993;1.28517;False;False
Node;AmplifyShaderEditor.CommentaryNode;89;-1539.995,-450.7488;Float;False;507.8813;571.005;Colores;6;87;67;64;88;80;79;Colores;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;64;-1489.187,-400.748;Float;False;Property;_ColorA;ColorA;8;0;1,0,0,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;87;-1489.995,-86.73986;Float;False;Property;_ColorC;ColorC;10;0;0,0,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;247;-4239.83,313.2827;Float;False;1610.292;718.1583;Design2;14;196;194;191;177;192;193;195;197;199;200;201;202;203;198;Design2;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;246;-4252.24,-482.3867;Float;False;1583.718;718.1577;Comment;14;91;90;93;46;92;77;78;118;75;119;117;121;120;101;Design1;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;67;-1486.743,-244.1336;Float;False;Property;_ColorB;ColorB;9;0;0,1,0,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;193;-3782.527,793.2988;Float;False;88;0;1;COLOR
Node;AmplifyShaderEditor.CommentaryNode;248;-4217.154,1124.532;Float;False;1610.293;718.1584;Design3;14;204;205;206;207;208;209;210;211;212;213;214;215;216;217;Design3;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;116;-968.9414,-478.441;Float;False;572.0022;651.3392;Comment;6;96;102;95;115;114;113;Mascaras;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;-3820.792,-97.06828;Float;False;80;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;90;-3819.153,-201.314;Float;False;79;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;93;-3821.514,-2.371109;Float;False;88;0;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;46;-4202.24,-183.0444;Float;True;Property;_D1;D1;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;191;-3781.804,698.6015;Float;False;80;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;80;-1275.115,-244.4315;Float;False;ColorB;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;177;-4189.83,425.9503;Float;True;Property;_D2;D2;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;88;-1282.368,-86.03783;Float;False;ColorC;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;79;-1279.303,-395.366;Float;False;ColorA;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;192;-3780.165,594.3558;Float;False;79;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-3653.617,-197.8648;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-3607.9,-131.6474;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;207;-4167.154,1237.2;Float;True;Property;_D3;D3;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;196;-3568.912,664.0224;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;-3524.296,730.5231;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-3563.285,-65.14684;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.CommentaryNode;249;-4211.94,1924.961;Float;False;1610.29;718.1584;Design4;14;218;219;220;221;222;223;224;225;226;227;228;229;230;231;Design4;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;208;-3757.493,1405.605;Float;False;79;0;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;102;-917.7286,-57.1007;Float;True;Property;_Mascara_Camisa;Mascara_Camisa;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;95;-912.5777,-434.1862;Float;True;Property;_Mascara_Medias;Mascara_Medias;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;96;-918.9414,-246.4637;Float;True;Property;_Mascara_Short;Mascara_Short;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;206;-3759.132,1509.851;Float;False;80;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;209;-3759.853,1604.548;Float;False;88;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-3614.629,597.8049;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;197;-3063.903,563.9868;Float;False;114;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;200;-3081.271,364.9028;Float;False;113;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;117;-3120.26,-430.7666;Float;False;113;0;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;198;-3285.908,593.3641;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.CommentaryNode;250;-4191.445,2720.236;Float;False;1610.292;718.1582;Design4;14;232;233;234;235;236;237;238;239;240;241;242;243;244;245;Design4;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;119;-3113.745,-25.69561;Float;False;115;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;210;-3591.956,1409.054;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;118;-3102.892,-231.683;Float;False;114;0;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;75;-3324.899,-202.3056;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;-3546.239,1475.272;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;113;-639.5529,-424.3341;Float;False;sample_Medias;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;-642.7628,-56.41088;Float;False;sample_Camisa;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-645.7628,-239.4113;Float;False;sample_Short;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;220;-3753.922,2310.28;Float;False;80;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;222;-3752.284,2206.035;Float;False;79;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;-3501.624,1541.773;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;199;-3074.756,769.9743;Float;False;115;0;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;221;-4163.541,2036.029;Float;True;Property;_D4;D4;6;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;223;-3754.644,2404.978;Float;False;88;0;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;217;-3263.238,1404.614;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;218;-3541.029,2275.701;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;219;-3496.414,2342.202;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;212;-3052.084,1581.224;Float;False;115;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;201;-2869.604,363.2827;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;202;-2865.296,568.5721;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;203;-2864.531,778.441;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;-3586.746,2209.484;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;211;-3041.231,1375.236;Float;False;114;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-2908.593,-432.3867;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-2903.521,-17.22892;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;234;-3733.425,3105.555;Float;False;80;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;236;-3731.786,3001.309;Float;False;79;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;213;-3058.599,1176.152;Float;False;113;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;120;-2904.285,-227.0976;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;235;-4141.445,2832.903;Float;True;Property;_D5;D5;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;237;-3734.147,3200.252;Float;False;88;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;225;-3036.021,2175.666;Float;False;114;0;1;COLOR
Node;AmplifyShaderEditor.CommentaryNode;263;-1114.406,1131.461;Float;False;906.1067;567.1077;Comment;8;271;270;269;268;267;266;265;264;Short;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;232;-3520.532,3070.976;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.CommentaryNode;254;-1102.933,1896.607;Float;False;906.1067;567.1077;Comment;8;262;261;260;259;258;257;256;255;Camisa;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;214;-2846.932,1174.532;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;238;-3566.25,3004.758;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;233;-3475.917,3137.476;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;215;-2842.624,1379.822;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;216;-2841.86,1589.691;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;226;-3046.874,2381.653;Float;False;115;0;1;COLOR
Node;AmplifyShaderEditor.WireNode;356;-1218.483,1186.362;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;384;-1173.101,1959.286;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;382;-1188.101,1996.286;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;363;-1204.409,1233.062;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;368;-1201.854,464.8179;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;231;-3258.028,2205.043;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;227;-3053.389,1976.581;Float;False;113;0;1;COLOR
Node;AmplifyShaderEditor.CommentaryNode;253;-1108.459,374.96;Float;False;906.1067;567.1077;Comment;8;252;251;188;189;190;185;187;186;Medias;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;367;-1193.719,492.4772;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;357;-1205.483,1332.362;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;240;-3026.377,3176.927;Float;False;115;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;239;-3015.524,2970.94;Float;False;114;0;1;COLOR
Node;AmplifyShaderEditor.WireNode;381;-1151.101,1997.286;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;241;-3032.892,2771.856;Float;False;113;0;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;258;-1066.771,2054.86;Float;False;Property;_Sldr_Camisa_0;Sldr_Camisa_0;11;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;366;-1157.553,483.8502;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;380;-1184.101,2091.286;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;383;-1144.101,1968.286;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;228;-2841.722,1974.961;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;229;-2837.414,2180.251;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;364;-1180.408,1202.062;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;245;-3237.531,3000.317;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;230;-2836.65,2390.12;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;370;-1191.877,587.0522;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;190;-1058.459,531.3062;Float;False;Property;_Sldr_Medias_0;Sldr_Medias_0;19;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;267;-1064.407,1287.806;Float;False;Property;_Sldr_Short_0;Sldr_Short_0;15;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;365;-1162.806,461.5639;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;355;-1180.483,1234.362;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;372;-1190.877,689.0521;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;185;-874.5795,424.9601;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;369;-1158.877,575.0522;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;358;-1201.483,1436.361;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;243;-2816.917,2975.525;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;378;-1180.101,2190.287;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;242;-2821.225,2770.236;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;244;-2816.153,3185.394;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;379;-1149.101,2097.286;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;266;-880.5283,1181.46;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;257;-869.055,1946.607;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;256;-892.7289,2147.024;Float;False;Property;_Sldr_Camisa_1;Sldr_Camisa_1;12;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;187;-990.7617,630.8184;Float;False;Property;_Sldr_Medias_1;Sldr_Medias_1;20;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;265;-904.2019,1381.876;Float;False;Property;_Sldr_Short_1;Sldr_Short_1;16;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;362;-1177.408,1321.062;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;374;-1187.877,782.052;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;376;-1181.101,2292.288;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;359;-1201.483,1536.361;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;186;-703.6856,519.2;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;361;-1173.408,1421.062;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;260;-736.2906,2247.48;Float;False;Property;_Sldr_Camisa_2;Sldr_Camisa_2;13;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;188;-741.8154,725.8322;Float;False;Property;_Sldr_Medias_2;Sldr_Medias_2;21;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;269;-747.7648,1482.332;Float;False;Property;_Sldr_Short_2;Sldr_Short_2;18;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;377;-1145.101,2192.287;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;371;-1163.877,677.0521;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;264;-709.6331,1275.699;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;255;-698.1603,2040.846;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;268;-552.7639,1375.734;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;375;-1151.101,2296.288;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;271;-585.2977,1583.568;Float;False;Property;_Sldr_Short_3;Sldr_Short_3;17;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;189;-546.8157,619.2344;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;262;-575.825,2348.716;Float;False;Property;_Sldr_Camisa_3;Sldr_Camisa_3;14;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;360;-1177.408,1523.061;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;259;-541.2909,2140.881;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;373;-1160.877,776.052;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;252;-581.3494,827.0668;Float;False;Property;_Sldr_Medias_3;Sldr_Medias_3;22;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;270;-392.3009,1476.969;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;251;-386.354,720.4689;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;261;-380.8285,2242.117;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;173;4.760574,1455.137;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;386;273.7516,1891.089;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;385;-53.72571,1721.241;Float;True;Property;_Normal;Normal;23;0;Assets/Simulacion/PARCIAL I/descarga (1).png;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;10.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;387;160.7787,2017.604;Float;False;Property;_NormalStrength;NormalStrength;24;0;0;0;3;0;1;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;607.0644,1463.614;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MyShaders/Parcial1/Mascara;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;80;0;67;0
WireConnection;88;0;87;0
WireConnection;79;0;64;0
WireConnection;77;0;90;0
WireConnection;77;1;46;1
WireConnection;78;0;91;0
WireConnection;78;1;46;2
WireConnection;196;0;191;0
WireConnection;196;1;177;2
WireConnection;194;0;193;0
WireConnection;194;1;177;3
WireConnection;92;0;93;0
WireConnection;92;1;46;3
WireConnection;195;0;192;0
WireConnection;195;1;177;1
WireConnection;198;0;195;0
WireConnection;198;1;196;0
WireConnection;198;2;194;0
WireConnection;210;0;208;0
WireConnection;210;1;207;1
WireConnection;75;0;77;0
WireConnection;75;1;78;0
WireConnection;75;2;92;0
WireConnection;204;0;206;0
WireConnection;204;1;207;2
WireConnection;113;0;95;0
WireConnection;115;0;102;0
WireConnection;114;0;96;0
WireConnection;205;0;209;0
WireConnection;205;1;207;3
WireConnection;217;0;210;0
WireConnection;217;1;204;0
WireConnection;217;2;205;0
WireConnection;218;0;220;0
WireConnection;218;1;221;2
WireConnection;219;0;223;0
WireConnection;219;1;221;3
WireConnection;201;0;200;0
WireConnection;201;1;198;0
WireConnection;202;0;197;0
WireConnection;202;1;198;0
WireConnection;203;0;199;0
WireConnection;203;1;198;0
WireConnection;224;0;222;0
WireConnection;224;1;221;1
WireConnection;101;0;117;0
WireConnection;101;1;75;0
WireConnection;121;0;119;0
WireConnection;121;1;75;0
WireConnection;120;0;118;0
WireConnection;120;1;75;0
WireConnection;232;0;234;0
WireConnection;232;1;235;2
WireConnection;214;0;213;0
WireConnection;214;1;217;0
WireConnection;238;0;236;0
WireConnection;238;1;235;1
WireConnection;233;0;237;0
WireConnection;233;1;235;3
WireConnection;215;0;211;0
WireConnection;215;1;217;0
WireConnection;216;0;212;0
WireConnection;216;1;217;0
WireConnection;356;0;120;0
WireConnection;384;0;121;0
WireConnection;382;0;203;0
WireConnection;363;0;202;0
WireConnection;368;0;101;0
WireConnection;231;0;224;0
WireConnection;231;1;218;0
WireConnection;231;2;219;0
WireConnection;367;0;201;0
WireConnection;357;0;215;0
WireConnection;381;0;382;0
WireConnection;366;0;367;0
WireConnection;380;0;216;0
WireConnection;383;0;384;0
WireConnection;228;0;227;0
WireConnection;228;1;231;0
WireConnection;229;0;225;0
WireConnection;229;1;231;0
WireConnection;364;0;356;0
WireConnection;245;0;238;0
WireConnection;245;1;232;0
WireConnection;245;2;233;0
WireConnection;230;0;226;0
WireConnection;230;1;231;0
WireConnection;370;0;214;0
WireConnection;365;0;368;0
WireConnection;355;0;363;0
WireConnection;372;0;228;0
WireConnection;185;0;365;0
WireConnection;185;1;366;0
WireConnection;185;2;190;0
WireConnection;369;0;370;0
WireConnection;358;0;229;0
WireConnection;243;0;239;0
WireConnection;243;1;245;0
WireConnection;378;0;230;0
WireConnection;242;0;241;0
WireConnection;242;1;245;0
WireConnection;244;0;240;0
WireConnection;244;1;245;0
WireConnection;379;0;380;0
WireConnection;266;0;364;0
WireConnection;266;1;355;0
WireConnection;266;2;267;0
WireConnection;257;0;383;0
WireConnection;257;1;381;0
WireConnection;257;2;258;0
WireConnection;362;0;357;0
WireConnection;374;0;242;0
WireConnection;376;0;244;0
WireConnection;359;0;243;0
WireConnection;186;0;185;0
WireConnection;186;1;369;0
WireConnection;186;2;187;0
WireConnection;361;0;358;0
WireConnection;377;0;378;0
WireConnection;371;0;372;0
WireConnection;264;0;266;0
WireConnection;264;1;362;0
WireConnection;264;2;265;0
WireConnection;255;0;257;0
WireConnection;255;1;379;0
WireConnection;255;2;256;0
WireConnection;268;0;264;0
WireConnection;268;1;361;0
WireConnection;268;2;269;0
WireConnection;375;0;376;0
WireConnection;189;0;186;0
WireConnection;189;1;371;0
WireConnection;189;2;188;0
WireConnection;360;0;359;0
WireConnection;259;0;255;0
WireConnection;259;1;377;0
WireConnection;259;2;260;0
WireConnection;373;0;374;0
WireConnection;270;0;268;0
WireConnection;270;1;360;0
WireConnection;270;2;271;0
WireConnection;251;0;189;0
WireConnection;251;1;373;0
WireConnection;251;2;252;0
WireConnection;261;0;259;0
WireConnection;261;1;375;0
WireConnection;261;2;262;0
WireConnection;173;0;251;0
WireConnection;173;1;270;0
WireConnection;173;2;261;0
WireConnection;386;0;385;0
WireConnection;386;1;387;0
WireConnection;0;0;173;0
ASEEND*/
//CHKSM=BAD63E2B4413FA6F004DF3698B730BDB3C8893A7