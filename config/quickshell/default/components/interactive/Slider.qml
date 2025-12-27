import QtQuick
import "../../theme"

/*
 * Slider Component
 * 
 * Purpose: Value slider for continuous ranges (volume, brightness, etc.)
 * 
 * Properties:
 *   - value (real): Current value (default: 0)
 *   - from (real): Minimum value (default: 0)
 *   - to (real): Maximum value (default: 100)
 *   - stepSize (real): Step increment (default: 1)
 *   - enabled (bool): Whether interactive (default: true)
 *   - width (int): Slider width (default: 200)
 *   - height (int): Slider height (default: 24)
 *   - trackHeight (int): Track thickness (default: 4)
 *   - thumbSize (int): Thumb diameter (default: 16)
 *   - trackColor (color): Unfilled track color (default: Colors.surface @ 50%)
 *   - progressColor (color): Filled track color (default: Colors.accent)
 *   - thumbColor (color): Thumb color (default: Colors.accent)
 * 
 * Signals:
 *   - moved(real value): Emitted while dragging
 *   - valueModified(real value): Emitted when dragging ends
 * 
 * Example:
 *   Slider {
 *       value: volume
 *       from: 0
 *       to: 100
 *       onValueModified: (val) => { volume = val }
 *   }
 */

Item {
    id: root
    
    property real value: 0
    property real from: 0
    property real to: 100
    property real stepSize: 1
    property bool enabled: true
    property int trackHeight: 4
    property int thumbSize: 16
    property color trackColor: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.5)
    property color progressColor: Colors.accent
    property color thumbColor: Colors.accent
    
    signal moved(real value)
    signal valueModified(real value)
    
    width: 200
    height: 24
    
    // Ensure value is within range
    onValueChanged: {
        if (value < from) value = from
        if (value > to) value = to
    }
    
    // Background track
    Rectangle {
        id: track
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: trackHeight
        radius: trackHeight / 2
        color: trackColor
        opacity: root.enabled ? 1.0 : 0.5
    }
    
    // Progress track
    Rectangle {
        id: progress
        anchors.left: track.left
        anchors.verticalCenter: track.verticalCenter
        width: thumb.x + thumb.width / 2
        height: trackHeight
        radius: trackHeight / 2
        color: progressColor
        opacity: root.enabled ? 1.0 : 0.5
    }
    
    // Thumb
    Rectangle {
        id: thumb
        width: thumbSize
        height: thumbSize
        radius: thumbSize / 2
        color: thumbColor
        opacity: root.enabled ? 1.0 : 0.5
        x: ((root.value - root.from) / (root.to - root.from)) * (root.width - width)
        anchors.verticalCenter: parent.verticalCenter
        scale: mouseArea.pressed ? 1.1 : 1.0
        
        Behavior on scale {
            NumberAnimation { duration: 100 }
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
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
        cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        
        property real pressValue: 0
        
        function updateValue(mouse) {
            let ratio = Math.max(0, Math.min(1, mouse.x / width))
            let newValue = root.from + ratio * (root.to - root.from)
            
            // Apply step size
            if (root.stepSize > 0) {
                newValue = Math.round(newValue / root.stepSize) * root.stepSize
            }
            
            root.value = newValue
        }
        
        onPressed: (mouse) => {
            pressValue = root.value
            updateValue(mouse)
            root.moved(root.value)
        }
        
        onPositionChanged: (mouse) => {
            if (pressed) {
                updateValue(mouse)
                root.moved(root.value)
            }
        }
        
        onReleased: {
            if (root.value !== pressValue) {
                root.valueModified(root.value)
            }
        }
    }
}