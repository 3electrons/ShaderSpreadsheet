import QtQuick 2.7
import QtQuick.Controls 2.0

Effect
{
  id:shader

  property variant angle_out;
  property real alpha1: 1.0
  property real alpha2: 1.0
  property int mode : 0;

  controls :
   Component
   {
      ComboBox {
       model : ["Add", "Subtract", "Multiply", "Divide"]
       onActivated : mode = index;
       currentIndex: mode;
      }

   }

  parameters : ListModel
  {
     property string name: "Mix detection"
     ListElement { name: "In1 alpha" ; value : 1.0 }
     ListElement { name: "In2 alpha" ; value : 1.0 }
     onDataChanged: updateParameters()
  }

  function updateParameters()
  {
      alpha1 = parameters.get(0).value;
      alpha2 = parameters.get(1).value;
  }

  fragmentShader: "
           #version 130
           out vec4 fragColor;

           uniform sampler2D tex_in;
           uniform sampler2D tex_in2;
           uniform float alpha1;
           uniform float alpha2;
           uniform int mode;
           varying highp vec2 coord;

           void main(void)
           {
               vec3 c1 = texture2D(tex_in, coord).rgb;
               vec3 c2 = texture2D(tex_in2, coord).rgb;
               c1 = c1 * alpha1;
               c2 = c2 * alpha2;

               switch(mode)
               {
                case 0 :  fragColor = vec4(c1 + c2 , 1.0) ; break ;
                case 1 :  fragColor = vec4(c1 - c2 , 1.0) ; break ;
                case 2 :  fragColor = vec4(c1 * c2 , 1.0) ; break ;
                case 3 :  fragColor = vec4(c1 / c2 , 1.0) ; break ;
                default : fragColor = vec4(c1,1.0); break;
               }
           }"
}
