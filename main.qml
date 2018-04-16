import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.0



ApplicationWindow
{

    width: 800
    height: 600

    Pane
    {
        id: main;
        anchors.fill: parent;
    }

    PropertyPanel
    {
        id: panel
        height: main.height
        anchors.right: main.right

        onCurrentItemChanged:
        {
            gridModel.get(grid.currentIndex).name = currentItem.name;
            gridModel.get(grid.currentIndex).item = currentItem.item;
        }
    }

    Drawer {
        id: drawer
        width: 200
        height: main.height
        visible: false
    }


    GridView
    {
        id: grid;
        property int columns : panel.columns
        property real factor: 3/4;
        property Item selectedItem ;
        cacheBuffer: 200
        displayMarginBeginning: 100;
        displayMarginEnd: 100;

        cellWidth:  width / columns;
        cellHeight: cellWidth * factor

        anchors.left: main.left
        anchors.right: panel.left;
        anchors.top : main.top
        anchors.bottom: main.bottom;
        property var table;

        delegate: GridDelegate{

            width:grid.cellWidth -1 ;
            height: grid.cellHeight -1
            onClicked: {
                            grid.currentIndex = index;
                            panel.setCurrentItem(this);
                        }
            source: "Effects/Effect.qml"

        }


        model: ListModel {
            id: gridModel ;
            function newItem() {  append({"name":"N/A", "item":"{}"}); }
            function delCurrent() { remove(grid.currentIndex, 1 ) }


        }



    }



}
