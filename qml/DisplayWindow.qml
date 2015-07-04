import QtQuick 2.0
import QtQuick.Window 2.2

Window {
    id: window
    title: "Ostraka"
    visible: true

    Component.onCompleted: {
        window.flags |= Qt.WindowDoesNotAcceptFocus
    }
}
