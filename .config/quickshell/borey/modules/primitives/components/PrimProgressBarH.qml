import QtQuick
import Quickshell
import "root:/configuration"
import "root:/data"

Item {
    id: root

    property int percent: 0

    implicitHeight: 15
    implicitWidth: FontConf.charWidth * 5

    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 1
        anchors.bottomMargin: 1
        color: Colors.secondaryColor
    }

    Rectangle {
        color: Colors.mainColor
        width: root.width * (percent / 100)

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            bottomMargin: 1
        }

    }

}
