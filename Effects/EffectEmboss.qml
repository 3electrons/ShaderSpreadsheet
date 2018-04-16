import QtQuick 2.7


Effect
{
    id:shader


    property real dividerValue : 0
    function updateParameters()
    {
        dividerValue = parameters.get(0).value;
    }

    fragmentShader:"
uniform float dividerValue;
const float step_w = 0.0015625;
const float step_h = 0.0027778;

uniform sampler2D tex_in;
varying highp vec2 coord;
uniform lowp float qt_Opacity;


void main()
{
    vec2 uv = coord;
    vec3 t1 = texture2D(tex_in, vec2(uv.x - step_w, uv.y - step_h)).rgb;
    vec3 t2 = texture2D(tex_in, vec2(uv.x, uv.y - step_h)).rgb;
    vec3 t3 = texture2D(tex_in, vec2(uv.x + step_w, uv.y - step_h)).rgb;
    vec3 t4 = texture2D(tex_in, vec2(uv.x - step_w, uv.y)).rgb;
    vec3 t5 = texture2D(tex_in, uv).rgb;
    vec3 t6 = texture2D(tex_in, vec2(uv.x + step_w, uv.y)).rgb;
    vec3 t7 = texture2D(tex_in, vec2(uv.x - step_w, uv.y + step_h)).rgb;
    vec3 t8 = texture2D(tex_in, vec2(uv.x, uv.y + step_h)).rgb;
    vec3 t9 = texture2D(tex_in, vec2(uv.x + step_w, uv.y + step_h)).rgb;
    vec3 rr = -4.0 * t1 - 4.0 * t2 - 4.0 * t4 + 12.0 * t5;
    float y = (rr.r + rr.g + rr.b) / 3.0;
    vec3 col = vec3(y, y, y) + 0.3;

        gl_FragColor = qt_Opacity * vec4(col, 1.0);
}
"

}
