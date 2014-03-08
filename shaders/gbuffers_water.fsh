#version 120

/* DRAWBUFFERS:0N2N4 */



//water color and opacity
const vec3 watercolor = vec3(0.0,0.051,0.102);
const float water_opacity = 0.7;

uniform sampler2D texture;
uniform float rainStrength;

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;

varying vec3 normal;

varying float iswater;


const float MAX_OCCLUSION_DISTANCE = 100.0;

const int MAX_OCCLUSION_POINTS = 20;

uniform int worldTime;

float rainx = clamp(rainStrength, 0.0f, 1.0f)/1.0f;

const float bump_distance = 80.0f;
const float fademult = 0.1f;





void main() {	
	

    vec4 tex = texture2D(texture, texcoord.xy);
    /*
    if (iswater > 0.9) {
		tex = vec4(	0.9,0.9,0.9, 0.15);
	}
    */

	
	
 if (iswater > 0.9) tex.rgb = watercolor;
    

	
	
	vec3 indlmap = mix(lmcoord.t,1.0,lmcoord.s)*tex.rgb*color.rgb;
	gl_FragData[0] = vec4(indlmap,mix(tex.a,water_opacity,iswater));
	gl_FragDepth = gl_FragCoord.z;
	
	vec4 frag2;
	

			frag2 = vec4((normal) * 0.5f + 0.5f, 1.0f);			
	
	
	gl_FragData[2] = frag2;	
	//x = specularity / y = land(0.0/1.0)/shadow early exit(0.2)/water(0.05) / z = torch lightmap
	gl_FragData[4] = vec4(0.0, mix(1.0,0.05,iswater), lmcoord.s, 1.0);
	
}