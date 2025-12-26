import Quickshell
import "panels"
import "widgets"

ShellRoot {
    Bar {
        id: mainBar
        
        leftWidgets: [
            Workspaces {},
        ]
        
        centerWidgets: [
            Clock {}
        ]
        
        rightWidgets: [
            SystemInfo {}
        ]
    }
}