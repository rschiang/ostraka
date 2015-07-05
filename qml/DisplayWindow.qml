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
            id: titleRect
            Layout.column: 1
            Layout.row: 3
            Layout.rowSpan: 2
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "orange"

            Text {
                id: titleLabel
                font.pointSize: 112
                font.weight: Font.Bold
                font.letterSpacing: -5
                color: "black"
                text: app.titleText

                transformOrigin: Item.TopLeft
                transform: [
                    Scale {
                        xScale: Math.min(titleLabel.parent.width / titleLabel.contentWidth, 1)
                        yScale: titleLabel.parent.height / titleLabel.contentHeight
                    }
                ]
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

    Rectangle {
        id: statusBar
        width: parent.width
        height: parent.height * 0.1
        anchors.bottom: parent.bottom
        color: "black"

        Text {
            id: clock
            width: parent.width * 0.15
            height: parent.height
            anchors.left: parent.left
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pointSize: 45
            font.weight: Font.DemiBold
            font.family: "Avenir Next Condensed"
            color: "white"
            text: "12:07:05"
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                var date = new Date()
                var hour = date.getHours()
                var minute = date.getMinutes()
                var second = date.getSeconds()
                clock.text = (hour >= 10 ? hour : "0" + hour) + ":" +
                             (minute >= 10 ? minute : "0" + minute) + ":" +
                             (second >= 10 ? second : "0" + second)
            }
        }
    }
}
