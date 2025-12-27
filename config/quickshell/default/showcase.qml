import QtQuick
import Quickshell
import "components/base" as Base
import "components/containers" as Containers
import "theme"

/*
 * Debug Showcase - Only Base + Container components
 * Run: quickshell -c config/quickshell/default/showcase.qml
 */

ShellRoot {
    Scope {
        FloatingWindow {
            width: 700
            height: 500
            color: Colors.background
            
            Flickable {
                anchors.fill: parent
                anchors.margins: 20
                contentHeight: content.implicitHeight
                clip: true
                
                Column {
                    id: content
                    width: parent.width
                    spacing: 25
                    
                    Text {
                        text: "Component Library (Base + Containers Only)"
                        font.pixelSize: 20
                        font.bold: true
                        color: Colors.foreground
                    }
                    
                    // Base Components
                    Column {
                        width: parent.width
                        spacing: 15
                        
                        Text {
                            text: "Base Components"
                            font.pixelSize: 14
                            font.bold: true
                            color: Colors.accent
                        }
                        
                        Row {
                            spacing: 40
                            
                            // Icons
                            Column {
                                spacing: 8
                                Row {
                                    spacing: 15
                                    Base.Icon { icon: ""; size: 12 }
                                    Base.Icon { icon: ""; size: 16 }
                                    Base.Icon { icon: ""; size: 20; iconColor: Colors.accent }
                                    Base.Icon { icon: ""; size: 24 }
                                }
                                Text {
                                    text: "Icon (12,16,20,24)"
                                    font.pixelSize: 10
                                    color: Qt.rgba(Colors.foreground.r, Colors.foreground.g, Colors.foreground.b, 0.6)
                                }
                            }
                            
                            // IconButtons
                            Column {
                                spacing: 8
                                Row {
                                    spacing: 15
                                    Base.IconButton {
                                        icon: ""
                                        width: 24; height: 24
                                        iconSize: 14
                                        onClicked: statusText.text = "24x24 clicked"
                                    }
                                    Base.IconButton {
                                        icon: ""
                                        width: 28; height: 28
                                        iconSize: 16
                                        showBackground: true
                                        onClicked: statusText.text = "28x28 clicked"
                                    }
                                    Base.IconButton {
                                        icon: ""
                                        width: 32; height: 32
                                        iconSize: 18
                                        showBackground: true
                                        radius: 16
                                        onClicked: statusText.text = "32x32 clicked"
                                    }
                                }
                                Text {
                                    text: "IconButton (24,28,32)"
                                    font.pixelSize: 10
                                    color: Qt.rgba(Colors.foreground.r, Colors.foreground.g, Colors.foreground.b, 0.6)
                                }
                            }
                        }
                        
                        Row {
                            spacing: 40
                            
                            // Badges
                            Column {
                                spacing: 8
                                Row {
                                    spacing: 15
                                    Base.Badge { count: 3; size: 16 }
                                    Base.Badge { count: 12; size: 18 }
                                    Base.Badge { count: 99; size: 20 }
                                    Base.Badge { count: 150; size: 20; badgeColor: "#f53c3c" }
                                }
                                Text {
                                    text: "Badge (fixed size)"
                                    font.pixelSize: 10
                                    color: Qt.rgba(Colors.foreground.r, Colors.foreground.g, Colors.foreground.b, 0.6)
                                }
                            }
                            
                            // Auto-sized badges
                            Column {
                                spacing: 8
                                Row {
                                    spacing: 15
                                    Base.Badge { count: 1 }
                                    Base.Badge { count: 5 }
                                    Base.Badge { count: 42 }
                                    Base.Badge { count: 100; badgeColor: Colors.accentVariant }
                                }
                                Text {
                                    text: "Badge (auto-size)"
                                    font.pixelSize: 10
                                    color: Qt.rgba(Colors.foreground.r, Colors.foreground.g, Colors.foreground.b, 0.6)
                                }
                            }
                        }
                        
                        // IconButtonBadge
                        Column {
                            spacing: 8
                            Row {
                                spacing: 20
                                Base.IconButtonBadge {
                                    icon: ""
                                    buttonWidth: 28; buttonHeight: 28
                                    iconSize: 16
                                    showBackground: true
                                    count: 5
                                    badgeSize: 16
                                    onClicked: statusText.text = "5 devices"
                                }
                                Base.IconButtonBadge {
                                    icon: ""
                                    buttonWidth: 32; buttonHeight: 32
                                    iconSize: 18
                                    count: 23
                                    badgeSize: 18
                                    badgeOffsetX: -6
                                    badgeOffsetY: -6
                                    onClicked: statusText.text = "23 devices"
                                }
                                Base.IconButtonBadge {
                                    icon: ""
                                    buttonWidth: 28; buttonHeight: 28
                                    count: 150
                                    badgeColor: "#ffbe61"
                                    badgeSize: 18
                                    onClicked: statusText.text = "150+ devices"
                                }
                            }
                            Text {
                                text: "IconButtonBadge (helper component)"
                                font.pixelSize: 10
                                color: Qt.rgba(Colors.foreground.r, Colors.foreground.g, Colors.foreground.b, 0.6)
                            }
                        }
                    }
                    
                    // Containers
                    Column {
                        width: parent.width
                        spacing: 15
                        
                        Text {
                            text: "Containers"
                            font.pixelSize: 14
                            font.bold: true
                            color: Colors.accent
                        }
                        
                        Row {
                            spacing: 15
                            
                            Containers.Card {
                                width: 120; height: 70
                                Column {
                                    anchors.centerIn: parent
                                    spacing: 6
                                    Base.Icon { icon: ""; size: 18; iconColor: Colors.accent; anchors.horizontalCenter: parent.horizontalCenter }
                                    Text { text: "Card"; font.pixelSize: 12; color: Colors.foreground }
                                }
                            }
                            
                            Containers.Group {
                                orientation: "horizontal"
                                spacing: 10
                                showBackground: true
                                padding: 8
                                Base.Icon { icon: ""; size: 16; iconColor: Colors.accent }
                                Text { text: "Group"; font.pixelSize: 12; color: Colors.foreground }
                                Base.Badge { count: 3; size: 16 }
                            }
                            
                            Containers.Section {
                                Base.IconButton { icon: ""; iconSize: 15; width: 24; height: 24 }
                                Text { text: "Section"; font.pixelSize: 12; color: Colors.foreground }
                                Base.Badge { count: 5; size: 16 }
                            }
                        }
                        
                        Text {
                            text: "Card: panels/popups • Group: flexible layout • Section: bar sections"
                            font.pixelSize: 10
                            color: Qt.rgba(Colors.foreground.r, Colors.foreground.g, Colors.foreground.b, 0.6)
                        }
                    }
                    
                    // Manual Composition
                    Column {
                        width: parent.width
                        spacing: 15
                        
                        Text {
                            text: "Manual Composition"
                            font.pixelSize: 14
                            font.bold: true
                            color: Colors.accent
                        }
                        
                        Row {
                            spacing: 20
                            
                            Item {
                                width: 32; height: 32
                                Base.IconButton {
                                    anchors.fill: parent
                                    icon: ""
                                    iconSize: 18
                                    showBackground: true
                                    onClicked: statusText.text = "Manual badge!"
                                }
                                Base.Badge {
                                    count: 99
                                    size: 18
                                    anchors.top: parent.top
                                    anchors.right: parent.right
                                    anchors.topMargin: -5
                                    anchors.rightMargin: -5
                                }
                            }
                            
                            Item {
                                width: 80; height: 36
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 6
                                    color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
                                    border.width: 1
                                    border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
                                    Row {
                                        anchors.centerIn: parent
                                        spacing: 10
                                        Base.Icon { icon: ""; size: 16; iconColor: Colors.accent }
                                        Base.Badge { count: 7; size: 16; anchors.verticalCenter: parent.verticalCenter }
                                    }
                                }
                            }
                        }
                        
                        Text {
                            text: "Use Item + anchors for full control"
                            font.pixelSize: 10
                            color: Qt.rgba(Colors.foreground.r, Colors.foreground.g, Colors.foreground.b, 0.6)
                        }
                    }
                    
                    // Status
                    Rectangle {
                        width: parent.width
                        height: 60
                        radius: 6
                        color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
                        border.width: 1
                        border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
                        
                        Column {
                            anchors.centerIn: parent
                            spacing: 6
                            Text {
                                text: "Status"
                                font.pixelSize: 13
                                font.bold: true
                                color: Colors.accent
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text {
                                id: statusText
                                text: "Click buttons to test..."
                                font.pixelSize: 12
                                color: Colors.foreground
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
            }
        }
    }
}