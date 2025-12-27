import QtQuick
import "../../theme"

/*
 * IconButtonBadge Component
 * 
 * Purpose: IconButton with an optional badge overlay (common pattern)
 * 
 * Properties:
 *   - icon (string): Nerd Font icon character (required)
 *   - iconSize (int): Icon font size (default: 15)
 *   - buttonWidth (int): Button width (default: 24)
 *   - buttonHeight (int): Button height (default: 24)
 *   - showBackground (bool): Show button background on hover (default: false)
 *   - count (int): Badge count (default: 0, badge hidden when 0)
 *   - badgeColor (color): Badge color (default: Colors.accent)
 *   - badgeSize (int): Badge diameter (default: 16)
 *   - badgeOffsetX (int): Badge X offset from top-right (default: -4)
 *   - badgeOffsetY (int): Badge Y offset from top-right (default: -4)
 * 
 * Signals:
 *   - clicked(): Emitted when button is clicked
 * 
 * Example:
 *   IconButtonBadge {
 *       icon: ""
 *       buttonWidth: 28
 *       buttonHeight: 28
 *       count: 5
 *       onClicked: openNotifications()
 *   }
 */

Item {
    id: root
    
    property string icon: ""
    property int iconSize: 15
    property int buttonWidth: 24
    property int buttonHeight: 24
    property bool showBackground: false
    property int count: 0
    property color badgeColor: Colors.accent
    property int badgeSize: 16
    property int badgeOffsetX: -4
    property int badgeOffsetY: -4
    
    signal clicked()
    
    width: buttonWidth
    height: buttonHeight
    
    IconButton {
        id: button
        anchors.fill: parent
        icon: root.icon
        iconSize: root.iconSize
        showBackground: root.showBackground
        onClicked: root.clicked()
    }
    
    Badge {
        id: badge
        count: root.count
        badgeColor: root.badgeColor
        size: badgeSize
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: badgeOffsetY
        anchors.rightMargin: badgeOffsetX
        z: 1
    }
}