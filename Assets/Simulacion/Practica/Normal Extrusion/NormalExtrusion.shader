// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/NormalExtrusion"
{
	Properties
	{
		_ExtrusionPoint("ExtrusionPoint", Float) = 0.1
		_ExtrusionAmount("Extrusion Amount", Range( 0 , 20)) = 12
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _ExtrusionPoint;
		uniform float _ExtrusionAmount;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 ase_vertex3Pos = v.vertex.xyz;
			v.vertex.xyz += ( ase_vertexNormal * max( ( cos( ( ( ase_vertex3Pos.y + _Time.y ) / _ExtrusionPoint ) ) / _ExtrusionAmount ) , 0.0 ) );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			o.Albedo = tex2D( _TextureSample0, uv_TextureSample0 ).rgb;
			o.Smoothness = 0.39;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
8;491;1558;519;1716.429;353.4727;1;True;True
Node;AmplifyShaderEditor.TimeNode;3;-1422.216,79.90482;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;1;-1433.037,-152.7281;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;4;-1132.779,292.2489;Float;False;Property;_ExtrusionPoint;ExtrusionPoint;0;0;0.1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-1123.311,-55.34692;Float;True;2;2;0;FLOAT;0,0,0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;5;-860.9239,81.25744;Float;True;2;0;FLOAT;0,0,0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CosOpNode;14;-643.3215,108.2647;Float;False;1;0;FLOAT;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;7;-786.9991,401.3572;Float;False;Property;_ExtrusionAmount;Extrusion Amount;1;0;12;0;20;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;8;-505.7358,173.4144;Float;False;2;0;FLOAT;0,0,0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMaxOpNode;9;-352.4408,157.4184;Float;False;2;0;FLOAT;0,0,0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.NormalVertexDataNode;11;-419.0898,-59.8605;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-128.4969,68.1073;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;12;-23.73229,-112.6822;Float;False;Constant;_Float0;Float 0;2;0;0.39;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;13;-244.4667,-537.1311;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.NormalVertexDataNode;15;-1439.003,-297.765;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;278.5967,-129.3009;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Custom/NormalExtrusion;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;2
WireConnection;2;1;3;2
WireConnection;5;0;2;0
WireConnection;5;1;4;0
WireConnection;14;0;5;0
WireConnection;8;0;14;0
WireConnection;8;1;7;0
WireConnection;9;0;8;0
WireConnection;10;0;11;0
WireConnection;10;1;9;0
WireConnection;0;0;13;0
WireConnection;0;4;12;0
WireConnection;0;11;10;0
ASEEND*/
//CHKSM=B2D706045E307FA342C6DF51859878CE1A18EBDE