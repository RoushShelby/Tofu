import QtQuick
import "../../theme"

/*
 * ProgressBar Component
 * 
 * Purpose: Progress indicator for loading, battery, CPU usage, etc.
 * 
 * Properties:
 *   - value (real): Current value (default: 0)
 *   - from (real): Minimum value (default: 0)
 *   - to (real): Maximum value (default: 100)
 *   - orientation (string): "horizontal" or "vertical" (default: "horizontal")
 *   - width (int): Bar width (default: 200 horizontal, 24 vertical)
 *   - height (int): Bar height (default: 8 horizontal, 100 vertical)
 *   - trackColor (color): Background color (default: Colors.surface @ 30%)
 *   - progressColor (color): Progress color (default: Colors.accent)
 *   - showText (bool): Show percentage text (default: false)
 *   - textColor (color): Text color (default: Colors.foreground)
 *   - radius (int): Corner radius (default: height/2 for horizontal, width/2 for vertical)
 * 
 * Color Thresholds (optional):
 *   - lowThreshold (real): Value below which uses lowColor (default: 20)
 *   - mediumThreshold (real): Value below which uses mediumColor (default: 50)
 *   - lowColor (color): Color for low values (default: "#f53c3c")
 *   - mediumColor (color): Color for medium values (default: "#ffbe61")
 *   - highColor (color): Color for high values (default: Colors.accent)
 *   - useThresholds (bool): Enable color thresholds (default: false)
 * 
 * Example:
 *   ProgressBar {
 *       value: batteryLevel
 *       from: 0
 *       to: 100
 *       useThresholds: true
 *       showText: true
 *   }
 */

Item {
    id: root
    
    property real value: 0
    property real from: 0
    property real to: 100
    property string orientation: "horizontal"
    property color trackColor: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
    property color progressColor: Colors.accent
    property bool showText: false
    property color textColor: Colors.foreground
    property int radius: orientation === "horizontal" ? height / 2 : width / 2
    
    // Threshold colors
    property real lowThreshold: 20
    property real mediumThreshold: 50
    property color lowColor: "#f53c3c"
    property color mediumColor: "#ffbe61"
    property color highColor: Colors.accent
    property bool useThresholds: false
    
    width: orientation === "horizontal" ? 200 : 24
    height: orientation === "horizontal" ? 8 : 100
    
    // Calculate percentage
    readonly property real percentage: ((value - from) / (to - from)) * 100
    
    // Get color based on thresholds
    function getProgressColor() {
        if (!useThresholds) return progressColor
        if (percentage < lowThreshold) return lowColor
        if (percentage < mediumThreshold) return mediumColor
        return highColor
    }
    
    Rectangle {
        id: track
        anchors.fill: parent
        radius: root.radius
        color: trackColor
        
        Rectangle {
            id: progress
            radius: root.radius
            color: root.getProgressColor()
            
            width: orientation === "horizontal" 
                ? (root.percentage / 100) * parent.width 
                : parent.width
            height: orientation === "horizontal" 
                ? parent.height 
                : (root.percentage / 100) * parent.height
            
            anchors.left: orientation === "horizontal" ? parent.left : undefined
            anchors.bottom: orientation === "vertical" ? parent.bottom : undefined
            
            Behavior on color {
                ColorAnimation { duration: 200 }
            }
            
            Behavior on width {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
            }
            
            Behavior on height {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
            }
        }
    }
    
    Text {
        visible: showText && orientation === "horizontal"
        anchors.centerIn: parent
        text: Math.round(root.percentage) + "%"
        font.pixelSize: 10
        font.bold: true
        color: textColor
    }
}