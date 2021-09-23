Shader "Examples/Glass"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_ScaleUV ("Scale", Range(1,1000)) = 1000
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent"}
		GrabPass{}
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 uvgrab : TEXCOORD1;
				float2 uvbump : TEXCOORD2;
				float4 vertex : SV_POSITION;
			};

			sampler2D _GrabTexture;
			float4 _GrabTexture_TexelSize;
			sampler2D _MainTex;
            //corresponding 2D S/T coordinate
			float4 _MainTex_ST;
			sampler2D _BumpMap;
			float4 _BumpMap_ST;
			float _ScaleUV;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				/*
				// Basiclly the same as ComputeScreenPos
				//add this to check if the image needs flipping
				# if UNITY_UV_STARTS_AT_TOP
                float scale = -1.0;
                # else
                float scale = 1.0f;
                # endif

                //include scale in this formulae as below
				// from -w,w to 0,w
                o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y * scale) + o.vertex.w) * 0.5;
                o.uvgrab.zw = o.vertex.zw;
				*/

				o.uvgrab = ComputeScreenPos(o.vertex);

				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvbump = TRANSFORM_TEX(v.uv, _BumpMap);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				half2 bump = UnpackNormal(tex2D(_BumpMap, i.uvbump)).rg;
				float2 offset = bump * _ScaleUV * _GrabTexture_TexelSize.xy;
				i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;

				// from 0,w to 0,1
				//tex2Dproj will remap from [0,w] to [0/w,w/w] = [0,1] before sample
				//which, [0,1], is a valid uv value
				fixed4 col = tex2Dproj(_GrabTexture, i.uvgrab);  // Equal to //fixed4 col = tex2D(_GrabTexture, i.uvgrab.xy / i.uvgrab.w);

				fixed4 tint = tex2D(_MainTex, i.uv);
				col *= tint;
				return col;
			}
			ENDCG
		}
	}
}
