import QtQuick 2.7


ShaderEffect
{
    id:shader
    blending : false
    //supportsAtlasTextures: true

    property Component controls; //Rectangle { color:"white" }
    property  ShaderEffectSource src1 :
    ShaderEffectSource
    {
      id: shaderSource1;
      width: shader.width;
      height: shader.height;
    }

    property  ShaderEffectSource src2 :
    ShaderEffectSource
    {
        id: shaderSource2;
        width: shader.width;
        height: shader.height;
    }


    property ListModel parameters;
    property variant tex_in : shaderSource1;
    property variant tex_in2 : shaderSource2;

    vertexShader: "
     uniform highp mat4 qt_Matrix;
     attribute highp vec4 qt_Vertex;
     attribute highp vec2 qt_MultiTexCoord0;
     varying highp vec2 coord;
     void main() {
         coord = qt_MultiTexCoord0;
         gl_Position = qt_Matrix * qt_Vertex;
     }"

    fragmentShader: "
                     varying highp vec2 coord;
                     const float size = 0.05;
                     const vec4 col0 = vec4(0.5, 0.5, 0.5, 0.5);
                     const vec4 col1 = vec4(0.7, 0.7, 0.7, 0.7);
                     void main() {
                     float x = float(int(gl_FragCoord.x*size) + int(gl_FragCoord.y*size));
                     if(mod(x, 2.0) > 0.0)
                        { gl_FragColor  = col0; }
                     else
                        { gl_FragColor = col1; }

                     }"
}






































































