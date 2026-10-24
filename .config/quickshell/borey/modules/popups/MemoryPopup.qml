import QtQuick
import Quickshell
import "root:/configuration"
import "root:/data"

import "root:/modules/primitives/components"

PopupWindow {
    implicitWidth: 200
    implicitHeight: 150

    id: root

    property var targetItem: null

    anchor {
        item: targetItem
        edges: Edges.Bottom
        gravity: Edges.Bottom
        margins.top: 15
    }


    // Content
    Rectangle {
        anchors.fill: parent
        color: Colors.popupBgColor

        Column {

            Text {
                text: `${System.memoryUsed} / ${System.memoryTotal} kB`
                color: Colors.fontColor
                font: FontConf.font
            }

            Text {
                text: `${System.memoryUsedPercent}\%`
                color: Colors.fontColor
                font: FontConf.font
            }

            NoiseRectangle {
                fill: System.memoryUsedPercent
                seed: 0
                noiseColor: "white"
                noiseScale: 30
                height: 60
                width: 40
            }
        }


    }

}
