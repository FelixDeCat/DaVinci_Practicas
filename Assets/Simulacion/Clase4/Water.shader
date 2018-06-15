// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/Clase4/Water"
{
	Properties
	{
		[HideInInspector] _DummyTex( "", 2D ) = "white" {}
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_Texture("Texture", 2D) = "white" {}
		_Speed("Speed", Vector) = (2,1,0,0)
		_NormalSpeed("Normal Speed", Vector) = (2,1,0,0)
		_Normal("Normal", 2D) = "white" {}
		_Offset("Offset", Float) = 0
		_SinOffset("Sin Offset", Float) = 1
		_NormalMultiply("Normal Multiply", Range( 0 , 10)) = 0
		_Tiling("Tiling", Vector) = (0.5,0.5,0,0)
		_BricksAlbedo("BricksAlbedo", 2D) = "white" {}
		_BricksBlending("BricksBlending", 2D) = "white" {}
		_BricksNormal("BricksNormal", 2D) = "white" {}
		_NoiseCloud("Noise Cloud", 2D) = "white" {}
		_FluidLevel("FluidLevel", Range( 0 , 30)) = 30
		_Emission("Emission", 2D) = "white" {}
		_EmissionIntensity("Emission Intensity", Float) = 0
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
			float2 uv_DummyTex;
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

		uniform sampler2D _Normal;
		uniform float2 _NormalSpeed;
		uniform sampler2D _DummyTex;
		uniform sampler2D _BricksNormal;
		uniform float4 _BricksNormal_ST;
		uniform sampler2D _BricksBlending;
		uniform float4 _BricksBlending_ST;
		uniform sampler2D _NoiseCloud;
		uniform float4 _NoiseCloud_ST;
		uniform float _FluidLevel;
		uniform sampler2D _Texture;
		uniform float2 _Speed;
		uniform float _NormalMultiply;
		uniform float2 _Tiling;
		uniform float _SinOffset;
		uniform sampler2D _BricksAlbedo;
		uniform float4 _BricksAlbedo_ST;
		uniform sampler2D _Emission;
		uniform float _EmissionIntensity;
		uniform float _Offset;
		uniform float _EdgeLength;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata v )
		{
			v.texcoord.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			float2 panner20 = ( v.texcoord.xy + 1.0 * _Time.y * _NormalSpeed);
			float3 tex2DNode6 = UnpackNormal( tex2Dlod( _Normal, float4( panner20, 0, 0.0) ) );
			float3 myNormal39 = tex2DNode6;
			float2 uv_BricksBlending = v.texcoord * _BricksBlending_ST.xy + _BricksBlending_ST.zw;
			float2 uv_NoiseCloud = v.texcoord * _NoiseCloud_ST.xy + _NoiseCloud_ST.zw;
			float temp_output_48_0 = saturate( ( tex2Dlod( _BricksBlending, float4( uv_BricksBlending, 0, 0.0) ).r + ( tex2Dlod( _NoiseCloud, float4( uv_NoiseCloud, 0, 0.0) ).r * _FluidLevel ) ) );
			float3 lerpResult42 = lerp( ( myNormal39 * _Offset ) , float3( 0,0,0 ) , temp_output_48_0);
			v.vertex.xyz += lerpResult42;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 texCoordDummy22 = i.uv_DummyTex*float2( 1,1 ) + float2( 0,0 );
			float2 panner20 = ( texCoordDummy22 + 1.0 * _Time.y * _NormalSpeed);
			float3 tex2DNode6 = UnpackNormal( tex2D( _Normal, panner20 ) );
			float3 myNormal39 = tex2DNode6;
			float2 uv_BricksNormal = i.uv_texcoord * _BricksNormal_ST.xy + _BricksNormal_ST.zw;
			float2 uv_BricksBlending = i.uv_texcoord * _BricksBlending_ST.xy + _BricksBlending_ST.zw;
			float2 uv_NoiseCloud = i.uv_texcoord * _NoiseCloud_ST.xy + _NoiseCloud_ST.zw;
			float temp_output_48_0 = saturate( ( tex2D( _BricksBlending, uv_BricksBlending ).r + ( tex2D( _NoiseCloud, uv_NoiseCloud ).r * _FluidLevel ) ) );
			float3 lerpResult38 = lerp( myNormal39 , UnpackNormal( tex2D( _BricksNormal, uv_BricksNormal ) ) , temp_output_48_0);
			o.Normal = lerpResult38;
			float temp_output_18_0 = ( (0.5 + (( 1.0 + sin( _Time.y ) ) - 0.0) * (0.7 - 0.5) / (2.0 - 0.0)) * _SinOffset );
			float2 appendResult23 = (float2(temp_output_18_0 , temp_output_18_0));
			float2 texCoordDummy5 = i.uv_DummyTex*( _Tiling + appendResult23 ) + float2( 0,0 );
			float2 panner2 = ( ( ( tex2DNode6 * _NormalMultiply ) + float3( texCoordDummy5 ,  0.0 ) ).xy + 1.0 * _Time.y * _Speed);
			float2 uv_BricksAlbedo = i.uv_texcoord * _BricksAlbedo_ST.xy + _BricksAlbedo_ST.zw;
			float4 lerpResult35 = lerp( tex2D( _Texture, panner2 ) , tex2D( _BricksAlbedo, uv_BricksAlbedo ) , temp_output_48_0);
			o.Albedo = lerpResult35.rgb;
			float4 lerpResult58 = lerp( ( tex2D( _Emission, panner2 ) * _EmissionIntensity ) , float4( 0,0,0,0 ) , temp_output_48_0);
			o.Emission = lerpResult58.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
8;99;1286;543;4467.63;222.9032;5.679725;True;True
Node;AmplifyShaderEditor.CommentaryNode;51;-3597.949,-51.79786;Float;False;2176.409;613.9392;;10;16;19;17;18;32;23;31;5;15;14;Movement;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;15;-3539.948,9.39311;Float;True;1;0;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SinOpNode;14;-3311.839,12.77133;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-3101.626,-3.797855;Float;True;2;2;0;FLOAT;1.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;52;-1721.42,956.0231;Float;False;1137.144;684.9301;;6;43;45;34;46;47;48;Fluid Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;17;-2864.826,-0.1041946;Float;True;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;2.0;False;3;FLOAT;0.5;False;4;FLOAT;0.7;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;62;-2746.678,-829.4413;Float;False;1227.898;622.589;Normal;7;22;21;20;6;39;28;27;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2825.882,302.1413;Float;True;Property;_SinOffset;Sin Offset;10;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-2584.882,274.2214;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-2696.678,-779.4413;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector2Node;21;-2665.095,-510.8526;Float;True;Property;_NormalSpeed;Normal Speed;7;0;2,1;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;45;-1616.664,1417.599;Float;True;Property;_FluidLevel;FluidLevel;17;0;30;0;30;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;43;-1684.323,1218.901;Float;True;Property;_NoiseCloud;Noise Cloud;16;0;Assets/Simulacion/Clase4/Noise Cloud.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;34;-1474.839,1030.477;Float;True;Property;_BricksBlending;BricksBlending;14;0;Assets/Simulacion/Clase4/BricksBlending.tga;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-1321.963,1335.374;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;23;-2333.696,278.416;Float;True;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.PannerNode;20;-2443.316,-613.8689;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2
Node;AmplifyShaderEditor.Vector2Node;32;-2172.505,3.347487;Float;True;Property;_Tiling;Tiling;12;0;0.5,0.5;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;28;-2160.213,-486.0077;Float;True;Property;_NormalMultiply;Normal Multiply;11;0;0;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;6;-2174.464,-730.6447;Float;True;Property;_Normal;Normal;8;0;None;True;0;True;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-1946.554,244.514;Float;True;2;2;0;FLOAT2;0.0,0;False;1;FLOAT2;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-1064.142,1190.567;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SaturateNode;48;-802.9554,1195.592;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1798.89,-506.9198;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.CommentaryNode;53;-1178.194,-199.9153;Float;False;780.0874;446.8341;;3;3;25;2;Flow Map Blending;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-1685.539,218.6474;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;77;-280.0382,335.9185;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;56;-193.5342,-165.2625;Float;False;788.2414;530.3614;;5;1;33;35;74;75;Albedo Blending;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;3;-921.2155,-21.16559;Float;True;Property;_Speed;Speed;6;0;2,1;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-1128.194,-149.9153;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT2;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.PannerNode;2;-686.4054,-111.5984;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2
Node;AmplifyShaderEditor.WireNode;75;15.38387,297.6139;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-129.6254,-118.4657;Float;True;Property;_Texture;Texture;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;33;-122.1794,73.17027;Float;True;Property;_BricksAlbedo;BricksAlbedo;13;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;74;199.0343,243.1592;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;55;-205.0978,1180.554;Float;False;731.1217;393.5186;;6;38;37;41;65;66;67;Normal Blending;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;54;-196.6792,1737.918;Float;False;765.3615;437.4065;;7;8;40;10;42;64;70;71;Vertex Offset Blending;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;79;1438.22,79.91513;Float;False;132;132;Comment;3;78;80;81;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;64;-181.9232,2084.133;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;65;-192.5865,1497.536;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;35;329.7072,62.59816;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.CommentaryNode;59;-202.7539,725.485;Float;False;682.8418;410.2125;;6;57;58;60;61;68;69;Emission Blending;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;80;1472.106,126.0456;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;40;-141.8696,1845.118;Float;False;39;0;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;57;-178.754,773.485;Float;True;Property;_Emission;Emission;18;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;69;-183.6992,1078.451;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-1783.88,-752.903;Float;True;myNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.WireNode;71;-32.96254,2126.415;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;8;-135.6185,1997.552;Float;False;Property;_Offset;Offset;9;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;67;-34.91512,1539.555;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;61;-147.347,972.5699;Float;False;Property;_EmissionIntensity;Emission Intensity;19;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;37;-138.5813,1333.563;Float;True;Property;_BricksNormal;BricksNormal;15;0;None;True;0;True;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;78;1488.22,129.9151;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;68;135.2534,1049.952;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;107.8179,1868.963;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;121.2765,887.8611;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;66;141.7475,1502.527;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;41;-111.9412,1252.816;Float;False;39;0;1;FLOAT3
Node;AmplifyShaderEditor.WireNode;70;121.0692,2091.116;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;38;266.8199,1273.745;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;58;255.2573,899.3921;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;42;301.6519,1851.257;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.WireNode;81;1490.106,156.0457;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2042.186,751.7358;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;MyShaders/Clase4/Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;True;2;2;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;15;0
WireConnection;16;1;14;0
WireConnection;17;0;16;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;46;0;43;1
WireConnection;46;1;45;0
WireConnection;23;0;18;0
WireConnection;23;1;18;0
WireConnection;20;0;22;0
WireConnection;20;2;21;0
WireConnection;6;1;20;0
WireConnection;31;0;32;0
WireConnection;31;1;23;0
WireConnection;47;0;34;1
WireConnection;47;1;46;0
WireConnection;48;0;47;0
WireConnection;27;0;6;0
WireConnection;27;1;28;0
WireConnection;5;0;31;0
WireConnection;77;0;48;0
WireConnection;25;0;27;0
WireConnection;25;1;5;0
WireConnection;2;0;25;0
WireConnection;2;2;3;0
WireConnection;75;0;77;0
WireConnection;1;1;2;0
WireConnection;74;0;75;0
WireConnection;64;0;48;0
WireConnection;65;0;48;0
WireConnection;35;0;1;0
WireConnection;35;1;33;0
WireConnection;35;2;74;0
WireConnection;80;0;35;0
WireConnection;57;1;2;0
WireConnection;69;0;48;0
WireConnection;39;0;6;0
WireConnection;71;0;64;0
WireConnection;67;0;65;0
WireConnection;78;0;80;0
WireConnection;68;0;69;0
WireConnection;10;0;40;0
WireConnection;10;1;8;0
WireConnection;60;0;57;0
WireConnection;60;1;61;0
WireConnection;66;0;67;0
WireConnection;70;0;71;0
WireConnection;38;0;41;0
WireConnection;38;1;37;0
WireConnection;38;2;66;0
WireConnection;58;0;60;0
WireConnection;58;2;68;0
WireConnection;42;0;10;0
WireConnection;42;2;70;0
WireConnection;81;0;78;0
WireConnection;0;0;81;0
WireConnection;0;1;38;0
WireConnection;0;2;58;0
WireConnection;0;11;42;0
ASEEND*/
//CHKSM=25CCD6EB16828AAB13A15E87C475F5A0D0E3283C