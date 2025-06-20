Shader "Unlit/Lesson16"
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

                //利用Swizzle来提取分量
                fixed4 f4 = fixed4(1,2,3,4);
                //获取第一个元素
                fixed f = f4.x;//xyzw
                f = f4.r;//rgba
                //2.利用它来重新排列分量
                f4 = f4.yzxw;
                f4 = f4.abgr;
                //3.利用它来创建新的向量
                fixed3 f3 = f4.xyw;
                fixed2 f2 = f4.xy;
                fixed4 f42 = fixed4(f2,5,6);

                //在声明矩阵的时候 我们可以配合向量来进行声明
                fixed4x4 f4x4 = {
                    fixed4(1,2,3,4),
                    fixed4(5,6,8,10),
                    fixed4(1,2,3,4),
                    fixed4(1,2,3,4),
                };
                //矩阵中元素的获取和二维数组一样
                f = f4x4[0][0];//第一行 第一列

                //我们可以用向量作为容器 存储矩阵中的某一行
                f42 = f4x4[0];

                //向量和矩阵都可以用低维存高维,会自动舍去多余元素
                fixed3 f32 = f4;//不明确写 直接用前面的对应个数xyz赋值 w会舍去
                
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
