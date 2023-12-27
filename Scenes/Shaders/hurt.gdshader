shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1.0); //Variable qui stocke les couleurs pour qu'on puisse les modifier pour notre inspecteur lorsque en veut
uniform float flash_modifier : hint_range(0.0, 1.0) = 1;

void fragment() {
	vec4 color = texture(TEXTURE, UV); // ici on parle de texture de l'image
	color.rgb = mix(color.rgb, flash_color.rgb, flash_modifier);
	COLOR = color;
}
