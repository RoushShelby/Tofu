pragma Singleton
import QtQuick

QtObject {
    readonly property color background: "{{colors.background.default.hex}}"
    readonly property color foreground: "{{colors.on_background.default.hex}}"
    readonly property color accent: "{{colors.primary.default.hex}}"
    readonly property color surface: "{{colors.surface.default.hex}}"
}
