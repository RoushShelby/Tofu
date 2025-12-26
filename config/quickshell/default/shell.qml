import Quickshell
import "panels"
import "widgets"

ShellRoot {
    Bar {
        id: mainBar
        
        // Left: clock and notification
        leftWidgets: [
            Clock {}
        ]
        
        // Center: workspaces
        centerWidgets: [
            Workspaces {}
        ]
        
        // Right: system info
        rightWidgets: [
            SystemInfo {}
        ]
    }
}