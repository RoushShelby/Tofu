import QtQuick
import Quickshell
import Quickshell.Services.UPower // <--- The library you just installed
import "../theme"

Item {
    id: root
    width: contentRow.implicitWidth + 24
    height: 24

    // --- UPOWER LOGIC ---
    
    // 1. Find the first actual battery
    readonly property var batteryDevice: {
        const devices = UPower.devices.values
        // Search for a device where type is Battery (2)
        return devices.find(dev => dev.type === UPowerDeviceType.Battery) || null
    }

    readonly property bool hasBattery: batteryDevice !== null
    
    // 2. Bind properties directly to the device
    // UPower gives percentage as 0.0 to 1.0, so multiply by 100
    readonly property int batteryLevel: hasBattery ? Math.round(batteryDevice.percentage * 100) : 0
    readonly property bool isCharging: hasBattery && batteryDevice.state === UPowerDeviceState.Charging
    readonly property bool isFull: hasBattery && batteryDevice.state === UPowerDeviceState.FullyCharged

    // 3. Helper for Time Remaining
    function getTimeString() {
        if (!hasBattery) return "No Battery"
        
        let seconds = 0
        if (isCharging) {
            seconds = batteryDevice.timeToFull
        } else {
            seconds = batteryDevice.timeToEmpty
        }

        if (seconds <= 0) {
            if (isFull) return "Fully Charged"
            return "Calculating..."
        }

        const hours = Math.floor(seconds / 3600)
        const minutes = Math.floor((seconds % 3600) / 60)

        if (hours > 0) return `${hours}h ${minutes}m`
        return `${minutes}m`
    }

    // --- VISUALS ---

    function getBatteryIcon() {
        if (!hasBattery) return "" // Plug icon
        
        // Charging Icons
        if (isCharging) {
            if (batteryLevel >= 90) return ""
            if (batteryLevel >= 60) return ""
            if (batteryLevel >= 30) return ""
            return "" 
        }

        // Discharging Icons
        if (batteryLevel >= 90) return ""
        if (batteryLevel >= 65) return ""
        if (batteryLevel >= 40) return ""
        if (batteryLevel >= 15) return ""
        return ""
    }

    function getBatteryColor() {
        if (isCharging) return Colors.accent
        if (batteryLevel <= 20) return "#ff5555" // Low battery red
        return Colors.foreground
    }

    // --- POPUP WINDOW ---
    PanelWindow {
        id: popup
        visible: false
        width: 160
        height: 80
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: 12
            color: Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.95)
            border.width: 1
            border.color: Colors.accent

            Column {
                anchors.centerIn: parent
                spacing: 4

                // Status
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: root.isCharging ? "Charging" : (root.isFull ? "Full" : "Discharging")
                    color: Colors.foreground
                    font.family: "CodeNewRoman Nerd Font Propo"
                    font.pixelSize: 14
                    font.bold: true
                }
                
                // Time Remaining
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: root.getTimeString()
                    color: Qt.rgba(Colors.foreground.r, Colors.foreground.g, Colors.foreground.b, 0.6)
                    font.family: "CodeNewRoman Nerd Font Propo"
                    font.pixelSize: 12
                }
            }
        }
    }

    // --- BAR BUTTON ---
    Rectangle {
        anchors.fill: parent
        radius: 12
        color: popup.visible 
               ? Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.4) 
               : Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
        border.width: 1
        border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)

        Row {
            id: contentRow
            anchors.centerIn: parent
            spacing: 8

            Text {
                text: getBatteryIcon()
                color: getBatteryColor()
                font.family: "CodeNewRoman Nerd Font Propo"
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: root.batteryLevel + "%"
                color: Colors.foreground
                font.family: "CodeNewRoman Nerd Font Propo"
                font.pixelSize: 14
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: popup.visible = !popup.visible
            onEntered: parent.border.color = Colors.accent
            onExited: parent.border.color = Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
        }
        
        Behavior on color { ColorAnimation { duration: 200 } }
    }
}