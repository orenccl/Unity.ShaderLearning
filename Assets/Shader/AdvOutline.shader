Shader "Examples/AdvOutline"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _OutlineColor("Outline Color", Color) = (0, 0, 0, 1)
        _Outline("Outline Width", Range(0.002, 0.1)) = 0.005
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }
        ENDCG
        
        Pass
        {
            Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

			struct v2f
			{
				float4 pos : SV_POSITION;
                fixed4 color : COLOR;
			};

            float _Outline;
            float4 _OutlineColor;

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                // https://blog.csdn.net/cubesky/article/details/38682975
                // http://www.lighthouse3d.com/tutorials/glsl-12-tutorial/the-normal-matrix/
                float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
                // Discard depth, so that outline would be flatten
                float2 offset = TransformViewToProjection(norm.xy);

                // o.pos.z = depth, to stays at the same relative thickness to the object
                o.pos.xy += offset *  o.pos.z * _Outline;
                o.color = _OutlineColor;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return i.color;
            }

            ENDCG
        }
    }
    FallBack "Diffuse"
}
