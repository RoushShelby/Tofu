import QtQuick
import Quickshell
import "../theme"

Item {
    id: root
    // Sizing matches Workspaces.qml/Clock.qml style
    width: buttonText.implicitWidth + 24
    height: 24

    // The Popup Window
    PanelWindow {
        id: popup
        visible: false
        width: 165
        height: 60
        
        // Use a transparent background for the window so the Rectangle handles the styling
        color: "transparent" 

        Rectangle {
            anchors.fill: parent
            radius: 12
            color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.9)
            border.width: 1
            border.color: Colors.accent

            Text {
                anchors.centerIn: parent
                text: "Welcome to Tofu"
                color: Colors.foreground
                font.family: "CodeNewRoman Nerd Font Propo"
                font.pixelSize: 16
            }
        }
    }

    // The Button on the Bar
    Rectangle {
        anchors.fill: parent
        radius: 12
        
        // Styling matches Workspaces.qml [cite: 1, 5]
        color: popup.visible 
               ? Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.4) 
               : Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
        
        border.width: 1
        border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)

        Text {
            id: buttonText
            anchors.centerIn: parent
            text: "Tofu"
            color: Colors.foreground
            font.family: "CodeNewRoman Nerd Font Propo"
            font.pixelSize: 14
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: popup.visible = !popup.visible
            
            // Simple hover effect
            onEntered: parent.border.color = Colors.accent
            onExited: parent.border.color = Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
        }
        
        // Smooth color transition like in Workspaces.qml [cite: 6]
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
}