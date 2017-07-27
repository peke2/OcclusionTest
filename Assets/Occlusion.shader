Shader "Unlit/Occlusion"
{
	SubShader
	{
		//	オクルージョンの条件
		//	・他のオブジェクトよりも先にデプスバッファが更新されていること
		//	キューで描画の条件を変えてやる
		//	不透明オブジェクト　→　キューが同じ数値だと描画順は最良パフォーマンスのために最適化
		//	透明なオブジェクト　→　距離でソート
			//	https://docs.unity3d.com/jp/540/Manual/SL-SubShaderTags.html
		//	不透明オブジェクトの場合は、おそらくバウンディングボックスの中心のZ座標で描画順番をソートしてる？
		//	確実に他のオブジェクトよりも先に描画するためには、「Queue」を調整する必要がある

		Tags {
			"RenderType"="Opaque"
			//両方コメントアウトでデフォルト「Geometry」で描画される
			//"Queue"="Geometry+1"	//	他の不透明オブジェクトの次に描画させてみる
			"Queue"="Geometry-1"	//	他の不透明オブジェクトよりも先に描画させてみる
		}
		LOD 100

		Pass
		{
			ZWrite On
			ColorMask 0

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(1,1,0,1);
				return col;
			}
			ENDCG
		}
	}
}
