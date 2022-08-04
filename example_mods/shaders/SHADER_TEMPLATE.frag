#pragma header
//its important to have this bit here. it inits all the importan OpenFL shader shits like the image's coordinates and size.

vec2 uv = openfl_TextureCoordv.xy;
// uv: coordinate of a pixel. usually replaces 'fragCoord.xy / iResolution.xy';




void main(void){

	gl_FragColor = texture2D( bitmap, uv);
	//bitmap: the original graphic of the camera or sprite. usually replaces iChannel0 
	//texture2D: a 4type Vector that returns the image. replaces texture
	//gl_FragColor: the result. usually replaces fragColor
}