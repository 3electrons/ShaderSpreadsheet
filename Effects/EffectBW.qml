import QtQuick 2.7


Effect
{
    id:shader

    property real thresholdHi: 1
    property real thresholdLo: 0
    parameters : ListModel {
        property string name: "Black & White"
        ListElement { name: "Threshold High" ; value: 1.0 }
        ListElement { name: "Threshold Low" ; value : 0 }
        onDataChanged: updateParameters()
    }

    function updateParameters()
    {
        thresholdHi = parameters.get(0).value
        thresholdLo = parameters.get(1).value
    }

    fragmentShader:"
uniform float thresholdHi;
uniform float thresholdLo;

uniform sampler2D tex_in;
varying vec2 coord;
uniform lowp float qt_Opacity;


void main()
{
    vec4 orig = texture2D(tex_in, coord);
    vec3 col = orig.rgb;
    float y = 0.3 *col.r + 0.59 * col.g + 0.11 * col.b;
    y = (y > thresholdLo)  && (y < thresholdHi) ? 1.0 : 0.0;

        gl_FragColor = qt_Opacity * vec4(y, y, y, 1.0);

}"

}
