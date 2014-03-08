#version 120


#define Waving_Water	
	
uniform float frameTimeCounter;

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;

varying vec3 normal;
varying vec3 viewVector;

varying float distance;

attribute vec4 mc_Entity;

varying float iswater;
varying float isice;


void main() {

	float frames = frameTimeCounter;

	iswater = 0.0f;
	isice = 0.0f;

	if (mc_Entity.x == 79) {
		isice = 1.0f;
	}
	
	vec4 position = gl_Vertex;


if (mc_Entity.x == 8.0 || mc_Entity.x == 9.0) + (iswater = 1.0);
#ifdef Waving_Water	
	if (mc_Entity.x == 8.0 || mc_Entity.x == 9.0) {
		float speed = 0.098;
        float magnitude = (sin((frames * 3.14159265358979323846264 / ((528.0) * speed))) * 0.01 + 0.40) * 0.27;
        float d0 = sin(frames * 3.14159265358979323846264 / (522.0 * speed)) * 3.0 - 1.5;
        float d1 = sin(frames * 3.14159265358979323846264 / (542.0 * speed)) * 3.0 - 1.5;
        float d2 = sin(frames * 3.14159265358979323846264 / (562.0 * speed)) * 3.0 - 1.5;
        float d3 = sin(frames * 3.14159265358979323846264 / (512.0 * speed)) * 3.0 - 1.5;
        position.y += sin((frames * 3.1415927 / (15.0 * speed)) +d2 + d3 + (position.z + position.x) * (3.1415927*2/16*3)) * magnitude;
	}
#endif


	vec4 locposition = gl_ModelViewMatrix * gl_Vertex;
	
    distance = sqrt(locposition.x * locposition.x + locposition.y * locposition.y + locposition.z * locposition.z);

	gl_Position = gl_ProjectionMatrix * (gl_ModelViewMatrix * position);
	
	color = gl_Color;
	
	texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;

	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	
	gl_FogFragCoord = gl_Position.z;
	
	normal = normalize(gl_NormalMatrix * gl_Normal);
    
}