Shader "Examples/UVSCroll"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _FoamTex ("Albedo2 (RGB)", 2D) = "white" {}
        _ScrollX("Scroll X", Range(-5, 5)) = 1
        _ScrollY("Scroll Y", Range(-5, 5)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _FoamTex;
        float _ScrollX;
        float _ScrollY;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_FoamTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            _ScrollX *= _Time;
            _ScrollY *= _Time;
            float2 newUV = IN.uv_MainTex + float2(_ScrollX, _ScrollY);
            float2 newUV2 = IN.uv_FoamTex + float2(_ScrollX/2, _ScrollY/2);
            fixed4 c = tex2D (_MainTex, newUV);
            fixed4 d = tex2D (_FoamTex, newUV2);
            o.Albedo = (c+d)/2;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
