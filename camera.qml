import QtQuick 2.7 
import QtQuick.Controls 2.0 
import QtMultimedia 5.6 
import QtQuick.Dialogs 1.2
import QtAV 1.6
import "Effects"


Rectangle {
    color: "darkgray"
    width: 820
    height: 480

    Button
    {
        text: "Open"
        anchors.bottom: parent.bottom;
        anchors.right:  parent.right
        onClicked: fileDialog.open()
    }


    FileDialog {
          id: fileDialog
          title: "Please choose a file"
          folder: shortcuts.home
          onAccepted: {
              console.log("You chose: " + fileDialog.fileUrls)
              player.source = fileDialog.fileUrl
          }

      }

    PropertyView
    {
        id: parametersView
        width: 200
        anchors.right:  parent.right
        anchors.top: parent.top
        height: 200
        model: shader.parameters
    }

    MovableItem
    {
        id: videoContainer
        onClicked:   player.play();
        AVPlayer {
            id: player
            source: "/home/coder/film.mp4"
            autoLoad:true
        }

        VideoOutput2 {
            id: output
            anchors.fill: parent
            z: parent.z - 1
            source: player

        }
    }

    MovableItem
    {
      x: 320
      id: isolateShader
        EffectEigen
        {
            id: shader
            anchors.fill: parent;
            tex_in: ShaderEffectSource {
                width: isolateShader.width
                height: isolateShader.height;
                sourceItem: videoContainer;
            }
            z: parent.z - 1
        }
        onClicked: parametersView.model = shader.parameters
    }

    MovableItem
    {
        id: edgeShader
        y: 240
        EffectBW
        {
            id: shader2
            anchors.fill: parent;
            tex_in: ShaderEffectSource {
                width: edgeShader.width
                height: edgeShader.height;
                sourceItem: isolateShader;
            }
            z: parent.z - 1
        }
        onClicked: parametersView.model = shader2.parameters

    }


}
