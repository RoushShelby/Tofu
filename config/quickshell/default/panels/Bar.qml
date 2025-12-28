import QtQuick
import Quickshell
import Quickshell.Wayland
import "../theme"
import "../widgets" // <--- FIXED: Import is now at the top!

PanelWindow {
    id: panel
    
    property list<Item> leftWidgets
    property list<Item> centerWidgets
    property list<Item> rightWidgets
    
    anchors {
        top: true
        left: true
        right: true
    }
    
    implicitHeight: 42
    color: "transparent"
    
    Rectangle {
        id: barBackground
        anchors {
            fill: parent
            margins: 5
            leftMargin: 10
            rightMargin: 10
        }
        radius: 10
        color: Qt.rgba(Colors.background.r, Colors.background.g, Colors.background.b, 0.6)
        
        // Shadow layer 1
        Rectangle {
            anchors.fill: parent
            anchors.margins: -1
            radius: parent.radius + 1
            color: "transparent"
            border.width: 1
            border.color: Qt.rgba(0, 0, 0, 0.2)
            z: -1
        }
        
        // Shadow layer 2
        Rectangle {
            anchors.fill: parent
            anchors.margins: -2
            radius: parent.radius + 2
            color: "transparent"
            border.width: 1
            border.color: Qt.rgba(0, 0, 0, 0.1)
            z: -2
        }
        
        Item {
            anchors.fill: parent
            anchors.margins: 7
            
            // Left section
            Row {
                id: leftRow
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                spacing: 5
                
                Component.onCompleted: {
                    for (var i = 0; i < leftWidgets.length; i++) {
                        leftWidgets[i].parent = leftRow
                    }
                }
            }
            
            // Center section
            Row {
                id: centerRow
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                spacing: 5

                // --- VISUALIZER ADDED HERE ---
                Visualizer {
                    barCount: 12
                    maxHeight: 20
                    // This makes it sit nicely in the middle
                }
                
                Component.onCompleted: {
                    for (var i = 0; i < centerWidgets.length; i++) {
                        centerWidgets[i].parent = centerRow
                    }
                }
            }
            
            // Right section
            Row {
                id: rightRow
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                spacing: 5
                
                Component.onCompleted: {
                    for (var i = 0; i < rightWidgets.length; i++) {
                        rightWidgets[i].parent = rightRow
                    }
                }
            }
        }
    }
}