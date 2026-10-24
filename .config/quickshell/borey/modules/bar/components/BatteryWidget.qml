import QtQuick
import QtQuick.Controls
import Quickshell
import "root:/configuration"
import "root:/data"
import "root:/modules/base"
import "root:/modules/popups"

import "root:/modules/primitives/components"

Item {
    id: "root"

    implicitWidth: 70
    implicitHeight: FontConf.charHeight

    // Contents
    Row {
        spacing: FontConf.charWidth

        Text {
            text: "BAT"
            color: Colors.fontColor
            font: FontConf.font
        }

        PrimProgressBarH {
            percent: System.batteryPercent
        }

    }

    // Popup
    BatteryPopup {
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
