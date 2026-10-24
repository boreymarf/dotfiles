import QtQuick
import Quickshell
import "root:/configuration"
import "root:/data"
import "root:/modules/base"

import "root:/modules/primitives/components"

PopupWindow {
    id: root

    property var targetItem: null

    // Обновление модели из массива
    function updateCoreModel(cores) {
        coreModel.clear();
        for (var i = 0; i < cores.length; i++) {
            coreModel.append({
                "percent": cores[i]
            });
        }
    }

    // Properties
    implicitWidth: 200
    implicitHeight: 150
    color: Colors.popupBgColor

    anchor {
        item: targetItem
        edges: Edges.Bottom
        gravity: Edges.Bottom
        margins.top: 15
    }

    // Models for cores
    ListModel {
        id: coreModel
    }

    Connections {
        function onCpuCoreUsedPercentChanged() {
            updateCoreModel(System.cpuCoreUsedPercent);
        }

        target: System
    }

    // Content
    Column {
        anchors.fill: parent

        // Total percent
        Text {
            font: FontConf.font
            text: System.cpuUsedPercent
            color: Colors.fontColor
        }

        // Cores
        Grid {
            spacing: 4
            columns: 4

            Repeater {
                model: coreModel

                PrimProgressBarV {
                    percent: model.percent
                    height: 30
                    width: 30
                }

            }

        }

    }

}
