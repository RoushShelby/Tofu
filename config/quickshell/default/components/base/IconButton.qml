import QtQuick
import "../../theme"

/*
 * IconButton Component
 * 
 * Purpose: Clickable icon with hover effects and precise sizing
 * 
 * Properties:
 *   - icon (string): Nerd Font icon character (required)
 *   - iconSize (int): Icon font size in pixels (default: 15)
 *   - width (int): Exact button width (default: auto-size)
 *   - height (int): Exact button height (default: auto-size)
 *   - showBackground (bool): Show background on hover (default: false)
 *   - radius (int): Corner radius (default: 4)
 * 
 * Signals:
 *   - clicked(): Emitted when button is clicked
 * 
 * States:
 *   - Normal: foreground color
 *   - Hover: accent color, optional background highlight
 * 
 * Example:
 *   IconButton {
 *       icon: "󰂯"
 *       iconSize: 16
 *       width: 24
 *       height: 24
 *       onClicked: console.log("Clicked!")
 *   }
 */

Item {
    id: root
    
    property string icon: ""
    property int iconSize: 15
    property bool showBackground: false
    property int radius: 4
    
    signal clicked()
    
    // Auto-size if not specified
    implicitWidth: iconSize + 10
    implicitHeight: iconSize + 10
    
    property bool hovered: false
    
    Rectangle {
        id: background
        anchors.fill: parent
        radius: root.radius
        visible: showBackground
        color: hovered 
            ? Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
            : "transparent"
        
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
    
    Text {
        id: iconText
        anchors.centerIn: parent
        text: icon
        font.family: "CodeNewRoman Nerd Font Propo"
        font.pixelSize: iconSize
        color: hovered ? Colors.accent : Colors.foreground
        
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: root.clicked()
    }
}