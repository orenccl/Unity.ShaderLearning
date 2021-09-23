Shader "Examples/UseProperties" {

	Properties{
		 _myColour("Example Colour", Color) = (1,1,1,1)
		 _myRange("Example Range", Range(0, 5)) = 1
		 _myTex("Example Texture", 2D) = "white"{}
		 _myEmissiveTex("Example Emissive Texture", 2D) = "black"{}
		 _myCube("Example Cube", CUBE) = ""{}
		 _myFloat("Example Float", Float) = 0.5
		 _myVector("Example Vector", Vector) = (0.5,1,1,1)

	}

	SubShader{

		CGPROGRAM
			#pragma surface surf Lambert

			fixed4 _myColour;
			half _myRange;
			sampler2D _myTex;
			sampler2D _myEmissiveTex;
			samplerCUBE _myCube;
			float _myFloat;
			float4 _myVector;

			struct Input {
				float2 uv_myTex;
				float2 uv_myEmissiveTex;
				float3 worldRefl;
			};


			void surf(Input IN, inout SurfaceOutput o) {
				o.Albedo = tex2D(_myTex, IN.uv_myTex).rgb;
				o.Emission = tex2D(_myEmissiveTex, IN.uv_myEmissiveTex).rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}