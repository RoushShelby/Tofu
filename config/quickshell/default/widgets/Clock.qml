import QtQuick
import "../theme"

Text {
    id: clock
    color: Colors.foreground
    font.pixelSize: 13
    font.weight: Font.Medium
    
    property var currentTime: new Date()
    
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            clock.currentTime = new Date()
        }
    }
    
    text: Qt.formatDateTime(currentTime, "ddd MMM d  hh:mm:ss")
}