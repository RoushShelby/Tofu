import QtQuick
import "../../theme"

/*
 * Card Component
 * 
 * Purpose: Rounded container with background, border, and consistent styling
 * 
 * Properties:
 *   - padding (int): Inner padding (default: 12)
 *   - radius (int): Corner radius (default: 8)
 *   - backgroundColor (color): Background color (default: Colors.surface with 30% opacity)
 *   - borderWidth (int): Border thickness (default: 1)
 *   - borderColor (color): Border color (default: Colors.accent with 20% opacity)
 *   - contentItem (Item): Content to display inside card
 * 
 * Usage Pattern:
 *   Card {
 *       width: 200
 *       height: 100
 *       
 *       Row {
 *           anchors.centerIn: parent
 *           spacing: 10
 *           Icon { icon: "󰂯" }
 *           Text { text: "Content" }
 *       }
 *   }
 */

Rectangle {
    id: root
    
    property int padding: 12
    property alias contentItem: contentContainer.data
    property alias backgroundColor: root.color
    property alias borderWidth: root.border.width
    property alias borderColor: root.border.color
    
    radius: 8
    color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
    border.width: 1
    border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
    
    Item {
        id: contentContainer
        anchors.fill: parent
        anchors.margins: root.padding
    }
}