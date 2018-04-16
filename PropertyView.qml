import QtQuick 2.7
import QtQuick.Controls 2.0

ListView
{

    model: ListModel {

        ListElement { name: "Threshold" ; value : 0.5; }
        ListElement { name: "Gamma" ; value : 0.5; }

        onDataChanged: updateParameters()
    }

    function updateParameters()
    {
        for (var i=0 ; i <  model.count ; i++)
            console.log( model.get(i).name + ":" + model.get(i).value )
    }

    Component {
        id: listDelegate

        Item {
            id: item
            width: parent.width; height: slider.height + label.height
            Label {
                id: label
                text: model.name +":" +  model.value.toFixed(3)
            }

            Slider  {
                id:slider
                width: parent.width
                value: model.value
                from: 0 ; to : 1.0;
                stepSize: 0.001
                anchors.bottom: parent.bottom
                onVisualPositionChanged:  model.value = visualPosition;
            }
        }
    }

    delegate: listDelegate
}
