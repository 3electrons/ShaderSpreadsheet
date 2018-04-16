import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    id: gridDelegate

    property string name: "N/A"

    property alias item: itemLoader.item
    property alias sourceItem: src

    property alias source : itemLoader.source
    signal clicked();


    Item
    {
        id: src
        anchors.fill : parent;
        Loader {
            id: itemLoader
            anchors.fill:  parent;
        }

    }

    Label {   text: "Frame " + index + ":" + name ; color: "white" ; style: Text.Outline; styleColor: "black"}

    MouseArea
    {
        anchors.fill : parent
        onClicked: gridDelegate.clicked(name);
    }

}
