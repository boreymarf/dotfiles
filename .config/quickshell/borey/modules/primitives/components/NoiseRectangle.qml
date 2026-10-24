import QtQuick
import Quickshell
import "root:/configuration"
import "root:/data"


Item {
	id: root
	implicitHeight: 100
	implicitWidth: 50

	property int fill: 0
	property int seed: 0
	property color noiseColor: "white"
	property real noiseScale: 16

	Rectangle {
		color: Colors.popupBgColor
		width: root.width
		height: root.height

		ShaderEffect {
			anchors.fill: parent
			vertexShader: "root:/shaders/noise.vert.qsb"
			fragmentShader: "root:/shaders/noise.frag.qsb"

			// property int fill: System.memoryUsedPercent
			property int fill: root.fill
			property int seed: root.seed
			property color noiseColor: root.noiseColor
			property real noiseScale: root.noiseScale
			property real aspect: parent.width / parent.height 
		}
	}
}
