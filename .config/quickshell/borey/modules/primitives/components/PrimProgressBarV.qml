import QtQuick
import Quickshell
import "root:/configuration"
import "root:/data"

Item {
    id: root

    property int percent: 0

    implicitHeight: 15
    implicitWidth: FontConf.charWidth

    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 1
        anchors.bottomMargin: 1
        color: Colors.secondaryColor
    }

    Rectangle {
        color: Colors.mainColor
        height: root.height * (percent / 100)

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            bottomMargin: 1
        }

    }

}
