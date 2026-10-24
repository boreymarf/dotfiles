import QtQuick
import QtQuick.Controls
import Quickshell
import "root:/configuration"
import "root:/data"
import "root:/modules/base"
import "root:/modules/popups"

Item {
    id: "root"

    function onClick() {
        console.log("Click!");
        popup.visible = !popup.visible
    }

    implicitHeight: FontConf.charHeight
    implicitWidth: FontConf.charWidth

    AbstractButton {
        anchors.fill: parent
        onClicked: onClick()

        Text {
            text: IconsConf.iconMenu
            font: FontConf.font
            color: Colors.mainColor
        }

    }

    // Popup
    MenuPopup {
        id: popup

        targetItem: root
        visible: false
    }

}
