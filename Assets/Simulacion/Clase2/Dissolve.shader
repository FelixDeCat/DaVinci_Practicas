// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/Clase2/Dissolve"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_OpacityPower("Opacity Power", Range( 0 , 20)) = 0
		_Tint("Tint", Color) = (0,0,0,0)
		_Noise("Noise", 2D) = "white" {}
		_Tint2("Tint2", Color) = (1,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Tint2;
		uniform float4 _Tint;
		uniform sampler2D _Noise;
		uniform float4 _Noise_ST;
		uniform float _OpacityPower;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Noise = i.uv_texcoord * _Noise_ST.xy + _Noise_ST.zw;
			float lerpResult12 = lerp( 0.0 , 1.0 , ( tex2D( _Noise, uv_Noise ).r * _OpacityPower ));
			float4 lerpResult15 = lerp( _Tint2 , _Tint , ( 0.4 * lerpResult12 ));
			o.Emission = lerpResult15.rgb;
			o.Alpha = 1;
			clip( lerpResult12 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
8;99;1286;543;1212.864;130.1983;1.429736;True;True
Node;AmplifyShaderEditor.RangedFloatNode;1;-859.957,362.4091;Float;False;Property;_OpacityPower;Opacity Power;1;0;0;0;20;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;4;-883.907,124.9576;Float;True;Property;_Noise;Noise;3;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-458.5618,219.2251;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;17;-70.67191,0.3558154;Float;False;Constant;_Float0;Float 0;5;0;0.4;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;12;-140.3292,153.2698;Float;True;3;0;FLOAT;0.0;False;1;FLOAT;1.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;156.5281,11.55585;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;14;-587.9797,-227.1482;Float;False;Property;_Tint2;Tint2;4;0;1,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;2;-563.2583,-63.1945;Float;False;Property;_Tint;Tint;2;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;15;446.0978,-136.5742;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;792.1848,-139.7914;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MyShaders/Clase2/Dissolve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Custom;0.5;True;True;0;True;TransparentCutout;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;4;1
WireConnection;5;1;1;0
WireConnection;12;2;5;0
WireConnection;16;0;17;0
WireConnection;16;1;12;0
WireConnection;15;0;14;0
WireConnection;15;1;2;0
WireConnection;15;2;16;0
WireConnection;0;2;15;0
WireConnection;0;10;12;0
ASEEND*/
//CHKSM=44EF5C387440FEC9478D97E46A4D00F1E0DD9D56