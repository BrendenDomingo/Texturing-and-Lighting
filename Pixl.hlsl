Texture2D simpleTexture : register(t0);
Texture2D simpleTexture1 : register(t1);
Texture2D simpleTexture2 : register(t2);
SamplerState simpleSampler : register(s0);

struct VSOut
{
	float4 Pos : SV_POSITION;
	float4 color : COLOR0;
	float2 TEX : TEXTURE;
	float3 norm : NORM;
	float4 wpos : WPOSITION;
	

};

cbuffer Con : register(b0)
{
	matrix World;
	matrix View;
	matrix Projection;
	float4 LightPosition;
	float4 CameraPosition;

};

float4 main(VSOut input) : SV_TARGET
{
	float3 lightdir = LightPosition - input.wpos;
	float distance = length(lightdir);
	lightdir = lightdir / distance;
	distance = distance * distance;

	float NdotL = dot(input.norm, lightdir);
	float intensity = saturate(NdotL);

	float3 diffuse = intensity * simpleTexture.Sample(simpleSampler, input.TEX) * 50 / distance;

	float3 H = normalize(lightdir + CameraPosition);

	float NdotH = dot(input.norm, H);
	intensity = pow(saturate(NdotH), 25);

	float3 spec = intensity * simpleTexture2.Sample(simpleSampler, input.TEX) * 80 / distance;

	float3 final = diffuse + spec + (simpleTexture1.Sample(simpleSampler, input.TEX) * 2);

	float4 color;
	color.x = final.x;
	color.y = final.y;
	color.z = final.z;
	color.a = 1.0f;

	return color;
}

