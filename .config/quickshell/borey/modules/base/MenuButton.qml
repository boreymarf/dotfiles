import QtQuick
import QtQuick.Controls
import Quickshell
import "root:/configuration"

Item {
    id: "root"

    property string label
    property var onClick: null

    height: 60
    width: 60

    Rectangle {
        anchors.fill: parent
        color: Colors.secondaryColor

        Text {
            text: root.label
            font: FontConf.font
            color: Colors.fontColor
        }

        AbstractButton {
            onClicked: root.onClick()
            anchors.fill: parent
        }

    }

}
