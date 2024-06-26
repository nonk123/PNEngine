/* -----------------------
   SMF FRAGMENT ÜBERSHADER
        (PER-VERTEX)
    Original by TheSnidr
          Forked by
    Can't Sleep & nonk123
        for PNEngine
   ----------------------- */

/* --------
   VARYINGS
   -------- */

varying vec2 v_texcoord;
varying vec4 v_color;
varying float v_light_depth;

/* --------
   UNIFORMS
   -------- */

uniform vec4 u_uvs;

uniform vec4 u_color;

uniform vec4 u_material_color;
uniform float u_material_alpha_test;
uniform float u_material_bright;

uniform int u_material_can_blend;
uniform sampler2D u_material_blend;
uniform vec4 u_material_blend_uvs;

void main() {
	float u = fract(v_texcoord.x);
	float v = fract(v_texcoord.y);
	vec2 uv = vec2(u_uvs.r + (u_uvs.b * u), u_uvs.g + (u_uvs.a * v));
	vec4 sample = texture2D(gm_BaseTexture, uv);
	float v_alpha;
	
	if (u_material_can_blend == 1) {
		vec2 blend_uv = vec2(u_material_blend_uvs.r + (u_material_blend_uvs.b * u), u_material_blend_uvs.g + (u_material_blend_uvs.a * v));
		
		sample = mix(texture2D(u_material_blend, blend_uv), sample, v_color.a);
		v_alpha = 1.;
	} else {
		v_alpha = v_color.a;
	}
	
	if (u_material_alpha_test > 0.) {
		if (sample.a < u_material_alpha_test) {
			discard;
		}
		
		sample.a = 1.;
	}
	
	gl_FragColor = (sample * u_material_color * vec4(v_color.rgb, mix(v_alpha, 0., u_material_bright))) * u_color;
	
	const mat4 pattern = mat4(
		vec4(0.0625, 0.5625, 0.1875, 0.6875),
		vec4(0.8125, 0.3125, 0.9375, 0.4375),
		vec4(0.25, 0.75, 0.125, 0.625),
		vec4(1.0, 0.5, 0.875, 0.375)
	);
    
	if (gl_FragColor.a < pattern[int(mod(gl_FragCoord.x, 4.))][int(mod(gl_FragCoord.y, 4.))]) {
		discard;
	}
	
	gl_FragColor = vec4(v_light_depth, 0, 0, 1);
}