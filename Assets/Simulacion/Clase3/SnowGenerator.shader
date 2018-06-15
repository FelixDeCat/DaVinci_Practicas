// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/Clase3/SnowGenerator"
{
	Properties
	{
		_Tint("Tint", Color) = (0.8676471,0.3253676,0.3253676,0)
		_Intensity("Intensity", Float) = 0.72
		_Position("Position", Float) = -0.21
		_Snow_Albedo("Snow_Albedo", 2D) = "white" {}
		_Snow_Normal("Snow_Normal", 2D) = "bump" {}
		_NormalSnowStrenght("NormalSnowStrenght", Float) = 1
		_NormalTilesStrenght("NormalTilesStrenght", Float) = 1
		_Tiles_Albedo("Tiles_Albedo", 2D) = "white" {}
		_Tiles_Normal("Tiles_Normal", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _Tiles_Normal;
		uniform float4 _Tiles_Normal_ST;
		uniform float _NormalTilesStrenght;
		uniform sampler2D _Snow_Normal;
		uniform float4 _Snow_Normal_ST;
		uniform float _NormalSnowStrenght;
		uniform float _Position;
		uniform float _Intensity;
		uniform sampler2D _Tiles_Albedo;
		uniform float4 _Tiles_Albedo_ST;
		uniform sampler2D _Snow_Albedo;
		uniform float4 _Snow_Albedo_ST;
		uniform float4 _Tint;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Tiles_Normal = i.uv_texcoord * _Tiles_Normal_ST.xy + _Tiles_Normal_ST.zw;
			float3 tex2DNode39 = UnpackNormal( tex2D( _Tiles_Normal, uv_Tiles_Normal ) );
			float3 appendResult42 = (float3(( tex2DNode39.r * _NormalTilesStrenght ) , ( tex2DNode39.g * _NormalTilesStrenght ) , tex2DNode39.b));
			float2 uv_Snow_Normal = i.uv_texcoord * _Snow_Normal_ST.xy + _Snow_Normal_ST.zw;
			float3 tex2DNode20 = UnpackNormal( tex2D( _Snow_Normal, uv_Snow_Normal ) );
			float3 appendResult27 = (float3(( tex2DNode20.r * _NormalSnowStrenght ) , ( tex2DNode20.g * _NormalSnowStrenght ) , tex2DNode20.b));
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_vertexNormal = mul( unity_WorldToObject, float4( ase_worldNormal, 0 ) );
			float4 transform10 = mul(unity_ObjectToWorld,float4( ase_vertexNormal , 0.0 ));
			float FinalSaturate35 = saturate( ( ( transform10.y + _Position ) * _Intensity ) );
			float3 lerpResult38 = lerp( appendResult42 , ( appendResult27 * FinalSaturate35 ) , FinalSaturate35);
			o.Normal = lerpResult38;
			float2 uv_Tiles_Albedo = i.uv_texcoord * _Tiles_Albedo_ST.xy + _Tiles_Albedo_ST.zw;
			float2 uv_Snow_Albedo = i.uv_texcoord * _Snow_Albedo_ST.xy + _Snow_Albedo_ST.zw;
			float4 lerpResult34 = lerp( tex2D( _Tiles_Albedo, uv_Tiles_Albedo ) , ( ( tex2D( _Snow_Albedo, uv_Snow_Albedo ) * _Tint ) * FinalSaturate35 ) , FinalSaturate35);
			o.Albedo = lerpResult34.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			# include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				float4 texcoords01 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.texcoords01 = float4( v.texcoord.xy, v.texcoord1.xy );
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord.xy = IN.texcoords01.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
527;91;982;560;1967.698;205.2131;1.218087;True;False
Node;AmplifyShaderEditor.CommentaryNode;99;-1896.283,22.94007;Float;False;1163.796;382.5127;Comment;7;16;10;13;12;11;14;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalVertexDataNode;16;-1852.783,81.23975;Float;True;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;10;-1611.581,76.99233;Float;True;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;13;-1345.35,287.4316;Float;False;Property;_Position;Position;3;0;-0.21;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;89;-281.4166,1083.356;Float;False;1245.012;529.2589;Lo mismo que arriba solo que a la salida la vuelvo a multiplicar por el resultado del Y - Vertex Normal;7;23;25;22;20;24;27;87;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1128.289,290.4525;Float;False;Property;_Intensity;Intensity;2;0;0.72;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-1363.374,74.54006;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-1143.553,76.72042;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;20;-231.4166,1152.879;Float;True;Property;_Snow_Normal;Snow_Normal;5;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;24;-207.2488,1345.28;Float;True;Property;_NormalSnowStrenght;NormalSnowStrenght;6;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;138.4344,1354.935;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;140.7119,1133.356;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SaturateNode;9;-916.0869,77.62289;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;35;-640.7657,73.77045;Float;True;FinalSaturate;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;27;402.8977,1164.225;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.GetLocalVarNode;87;392.2143,1382.615;Float;True;35;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;728.5959,1263.716;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.CommentaryNode;103;-177.7225,-288.1443;Float;False;1192.49;693.6334;Comment;10;3;19;17;28;4;53;51;52;34;100;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;19;-127.7226,-145.7986;Float;True;Property;_Snow_Albedo;Snow_Albedo;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;3;-76.85747,101.8514;Float;False;Property;_Tint;Tint;0;0;0.8676471,0.3253676,0.3253676,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;97;1029.172,1183.488;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.CommentaryNode;86;-193.6718,448.8172;Float;False;999.8303;557.0784;X e Y se la multiplico x un valor, Z se la paso asi como está;5;39;55;40;41;42;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;28;351.417,-238.1442;Float;True;Property;_Tiles_Albedo;Tiles_Albedo;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;55;-104.9951,747.8959;Float;True;Property;_NormalTilesStrenght;NormalTilesStrenght;6;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;39;-143.6719,498.8172;Float;True;Property;_Tiles_Normal;Tiles_Normal;7;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;100;205.5772,175.4891;Float;True;35;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;191.3817,-47.19381;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;95;1030.085,903.7084;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;288.637,519.5755;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;438.1037,-41.83231;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;53;676.98,-133.7173;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.WireNode;90;1046.459,855.3692;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;283.6381,742.9615;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;52;652.4256,118.7377;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.DynamicAppendNode;42;570.1581,604.5618;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.WireNode;96;1085.744,825.139;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.WireNode;51;687.2913,103.7952;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;36;1383.797,820.053;Float;True;35;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;38;1670.091,683.631;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;34;749.7676,87.03159;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.BlendNormalsNode;43;1868.896,1186.029;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2465.826,677.4946;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MyShaders/Clase3/SnowGenerator;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;16;0
WireConnection;12;0;10;2
WireConnection;12;1;13;0
WireConnection;14;0;12;0
WireConnection;14;1;11;0
WireConnection;25;0;20;2
WireConnection;25;1;24;0
WireConnection;23;0;20;1
WireConnection;23;1;24;0
WireConnection;9;0;14;0
WireConnection;35;0;9;0
WireConnection;27;0;23;0
WireConnection;27;1;25;0
WireConnection;27;2;20;3
WireConnection;22;0;27;0
WireConnection;22;1;87;0
WireConnection;97;0;22;0
WireConnection;17;0;19;0
WireConnection;17;1;3;0
WireConnection;95;0;97;0
WireConnection;40;0;39;1
WireConnection;40;1;55;0
WireConnection;4;0;17;0
WireConnection;4;1;100;0
WireConnection;53;0;28;0
WireConnection;90;0;95;0
WireConnection;41;0;39;2
WireConnection;41;1;55;0
WireConnection;52;0;4;0
WireConnection;42;0;40;0
WireConnection;42;1;41;0
WireConnection;42;2;39;3
WireConnection;96;0;90;0
WireConnection;51;0;53;0
WireConnection;38;0;42;0
WireConnection;38;1;96;0
WireConnection;38;2;36;0
WireConnection;34;0;51;0
WireConnection;34;1;52;0
WireConnection;34;2;100;0
WireConnection;0;0;34;0
WireConnection;0;1;38;0
ASEEND*/
//CHKSM=770DC18FDD46007B48A743D6D21A8BEE71261C09