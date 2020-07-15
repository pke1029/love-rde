
uniform vec2 Mouse = vec2(400, 400);

vec4 effect(vec4 color, Image tex, vec2 uv, vec2 screen_coords)
{
    vec4 texturecolor = Texel(tex, uv);
    return texturecolor * color;
}