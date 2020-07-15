uniform float dt = 0.025;
uniform float D1 = 1.0;
uniform float D2 = 0.5;
uniform float Feed = 0.04;
uniform float Kill = 0.062;
uniform float Step = 40.0;
uniform vec2 Resolution = vec2(800, 400);

vec4 effect(vec4 color, Image tex, vec2 uv, vec2 screen_coords)
{
    vec2 pixel = 1.0 / Resolution;
    vec4 col = vec4(0.0);

    if (uv.x <= 0.5){

        vec4 A11 = Texel(tex, uv + vec2(-1,-1)*pixel);
        vec4 A12 = Texel(tex, uv + vec2(-1, 0)*pixel);
        vec4 A13 = Texel(tex, uv + vec2(-1, 1)*pixel);
        vec4 A21 = Texel(tex, uv + vec2( 0,-1)*pixel);
        vec4 A22 = Texel(tex, uv + vec2( 0, 0)*pixel);
        vec4 A23 = Texel(tex, uv + vec2( 0, 1)*pixel);
        vec4 A31 = Texel(tex, uv + vec2( 1,-1)*pixel);
        vec4 A32 = Texel(tex, uv + vec2( 1, 0)*pixel);
        vec4 A33 = Texel(tex, uv + vec2( 1, 1)*pixel);

        vec4 B22 = Texel(tex, uv + vec2(0.5, 0.0));

        float u11 = (A11.r + A11.g / 255.0 + A11.b / 65025.0) * A11.a;
        float u12 = (A12.r + A12.g / 255.0 + A12.b / 65025.0) * A12.a;
        float u13 = (A13.r + A13.g / 255.0 + A13.b / 65025.0) * A13.a;
        float u21 = (A21.r + A21.g / 255.0 + A21.b / 65025.0) * A21.a;
        float u22 = (A22.r + A22.g / 255.0 + A22.b / 65025.0) * A22.a;
        float u23 = (A23.r + A23.g / 255.0 + A23.b / 65025.0) * A23.a;
        float u31 = (A31.r + A31.g / 255.0 + A31.b / 65025.0) * A31.a;
        float u32 = (A32.r + A32.g / 255.0 + A32.b / 65025.0) * A32.a;
        float u33 = (A33.r + A33.g / 255.0 + A33.b / 65025.0) * A33.a;

        float v22 = (B22.r + B22.g / 255.0 + B22.b / 65025.0) * B22.a;

        float diffusion = (0.05*u11 + 0.2*u12 + 0.05*u13 + 0.2*u21 - u22 + 0.2*u23 + 0.05*u31 + 0.2*u32 + 0.05*u33);
        float reaction = -u22*v22*v22 + Feed * (1.0-u22);
        float u_new = u22 + (D1 * diffusion + reaction) * Step * dt;

        u_new = clamp(u_new, 0.0, 1.0);
        float u_hi = u_new - mod(u_new, 1.0/255.0);
        float u_mid = u_new - u_hi - mod(u_new, 1.0/65025.0);
        float u_lo = u_new - u_hi - u_mid;

        col = vec4(u_hi, u_mid*255.0, u_lo*65025.0, A22.a);

    }
    else if(uv.x > 0.5){

        vec4 B11 = Texel(tex, uv + vec2(-1,-1)*pixel);
        vec4 B12 = Texel(tex, uv + vec2(-1, 0)*pixel);
        vec4 B13 = Texel(tex, uv + vec2(-1, 1)*pixel);
        vec4 B21 = Texel(tex, uv + vec2( 0,-1)*pixel);
        vec4 B22 = Texel(tex, uv + vec2( 0, 0)*pixel);
        vec4 B23 = Texel(tex, uv + vec2( 0, 1)*pixel);
        vec4 B31 = Texel(tex, uv + vec2( 1,-1)*pixel);
        vec4 B32 = Texel(tex, uv + vec2( 1, 0)*pixel);
        vec4 B33 = Texel(tex, uv + vec2( 1, 1)*pixel);

        vec4 A22 = Texel(tex, uv - vec2(0.5, 0.0));

        float v11 = (B11.r + B11.g / 255.0 + B11.b / 65025.0) * B11.a;
        float v12 = (B12.r + B12.g / 255.0 + B12.b / 65025.0) * B12.a;
        float v13 = (B13.r + B13.g / 255.0 + B13.b / 65025.0) * B13.a;
        float v21 = (B21.r + B21.g / 255.0 + B21.b / 65025.0) * B21.a;
        float v22 = (B22.r + B22.g / 255.0 + B22.b / 65025.0) * B22.a;
        float v23 = (B23.r + B23.g / 255.0 + B23.b / 65025.0) * B23.a;
        float v31 = (B31.r + B31.g / 255.0 + B31.b / 65025.0) * B31.a;
        float v32 = (B32.r + B32.g / 255.0 + B32.b / 65025.0) * B32.a;
        float v33 = (B33.r + B33.g / 255.0 + B33.b / 65025.0) * B33.a;
        
        float u22 = (A22.r + A22.g / 255.0 + A22.b / 65025.0) * A22.a;

        float diffusion = 0.05*v11 + 0.2*v12 + 0.05*v13 + 0.2*v21 - v22 + 0.2*v23 + 0.05*v31 + 0.2*v32 + 0.05*v33;
        float reaction = u22*v22*v22 - (Feed + Kill) * v22;
        float v_new = v22 + (D2 * diffusion + reaction) * Step * dt;
        
        v_new = clamp(v_new, 0.0, 1.0);
        float v_hi = v_new - mod(v_new, 1.0/255.0);
        float v_mid = v_new - v_hi - mod(v_new, 1.0/65025.0);
        float v_lo = v_new - v_hi - v_mid;

        col = vec4(v_hi, v_mid*255.0, v_lo*65025.0, B22.a);

    }
    
    return col;
}