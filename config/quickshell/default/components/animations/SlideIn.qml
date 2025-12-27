import QtQuick

/*
 * SlideIn Animation Wrapper
 * 
 * Purpose: Position animation for drawer/menu transitions
 * 
 * Properties:
 *   - direction (string): "left", "right", "up", "down" (default: "left")
 *   - distance (int): Slide distance in pixels (default: 100)
 *   - duration (int): Animation duration in ms (default: 300)
 *   - delay (int): Delay before animation starts (default: 0)
 *   - easing (var): Easing curve (default: Easing.OutQuad)
 *   - trigger (bool): When true, shows content; when false, hides (default: true)
 * 
 * Example:
 *   SlideIn {
 *       direction: "left"
 *       distance: 200
 *       duration: 400
 *       trigger: drawerOpen
 *       
 *       Rectangle {
 *           width: 200
 *           height: 300
 *           color: "blue"
 *       }
 *   }
 */

Item {
    id: root
    
    property string direction: "left"
    property int distance: 100
    property int duration: 300
    property int delay: 0
    property var easing: Easing.OutQuad
    property bool trigger: true
    
    default property alias content: container.data
    
    implicitWidth: container.implicitWidth
    implicitHeight: container.implicitHeight
    
    Item {
        id: container
        anchors.fill: parent
        
        transform: Translate {
            x: {
                if (!root.trigger) {
                    if (root.direction === "left") return -root.distance
                    if (root.direction === "right") return root.distance
                }
                return 0
            }
            
            y: {
                if (!root.trigger) {
                    if (root.direction === "up") return -root.distance
                    if (root.direction === "down") return root.distance
                }
                return 0
            }
            
            Behavior on x {
                SequentialAnimation {
                    PauseAnimation { duration: root.delay }
                    NumberAnimation { 
                        duration: root.duration
                        easing.type: root.easing
                    }
                }
            }
            
            Behavior on y {
                SequentialAnimation {
                    PauseAnimation { duration: root.delay }
                    NumberAnimation { 
                        duration: root.duration
                        easing.type: root.easing
                    }
                }
            }
        }
    }
}