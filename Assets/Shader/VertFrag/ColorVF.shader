Shader "Examples/ColorVF"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            // vertex data
            struct appdata
            {
                // this vertex.y is flat, local position
                float4 vertex : POSITION;
            };

            // vertex to fragment
            struct v2f
            {
                // this vertex has been precess from world space to clipping space
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.color.r = (v.vertex.x+5)/10;
                //o.color.g = (v.vertex.z+5)/10;
                return o;
            }

            // pixel shader
            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col;
                col.r = i.vertex.x / 1000;
                col.g = i.vertex.y / 1000;
                return col;
            }
            ENDCG
        }
    }
}
