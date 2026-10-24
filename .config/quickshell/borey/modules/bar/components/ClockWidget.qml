import QtQuick
import Quickshell
import "root:/configuration"
import "root:/data"
import "root:/modules/popups"

Item {
    id: "root"

    implicitWidth: text.width
    implicitHeight: FontConf.charHeight

    Text {
        id: "text"

        color: Colors.fontColor
        text: Date.time
        font: FontConf.font
    }

    // Popup
    ClockPopup {
        id: popup

        targetItem: root
        visible: false
    }

    // Popup area
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            popup.visible = true;
        }
        onExited: {
            if (!popup.containsMouse)
                popup.visible = false;

        }
        onClicked: {
            popup.visible = !popup.visible;
        }
    }

}
