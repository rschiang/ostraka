import QtQuick 2.0

QtObject {
    property string text
    property real percentage
    property color color

    Behavior on percentage {
        NumberAnimation {
            duration: 500
            easing.type: Easing.OutCubic
        }
    }
}
