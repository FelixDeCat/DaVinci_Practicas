// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/Parcial/HeigthMap"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_Intensity("Intensity", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Float0("Float 0", Float) = 2.64
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

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _Float0;
		uniform float _Intensity;
		uniform float _EdgeLength;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata v )
		{
			float3 ase_vertexNormal = v.normal.xyz;
			float3 temp_output_2_0 = ( _Float0 * saturate( ase_vertexNormal ) * float3( 0,0,0 ) );
			float2 uv_TextureSample0 = v.texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode3 = tex2Dlod( _TextureSample0, float4( uv_TextureSample0, 0, 0.0) );
			float3 lerpResult4 = lerp( float3( 0,0,0 ) , temp_output_2_0 , tex2DNode3.r);
			v.vertex.xyz += ( lerpResult4 * _Intensity * float3( 0,0,0 ) );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode3 = tex2D( _TextureSample0, uv_TextureSample0 );
			o.Albedo = tex2DNode3.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
527;91;982;560;3025.149;1728.93;2.65062;True;False
Node;AmplifyShaderEditor.NormalVertexDataNode;1;-1596.998,5.876236;Float;True;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;5;-1282.811,-249.2469;Float;False;Property;_Float0;Float 0;6;0;2.64;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SaturateNode;6;-1347.372,5.010148;Float;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-1005.17,-223.4947;Float;True;3;3;0;FLOAT;0,0,0;False;1;FLOAT3;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;3;-1061.132,27.49257;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Assets/Simulacion/Clase4/BricksAlbedo.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;4;-563.9099,-3.893141;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;8;-452.3805,281.1625;Float;False;Property;_Intensity;Intensity;3;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;32;-2215.105,-734.8223;Float;False;Constant;_Float5;Float 5;4;0;2.63;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;31;-2247.659,-882.1222;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;35;-1838.646,-862.6648;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;30;-1741.087,-1002.048;Float;False;Constant;_Float4;Float 4;4;0;5.56;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-1942.373,-1177.155;Float;True;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;27;-2107.06,-1038.214;Float;False;Constant;_Float3;Float 3;4;0;2.63;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;26;-2149.161,-1190.287;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;34;-1784.616,-640.6898;Float;False;Constant;_Float6;Float 6;4;0;-4.69;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-2047.241,-868.9899;Float;True;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;29;-1746.004,-1211.652;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;22;-58.47011,-574.4038;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;11;-751.7651,-334.0797;Float;True;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-324.4104,-447.1498;Float;True;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;13;-466.7491,-219.6163;Float;False;Constant;_Float1;Float 1;4;0;-0.54;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;25;214.9124,-246.3457;Float;False;Constant;_Float2;Float 2;4;0;-0.11;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-161.9124,185.4039;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleAddOpNode;24;235.8511,-509.2576;Float;True;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;23;-59.63341,-345.2283;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;44;-1450.6,-856.9648;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;71,-107;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;MyShaders/Parcial/HeigthMap;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;True;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;1;0
WireConnection;2;0;5;0
WireConnection;2;1;6;0
WireConnection;4;1;2;0
WireConnection;4;2;3;1
WireConnection;35;0;33;0
WireConnection;35;1;34;0
WireConnection;28;0;26;2
WireConnection;28;1;27;0
WireConnection;33;0;31;2
WireConnection;33;1;32;0
WireConnection;29;0;28;0
WireConnection;29;1;30;0
WireConnection;22;0;21;0
WireConnection;11;0;2;0
WireConnection;21;0;11;2
WireConnection;21;1;13;0
WireConnection;7;0;4;0
WireConnection;7;1;8;0
WireConnection;24;0;23;0
WireConnection;24;1;25;0
WireConnection;23;0;21;0
WireConnection;0;0;3;0
WireConnection;0;11;7;0
ASEEND*/
//CHKSM=DA9F2BD062F1833C914B8DF9DB6BF92612AA74FE