// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/PracticasVideos/Invisible"
{
	Properties
	{
		_DistortionMap("DistortionMap", 2D) = "white" {}
		_Blending("Blending", Range( 0 , 1)) = 0
		_DistoritionStrengh("DistoritionStrengh", Range( 0 , 0.5)) = 0
		_RippleScale("RippleScale", Range( 0 , 20)) = 0
		_RippleSpeed("RippleSpeed", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
		};

		uniform sampler2D _GrabTexture;
		uniform sampler2D _DistortionMap;
		uniform float _RippleScale;
		uniform float _RippleSpeed;
		uniform float _DistoritionStrengh;
		uniform float _Blending;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = float3(0,0,0);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPos7 = ase_screenPos;
			#if UNITY_UV_STARTS_AT_TOP
			float scale7 = -1.0;
			#else
			float scale7 = 1.0;
			#endif
			float halfPosW7 = ase_screenPos7.w * 0.5;
			ase_screenPos7.y = ( ase_screenPos7.y - halfPosW7 ) * _ProjectionParams.x* scale7 + halfPosW7;
			ase_screenPos7.xyzw /= ase_screenPos7.w;
			float4 screenColor2 = tex2D( _GrabTexture, ( ( tex2D( _DistortionMap, ( _RippleScale * (( ( _Time.x + _RippleSpeed ) + ase_screenPos7 )).xyz ).xy ) * _DistoritionStrengh ) + ase_screenPos7 ).rg );
			float4 temp_cast_3 = (1.0).xxxx;
			float4 lerpResult3 = lerp( screenColor2 , temp_cast_3 , _Blending);
			o.Emission = lerpResult3.rgb;
			o.Metallic = lerpResult3.r;
			o.Smoothness = lerpResult3.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
8;99;1286;543;2856.41;785.4534;2.510713;True;True
Node;AmplifyShaderEditor.TimeNode;13;-2268.655,-150.3822;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;20;-2287.205,23.53569;Float;False;Property;_RippleSpeed;RippleSpeed;4;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1997.975,-132.716;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GrabScreenPosition;7;-2036.835,144.5587;Float;False;0;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-1843.942,-61.79262;Float;False;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.SwizzleNode;15;-1703.913,-142.9792;Float;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;17;-1906.375,-385.3456;Float;False;Property;_RippleScale;RippleScale;3;0;0;0;20;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1575.375,-283.3456;Float;False;2;2;0;FLOAT;0,0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;12;-1369.562,-47.67249;Float;False;Property;_DistoritionStrengh;DistoritionStrengh;2;0;0;0;0.5;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;6;-1380.166,-259.1306;Float;True;Property;_DistortionMap;DistortionMap;1;0;Assets/Simulacion/Practica/SmallWaves2.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1014.286,-201.3835;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-863.2128,-36.99513;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;4;-563.9833,216.5711;Float;False;Constant;_White;White;0;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;5;-567.8196,293.8423;Float;False;Property;_Blending;Blending;1;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.ScreenColorNode;2;-601.7727,27.79845;Float;False;Global;_GrabScreen0;Grab Screen 0;0;0;Object;-1;False;1;0;FLOAT2;0,0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector3Node;1;-400.7154,-103.7402;Float;False;Constant;_Vector0;Vector 0;0;0;0,0,0;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;3;-225.4943,144.9997;Float;False;3;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MyShaders/PracticasVideos/Invisible;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Translucent;5;True;True;0;False;Opaque;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;13;1
WireConnection;19;1;20;0
WireConnection;18;0;19;0
WireConnection;18;1;7;0
WireConnection;15;0;18;0
WireConnection;16;0;17;0
WireConnection;16;1;15;0
WireConnection;6;1;16;0
WireConnection;11;0;6;0
WireConnection;11;1;12;0
WireConnection;8;0;11;0
WireConnection;8;1;7;0
WireConnection;2;0;8;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;3;2;5;0
WireConnection;0;0;1;0
WireConnection;0;2;3;0
WireConnection;0;3;3;0
WireConnection;0;4;3;0
ASEEND*/
//CHKSM=AC12654C05C783E1893966B0CF451077BA8F4A89