shader_type canvas_item;

// Automatically grab the current screen and set it to screen_texture
uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform int color_levels : hint_range(2, 32) = 4;  // Color quantization steps

uniform float dither_strength : hint_range(0.0, 1.0) = 1.0;

uniform float dither_scale : hint_range(1.0, 16.0) = 4.0;

float bayer4x4(ivec2 pos) {
	// Amount of % is based on size of the matrix so %4 for a 4x4 and %8 for 8x8
	// We take the mod so that the bayer matrix can tile across the span of the canvas
	int x = pos.x % 4; 
    int y = pos.y % 4;
	
	// This contains the 4x4 bayer matrix itself, this is just a pre-determined matrix of values
	// that assure that no value is repeated, and that it has spatial uniformity
	int matrix[16] = int[16](
         0,  8,  2, 10,
        12,  4, 14,  6,
         3, 11,  1,  9,
        15,  7, 13,  5
    );
	// The -- matrix[y * 4 + x] -- portion acceses the correct row and column of the matrix
	// It is divided by 16 to get a value from range [0,1) as a decimal
	return float(matrix[y * 4 + x]) / 16.0;
}



void fragment() {
	// Called for every pixel the material is visible on.
	
	// This grabs the UV coordinate for the pixel
	vec2 uv = SCREEN_UV;
	// Samples the color from the screen_texture at the coordinate uv
	vec4 color = texture(screen_texture, uv);
	
	// Grabs the vec2 coordinate of the pixel in the screen space and casts it as an int
	// because the bayer matrix needs whole numbers
	ivec2 pixel_pos = ivec2(FRAGCOORD.xy / dither_scale);
	
	// Looks up the bayer threshold of the pixel position and sets it to be from [-0.5, 0.5),bool
	// So that it is ranged around 0
	float threshold = bayer4x4(pixel_pos) - 0.5;
	
	// This acts as the denominator for the colors available
	// eg. 0/3, 1/3, 2/3, 3/3
	float levels = float(color_levels - 1);
	
	// Add the scaled threshold to the color to nudge it up or down
	vec3 dithered = color.rgb + (threshold * dither_strength / levels);
	// Quantize and then divide by levels to bring it back to the [0,1) range
	dithered = floor(dithered * levels + 0.5) / levels;
	// Finally set the color
	COLOR = vec4(dithered, color.a);
}
