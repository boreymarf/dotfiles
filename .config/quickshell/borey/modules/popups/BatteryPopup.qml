import QtQuick
import Quickshell
import "root:/configuration"
import "root:/data"
import "root:/modules/base"


import "root:/modules/primitives/components"

PopupWindow {
    id: root

    property var targetItem: null


    // Properties
    implicitWidth: 200
    implicitHeight: 150
    color: Colors.popupBgColor

    anchor {
        item: targetItem
        edges: Edges.Bottom
        gravity: Edges.Bottom
        margins.top: 15
    }


    // Content
    Column {
        anchors.fill: parent

    }

}
