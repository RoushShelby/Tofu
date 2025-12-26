import QtQuick
import Quickshell
import "../theme"

Item {
    width: notificationText.width + 10
    height: 16
    
    Text {
        id: notificationText
        anchors.centerIn: parent
        text: ""
        color: Colors.foreground
        font.family: "CodeNewRoman Nerd Font Propo"
        font.pixelSize: 15
        
        Behavior on color {
            ColorAnimation { duration: 300; easing.type: Easing.InOutQuad }
        }
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        
        onClicked: {
            // Toggle SwayNC
            Process.run("swaync-client", ["-t", "-sw"])
        }
        
        onEntered: {
            notificationText.color = Colors.accent
        }
        
        onExited: {
            notificationText.color = Colors.foreground
        }
    }
}