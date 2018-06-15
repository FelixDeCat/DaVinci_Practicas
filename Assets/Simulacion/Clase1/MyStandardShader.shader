// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/MyStandars"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Tint("Tint", Color) = (1,1,1,0)
		_Brightness("Brightness", Range( 0 , 2)) = 1
		_Normal("Normal", 2D) = "bump" {}
		_NormalStrengt("NormalStrengt", Range( 0 , 2)) = 0
		_Roughness("Roughness", 2D) = "white" {}
		_RoughtnessStrengt("RoughtnessStrengt", Range( 0 , 2)) = 0
		_AOC("AOC", 2D) = "white" {}
		_GeneralTiling("GeneralTiling", Vector) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 texcoord_0;
		};

		uniform sampler2D _Normal;
		uniform float2 _GeneralTiling;
		uniform float _NormalStrengt;
		uniform float4 _Tint;
		uniform sampler2D _Albedo;
		uniform float _Brightness;
		uniform sampler2D _Roughness;
		uniform float _RoughtnessStrengt;
		uniform sampler2D _AOC;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * _GeneralTiling + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 tex2DNode3 = UnpackNormal( tex2D( _Normal, i.texcoord_0 ) );
			float temp_output_15_0 = ( tex2DNode3.g * _NormalStrengt );
			float3 appendResult16 = (float3(( tex2DNode3.r * _NormalStrengt ) , temp_output_15_0 , temp_output_15_0));
			o.Normal = appendResult16;
			o.Albedo = ( _Tint * ( tex2D( _Albedo, i.texcoord_0 ) * _Brightness ) ).rgb;
			o.Smoothness = ( 1.0 - ( tex2D( _Roughness, i.texcoord_0 ).r * _RoughtnessStrengt ) );
			o.Occlusion = tex2D( _AOC, i.texcoord_0 ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
0;91;986;548;3607.757;1016.689;3.6292;False;False
Node;AmplifyShaderEditor.Vector2Node;21;-1902.503,87.13564;Float;False;Property;_GeneralTiling;GeneralTiling;8;0;0,0;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1651.732,66.91159;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;18;-1149.256,400.1605;Float;False;724.6096;347.815;Comment;4;4;11;12;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;26;-1094.284,-573.5057;Float;False;834.5359;512.1339;Tint;5;10;1;9;22;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;17;-1146.064,6.499702;Float;False;893.0221;369.5222;Normal;5;3;14;13;15;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1;-1043.08,-376.2459;Float;True;Property;_Albedo;Albedo;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;10;-1044.284,-176.3718;Float;False;Property;_Brightness;Brightness;2;0;1;0;2;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;14;-1037.617,261.0219;Float;False;Property;_NormalStrengt;NormalStrengt;4;0;0;0;2;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;11;-1053.633,632.9756;Float;False;Property;_RoughtnessStrengt;RoughtnessStrengt;6;0;0;0;2;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;3;-1096.064,56.4997;Float;True;Property;_Normal;Normal;3;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;4;-1099.256,450.1605;Float;True;Property;_Roughness;Roughness;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-779.5836,535.2983;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-716.5105,-336.6321;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-667.9719,186.0314;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-696.9825,88.46462;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;22;-733.0887,-523.5057;Float;False;Property;_Tint;Tint;1;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;7;-622.6468,453.532;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;8;-975.2036,837.896;Float;True;Property;_AOC;AOC;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-428.7479,-389.7371;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.DynamicAppendNode;16;-488.042,70.28856;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;322.0266,-62.48276;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MyShaders/MyStandars;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;21;0
WireConnection;1;1;20;0
WireConnection;3;1;20;0
WireConnection;4;1;20;0
WireConnection;12;0;4;1
WireConnection;12;1;11;0
WireConnection;9;0;1;0
WireConnection;9;1;10;0
WireConnection;15;0;3;2
WireConnection;15;1;14;0
WireConnection;13;0;3;1
WireConnection;13;1;14;0
WireConnection;7;0;12;0
WireConnection;8;1;20;0
WireConnection;23;0;22;0
WireConnection;23;1;9;0
WireConnection;16;0;13;0
WireConnection;16;1;15;0
WireConnection;16;2;15;0
WireConnection;0;0;23;0
WireConnection;0;1;16;0
WireConnection;0;4;7;0
WireConnection;0;5;8;0
ASEEND*/
//CHKSM=F26E80D4044800F727008A966173865325DD28D1