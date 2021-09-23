Shader "Examples/Rim" {

	Properties{
		 _MainTex("Diffuse Texture", 2D) = "white"{}
		 _RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
		 _mySlider("Stripe Range", Range(1, 20)) = 10
	}

	SubShader{

		CGPROGRAM
		#pragma surface surf Lambert
		struct Input {
			float3 viewDir;
			float3 worldPos;
			float2 uv_MainTex;
		};

		sampler2D _MainTex;
		float4 _RimColor;
		float _RimPower;
		float _mySlider;

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = frac(IN.worldPos.y * (20 - _mySlider) * 0.5) > 0.49 ? float3(0, 1, 0) * rim : float3(1, 0, 0) * rim;
		}

		ENDCG
	}

	FallBack "Diffuse"
}