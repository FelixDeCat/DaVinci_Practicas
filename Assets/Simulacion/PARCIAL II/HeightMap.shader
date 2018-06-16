// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/Parcial/HeigthMap"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_Intensity("Intensity", Float) = 0.4
		_Snow("Snow", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Grass("Grass", 2D) = "white" {}
		_Rock("Rock", 2D) = "white" {}
		_Float0("Float 0", Float) = 2.64
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
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

		uniform sampler2D _Grass;
		uniform float4 _Grass_ST;
		uniform sampler2D _Rock;
		uniform float4 _Rock_ST;
		uniform sampler2D _Snow;
		uniform float4 _Snow_ST;
		uniform float _Float0;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Intensity;
		uniform float _EdgeLength;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata v )
		{
			float3 ase_vertexNormal = v.normal.xyz;
			float4 transform65 = mul(unity_ObjectToWorld,float4( ase_vertexNormal , 0.0 ));
			float2 uv_TextureSample0 = v.texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 lerpResult4 = lerp( float4( 0,0,0,0 ) , ( _Float0 * saturate( transform65 ) ) , tex2Dlod( _TextureSample0, float4( uv_TextureSample0, 0, 0.0) ).r);
			v.vertex.xyz += ( lerpResult4 * _Intensity ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Grass = i.uv_texcoord * _Grass_ST.xy + _Grass_ST.zw;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_33_0 = ( ase_vertex3Pos.y * 2.5 );
			float temp_output_45_0 = ( 1.0 - ( temp_output_33_0 / 2.0 ) );
			float2 uv_Rock = i.uv_texcoord * _Rock_ST.xy + _Rock_ST.zw;
			float temp_output_46_0 = ( 1.0 - ( temp_output_33_0 / -2.0 ) );
			float2 uv_Snow = i.uv_texcoord * _Snow_ST.xy + _Snow_ST.zw;
			o.Albedo = ( ( ( tex2D( _Grass, uv_Grass ) * temp_output_45_0 ) * 0.5 ) + ( ( tex2D( _Rock, uv_Rock ) * ( temp_output_45_0 * temp_output_46_0 ) ) * 0.5 ) + ( ( temp_output_46_0 * tex2D( _Snow, uv_Snow ) ) * 0.5 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
887;91;622;560;1943.902;886.9011;3.050294;False;False
Node;AmplifyShaderEditor.RangedFloatNode;32;-3566.083,-823.1745;Float;False;Constant;_Float5;Float 5;4;0;2.5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;31;-3598.637,-970.4744;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;30;-3106.466,-938.4006;Float;False;Constant;_Float4;Float 4;4;0;2;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;34;-3061.596,-604.8422;Float;False;Constant;_Float6;Float 6;4;0;-2;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-3398.219,-957.3421;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.NormalVertexDataNode;1;-1974.928,-38.64871;Float;True;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;35;-3125.626,-819.8177;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;29;-3134.633,-1148.668;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;65;-1640.696,-156.7768;Float;True;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;46;-2853.153,-829.343;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;45;-2861.156,-1151.044;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-2532.658,-999.6503;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;48;-2916.312,-508.3214;Float;True;Property;_Snow;Snow;4;0;Assets/Simulacion/PARCIAL II/Snow.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;50;-2922.422,-1491.798;Float;True;Property;_Grass;Grass;5;0;Assets/Simulacion/PARCIAL II/Grass.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SaturateNode;6;-1347.372,5.010148;Float;True;1;0;FLOAT4;0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;5;-1303.219,-377.256;Float;False;Property;_Float0;Float 0;6;0;2.64;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;52;-2332.259,-1173.272;Float;True;Property;_Rock;Rock;6;0;Assets/Simulacion/PARCIAL II/Rock.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;3;-1061.132,27.49257;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Assets/Simulacion/Clase3/TerrainHeight.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;57;-2130.168,-453.3978;Float;False;Constant;_Float1;Float 1;7;0;0.5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-2508.759,-549.189;Float;True;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-2038.441,-962.6996;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;62;-1920.27,-1121.39;Float;False;Constant;_Float3;Float 3;7;0;0.5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;60;-2154.255,-1518.749;Float;False;Constant;_Float2;Float 2;7;0;0.5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-1005.17,-223.4947;Float;True;2;2;0;FLOAT;0,0,0;False;1;FLOAT4;0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-2541.428,-1412.962;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;4;-563.9099,-3.893141;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-1976.195,-1619.917;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-1952.105,-554.566;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-1742.206,-1222.558;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;8;-659.089,295.908;Float;False;Property;_Intensity;Intensity;3;0;0.4;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-304.7307,116.8275;Float;True;2;2;0;FLOAT4;0,0,0;False;1;FLOAT;0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;56;-1420.649,-885.8751;Float;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;71,-107;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;MyShaders/Parcial/HeigthMap;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;True;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;33;0;31;2
WireConnection;33;1;32;0
WireConnection;35;0;33;0
WireConnection;35;1;34;0
WireConnection;29;0;33;0
WireConnection;29;1;30;0
WireConnection;65;0;1;0
WireConnection;46;0;35;0
WireConnection;45;0;29;0
WireConnection;47;0;45;0
WireConnection;47;1;46;0
WireConnection;6;0;65;0
WireConnection;49;0;46;0
WireConnection;49;1;48;0
WireConnection;53;0;52;0
WireConnection;53;1;47;0
WireConnection;2;0;5;0
WireConnection;2;1;6;0
WireConnection;51;0;50;0
WireConnection;51;1;45;0
WireConnection;4;1;2;0
WireConnection;4;2;3;1
WireConnection;59;0;51;0
WireConnection;59;1;60;0
WireConnection;58;0;49;0
WireConnection;58;1;57;0
WireConnection;61;0;53;0
WireConnection;61;1;62;0
WireConnection;7;0;4;0
WireConnection;7;1;8;0
WireConnection;56;0;59;0
WireConnection;56;1;61;0
WireConnection;56;2;58;0
WireConnection;0;0;56;0
WireConnection;0;11;7;0
ASEEND*/
//CHKSM=4A85BCE039E7EB4CC15AC6A6F83FC930E07ABED3