
uniform vec4 COL1 = vec4(0.7, 0.0, 0.0, 1.0);
uniform vec4 COL2 = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 COL3 = vec4(0.0, 0.0, 0.7, 1.0);

vec4 effect(vec4 color, Image tex, vec2 uv, vec2 screen_coords)
{
    vec4 col = vec4(1.0);

    if (uv.x <= 0.5){

        vec4 A22 = Texel(tex, uv);
        float u = A22.r + A22.g / 255.0;

        if (u < 0.5){
            col = 2.0 * u * (COL2 - COL1) + COL1;
        }
        else {
            col = 2.0 * (u-0.5) * (COL3 - COL2) + COL2;
        }

        col = col * A22.a;
    
    }
    else{

        col = vec4(0.0, 0.0, 0.0, 0.0);
    
    }

    return col;
}