// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/Lava"
{
	Properties
	{
		[HideInInspector] _DummyTex( "", 2D ) = "white" {}
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_Cracks("Cracks", 2D) = "white" {}
		_Lava("Lava", 2D) = "white" {}
		_Stone("Stone", 2D) = "white" {}
		_Speed("Speed", Vector) = (0.5,0,0,0)
		_Dispalcement("Dispalcement", Range( 0 , 1)) = 1
		_EmissionColor("Emission Color", Color) = (0.9960785,0.6745098,0,0)
		_EmissionStrenght("Emission Strenght", Range( 0 , 1)) = 0
		_Reach("Reach", Range( 0 , 10)) = 1
		_HitPosition("HitPosition", Vector) = (0,0,0,0)
		_Radius("Radius", Float) = 1
		_FallOff("FallOff", Range( 0 , 10)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv_DummyTex;
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

		uniform sampler2D _Stone;
		uniform float4 _Stone_ST;
		uniform sampler2D _Lava;
		uniform float2 _Speed;
		uniform sampler2D _DummyTex;
		uniform float3 _HitPosition;
		uniform float _Radius;
		uniform float _FallOff;
		uniform sampler2D _Cracks;
		uniform float4 _Cracks_ST;
		uniform float _Reach;
		uniform float4 _EmissionColor;
		uniform float _EmissionStrenght;
		uniform float _Dispalcement;
		uniform float _EdgeLength;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata v )
		{
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 uv_Cracks = v.texcoord * _Cracks_ST.xy + _Cracks_ST.zw;
			float temp_output_38_0 = ( ( 1.0 - saturate( pow( ( distance( ase_worldPos , _HitPosition ) / _Radius ) , _FallOff ) ) ) * saturate( (-1.0 + (saturate( (0.0 + (tex2Dlod( _Cracks, float4( uv_Cracks, 0, 0.0) ).r - 0.0) * (_Reach - 0.0) / (1.0 - 0.0)) ) - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ) );
			v.vertex.xyz += ( ( temp_output_38_0 * float3(0,-1,0) ) * _Dispalcement );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Stone = i.uv_texcoord * _Stone_ST.xy + _Stone_ST.zw;
			float2 texCoordDummy7 = i.uv_DummyTex*float2( 1,1 ) + float2( 0,0 );
			float2 panner6 = ( texCoordDummy7 + 1.0 * _Time.y * _Speed);
			float3 ase_worldPos = i.worldPos;
			float2 uv_Cracks = i.uv_texcoord * _Cracks_ST.xy + _Cracks_ST.zw;
			float temp_output_38_0 = ( ( 1.0 - saturate( pow( ( distance( ase_worldPos , _HitPosition ) / _Radius ) , _FallOff ) ) ) * saturate( (-1.0 + (saturate( (0.0 + (tex2D( _Cracks, uv_Cracks ).r - 0.0) * (_Reach - 0.0) / (1.0 - 0.0)) ) - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ) );
			float4 lerpResult5 = lerp( tex2D( _Stone, uv_Stone ) , tex2D( _Lava, panner6 ) , temp_output_38_0);
			o.Albedo = lerpResult5.rgb;
			o.Emission = ( ( temp_output_38_0 * _EmissionColor ) * _EmissionStrenght ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
0;92;758;614;4321.965;3130.194;8.55064;True;False
Node;AmplifyShaderEditor.CommentaryNode;26;-2620.506,-1057.324;Float;False;1662.265;400.9258;Crack Mask;6;23;1;17;18;21;22;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;31;-1787.628,-1579.709;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector3Node;30;-1774.355,-1374.617;Float;False;Property;_HitPosition;HitPosition;9;0;0,0,0;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-2570.506,-886.3986;Float;True;Property;_Cracks;Cracks;0;0;Assets/Cracks.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;23;-2319.858,-984.1465;Float;False;Property;_Reach;Reach;8;0;1;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;34;-1537.227,-1319.572;Float;False;Property;_Radius;Radius;10;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.DistanceOpNode;32;-1521.33,-1476.316;Float;False;2;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;43;-1325.189,-1329.793;Float;False;Property;_FallOff;FallOff;11;0;1;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemapNode;17;-2020.589,-997.0579;Float;True;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;5.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;44;-1246.451,-1568.188;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SaturateNode;18;-1705.589,-988.0579;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.PowerNode;42;-980.1895,-1395.793;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SaturateNode;39;-785.6262,-1374.652;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemapNode;21;-1467.24,-1001.324;Float;True;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-1.0;False;4;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;37;-527.5131,-1378.652;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;28;-1780.209,-506.136;Float;False;1512.793;590.9229;Main Texture;6;5;8;7;6;3;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;22;-1156.241,-1007.324;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;29;-99.54822,3.836017;Float;False;710.1665;302.3344;Vertex Offset;4;10;11;9;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1730.209,-456.136;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-493.0367,-1107.074;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.Vector2Node;8;-1610.306,-279.7736;Float;False;Property;_Speed;Speed;3;0;0.5,0;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;14;72.02454,-285.1054;Float;False;Property;_EmissionColor;Emission Color;6;0;0.9960785,0.6745098,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;33;-280.8052,-555.3882;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.Vector3Node;9;-49.54817,76.1208;Float;False;Constant;_Vector0;Vector 0;4;0;0,-1,0;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PannerNode;6;-1358.774,-343.0803;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1.0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;337.5945,-324.8829;Float;True;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;230.9125,53.83604;Float;False;2;2;0;FLOAT;0.0,0,0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;2;-1000.251,-384.0173;Float;True;Property;_Lava;Lava;1;0;Assets/Lava.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;12;155.104,191.1705;Float;False;Property;_Dispalcement;Dispalcement;5;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;3;-1004.56,-145.2131;Float;True;Property;_Stone;Stone;2;0;Assets/Stone.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;16;543.801,-156.3531;Float;False;Property;_EmissionStrenght;Emission Strenght;7;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;749.8809,-276.0609;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;441.6187,75.77046;Float;False;2;2;0;FLOAT3;0.0;False;1;FLOAT;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;5;-532.4166,-402.769;Float;True;3;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1275.89,-413.284;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;MyShaders/Lava;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;True;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;17;0;1;1
WireConnection;17;4;23;0
WireConnection;44;0;32;0
WireConnection;44;1;34;0
WireConnection;18;0;17;0
WireConnection;42;0;44;0
WireConnection;42;1;43;0
WireConnection;39;0;42;0
WireConnection;21;0;18;0
WireConnection;37;0;39;0
WireConnection;22;0;21;0
WireConnection;38;0;37;0
WireConnection;38;1;22;0
WireConnection;33;0;38;0
WireConnection;6;0;7;0
WireConnection;6;2;8;0
WireConnection;13;0;38;0
WireConnection;13;1;14;0
WireConnection;10;0;33;0
WireConnection;10;1;9;0
WireConnection;2;1;6;0
WireConnection;15;0;13;0
WireConnection;15;1;16;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;5;0;3;0
WireConnection;5;1;2;0
WireConnection;5;2;38;0
WireConnection;0;0;5;0
WireConnection;0;2;15;0
WireConnection;0;11;11;0
ASEEND*/
//CHKSM=49F9084B24FBF607E8C2AEA30411E1A6D82EF23B