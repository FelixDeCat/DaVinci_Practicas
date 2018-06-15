// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/Bounce"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_HitWorldPos("HitWorldPos", Vector) = (-4.21,0.56,4.18,0)
		_Tesellation("Tesellation", Range( 0 , 10)) = 2
		_Radius("Radius", Float) = 3
		_Albedo("Albedo", 2D) = "white" {}
		_ImpactVector("ImpactVector", Vector) = (0,0,0,0)
		_Brick0207_NORM("Brick-0207_NORM", 2D) = "white" {}
		_10552normal("10552-normal", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
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

		uniform sampler2D _Brick0207_NORM;
		uniform float4 _Brick0207_NORM_ST;
		uniform sampler2D _10552normal;
		uniform float3 _HitWorldPos;
		uniform float _Radius;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float3 _ImpactVector;
		uniform float _Tesellation;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			float4 temp_cast_0 = (_Tesellation).xxxx;
			return temp_cast_0;
		}

		void vertexDataFunc( inout appdata v )
		{
			float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex);
			float temp_output_9_0 = ( 1.0 - saturate( ( distance( _HitWorldPos , ase_worldPos ) / _Radius ) ) );
			v.vertex.xyz += ( temp_output_9_0 * _ImpactVector );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Brick0207_NORM = i.uv_texcoord * _Brick0207_NORM_ST.xy + _Brick0207_NORM_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float temp_output_9_0 = ( 1.0 - saturate( ( distance( _HitWorldPos , ase_worldPos ) / _Radius ) ) );
			float2 temp_cast_0 = (temp_output_9_0).xx;
			o.Normal = BlendNormals( UnpackNormal( tex2D( _Brick0207_NORM, uv_Brick0207_NORM ) ) , UnpackNormal( tex2D( _10552normal, temp_cast_0 ) ) );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = tex2D( _Albedo, uv_Albedo ).xyz;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13101
379;92;476;614;482.9;80.16681;1.372058;True;False
Node;AmplifyShaderEditor.Vector3Node;2;-1230.924,-37.35738;Float;False;Property;_HitWorldPos;HitWorldPos;1;0;-4.21,0.56,4.18;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;4;-1183.923,138.3936;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;7;-940.8408,279.769;Float;False;Property;_Radius;Radius;2;0;3;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.DistanceOpNode;3;-894.7565,82.99352;Float;False;2;0;FLOAT3;0.0,0,0;False;1;FLOAT3;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;8;-682.2885,154.9076;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SaturateNode;10;-513.1967,184.0541;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;9;-308.6175,231.6705;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.Vector3Node;12;-394.4921,381.9091;Float;False;Property;_ImpactVector;ImpactVector;4;0;0,0,0;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;15;-105.452,-15.89238;Float;True;Property;_10552normal;10552-normal;6;0;Assets/10552-normal.jpg;True;0;True;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;14;-103.5775,-211.779;Float;True;Property;_Brick0207_NORM;Brick-0207_NORM;5;0;Assets/Brick-0207_NORM.tga;True;0;True;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;1;-280.1297,689.4838;Float;False;Property;_Tesellation;Tesellation;1;0;2;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;11;-99.63123,-467.8022;Float;True;Property;_Albedo;Albedo;3;0;Assets/Brick-0207.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-52.05731,330.5233;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.BlendNormalsNode;16;287.4214,-52.09286;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;620.6793,9.88076;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;MyShaders/Bounce;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;True;1;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;8;0;3;0
WireConnection;8;1;7;0
WireConnection;10;0;8;0
WireConnection;9;0;10;0
WireConnection;15;1;9;0
WireConnection;13;0;9;0
WireConnection;13;1;12;0
WireConnection;16;0;14;0
WireConnection;16;1;15;0
WireConnection;0;0;11;0
WireConnection;0;1;16;0
WireConnection;0;11;13;0
WireConnection;0;14;1;0
ASEEND*/
//CHKSM=3FA4FC7862119C4BE15C0E8752C4CBBBF19528B3