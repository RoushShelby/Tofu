import QtQuick
import Quickshell.Hyprland
import "../components/containers" as Containers
import "../theme"

Containers.Section {
    spacing: 4
    
    property bool showEmpty: true
    
    readonly property int maxWorkspaceId: {
        let max = 0;
        for (let i = 0; i < Hyprland.workspaces.values.length; i++) {
            if (Hyprland.workspaces.values[i].id > max) {
                max = Hyprland.workspaces.values[i].id;
            }
        }
        return Math.max(max, 1);
    }
    
    Repeater {
        model: maxWorkspaceId
        
        delegate: Rectangle {
            property int workspaceId: index + 1
            property var workspace: getWorkspace(workspaceId)
            property bool exists: workspace !== null
            property bool isEmpty: !exists || workspace.toplevels.length === 0
            property bool isActive: exists && (workspace.focused || workspace.active)
            
            visible: showEmpty || !isEmpty
            
            width: isActive ? 24 : 16
            height: 16
            radius: 8
            
            color: {
                if (isActive) return Colors.accent
                if (isEmpty) return "transparent"
                return Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.4)
            }
            
            border.width: isEmpty ? 1 : 0
            border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.3)
            
            Behavior on color { ColorAnimation { duration: 200 } }
            Behavior on border.color { ColorAnimation { duration: 200 } }
            Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
            
            Text {
                visible: parent.isActive && parent.width > 18
                anchors.centerIn: parent
                text: workspaceId
                font.family: "CodeNewRoman Nerd Font Propo"
                font.pixelSize: 10
                font.bold: true
                color: Colors.background
            }
            
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("workspace", workspaceId.toString())
                
                onEntered: {
                    if (!parent.isActive) {
                        parent.color = Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.6)
                    }
                }
                
                onExited: {
                    if (!parent.isActive) {
                        parent.color = parent.isEmpty ? "transparent" 
                            : Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.4)
                    }
                }
            }
        }
    }
    
    function getWorkspace(id) {
        for (let i = 0; i < Hyprland.workspaces.values.length; i++) {
            if (Hyprland.workspaces.values[i].id === id) {
                return Hyprland.workspaces.values[i];
            }
        }
        return null;
    }
}