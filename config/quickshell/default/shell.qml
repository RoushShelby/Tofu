import Quickshell
import "panels"
import "widgets"

ShellRoot {
    Bar {
        id: mainBar

        leftWidgets: [
            Clock {}
        ]

        centerWidgets: [
            Workspaces {}
        ]

        rightWidgets: [
            SystemInfo {}
        ]
    }
}
