import QtQuick 2.7
import QtMultimedia 5.7
import QtQuick.Controls 2.0

VideoOutput {


    property ListModel  parameters: ListModel {
        ListElement { name:"Zoom" ; value : 0.5 }
       onDataChanged: updateParameters()
    }

    property Component controls:
    Component
    {
       Row
       {
            Button { width: parent.width / 2 - 2; text:"Stop" ; onClicked: camera.stop() }
            Button { width: parent.width / 2 - 2; text:"Start" ; onClicked: camera.start() }
       }


    }

    function updateParameters()
    {
      var value = parameters.get(0).value;
      camera.digitalZoom = value * 2;
    }



    anchors.fill : parent;
    width: 320
    height: 240


    Camera {
             id: camera
             imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
             deviceId: "/dev/video1"

             exposure {
                 exposureCompensation: -1.0
                 exposureMode: Camera.ExposurePortrait
             }

             viewfinder.resolution: Qt.size(640, 480) ;

         }

         VideoOutput {
             source: camera
             anchors.fill: parent
         }


}
