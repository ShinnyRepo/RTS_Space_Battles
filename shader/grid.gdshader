shader_type spatial;

void vertex(){
	vec4 black = vec4(0,0,0,1);
	vec4 white = vec4(1,1,1,1);
	vec4 send_color = white;
	vec3 color = vec3(0.0);
	
	vec2 st = VERTEX.xy * WORLD_MATRIX[2].zx;
	
	float left = step(st.x, 0.1);
	float bottom = step(st.y, 0.1);
	color = vec3(left * bottom);
	
	
	//vec4(VERTEX, 1.0);
	
	COLOR = vec4(color, 1.0);
}

void fragment(){
	ALBEDO = COLOR.rgb;
	ALPHA = COLOR.a;
}