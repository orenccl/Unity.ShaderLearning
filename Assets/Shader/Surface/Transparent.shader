Shader "Examples/Transparent" 
{

	Properties
	{
		 _MainTex("MainTex", 2D) = "white"{}
	}

	SubShader
	{
		Tags { "Queue" = "Transparent" }
		// multiply 1 by the incoming color and multiply 1 in the frame buffer
		// then adds together
		// finalValue = sourceFactor * sourceValue operation destinationFactor * destinationValue
		//Blend One One

		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off
		Pass
		{
			SetTexture[_MainTex] {combine texture}
		}
	}
}