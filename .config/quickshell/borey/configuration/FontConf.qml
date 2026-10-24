import QtQuick
pragma Singleton

QtObject {
    id: root

    // Actual configuration
    readonly property font font: Qt.font({
        "family": "CaskaydiaMono Nerd Font",
        "pixelSize": 12
    })

    // Some readonly variables
    readonly property FontMetrics
    metrics: FontMetrics {
        font: root.font
    }

    readonly property real charHeight: font.pixelSize
    readonly property real charWidth: metrics.maximumCharacterWidth
}
