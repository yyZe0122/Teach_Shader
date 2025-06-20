Shader "Unlit/Lesson15"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);

                //向量声明
                //二维向量
                fixed2 f2 = fixed2(1.2,2.5);
                //三维向量
                fixed3 f3 = fixed3(1,2,3);
                //四维向量
                int4 i4 = int4(1,2,3,4);

                //矩阵声明
                fixed3x3 f3x3 =
                {
                    1,2,3,
                    4,5,6,
                    6,7,8
                };
                fixed4x4 f4x4 =
                {
                    1,2,3,4,
                    5,6,7,8,
                    9,10,11,12,
                    13,14,15,16
                };


                
                return col;
            }
            ENDCG
        }
    }
}
