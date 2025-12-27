pragma Singleton
import QtQuick

QtObject {
    // Base
    readonly property color background: "{{colors.background.default.hex}}"
    readonly property color foreground: "{{colors.on_background.default.hex}}"
    readonly property color accent: "{{colors.primary.default.hex}}"
    readonly property color surface: "{{colors.surface.default.hex}}"
    readonly property color surfaceVariant: "{{colors.surface_variant.default.hex}}"
    
    // Additional
    readonly property color accentVariant: "{{colors.primary_container.default.hex}}"
    readonly property color secondary: "{{colors.secondary.default.hex}}"
    readonly property color tertiary: "{{colors.tertiary.default.hex}}"
    readonly property color error: "{{colors.error.default.hex}}"
    readonly property color warning: "{{colors.tertiary.default.hex}}"
    readonly property color success: "{{colors.secondary.default.hex}}"
    
    // Outline
    readonly property color outline: "{{colors.outline.default.hex}}"
    readonly property color outlineVariant: "{{colors.outline_variant.default.hex}}"
}