#version 450 core
layout(location = 0) in vec2 aPos;
layout(location = 1) in vec2 aUV;
layout(location = 2) in vec4 aColor;

layout(push_constant) uniform uPushConstant {
    vec2 uScale;
    vec2 uTranslate;
} pc;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(location = 0) out struct {
    vec4 Color;
    vec2 UV;
} Out;

void main()
{
    // ImGui vertex colors are in sRGB. Decompress to linear so the sRGB swapchain
    // gamma-encode produces the intended colors on screen. See:
    // https://tuket.github.io/posts/2022-11-24-imgui-gamma/
    Out.Color = vec4(pow(aColor.rgb, vec3(2.2)), aColor.a);
    Out.UV = aUV;
    gl_Position = vec4(aPos * pc.uScale + pc.uTranslate, 0, 1);
}
