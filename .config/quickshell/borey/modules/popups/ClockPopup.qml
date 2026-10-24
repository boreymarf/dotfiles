import QtQuick
import Quickshell
import "root:/configuration"
import "root:/data"

PopupWindow {
    id: root

    property var targetItem: null

    anchor {
        item: targetItem
        edges: Edges.Bottom
        gravity: Edges.Bottom
        margins.top: 15
    }

    Rectangle {
        anchors.fill: parent
        color: Colors.popupBgColor

        Text {
          text: Date.date
          color: Colors.fontColor
          font: FontConf.font
        }
    }

}
