// canvas: square
precision mediump float;

uniform float u_time;
uniform vec2 u_resolution;
uniform vec3 u_colors[4];
uniform vec2 u_mouse;

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    vec2 center = vec2(0.5);
    float dist = length(uv - center);
    
    float t = u_time * 0.5;
    
    float wave1 = sin(dist * 10.0 - t * 2.0) * 0.5 + 0.5;
    float wave2 = sin(dist * 15.0 - t * 1.5 + 1.0) * 0.5 + 0.5;
    float wave3 = sin(dist * 5.0 - t * 3.0 + 2.0) * 0.5 + 0.5;
    
    vec3 color = mix(u_colors[0], u_colors[1], wave1);
    color = mix(color, u_colors[2], wave2 * 0.5);
    color = mix(color, u_colors[3], wave3 * 0.3);
    
    float vignette = 1.0 - dist * 0.8;
    color *= vignette;
    
    gl_FragColor = vec4(color, 1.0);
}
