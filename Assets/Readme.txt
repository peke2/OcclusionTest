(2017.07.27)
「OcclusionCube」と「OcclusionQuad」による「Cube」のカリングテスト。
シェーダーはデプスのみを書き込む。

	OcclusionCube
		「Cube」よりも先に描画されるよう中心座標を調整
	OcclusionQuad
		「Cube」よりも後に描画されるよう中心座標を調整


シェーダー「Occlusion」で「Queue」を調整することで挙動の違いが分かる。
	Queue
		Geometry	オブジェクトの中心座標でソートされるらしく、「OcclusionCube」でのカリングは無効
					「OcclusionQuad」ではカリングされる
		Geometry+1	他のオブジェクトの後に描画されるため、デプスしか書き込まない場合はカリングされない
		Geometry-1	他のオブジェクトの前に描画されるため、想定したカリングが行われる


