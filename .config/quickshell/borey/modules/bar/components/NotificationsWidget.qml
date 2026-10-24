import QtQuick
import QtQuick.Controls
import Quickshell
import "root:/configuration"
import "root:/data"
import "root:/modules/base"
import "root:/modules/popups"

Item {
    id: "root"

    implicitHeight: FontConf.charHeight
    implicitWidth: FontConf.charWidth

    AbstractButton {
        anchors.fill: parent

        Text {
            text: IconsConf.iconBell
            font: FontConf.font
            color: Colors.mainColor
        }

    }

}
