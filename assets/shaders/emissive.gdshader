shader_type canvas_item;
uniform float brightness: hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	// scale brightness with red color channel
	float lightness = 1.f + (brightness * color.r);
	COLOR.rgb = color.rgb * vec3(lightness, lightness, lightness);
}

// Called for every pixel for every light affecting the CanvasItem.
void light() {
	// ignore shading from other sources and always draw at full brightness
	// vec4 color = texture(TEXTURE, UV);
	// LIGHT = color;
}
