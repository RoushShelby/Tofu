import QtQuick
import "../theme"

Rectangle {
    width: 200
    height: 16
    color: Colors.surface
    radius: 4
    
    Text {
        anchors.centerIn: parent
        text: "System Info"
        color: Colors.foreground
        font.pixelSize: 12
    }
}