Shader "Unlit/Lesson14"
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
                
                uint ui = 12;
                int i = -3;

                float f = 0.5f;
                half h = 0.2h;
                fixed fix = 0.002;
                
                bool b = true;
                string str = "1223";

                sampler sam;

                //一维数组
                float arrayf[4] = {2,3,4,5};
                //CG中不能通过lenght来获取数组长度 需要自己声明
                int arrayfLenght = 4;
                
                //二维数组
                float arrayff[3][3] = {{1,2,3},{4,5,6},{7,8,9}};

                //结构体
                struct test
                {
                    int i;
                    float f;
                    bool b;
                };
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
