Shader "Unlit/HoloShader"
{
    Properties
    {
       _Colour("ColourA", Color) = (1,1,1,1)

       _Scale ("Scale", Float) = 1
    }
        SubShader
    {
        Tags { "RenderType" = "Transparent"
               "Queue"      = "Transparent" }
        LOD 100

        Pass
        {
            //Blend One One
            Blend DstColor Zero

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float _ColourA;
            float _Scale;

            #define TAU 6.2831853071;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normals : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD1; //data stream from vertex shader
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture
                return float4 (i.normal,1);
                //float xOffset = cos(i.uv * TAU * 8) * 0.05;
                //return float4 (i.uv.x + xOffset, i.uv.y, 0, 1);
                
            }
            ENDCG
        }
    }
}
