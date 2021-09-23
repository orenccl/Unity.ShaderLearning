Shader "Examples/ToonRamp" 
{

	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_RampTex("Ramp Texture", 2D) = "white"{}
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
		}

		CGPROGRAM
		#pragma surface surf ToonRamp

		float4 _Color;
		sampler2D _RampTex;

		half4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			// brightness
			float diff = dot(s.Normal, lightDir);

			// shife diit from -1~1 to 0~1
			float h = diff * 0.5 + 0.5;
			float2 rh = h;
			float3 ramp = tex2D(_RampTex, rh).rgb;

			half4 c;
			// _LightColor0 is mean all light that affect your object
			c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
			c.a = s.Alpha;
			return c;
		}

		struct Input {
			float2 uv_MainTex;
			float3 viewDir;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			//float diff = dot(o.Normal, IN.viewDir);
			//float h = diff * 0.5 + 0.5;
			//float2 rh = h;
			//o.Albedo = tex2D(_RampTex, rh).rgb * _Color.rgb;
			o.Albedo = _Color.rgb;
		}

		ENDCG
	}
	FallBack "Diffuse"
}