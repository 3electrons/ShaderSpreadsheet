import QtQuick 2.7
import QtMultimedia 5.6
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2


VideoOutput {

    id: videoOutput
    source: player
    property ListModel  parameters: ListModel {}
    property Component controls: Component  {

        Column
        {
            id: col
            width: parent.width;
            spacing:4
            Label { text: "Position(" + player.position/1000.0 + "/" + player.duration/1000.0 + ")" }
            Slider
            {
                width: parent.width;
                from:0
                to: player.duration;
                value: player.position
                onValueChanged: player.seek(value);
            }

            Row
            {
                spacing: 4
                Button { width: col.width / 2 -2 ; text : "Play" ; onClicked: player.play() }
                Button { width: col.width / 2 -2 ; text : "Pause" ; onClicked: player.pause() }
            }


            Button {
                text:"Open"
                onClicked: fileDialog.open();
            }
        }
    }






    function updateParameters()
    {
        var value = parameters.get(0).value;
        player.seek( value * player.duration)
    }

    property alias videoSource: player.source;

    anchors.fill : parent;
    width: 320
    height: 240

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted:   player.source = fileDialog.fileUrl
    }

    MediaPlayer {
        id: player
        source: "/home/coder/film.mp4"
        autoPlay: true
        loops: MediaPlayer.Infinite


    }


}
