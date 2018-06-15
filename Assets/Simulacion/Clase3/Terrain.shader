// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/Clase3/Terrain"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 1
		_TessMin( "Tess Min Distance", Float ) = 3.23
		_TessMax( "Tess Max Distance", Float ) = 0
		_TerrainHeight("TerrainHeight", 2D) = "white" {}
		_Intensity("Intensity", Float) = 1.68
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		struct appdata
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
			float4 texcoord3 : TEXCOORD3;
			fixed4 color : COLOR;
			UNITY_VERTEX_INPUT_INSTANCE_ID
		};

		uniform sampler2D _TerrainHeight;
		uniform float4 _TerrainHeight_ST;
		uniform float _Intensity;
		uniform float _TessValue;
		uniform float _TessMin;
		uniform float _TessMax;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, _TessMin, _TessMax, _TessValue );
		}

		void vertexDataFunc( inout appdata v )
		{
			float3 ase_vertexNormal = v.normal.xyz;
			float2 uv_TerrainHeight = v.texcoord * _TerrainHeight_ST.xy + _TerrainHeight_ST.zw;
			float4 tex2DNode1 = tex2Dlod( _TerrainHeight, float4( uv_TerrainHeight, 0, 0.0) );
			float3 lerpResult8 = lerp( float3( 0,0,0 ) , ( _Intensity * saturate( ase_vertexNormal ) ) , tex2DNode1.r);
			v.vertex.xyz += lerpResult8;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TerrainHeight = i.uv_texcoord * _TerrainHeight_ST.xy + _TerrainHeight_ST.zw;
			float4 tex2DNode1 = tex2D( _TerrainHeight, uv_TerrainHeight );
			o.Albedo = tex2DNode1.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
527;91;982;560;727.1428;364.3093;2.206639;False;False
Node;AmplifyShaderEditor.NormalVertexDataNode;7;-521.2275,344.8647;Float;True;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;4;-208.1073,90.8083;Float;False;Property;_Intensity;Intensity;6;0;1.68;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SaturateNode;6;-271.6017,343.9986;Float;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;70.59966,115.4937;Float;True;2;2;0;FLOAT;0,0,0;False;1;FLOAT3;0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;1;81.58079,361.8642;Float;True;Property;_TerrainHeight;TerrainHeight;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;8;590.3471,344.3289;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;977.9301,162.1434;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;MyShaders/Clase3/Terrain;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;True;0;1;3.23;0;False;0.73;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;7;0
WireConnection;3;0;4;0
WireConnection;3;1;6;0
WireConnection;8;1;3;0
WireConnection;8;2;1;1
WireConnection;0;0;1;0
WireConnection;0;11;8;0
ASEEND*/
//CHKSM=46166FB9A0DF3A1399734409B49E332C81908121