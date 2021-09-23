Shader "Examples/CustonBlinn" {

	Properties{
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader{
		Tags{
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf CustonBlinn

		half4 LightingCustonBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir,half atten){
			half3 h = normalize(lightDir + viewDir);

			// max is to remove light > 90 degree
			half diff = max(0, dot(s.Normal, lightDir));

			float nh = max(0, dot(s.Normal, h));

			// unity use 48 for Blinn default power
			float spec = pow(nh, 48.0);

			half4 c;
			// _LightColor0 is mean all light that affect your object
			c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten * _SinTime;
			c.a = s.Alpha;
			return c;
		}

		float4 _Color;
			
		struct Input {
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			o.Albedo = _Color.rgb;
		}

		ENDCG
	}
	FallBack "Diffuse"
}