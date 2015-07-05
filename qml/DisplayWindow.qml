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
        anchors {
            top: parent.top
            bottom: titleBar.top
            left: parent.left
            right: parent.right
        }
        rows: 3
        columns: 3

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
            Layout.column: 2
            Layout.row: 0
            Layout.rowSpan: 3
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "azure"
        }
    }

    Rectangle {
        id: titleBar
        width: parent.width
        height: parent.height * 0.2
        anchors.bottom: statusBar.top
        color: "orange"

        Text {
            id: titleLabel
            x: parent.width * 0.05
            y: parent.height * 0.02
            font.pointSize: 112
            font.weight: Font.Bold
            font.letterSpacing: -5
            color: "black"
            text: app.titleText

            transformOrigin: Item.TopLeft
            transform: [
                Scale {
                    xScale: Math.min(titleBar.width * 0.9 / titleLabel.contentWidth, 1)
                    yScale: titleBar.height * 0.96 / titleLabel.contentHeight
                }
            ]
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
