import QtQuick
import "../../theme"

/*
 * Dropdown Component
 * 
 * Purpose: Select menu with options list
 * 
 * Properties:
 *   - model (var): Array of options (strings or {text, value})
 *   - currentIndex (int): Selected index (default: 0)
 *   - currentValue (var): Selected value
 *   - placeholder (string): Text when no selection (default: "Select...")
 *   - width (int): Dropdown width (default: 150)
 *   - height (int): Button height (default: 32)
 *   - maxDropdownHeight (int): Max height of options list (default: 200)
 *   - dropdownColor (color): Options background (default: Colors.surface @ 30%)
 *   - hoverColor (color): Option hover color (default: Colors.accent @ 20%)
 * 
 * Signals:
 *   - selected(int index, var value): Emitted when option selected
 * 
 * Example:
 *   Dropdown {
 *       model: ["Option 1", "Option 2", "Option 3"]
 *       onSelected: (index, value) => { console.log(value) }
 *   }
 * 
 *   Dropdown {
 *       model: [
 *           {text: "Low", value: 0},
 *           {text: "Medium", value: 50},
 *           {text: "High", value: 100}
 *       ]
 *   }
 */

Item {
    id: root
    
    property var model: []
    property int currentIndex: -1
    property var currentValue: currentIndex >= 0 ? getValueAt(currentIndex) : null
    property string placeholder: "Select..."
    property int maxDropdownHeight: 200
    property color dropdownColor: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
    property color hoverColor: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
    
    signal selected(int index, var value)
    
    width: 150
    height: 32
    
    property bool isOpen: false
    
    function getTextAt(index) {
        if (index < 0 || index >= model.length) return ""
        let item = model[index]
        return typeof item === "object" ? item.text : item
    }
    
    function getValueAt(index) {
        if (index < 0 || index >= model.length) return null
        let item = model[index]
        return typeof item === "object" ? item.value : item
    }
    
    // Button
    Rectangle {
        id: button
        anchors.fill: parent
        radius: 6
        color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
        border.width: 1
        border.color: isOpen 
            ? Colors.accent 
            : Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
        
        Behavior on border.color {
            ColorAnimation { duration: 150 }
        }
        
        Row {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 8
            
            Text {
                text: currentIndex >= 0 ? getTextAt(currentIndex) : placeholder
                font.pixelSize: 13
                color: currentIndex >= 0 ? Colors.foreground : Qt.rgba(Colors.foreground.r, Colors.foreground.g, Colors.foreground.b, 0.5)
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 20
                elide: Text.ElideRight
            }
            
            Text {
                text: isOpen ? "▲" : "▼"
                font.pixelSize: 10
                color: Colors.accent
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.isOpen = !root.isOpen
        }
    }
    
    // Dropdown options
    Rectangle {
        id: dropdown
        visible: isOpen
        width: parent.width
        y: parent.height + 4
        height: Math.min(maxDropdownHeight, optionsList.contentHeight)
        radius: 6
        color: dropdownColor
        border.width: 1
        border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
        clip: true
        z: 100
        
        ListView {
            id: optionsList
            anchors.fill: parent
            model: root.model
            
            delegate: Rectangle {
                width: optionsList.width
                height: 32
                color: mouseArea.containsMouse ? hoverColor : "transparent"
                
                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
                
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    text: typeof modelData === "object" ? modelData.text : modelData
                    font.pixelSize: 13
                    color: Colors.foreground
                }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    
                    onClicked: {
                        root.currentIndex = index
                        root.selected(index, root.getValueAt(index))
                        root.isOpen = false
                    }
                }
            }
        }
    }
    
    // Close dropdown when clicking outside
    MouseArea {
        visible: isOpen
        anchors.fill: parent
        anchors.margins: -10000
        z: -1
        onPressed: root.isOpen = false
    }
}