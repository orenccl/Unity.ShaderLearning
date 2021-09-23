Shader "Examples/Basic" {

	Properties{
		 _MainTex("Base (RBG)", 2D) = "white"{}
	}

	SubShader{
		Tags { "Queue" = "Geometry" }

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}