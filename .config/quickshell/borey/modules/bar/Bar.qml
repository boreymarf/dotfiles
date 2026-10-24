import QtQuick
import Quickshell
import "root:/configuration"
import "root:/data"
import "root:/modules/bar/components"

Scope {
    // This component copies bar to every screen
    Variants {
        model: Quickshell.screens

        delegate: Component {
            id: "root"

            PanelWindow {
                required property var modelData

                screen: modelData
                implicitHeight: FontConf.charHeight
                color: "transparent"

                // Put bar at the top
                anchors {
                    top: true
                    left: true
                    right: true
                    bottom: false
                }

                // Left side
                Row {
                    anchors.left: parent.left
                }

                // Center
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // Right side
                Row {
                    anchors.right: parent.right
                    spacing: 15

                    MemoryWidget {
                        height: root.height
                    }

                    CPUWidget {
                        height: root.height
                    }

                    BatteryWidget {
                        height: root.height
                    }

                    ClockWidget {
                        height: root.height
                    }

                    MenuWidget {
                        height: root.height
                    }

                }

            }

        }

    }

}
