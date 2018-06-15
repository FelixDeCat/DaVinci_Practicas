// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/DepthCameraWater"
{
	Properties
	{
		_Intensity("Intensity", Float) = 0
		_MaxIntensity("MaxIntensity", Float) = 0
		_Water("Water", 2D) = "white" {}
		_WaterNormal("Water Normal", 2D) = "white" {}
		_Flowmap("Flowmap", 2D) = "white" {}
		_Speed("Speed", Vector) = (0,0,0,0)
		_FlowMapIntensity("FlowMapIntensity", Range( 0 , 1)) = 0
		_EdgeItensity("Edge Itensity", Range( 0 , 10)) = 0
		_Bias("Bias", Float) = 0
		_Power("Power", Float) = 5
		_Scale("Scale", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
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
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 texcoord_0;
			float2 texcoord_1;
			float4 screenPos;
		};

		uniform sampler2D _WaterNormal;
		uniform float4 _WaterNormal_ST;
		uniform float _Bias;
		uniform float _Scale;
		uniform float _Power;
		uniform sampler2D _Water;
		uniform sampler2D _Flowmap;
		uniform float2 _Speed;
		uniform float _FlowMapIntensity;
		uniform float _EdgeItensity;
		uniform sampler2D _CameraDepthTexture;
		uniform float _Intensity;
		uniform float _MaxIntensity;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			o.texcoord_1.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_WaterNormal = i.uv_texcoord * _WaterNormal_ST.xy + _WaterNormal_ST.zw;
			o.Normal = tex2D( _WaterNormal, uv_WaterNormal ).rgb;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNDotV26 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode26 = ( _Bias + _Scale * pow( 1.0 - fresnelNDotV26, _Power ) );
			float2 panner15 = ( i.texcoord_1 + 1.0 * _Time.y * _Speed);
			float4 lerpResult23 = lerp( float4( i.texcoord_0, 0.0 , 0.0 ) , tex2D( _Flowmap, panner15 ) , _FlowMapIntensity);
			float4 tex2DNode12 = tex2D( _Water, lerpResult23.rg );
			o.Albedo = ( ( ( fresnelNode26 * tex2DNode12 ) * _EdgeItensity ) + tex2DNode12 ).rgb;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float eyeDepth4 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float4 temp_cast_4 = (eyeDepth4).xxxx;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float clampResult10 = clamp( (0.1 + (_Intensity - 0.0) * (0.4 - 0.1) / (1.0 - 0.0)) , 0.0 , _MaxIntensity );
			o.Alpha = ( abs( ( temp_cast_4 - ase_screenPosNorm ) ) * clampResult10 ).x;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc 

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
				float4 screenPos : TEXCOORD7;
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
				Input customInputData;
				vertexDataFunc( v, customInputData );
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
				o.screenPos = ComputeScreenPos( o.pos );
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
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
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
0;92;758;614;801.3563;1272.88;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-2061.155,-873.7802;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector2Node;17;-2027.007,-730.4443;Float;False;Property;_Speed;Speed;5;0;0,0;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.PannerNode;15;-1759.588,-780.2598;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-1270.262,-957.404;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;25;-1438.214,-529.2374;Float;False;Property;_FlowMapIntensity;FlowMapIntensity;6;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;22;-1432.582,-775.3705;Float;True;Property;_Flowmap;Flowmap;5;0;Assets/Flowmap.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;32;-491.3563,-977.8805;Float;False;Property;_Scale;Scale;8;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;33;-495.3563,-884.8805;Float;False;Property;_Power;Power;8;0;5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;23;-1005.663,-694.0951;Float;True;3;0;COLOR;0.0;False;1;COLOR;0.0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;31;-494.3563,-1068.88;Float;False;Property;_Bias;Bias;8;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;9;-806.1158,163.7781;Float;False;Property;_Intensity;Intensity;1;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.FresnelNode;26;-253.1438,-1055.823;Float;True;World;4;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;5.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;12;-586.7182,-679.4556;Float;True;Property;_Water;Water;3;0;Assets/Water.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ScreenPosInputsNode;3;-981.4595,-31.47098;Float;False;0;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ScreenDepthNode;4;-721.6711,-128.1489;Float;False;0;1;0;FLOAT4;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;5;-450.3519,-28.03697;Float;False;2;0;FLOAT;0.0;False;1;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;29;150.7651,-658.2462;Float;False;Property;_EdgeItensity;Edge Itensity;7;0;0;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;11;-427.2988,424.1362;Float;False;Property;_MaxIntensity;MaxIntensity;2;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemapNode;8;-485.8455,187.501;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;0.1;False;4;FLOAT;0.4;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;128.4701,-889.6345;Float;True;2;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.AbsOpNode;6;-262.7471,-25.87122;Float;False;1;0;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.ClampOpNode;10;-219.2988,288.9364;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;503.8568,-854.4401;Float;True;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;30;784.7867,-541.4229;Float;True;2;2;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-40.64924,91.40129;Float;False;2;2;0;FLOAT4;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SamplerNode;13;-619.0198,-417.2487;Float;True;Property;_WaterNormal;Water Normal;3;0;Assets/Water Normal.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1120.141,-343.5311;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MyShaders/DepthCameraWater;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;0;False;0;0;Transparent;0.5;True;True;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;16;0
WireConnection;15;2;17;0
WireConnection;22;1;15;0
WireConnection;23;0;24;0
WireConnection;23;1;22;0
WireConnection;23;2;25;0
WireConnection;26;1;31;0
WireConnection;26;2;32;0
WireConnection;26;3;33;0
WireConnection;12;1;23;0
WireConnection;5;0;4;0
WireConnection;5;1;3;0
WireConnection;8;0;9;0
WireConnection;27;0;26;0
WireConnection;27;1;12;0
WireConnection;6;0;5;0
WireConnection;10;0;8;0
WireConnection;10;2;11;0
WireConnection;28;0;27;0
WireConnection;28;1;29;0
WireConnection;30;0;28;0
WireConnection;30;1;12;0
WireConnection;7;0;6;0
WireConnection;7;1;10;0
WireConnection;0;0;30;0
WireConnection;0;1;13;0
WireConnection;0;9;7;0
ASEEND*/
//CHKSM=5C68D0F6F35D62005F30FCA619957DEDD28CA3DB