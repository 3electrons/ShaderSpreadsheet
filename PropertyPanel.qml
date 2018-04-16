import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle
{
    id: panel
    color:"darkgray"
    width: 300
    height: 400;

    property Item currentItem;
    property Item prevItem;
    property int columns : 2

    function setCurrentItem(arg)
    {
        prevItem = currentItem;
        currentItem = arg;

    }

    onCurrentItemChanged: {
        combo.currentIndex = combo.find(currentItem.name)

        updatePanel();
    }

    function updatePanel()
    {
        properties.model  = currentItem.item.parameters;
        // controlsLoader.sourceComponent = currentItem.item.controls;
    }


    Column
    {
        spacing: 4;

        Row
        {
            spacing: 4
            Button
            {
                text: "Add +"
                onClicked:gridModel.newItem()
                width: panel.width / 2
            }

            Button
            {
                text: "Del -"
                onClicked:gridModel.delCurrent()
                width: panel.width / 2
            }
        }

        Label { text:"Columns" ; anchors.horizontalCenter:  parent.horizontalCenter}
        SpinBox {
           width : panel.width / 2
           from: 1
           to: 5
           stepSize: 1
           onValueChanged: panel.columns = value;
           value : 2
        }




        //  Label { text: "Input item:" + currentItem.item.sourceItem.name }
        Label { text: "Prev item:" + prevItem.name; }

        Row
        {
            spacing : 4
            Button {
                text: "Prev 1 in" ;
                width: panel.width / 2 ;
                onClicked: currentItem.item.src1.sourceItem = prevItem.sourceItem
            }

            Button {
                text: "Prev 2 in" ;
                width: panel.width / 2 ;
                onClicked: currentItem.item.src2.sourceItem = prevItem.sourceItem
            }
        }



        Label { text: "Frame type"; anchors.horizontalCenter: parent.horizontalCenter }

        ComboBox {
            id: combo;
            width:  panel.width;

            textRole: "name"
            model: ListModel {
                ListElement { name: "Video";         source:"Video/Video.qml" }
                ListElement { name: "Black & White"; source:"Effects/EffectBW.qml" }
                ListElement { name: "Edge";          source:"Effects/EffectEdge.qml" }
                ListElement { name: "Eigen";         source:"Effects/EffectEigen.qml" }
                ListElement { name: "Emboss";        source:"Effects/EffectEmboss.qml" }
                ListElement { name: "Isolate";       source:"Effects/EffectIsolate.qml" }
                ListElement { name: "Invert";        source:"Effects/EffectInvert.qml" }
                ListElement { name: "Mixer";         source:"Effects/EffectMix.qml" }
                ListElement { name: "Camera";        source:"Video/Camera.qml" }
                ListElement { name: "VideoQtAV";     source:"Video/VideoAV.qml" }
            }

            onActivated: {
                panel.currentItem.name = model.get(index).name
                panel.currentItem.source = model.get(index).source;
                updatePanel();
            }

        }

        PropertyView
        {
            id: properties;
            width: parent.width;
            height: childrenRect.height
            model: ListModel {}
        }

        Loader
        {
            id: controlsLoader
            width: panel.width;
            //height: item.childrenRect.height
            sourceComponent: currentItem.item.controls
        }




    }



}
