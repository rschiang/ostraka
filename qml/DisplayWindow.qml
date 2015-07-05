import QtQuick 2.1
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Window {
    id: window
    title: "Ostraka"
    visible: true

    Component.onCompleted: {
        window.flags |= Qt.WindowDoesNotAcceptFocus
    }

    GridLayout {
        anchors.fill: parent
        rows: 6
        columns: 2

        Repeater {
            model: 3
            Rectangle {
                Layout.column: 0
                Layout.row: index
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Qt.rgba(0.4 + 0.3 * index, 0.3 + 0.2 * index, 0.6 + 0.2 * index, 1)
            }
        }

        Repeater {
            model: 3
            Rectangle {
                Layout.column: 1
                Layout.row: index
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Qt.lighter("#2d7500", 1 + 0.2 * index)
            }
        }

        Rectangle {
            Layout.column: 0
            Layout.row: 3
            Layout.rowSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "azure"
        }

        Rectangle {
            Layout.column: 1
            Layout.row: 3
            Layout.rowSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "orange"

            Text {
                anchors.fill: parent
                font.pointSize: 112
                fontSizeMode: Text.Fit
                text: app.titleText
            }
        }

        Rectangle {
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.row: 5
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "maroon"
        }
    }
}
