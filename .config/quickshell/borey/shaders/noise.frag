#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    int fill;
    int seed;
    vec4 noiseColor;
    float noiseScale;
    float aspect;
};

layout(location = 0) out vec4 fragColor;

void main() {
    vec2 uv = vec2(qt_TexCoord0.x * aspect, qt_TexCoord0.y) * noiseScale;
    vec2 cell = floor(uv); 
    float randomValue = fract(sin(dot(cell, vec2(12.9898, 78.233)) + float(seed)) * 43758.5453);
    float threshold = float(fill) / 100.0;
    if (randomValue < threshold) {
        fragColor = noiseColor;
    } else {
        discard;
    }
}
