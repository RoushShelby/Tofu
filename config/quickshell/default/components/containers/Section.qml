import QtQuick
import "../../theme"

/*
 * Section Component
 * 
 * Purpose: Pre-styled bar section with background and spacing
 * 
 * Properties:
 *   - spacing (int): Space between items (default: 5)
 *   - padding (int): Inner padding (default: 7)
 *   - radius (int): Corner radius (default: 10)
 * 
 * Visual Style:
 *   - 60% transparent background
 *   - Subtle border for depth
 *   - Consistent with main bar design
 * 
 * Example:
 *   Section {
 *       IconButton { icon: "󰂯" }
 *       Clock {}
 *       Badge { count: 5 }
 *   }
 */

Rectangle {
    id: root
    
    property int spacing: 5
    property int padding: 7
    
    implicitWidth: layout.implicitWidth + padding * 2
    implicitHeight: 32
    radius: 10
    color: Qt.rgba(Colors.background.r, Colors.background.g, Colors.background.b, 0.6)
    
    // Subtle shadow effect
    Rectangle {
        anchors.fill: parent
        anchors.margins: -1
        radius: parent.radius + 1
        color: "transparent"
        border.width: 1
        border.color: Qt.rgba(0, 0, 0, 0.2)
        z: -1
    }
    
    Rectangle {
        anchors.fill: parent
        anchors.margins: -2
        radius: parent.radius + 2
        color: "transparent"
        border.width: 1
        border.color: Qt.rgba(0, 0, 0, 0.1)
        z: -2
    }
    
    Row {
        id: layout
        anchors.centerIn: parent
        spacing: root.spacing
        
        Component.onCompleted: {
            for (var i = 0; i < root.children.length; i++) {
                var child = root.children[i]
                if (child !== layout && !child.toString().includes("Rectangle")) {
                    child.parent = layout
                }
            }
        }
    }
}