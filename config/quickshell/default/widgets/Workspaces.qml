import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../theme"

Row {
    spacing: 4
    
    Repeater {
        model: Hyprland.workspaces
        
        delegate: Rectangle {
            required property HyprlandWorkspace modelData
            
            width: 24
            height: 16
            radius: 8
            
            color: {
                if (modelData.focused) return Colors.accent
                if (modelData.active) return Colors.surfaceVariant
                if (modelData.toplevels.length > 0) return Colors.surface
                return "transparent"
            }
            
            border.width: modelData.toplevels.length > 0 ? 0 : 1
            border.color: Colors.surfaceVariant
            
            Text {
                anchors.centerIn: parent
                text: modelData.id
                color: modelData.focused ? Colors.background : Colors.foreground
                font.pixelSize: 10
                font.weight: Font.Medium
            }
            
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace", modelData.id.toString())
            }
        }
    }
}