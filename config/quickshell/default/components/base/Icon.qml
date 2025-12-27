import QtQuick
import "../../theme"

/*
 * Icon Component
 * 
 * Purpose: Display a Nerd Font icon with consistent styling
 * 
 * Properties:
 *   - icon (string): Nerd Font icon character (required)
 *   - size (int): Font size in pixels (default: 15)
 *   - color (color): Icon color (default: Colors.foreground)
 * 
 * Example:
 *   Icon {
 *       icon: ""
 *       size: 18
 *       color: Colors.accent
 *   }
 */

Text {
    id: root
    
    property string icon: ""
    property int size: 15
    property alias iconColor: root.color
    
    text: icon
    font.family: "CodeNewRoman Nerd Font Propo"
    font.pixelSize: size
    color: Colors.foreground
    
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}