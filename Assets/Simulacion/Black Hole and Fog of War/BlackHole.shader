// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MyShaders/BlackHole"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_BlackHoleLocation("BlackHoleLocation", Vector) = (0,0,0,0)
		_Strenght("Strenght", Float) = 2
		_Falloff("Falloff", Float) = 5
		_OpacityRadius("OpacityRadius", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform float3 _BlackHoleLocation;
		uniform float _Strenght;
		uniform float _Falloff;
		uniform float _OpacityRadius;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_6_0 = distance( ase_worldPos , _BlackHoleLocation );
			float temp_output_12_0 = saturate( pow( ( temp_output_6_0 / _Strenght ) , _Falloff ) );
			float3 lerpResult19 = lerp( float3( 0,0,0 ) , ( ase_worldPos + ( 1.0 - _BlackHoleLocation ) ) , ( temp_output_12_0 - 1.0 ));
			float4 transform18 = mul(unity_WorldToObject,float4( lerpResult19 , 0.0 ));
			v.vertex.xyz += transform18.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float temp_output_6_0 = distance( ase_worldPos , _BlackHoleLocation );
			float temp_output_12_0 = saturate( pow( ( temp_output_6_0 / _Strenght ) , _Falloff ) );
			float4 lerpResult11 = lerp( float4(1,0,0,1) , float4(0.7824394,0.9013543,0.9852941,1) , temp_output_12_0);
			o.Albedo = lerpResult11.rgb;
			o.Alpha = 1;
			clip( saturate( ( temp_output_6_0 / _OpacityRadius ) ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
373;92;480;614;935.5046;151.4705;1;True;False
Node;AmplifyShaderEditor.Vector3Node;1;-719.3747,123.8864;Float;False;Property;_BlackHoleLocation;BlackHoleLocation;0;0;0,0,0;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;5;-701.1515,-52.61472;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DistanceOpNode;6;-433.1608,48.49023;Float;False;2;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;2;-422.0203,219.4001;Float;False;Property;_Strenght;Strenght;1;0;2;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;7;-224.6189,106.6677;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;4;-334.9426,335.0662;Float;False;Property;_Falloff;Falloff;2;0;5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.PowerNode;8;-15.40039,207.2191;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;17;-504.4609,452.856;Float;False;1;0;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SaturateNode;12;224.948,254.2774;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;22;-460.1881,-132.8702;Float;False;Property;_OpacityRadius;OpacityRadius;4;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-84.03242,458.5761;Float;False;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;20;317.0184,391.6827;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;19;474.951,455.3968;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0;False;2;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleDivideOpNode;21;-149.8268,-122.9805;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;9;214.4779,64.43575;Float;False;Constant;_Color0;Color 0;3;0;0.7824394,0.9013543,0.9852941,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;10;246.5247,-133.1885;Float;False;Constant;_Color1;Color 1;3;0;1,0,0,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;11;531.4125,200.9186;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.WorldToObjectTransfNode;18;753.7747,446.6844;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SaturateNode;23;-25.87677,-36.55994;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1134.158,100.6441;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MyShaders/BlackHole;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Custom;0.5;True;True;0;False;TransparentCutout;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;5;0
WireConnection;6;1;1;0
WireConnection;7;0;6;0
WireConnection;7;1;2;0
WireConnection;8;0;7;0
WireConnection;8;1;4;0
WireConnection;17;0;1;0
WireConnection;12;0;8;0
WireConnection;16;0;5;0
WireConnection;16;1;17;0
WireConnection;20;0;12;0
WireConnection;19;1;16;0
WireConnection;19;2;20;0
WireConnection;21;0;6;0
WireConnection;21;1;22;0
WireConnection;11;0;10;0
WireConnection;11;1;9;0
WireConnection;11;2;12;0
WireConnection;18;0;19;0
WireConnection;23;0;21;0
WireConnection;0;0;11;0
WireConnection;0;10;23;0
WireConnection;0;11;18;0
ASEEND*/
//CHKSM=51CF7C811E09077E68AF8678091B4B21A0FB124A