import QtQuick 2.7


Effect
{
  id:shader

  property variant angle_out;
  property real threshold: 0.5

  parameters : ListModel
  {
     property string name: "Edge detection"
     ListElement { name: "Threshold" ; value : 0.5 }
     onDataChanged: updateParameters()
  }

  function updateParameters()
  {
      threshold = parameters.get(0).value;
  }

  fragmentShader: "
           #version 130
           out vec4 fragColor;
           out vec4 angle_out;

           uniform sampler2D tex_in;
           uniform float threshold;

           varying highp vec2 coord;

           #define theta_360 360.0
           #define theta_22_5 22.5
           #define theta_67_5 67.5
           #define theta_112_5 112.5
           #define theta_157_5 157.5
           #define theta_202_5 202.5
           #define theta_247_5 247.5
           #define theta_292_5 292.5
           #define theta_337_5 337.5

           uniform float coeffs_fx[9] = float[9](-1.0, +0.0, +1.0,
                                               -2.0, +0.0, +2.0,
                                               -1.0, +0.0, +1.0);

           uniform float coeffs_fy[9] = float[9](+1.0, +2.0, +1.0,
                                               +0.0, +0.0, +0.0,
                                               -1.0, -2.0, -1.0);

           uniform vec2 offset[9] = vec2[9](vec2(-1.0, +1.0), vec2(+0.0, +1.0), vec2(+1.0, +1.0),
                                       vec2(-1.0, +0.0), vec2(+0.0, +0.0), vec2(+1.0, +0.0),
                                       vec2(-1.0, -1.0), vec2(+0.0, -1.0), vec2(+1.0, -1.0));
           void main(void)
           {
               vec2 pos;
               float theta;
               float y = 0.0, gx = 0.0, gy = 0.0;
               float thr = threshold ;
               ivec2 tex_size = textureSize(tex_in, 0);
               vec2 current = coord;
               for (int i = 0; i < offset.length(); i++) {
                   pos.x = current.x+(offset[i].x/float(tex_size.x));
                   pos.y = current.y+(offset[i].y/float(tex_size.y));
                   y = texture2D(tex_in, pos).r;
                   gx += (y*coeffs_fx[i]);
                   gy += (y*coeffs_fy[i]);
               }
                   y = sqrt((gx*gx)+(gy*gy));
               theta = degrees(atan(abs(gy), abs(gx)));
               if (gx >= 0.0 && gy >= 0.0)
                   theta += 0.0;
               else if (gx < 0.0 && gy >= 0.0)
                   theta = 180.0-theta;
               else if (gx < 0.0 && gy < 0.0)
                   theta = 180.0+theta;
               else
                   theta = 360.0-theta;
               if ((theta >= theta_22_5 && theta < theta_67_5)||(theta >= theta_202_5 && theta < theta_247_5))
                   theta = 0.25;
               else if ((theta >= theta_67_5 && theta < theta_112_5)||(theta >= theta_247_5 && theta < theta_292_5))
                   theta = 0.5;
               else if ((theta >= theta_112_5 && theta < theta_157_5)||(theta >= theta_292_5 && theta < theta_337_5))
                   theta = 0.75;
               else
                   theta = 0.0;
               angle_out = vec4(theta, 0.0, 0.0, 1.0);

               if (y < thr)
                   y = 0;
               //else
                 y = sqrt(y) ;

               fragColor = vec4(y , y, y, 1.0);

           }"
}
