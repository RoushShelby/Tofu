import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import "../theme"

Item {
    id: root
    
    // --- CONFIGURATION ---
    property int barCount: 12
    property int barWidth: 4
    property int spacing: 3
    property int maxHeight: 20
    
    // Matugen Color Binding
    property color barColor: Colors.accent 

    // Auto-calculate width based on bars
    width: (barCount * barWidth) + ((barCount - 1) * spacing)
    height: 32

    // --- LOGIC ---
    
    // Only run when music is actually playing
    readonly property bool isPlaying: Mpris.players.values.some(p => p.playbackState === MprisPlaybackState.Playing)

    Process {
        id: cavaProc
        running: root.isPlaying
        
        // We generate a temporary config on the fly to force raw output
        command: ["bash", "-c", 
            "printf '[general]\nframerate=60\nbars=" + root.barCount + "\n[output]\nmethod=raw\nraw_target=/dev/stdout\ndata_format=ascii\nascii_max_range=100\n' > /tmp/quickshell_cava.conf && cava -p /tmp/quickshell_cava.conf"
        ]
        
        stdout: SplitParser {
            onRead: data => root.updateBars(data)
        }
        
        onRunningChanged: if (!running) root.resetBars()
    }
    
    function updateBars(data) {
        const values = data.split(";")
        for (let i = 0; i < root.barCount; i++) {
            if (i < values.length && i < barRepeater.count) {
                let val = parseInt(values[i])
                if (isNaN(val)) val = 0
                
                // Map 0-100 input to 2-maxHeight pixels
                let h = Math.min(Math.max((val / 100) * root.maxHeight, 2), root.maxHeight)
                barRepeater.itemAt(i).targetHeight = h
            }
        }
    }
    
    function resetBars() {
        for (let i = 0; i < barRepeater.count; i++) {
            barRepeater.itemAt(i).targetHeight = 2
        }
    }

    // --- VISUALS ---

    Row {
        anchors.centerIn: parent
        spacing: root.spacing
        anchors.verticalCenterOffset: 1 // slight alignment fix
        
        Repeater {
            id: barRepeater
            model: root.barCount
            
            Rectangle {
                property real targetHeight: 2
                
                width: root.barWidth
                height: targetHeight
                radius: 2
                color: root.barColor
                anchors.bottom: parent.bottom
                
                // Smooth animation between frames
                Behavior on height {
                    NumberAnimation { duration: 80; easing.type: Easing.OutQuad }
                }
            }
        }
    }
}