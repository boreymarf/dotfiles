import QtQuick
import Quickshell
import "root:/configuration"
import "root:/data"
import "root:/modules/base"

PopupWindow {
    id: root

    property var targetItem: null

    color: Colors.popupBgColor
    implicitHeight: 400
    implicitWidth: 400

    anchor {
        item: targetItem
        edges: Edges.Bottom
        gravity: Edges.Bottom
        margins.top: 15
    }

    Column {

        Rectangle {
            color: Colors.popupBgColor
            width: 50
            height: 100

            ShaderEffect {
                anchors.fill: parent
                vertexShader: "root:/shaders/noise.vert.qsb"
                fragmentShader: "root:/shaders/noise.frag.qsb"

                property int fill: System.memoryUsedPercent
                // property int fill: 10
                property int seed: 12345
                property color noiseColor: "white"
                property real noiseScale: 16
                property real aspect: parent.width / parent.height 
            }
        }

    }

}
