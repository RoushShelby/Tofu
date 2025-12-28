import QtQuick
import Quickshell
import Quickshell.Wayland
import "../theme"
import "../widgets"

PanelWindow {
    id: panel
    
    property list<Item> leftWidgets
    property list<Item> centerWidgets
    property list<Item> rightWidgets
    
    // Moved these up to avoid syntax errors with anchors
    implicitHeight: 52
    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
    }
    
    Rectangle {
        id: barBackground
        
        anchors {
            fill: parent
            margins: 6
            leftMargin: 12
            rightMargin: 12
        }
        
        radius: 14
        
        // Background color
        color: Qt.rgba(Colors.background.r, Colors.background.g, Colors.background.b, 0.6)
        
        // Shadow/Border effect
        Rectangle {
            anchors.fill: parent
            anchors.margins: -1
            radius: parent.radius + 1
            color: "transparent"
            border.width: 1
            border.color: Qt.rgba(0, 0, 0, 0.2)
            z: -1
        }
        
        // Outer Glow
        Rectangle {
            anchors.fill: parent
            anchors.margins: -2
            radius: parent.radius + 2
            color: "transparent"
            border.width: 1
            border.color: Qt.rgba(0, 0, 0, 0.1)
            z: -2
        }
        
        // Widget Container
        Item {
            anchors.fill: parent
            anchors.margins: 7
            
            // --- Left Widgets ---
            Row {
                id: leftRow
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5
                
                Component.onCompleted: {
                    for (var i = 0; i < leftWidgets.length; i++) {
                        leftWidgets[i].parent = leftRow
                    }
                }
            }
            
            // --- Center Widgets ---
            Row {
                id: centerRow
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5
                
                Component.onCompleted: {
                    for (var i = 0; i < centerWidgets.length; i++) {
                        centerWidgets[i].parent = centerRow
                    }
                }
            }
            
            // --- Right Widgets ---
            Row {
                id: rightRow
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
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