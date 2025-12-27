import QtQuick
import "../../theme"

/*
 * Toggle Component
 * 
 * Purpose: On/off switch for binary states
 * 
 * Properties:
 *   - checked (bool): Toggle state (default: false)
 *   - enabled (bool): Whether toggle is interactive (default: true)
 *   - width (int): Toggle width (default: 44)
 *   - height (int): Toggle height (default: 24)
 *   - thumbSize (int): Thumb diameter (default: 20)
 *   - onColor (color): Background when on (default: Colors.accent)
 *   - offColor (color): Background when off (default: Colors.surface @ 50%)
 *   - thumbColor (color): Thumb color (default: Colors.background)
 * 
 * Signals:
 *   - toggled(bool checked): Emitted when state changes
 * 
 * Example:
 *   Toggle {
 *       checked: bluetoothEnabled
 *       onToggled: (checked) => { bluetoothEnabled = checked }
 *   }
 */

Item {
    id: root
    
    property bool checked: false
    property bool enabled: true
    property int thumbSize: 20
    property color onColor: Colors.accent
    property color offColor: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.5)
    property color thumbColor: Colors.background
    
    signal toggled(bool checked)
    
    width: 44
    height: 24
    
    Rectangle {
        id: track
        anchors.fill: parent
        radius: height / 2
        color: root.checked ? root.onColor : root.offColor
        opacity: root.enabled ? 1.0 : 0.5
        
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
    }
    
    Rectangle {
        id: thumb
        width: thumbSize
        height: thumbSize
        radius: thumbSize / 2
        color: thumbColor
        x: root.checked ? parent.width - width - 2 : 2
        anchors.verticalCenter: parent.verticalCenter
        
        Behavior on x {
            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
        
        // Subtle shadow
        Rectangle {
            anchors.fill: parent
            anchors.margins: -1
            radius: parent.radius + 1
            color: "transparent"
            border.width: 1
            border.color: Qt.rgba(0, 0, 0, 0.2)
            z: -1
        }
    }
    
    MouseArea {
        anchors.fill: parent
        enabled: root.enabled
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        
        onClicked: {
            root.checked = !root.checked
            root.toggled(root.checked)
        }
    }
}