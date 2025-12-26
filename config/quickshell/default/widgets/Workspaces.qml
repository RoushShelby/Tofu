import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../theme"

Rectangle {
    id: workspacesContainer
    width: workspacesRow.implicitWidth + 16
    height: 24
    radius: 12
    color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
    border.width: 1
    border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
    
    Row {
        id: workspacesRow
        anchors.centerIn: parent
        spacing: 6
        
        Repeater {
            model: Hyprland.workspaces
            
            delegate: Rectangle {
                required property HyprlandWorkspace modelData
                
                width: 16
                height: 16
                radius: 8
                
                property bool isEmpty: modelData.toplevels.length === 0
                property bool isActive: modelData.focused || modelData.active
                
                color: {
                    if (isActive) return Colors.accent
                    if (isEmpty) return "transparent"
                    return Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.4)
                }
                
                border.width: isEmpty ? 1 : 0
                border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.3)
                
                Behavior on color {
                    ColorAnimation { duration: 200 }
                }
                
                Behavior on border.color {
                    ColorAnimation { duration: 200 }
                }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Hyprland.dispatch("workspace", modelData.id.toString())
                    
                    onEntered: {
                        if (!parent.isActive) {
                            parent.color = Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.6)
                        }
                    }
                    
                    onExited: {
                        if (!parent.isActive) {
                            if (parent.isEmpty) {
                                parent.color = "transparent"
                            } else {
                                parent.color = Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.4)
                            }
                        }
                    }
                }
            }
        }
    }
}