import QtQuick
import Quickshell
import "../theme"

Item {
    id: root
    width: button.width
    height: 24
    
    // Popup Window
    PanelWindow {
        id: popup
        visible: false
        implicitWidth: 180
        implicitHeight: menuColumn.implicitHeight + 20
        color: "transparent"
        
        Rectangle {
            anchors.fill: parent
            radius: 12
            color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.95)
            border.width: 1
            border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.3)
            
            Column {
                id: menuColumn
                anchors.fill: parent
                anchors.margins: 10
                spacing: 4
                
                // Menu items
                Repeater {
                    model: [
                        {icon: "", text: "Settings"},
                        {icon: "", text: "System"},
                        {icon: "", text: "About"}
                    ]
                    
                    delegate: Rectangle {
                        width: parent.width
                        height: 32
                        radius: 8
                        color: mouseArea.containsMouse 
                            ? Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
                            : "transparent"
                        
                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                        
                        Row {
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 10
                            
                            Text {
                                text: modelData.icon
                                font.family: "CodeNewRoman Nerd Font Propo"
                                font.pixelSize: 16
                                color: Colors.accent
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            
                            Text {
                                text: modelData.text
                                font.family: "CodeNewRoman Nerd Font Propo"
                                font.pixelSize: 13
                                color: Colors.foreground
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                        
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("Clicked:", modelData.text)
                                popup.visible = false
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Button on the bar
    Rectangle {
        id: button
        width: buttonRow.implicitWidth + 16
        height: 24
        radius: 12
        
        color: popup.visible 
            ? Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.4)
            : Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
        
        border.width: 1
        border.color: popup.visible || buttonMouseArea.containsMouse
            ? Colors.accent
            : Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
        
        Behavior on color {
            ColorAnimation { duration: 200 }
        }
        
        Behavior on border.color {
            ColorAnimation { duration: 200 }
        }
        
        Row {
            id: buttonRow
            anchors.centerIn: parent
            spacing: 6
            
            Text {
                text: "Tofu"
                color: Colors.foreground
                font.family: "CodeNewRoman Nerd Font Propo"
                font.pixelSize: 13
                anchors.verticalCenter: parent.verticalCenter
            }
            
            Text {
                text: popup.visible ? "▲" : "▼"
                color: Colors.accent
                font.pixelSize: 10
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        
        MouseArea {
            id: buttonMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: popup.visible = !popup.visible
        }
    }
    
    // Close popup when clicking outside
    MouseArea {
        visible: popup.visible
        anchors.fill: parent
        anchors.margins: -10000
        z: -1
        onPressed: popup.visible = false
    }
}