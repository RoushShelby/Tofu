import QtQuick
import "../../theme"

/*
 * Group Component
 * 
 * Purpose: Flexible Row/Column container with consistent spacing
 * 
 * Properties:
 *   - orientation (string): "horizontal" or "vertical" (default: "horizontal")
 *   - spacing (int): Space between items (default: 8)
 *   - padding (int): Inner padding (default: 0)
 *   - showBackground (bool): Show background (default: false)
 *   - radius (int): Corner radius when background shown (default: 6)
 * 
 * Example:
 *   Group {
 *       orientation: "horizontal"
 *       spacing: 12
 *       
 *       Icon { icon: "󰂯" }
 *       Text { text: "Bluetooth" }
 *       Badge { count: 3 }
 *   }
 * 
 *   Group {
 *       orientation: "vertical"
 *       spacing: 10
 *       showBackground: true
 *       padding: 12
 *       
 *       Text { text: "Title" }
 *       Text { text: "Subtitle" }
 *   }
 */

Item {
    id: root
    
    property string orientation: "horizontal"
    property int spacing: 8
    property int padding: 0
    property bool showBackground: false
    property int radius: 6
    property alias contentItem: loader.item
    
    implicitWidth: loader.item ? loader.item.implicitWidth + padding * 2 : padding * 2
    implicitHeight: loader.item ? loader.item.implicitHeight + padding * 2 : padding * 2
    
    Rectangle {
        anchors.fill: parent
        visible: showBackground
        radius: root.radius
        color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
        border.width: 1
        border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
    }
    
    Loader {
        id: loader
        anchors.fill: parent
        anchors.margins: padding
        
        sourceComponent: orientation === "horizontal" ? horizontalLayout : verticalLayout
        
        onLoaded: {
            for (var i = 0; i < root.children.length; i++) {
                var child = root.children[i]
                if (child !== loader && child !== loader.item) {
                    child.parent = loader.item
                }
            }
        }
    }
    
    Component {
        id: horizontalLayout
        Row {
            spacing: root.spacing
        }
    }
    
    Component {
        id: verticalLayout
        Column {
            spacing: root.spacing
        }
    }
}