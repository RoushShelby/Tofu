import QtQuick
import Quickshell
import Quickshell.Io
import "../theme"
import "../components/base"

Item {
    id: root
    width: 32
    height: 32
    
    property bool isPowered: false
    
    Process {
        id: statusProc
        command: ["sh", "-c", "bluetoothctl show | grep -q 'Powered: yes'"]
        running: true
        
        onExited: (code) => {
            root.isPowered = (code === 0)
            statusTimer.start()
        }
    }
    
    Timer {
        id: statusTimer
        interval: 5000
        onTriggered: statusProc.running = true
    }
    
    Rectangle {
        anchors.fill: parent
        radius: 6
        color: "transparent"
        
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: Colors.accent
            opacity: mouseArea.containsMouse ? 0.2 : 0
            Behavior on opacity { NumberAnimation { duration: 150 } }
        }
        
        Text {
            anchors.centerIn: parent
            text: root.isPowered ? "󰂯" : "󰂲"
            font.family: "CodeNewRoman Nerd Font Propo"
            font.pixelSize: 18
            color: root.isPowered ? Colors.accent : Colors.foreground
            Behavior on color { ColorAnimation { duration: 200 } }
        }
        
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            
            onClicked: {
                bluemanProc.running = true
                statusProc.running = true
            }
        }
    }
    
    Process {
        id: bluemanProc
        command: ["blueman-manager"]
    }
}