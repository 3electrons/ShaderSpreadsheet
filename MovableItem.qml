import QtQuick 2.4
import "Movable" 1.0

Item
{
    id: movable
    property variant target: Item { width: 100 ; height: 100 }
    width: 300; //target.width
    height: 400 //; target.height;
    property bool movable: true;
    property bool showFrame : false;
    property string name;

    signal doubleClicked();
    signal clicked();

    Connections {
        target: Movable
        onSave: saveLayout(Movable.layout)
    }

    function saveLayout()
    {
        var obj = target
        var rect = Qt.rect(obj.x, obj.y, obj.width, obj.height);
        var key = "Layouts/"+Movable.layout+"#"+name;
        console.log(key +"   " + rect);
        //Settings.setValue(key, rect);
    }

    function restoreLayout(target)
    {
        var key = "Layouts/"+Movable.layout+"#"+name;
        var rect = Qt.rect(0,0,320,240); // Settings.value(key);
        console.log("Restoring Layout:" + key +"   " + rect);
        x= rect.x
        y= rect.y;
        width = rect.width;
        height = rect.height;
    }

    onTargetChanged:
    {
       target.anchors.fill  = movable ;
    }

    onNameChanged:
    {
        restoreLayout(target)
    }

    Rectangle
    {
        id: borderRect
        color: "#00000000"
        border.color: (movable.showFrame || area.containsMouse || corner.containsMouse || corner.pressed) ? "white" : "#00000000"
        border.width: 1
        anchors.fill: parent;
    }

    MouseArea
    {
      id: area
      hoverEnabled: movable.movable
      anchors.fill : movable.movable ? parent : null
      drag.target: movable.movable ? movable : null
      onDoubleClicked: movable.doubleClicked();
      onClicked: movable.clicked();
    }

    MouseArea
    {
        id: corner
        width: 15;
        height: 15
        hoverEnabled: true
        x: parent.width - width
        y: parent.height - height
        drag.target : corner

        onXChanged: movable.width = x + height;
        onYChanged: {
            movable.height = y + width;
            console.log("(" +parent.width + "x" + parent.height + ")" + parent.x +"," + parent.y);
        }

        Rectangle
        {
            id: resizeRect
            //color: "yellow"
            color: movable.showFrame || corner.pressed || corner.containsMouse ? "white" : "#00000000"
            anchors.fill : parent
        }

        Component.onCompleted:
        {
            movable.width = x + width;
            movable.height = y + height ;

            name = Movable.nameId();
            //console.log("MovableName:" + name)

        }

    }



}// movable
