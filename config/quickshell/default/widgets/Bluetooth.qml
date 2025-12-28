import QtQuick
import Quickshell
import Quickshell.Io
import "../theme"
import "../components/base"

Item {
    id: root
    
    // Auto-size
    width: 32
    height: 32

    // --- BLUEMAN & STATUS LOGIC ---

    // 1. Process to open Blueman
    Process {
        id: bluemanProc
        command: ["blueman-manager"]
    }

    // 2. Process to check status periodically
    Process {
        id: statusProc
        // Returns exit code 0 if "Powered: yes" is found
        command: ["sh", "-c", "bluetoothctl show | grep 'Powered: yes'"]
        running: true
        onExited: checkTimer.start()
    }

    Timer {
        id: checkTimer
        interval: 5000 // Check every 5 seconds
        onTriggered: statusProc.running = true
    }

    property bool isPowered: statusProc.exitCode === 0

    // --- VISUALS ---

    Rectangle {
        id: button
        anchors.fill: parent
        radius: 6 // Matches your other widgets
        color: "transparent" // Default transparent

        // Hover Effect
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: Colors.accent
            opacity: mouseArea.containsMouse ? 0.2 : 0
            
            Behavior on opacity { NumberAnimation { duration: 150 } }
        }

        // Icon
        Text {
            anchors.centerIn: parent
            text: root.isPowered ? "󰂯" : "󰂲"
            font.family: "CodeNewRoman Nerd Font Propo"
            font.pixelSize: 18
            
            // COLOR LOGIC:
            // - Powered On: Use Matugen Accent
            // - Powered Off: Use Matugen Foreground (standard text color)
            color: root.isPowered ? Colors.accent : Colors.foreground
            
            Behavior on color { ColorAnimation { duration: 200 } }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            
            onClicked: {
                // Launch Blueman
                bluemanProc.running = true
                // Force an immediate status check update
                statusProc.running = true
            }
        }
    }
}