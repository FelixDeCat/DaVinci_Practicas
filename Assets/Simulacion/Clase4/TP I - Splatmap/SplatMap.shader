// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TP1/SplatMapExample 1"
{
	Properties
	{
		_1("1", 2D) = "white" {}
		_Tint("Tint", Color) = (0,0,0,0)
		_Intensity("Intensity", Range( 0 , 2)) = 0
		_Float0("Float 0", Range( 0 , 1)) = 0
		_Float1("Float 1", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Intensity;
		uniform float4 _Tint;
		uniform sampler2D _1;
		uniform float4 _1_ST;
		uniform float _Float0;
		uniform float _Float1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_1 = i.uv_texcoord * _1_ST.xy + _1_ST.zw;
			float4 tex2DNode1 = tex2D( _1, uv_1 );
			float lerpResult6 = lerp( tex2DNode1.r , tex2DNode1.g , _Float0);
			float lerpResult8 = lerp( lerpResult6 , tex2DNode1.b , _Float1);
			o.Albedo = ( _Intensity * ( _Tint * lerpResult8 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
8;99;919;458;-238.4135;410.3808;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-1214.357,-173.3049;Float;True;Property;_1;1;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;7;-1099.252,74.72656;Float;False;Property;_Float0;Float 0;3;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;6;-723.8247,-135.8873;Float;True;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;9;-823.2631,183.2555;Float;False;Property;_Float1;Float 1;4;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;8;-385.9421,49.6377;Float;True;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;2;-376.4932,-141.5415;Float;False;Property;_Tint;Tint;1;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;89.32405,-58.96689;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;5;-291.3669,-337.5101;Float;False;Property;_Intensity;Intensity;2;0;0;0;2;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;332.5948,-198.2547;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;585.2162,-205.6228;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;TP1/SplatMapExample 1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;1;1
WireConnection;6;1;1;2
WireConnection;6;2;7;0
WireConnection;8;0;6;0
WireConnection;8;1;1;3
WireConnection;8;2;9;0
WireConnection;3;0;2;0
WireConnection;3;1;8;0
WireConnection;4;0;5;0
WireConnection;4;1;3;0
WireConnection;0;0;4;0
ASEEND*/
//CHKSM=4E0EB9C1294AE0CE0A763C616F8AEB5956F10065