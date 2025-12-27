import QtQuick
import "../../theme"

/*
 * Glow Effect Wrapper
 * 
 * Purpose: Hover glow effect for attention-grabbing interactions
 * 
 * Properties:
 *   - glowColor (color): Glow color (default: Colors.accent)
 *   - glowRadius (int): Glow spread (default: 8)
 *   - glowOpacity (real): Maximum glow opacity (default: 0.5)
 *   - duration (int): Transition duration (default: 200)
 *   - trigger (bool): Force glow on/off, overrides hover (default: null)
 * 
 * Example:
 *   Glow {
 *       glowColor: Colors.accent
 *       glowRadius: 12
 *       
 *       Rectangle {
 *           width: 100
 *           height: 100
 *           color: "blue"
 *       }
 *   }
 * 
 *   Glow {
 *       trigger: isActive
 *       glowColor: "#f53c3c"
 *       
 *       IconButton { icon: "" }
 *   }
 */

Item {
    id: root
    
    property color glowColor: Colors.accent
    property int glowRadius: 8
    property real glowOpacity: 0.5
    property int duration: 200
    property var trigger: null  // null = use hover, true/false = force state
    
    default property alias content: container.data
    
    implicitWidth: container.implicitWidth
    implicitHeight: container.implicitHeight
    
    property bool isGlowing: trigger !== null ? trigger : mouseArea.containsMouse
    
    // Glow layers
    Repeater {
        model: 3
        
        Rectangle {
            anchors.fill: parent
            anchors.margins: -(glowRadius - index * 3)
            radius: glowRadius - index * 2
            color: "transparent"
            border.width: 2
            border.color: root.glowColor
            opacity: isGlowing ? (root.glowOpacity * (1 - index * 0.3)) : 0
            z: -1
            
            Behavior on opacity {
                NumberAnimation { duration: root.duration }
            }
        }
    }
    
    Item {
        id: container
        anchors.fill: parent
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: trigger === null
        propagateComposedEvents: true
        
        onPressed: (mouse) => mouse.accepted = false
        onReleased: (mouse) => mouse.accepted = false
        onClicked: (mouse) => mouse.accepted = false
    }
}