import QtQuick

/*
 * FadeIn Animation Wrapper
 * 
 * Purpose: Opacity animation for smooth appearance transitions
 * 
 * Properties:
 *   - duration (int): Animation duration in ms (default: 300)
 *   - delay (int): Delay before animation starts (default: 0)
 *   - easing (var): Easing curve (default: Easing.OutQuad)
 *   - trigger (bool): When true, runs animation (default: true)
 *   - from (real): Starting opacity (default: 0)
 *   - to (real): Ending opacity (default: 1)
 * 
 * Example:
 *   FadeIn {
 *       duration: 400
 *       delay: 100
 *       
 *       Rectangle {
 *           width: 100
 *           height: 100
 *           color: "red"
 *       }
 *   }
 * 
 *   FadeIn {
 *       trigger: isVisible
 *       from: 0
 *       to: 1
 *       
 *       Text { text: "Fades in when isVisible is true" }
 *   }
 */

Item {
    id: root
    
    property int duration: 300
    property int delay: 0
    property var easing: Easing.OutQuad
    property bool trigger: true
    property real from: 0
    property real to: 1
    
    default property alias content: container.data
    
    implicitWidth: container.implicitWidth
    implicitHeight: container.implicitHeight
    
    Item {
        id: container
        anchors.fill: parent
        opacity: root.trigger ? root.to : root.from
        
        Behavior on opacity {
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