import QtQuick
import "../../theme"

/*
 * Badge Component
 * 
 * Purpose: Small circular badge for displaying counts/notifications
 * 
 * Properties:
 *   - count (int): Number to display (required)
 *   - maxCount (int): Maximum number before showing "+" (default: 99)
 *   - badgeColor (color): Badge background color (default: Colors.accent)
 *   - textColor (color): Text color (default: Colors.background)
 *   - size (int): Badge diameter (default: auto-size based on content)
 *   - fontSize (int): Text font size (default: 10)
 * 
 * Behavior:
 *   - Shows number if count <= maxCount
 *   - Shows "maxCount+" if count > maxCount (e.g., "99+")
 *   - Auto-sizes to fit content or uses specified size
 *   - Perfect circle when single digit
 *   - Pill shape when multiple digits
 * 
 * Example:
 *   Badge {
 *       count: 5
 *       size: 18
 *   }
 * 
 *   Badge {
 *       count: 150
 *       maxCount: 99
 *       badgeColor: "#f53c3c"
 *   }
 */

Rectangle {
    id: root
    
    property int count: 0
    property int maxCount: 99
    property color badgeColor: Colors.accent
    property color textColor: Colors.background
    property int size: 0  // 0 means auto-size
    property int fontSize: 10
    
    width: size > 0 ? size : Math.max(16, badgeText.implicitWidth + 8)
    height: size > 0 ? size : 16
    radius: height / 2
    color: badgeColor
    
    visible: count > 0
    
    Text {
        id: badgeText
        anchors.centerIn: parent
        text: count > maxCount ? maxCount + "+" : count
        font.family: "CodeNewRoman Nerd Font Propo"
        font.pixelSize: fontSize
        font.bold: true
        color: textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
    
    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: "transparent"
        border.width: 1
        border.color: Qt.rgba(0, 0, 0, 0.2)
    }
}