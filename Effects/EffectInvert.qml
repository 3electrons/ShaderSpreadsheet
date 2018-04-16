import QtQuick 2.7


Effect
{
    id:shader

    property real red: 1
    property real green: 0
    property real blue: 0
    parameters : ListModel {
        
        onDataChanged: updateParameters()
    }

    function updateParameters()
    {
    }

    fragmentShader:"
        uniform sampler2D tex_in;
        varying vec2 coord;

        void main(void)
        {
            vec2 p = coord.st;
            vec3 col = vec3(1.0) - texture2D(tex_in, p).rgb;
            gl_FragColor = vec4(col, 1.0);
        }
        ";

}
