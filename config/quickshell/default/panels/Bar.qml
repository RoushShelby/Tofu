import Quickshell
import Quickshell.Wayland
import QtQuick
import "../theme"

PanelWindow {
    id: bar
    
    default property list<Item> leftWidgets
    property list<Item> centerWidgets
    property list<Item> rightWidgets
    
    anchors {
        top: true
        left: true
        right: true
    }
    
    height: 32
    color: Colors.background
    
    Item {
        anchors.fill: parent
        anchors.margins: 8
        
        Row {
            id: leftRow
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8
            height: parent.height
            
            children: bar.leftWidgets
        }
        
        Row {
            id: centerRow
            anchors.centerIn: parent
            spacing: 8
            height: parent.height
            
            children: bar.centerWidgets
        }
        
        Row {
            id: rightRow
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8
            height: parent.height
            
            children: bar.rightWidgets
        }
    }
}