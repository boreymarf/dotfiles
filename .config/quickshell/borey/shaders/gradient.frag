#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

void main() {
    vec3 color1 = vec3(1.0, 0.0, 0.0);
    vec3 color2 = vec3(0.0, 0.0, 1.0);
    float mixFactor = qt_TexCoord0.x;
    vec3 finalColor = mix(color1, color2, mixFactor);
    fragColor = vec4(finalColor, 1.0);
}
