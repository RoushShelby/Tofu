import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "../../theme"

/*
 * Advanced Battery Component
 * Merged logic: Scaling, Preferred Battery, Granular Icons
 */

Item {
    id: root

    // --- CONFIGURATION ---
    // Mimicking SettingsData.batteryChargeLimit (set to 80 if you cap your battery)
    property int chargeLimit: 100 
    readonly property real scale: 100 / chargeLimit
    
    property string preferredBatteryOverride: Quickshell.env("DMS_PREFERRED_BATTERY")
    
    // Toggle for time view
    property bool showTime: false

    // --- ADVANCED UPOWER LOGIC ---

    // 1. Filter for laptop batteries
    readonly property var batteries: UPower.devices.values.filter(dev => dev.type === UPowerDeviceType.Battery)
    readonly property bool batteryAvailable: batteries.length > 0
    readonly property bool usePreferred: preferredBatteryOverride && preferredBatteryOverride.length > 0

    // 2. Find the main device
    readonly property var device: {
        var preferredDev;
        if (usePreferred) {
            preferredDev = batteries.find(dev => dev.nativePath.toLowerCase().includes(preferredBatteryOverride.toLowerCase()));
        }
        return preferredDev || batteries[0] || null;
    }

    // 3. Calculate Scaled Level
    readonly property int batteryLevel: {
        if (!batteryAvailable) return 0;
        
        // If UPower gives us a capacity, use energy/capacity for accuracy
        if (device && device.energyCapacity > 0) {
             return Math.round((device.energy * 100) / device.energyCapacity * root.scale);
        }
        
        // Fallback to simple percentage
        if (device) {
            return Math.round(device.percentage * 100 * root.scale);
        }
        return 0;
    }

    readonly property bool isCharging: batteryAvailable && batteries.some(b => b.state === UPowerDeviceState.Charging)
    readonly property bool isPluggedIn: batteryAvailable && batteries.every(b => b.state !== UPowerDeviceState.Discharging)
    readonly property bool isLowBattery: batteryAvailable && batteryLevel <= 20
    
    // 4. Rate calculation for time estimation
    readonly property real changeRate: {
        if (usePreferred && device && device.ready) return device.changeRate;
        return batteries.length > 0 ? batteries.reduce((sum, b) => sum + b.changeRate, 0) : 0;
    }

    readonly property real batteryEnergy: {
        if (usePreferred && device && device.ready) return device.energy;
        return batteries.length > 0 ? batteries.reduce((sum, b) => sum + b.energy, 0) : 0;
    }

    readonly property real batteryCapacity: {
        if (usePreferred && device && device.ready) return device.energyCapacity;
        return batteries.length > 0 ? batteries.reduce((sum, b) => sum + b.energyCapacity, 0) : 0;
    }

    // --- FORMATTERS ---

    function formatTimeRemaining() {
        if (!batteryAvailable) return "No Battery";
        
        // Calculate seconds remaining
        let seconds = 0;
        
        // If UPower gives us direct time (often more accurate than manual calc)
        if (device.timeToEmpty > 0 && !isCharging) seconds = device.timeToEmpty;
        else if (device.timeToFull > 0 && isCharging) seconds = device.timeToFull;
        else {
            // Manual calculation fallback
            let totalTime = (isCharging) ? ((batteryCapacity - batteryEnergy) / changeRate) : (batteryEnergy / changeRate);
            seconds = Math.abs(totalTime * 3600);
        }

        if (!seconds || seconds <= 0 || seconds > 86400) return "Calculating...";

        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);
        const suffix = isCharging ? "until full" : "remaining";

        return hours > 0 ? `${hours}h ${minutes}m ${suffix}` : `${minutes}m ${suffix}`;
    }

    // The Fancy Icon Logic you asked for
    function getBatteryIcon() {
        if (!batteryAvailable) return ""; // Plug

        if (isCharging) {
            if (batteryLevel >= 90) return "";
            if (batteryLevel >= 80) return "";
            if (batteryLevel >= 60) return "";
            if (batteryLevel >= 50) return "";
            if (batteryLevel >= 30) return "";
            if (batteryLevel >= 20) return "";
            return "";
        }
        
        if (isPluggedIn) {
            // Plugged in but not charging (often happens at 100% or held charge)
            return ""; 
        }

        if (batteryLevel >= 95) return "";
        if (batteryLevel >= 85) return ""; // You might need to adjust these glyphs depending on your specific Nerd Font version
        if (batteryLevel >= 70) return "";
        if (batteryLevel >= 55) return "";
        if (batteryLevel >= 40) return "";
        if (batteryLevel >= 25) return "";
        return "";
    }

    // --- VISUALS ---

    // Dynamic width container
    width: contentContainer.width
    height: 32

    Rectangle {
        id: contentContainer
        anchors.centerIn: parent
        
        width: layout.implicitWidth + 24
        height: 28
        radius: 14
        
        color: root.showTime 
            ? Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
            : Qt.rgba(Colors.surface.r, Colors.surface.g, Colors.surface.b, 0.3)
            
        border.width: 1
        border.color: root.showTime || (isLowBattery && !isCharging)
            ? (isLowBattery && !isCharging ? "#f53c3c" : Colors.accent)
            : Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
            
        Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.OutQuad } }
        Behavior on color { ColorAnimation { duration: 200 } }
        Behavior on border.color { ColorAnimation { duration: 200 } }

        Row {
            id: layout
            anchors.centerIn: parent
            spacing: 8
            
            Text {
                text: getBatteryIcon()
                // Logic for icon color
                color: {
                    if (!batteryAvailable) return Colors.widgetIconColor || Colors.foreground;
                    if (isLowBattery && !isCharging) return "#f53c3c"; // Error Red
                    if (isCharging || isPluggedIn) return Colors.accent;
                    return Colors.foreground;
                }
                
                font.family: "CodeNewRoman Nerd Font Propo"
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: label
                text: root.showTime ? root.formatTimeRemaining() : `${root.batteryLevel}%`
                color: Colors.foreground
                font.family: "CodeNewRoman Nerd Font Propo"
                font.pixelSize: 13
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            
            onClicked: root.showTime = !root.showTime
            
            onEntered: {
                if (!root.showTime && (!root.isLowBattery || root.isCharging)) {
                    parent.border.color = Colors.accent
                }
            }
            onExited: {
                if (!root.showTime && (!root.isLowBattery || root.isCharging)) {
                    parent.border.color = Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.2)
                }
            }
        }
    }
}