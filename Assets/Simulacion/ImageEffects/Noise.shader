// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ASETemplateShaders/PostProcess"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		_GreenSaturation("Green Saturation", Float) = 1
		_Lerp("Lerp", Range( 0 , 1)) = 1
		_Mask("Mask", 2D) = "white" {}
		_NoiseStrenght("Noise Strenght", Range( 0 , 1)) = 0
	}

	SubShader
	{
		Tags{  }
		
		ZTest Always Cull Off ZWrite Off
		


		Pass
		{ 
			CGPROGRAM 

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _GreenSaturation;
			uniform float _Lerp;
			uniform sampler2D _Mask;
			uniform float4 _Mask_ST;
			uniform float _NoiseStrenght;

			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				o.pos = UnityObjectToClipPos ( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#ifdef UNITY_HALF_TEXEL_OFFSET
						o.uv.y += _MainTex_TexelSize.y;
				#endif

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 tex2DNode3 = tex2D( _MainTex, uv_MainTex );
				float3 appendResult30 = (float3(tex2DNode3.r , ( tex2DNode3.g * _GreenSaturation ) , tex2DNode3.b));
				float3 temp_cast_0 = (( ( tex2DNode3.r + tex2DNode3.g + tex2DNode3.b ) / 3.0 )).xxx;
				float3 lerpResult25 = lerp( appendResult30 , temp_cast_0 , _Lerp);
				float2 uv_Mask = i.uv.xy * _Mask_ST.xy + _Mask_ST.zw;
				float4 tex2DNode31 = tex2D( _Mask, uv_Mask );
				float2 uv48 = i.uv.xy * float2( 1,1 ) + float2( 0.03,0.03 );
				float2 uv49 = i.uv.xy * float2( 1,1 ) + float2( -0.03,-0.03 );
				float4 lerpResult57 = lerp( float4( lerpResult25 , 0.0 ) , ( tex2D( _MainTex, uv48 ) * tex2D( _MainTex, uv49 ) * tex2D( _MainTex, uv_MainTex ) ) , _NoiseStrenght);
				

				finalColor = ( float4( ( lerpResult25 * tex2DNode31.r ) , 0.0 ) + ( lerpResult57 * ( 1.0 - tex2DNode31.r ) ) );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
0;92;758;298;1910.795;779.8445;4.267841;True;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;8;-108.7412,-233.6517;Float;False;_MainTex;0;5;SAMPLER2D;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;29;344.0334,-454.5956;Float;False;Property;_GreenSaturation;Green Saturation;4;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;3;94.48964,-228.4463;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;1015.03,-88.47694;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0.03,0.03;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;1026.894,266.0428;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;-0.03,-0.03;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;47;1064.409,103.356;Float;False;_MainTex;0;5;SAMPLER2D;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;739.2784,-476.9243;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;20;531.4832,-28.49008;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;30;920.2203,-329.0324;Float;False;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleDivideOpNode;21;754.8713,-41.37437;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;3.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;26;602.7506,126.2731;Float;False;Property;_Lerp;Lerp;3;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;46;1355.869,-124.8322;Float;True;Property;_TextureSample3;Texture Sample 3;8;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;45;1362.335,234.0126;Float;True;Property;_TextureSample2;Texture Sample 2;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;44;1362.335,56.20665;Float;True;Property;_TextureSample1;Texture Sample 1;6;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;1831.417,42.27588;Float;False;3;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;58;1794.157,248.9201;Float;False;Property;_NoiseStrenght;Noise Strenght;6;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;25;1113.951,-222.4422;Float;False;3;0;FLOAT3;0.0;False;1;FLOAT3;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;31;1103.676,534.8611;Float;True;Property;_Mask;Mask;5;0;Assets/Mask.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;34;1917.074,490.4458;Float;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;57;2125.642,5.811241;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;2295.996,182.5399;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;2270.712,-159.3561;Float;False;2;2;0;FLOAT3;0.0;False;1;FLOAT;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleAddOpNode;40;2523.731,12.22284;Float;False;2;2;0;FLOAT3;0.0;False;1;COLOR;0.0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.TemplateMasterNode;0;2689.854,-146.4332;Float;False;True;2;Float;ASEMaterialInspector;0;1;ASETemplateShaders/PostProcess;c71b220b631b6344493ea3cf87110c93;ASETemplateShaders/PostProcess;1;0;FLOAT4;0,0,0,0;False;0
WireConnection;3;0;8;0
WireConnection;28;0;3;2
WireConnection;28;1;29;0
WireConnection;20;0;3;1
WireConnection;20;1;3;2
WireConnection;20;2;3;3
WireConnection;30;0;3;1
WireConnection;30;1;28;0
WireConnection;30;2;3;3
WireConnection;21;0;20;0
WireConnection;46;0;47;0
WireConnection;46;1;48;0
WireConnection;45;0;47;0
WireConnection;45;1;49;0
WireConnection;44;0;47;0
WireConnection;56;0;46;0
WireConnection;56;1;45;0
WireConnection;56;2;44;0
WireConnection;25;0;30;0
WireConnection;25;1;21;0
WireConnection;25;2;26;0
WireConnection;34;0;31;1
WireConnection;57;0;25;0
WireConnection;57;1;56;0
WireConnection;57;2;58;0
WireConnection;39;0;57;0
WireConnection;39;1;34;0
WireConnection;32;0;25;0
WireConnection;32;1;31;1
WireConnection;40;0;32;0
WireConnection;40;1;39;0
WireConnection;0;0;40;0
ASEEND*/
//CHKSM=B176222DDBC72FDBB999D1FCCCE39E5A898A4DD7