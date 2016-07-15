import QtQuick 2.0
import "Strings.js" as Strings

Row {
    id: root

    // Properties
    property int number
    property string name
    property color partyColor
    property bool elected: false

    // Display properties
    property color textColor: "white"

    spacing: 5
    state: elected ? "elected" : ""

    Rectangle {
        id: numberBlock
        anchors.verticalCenter: parent.verticalCenter
        width: 42 * window.scaleFactor
        height: width

        radius: 5
        color: root.textColor

        Text {
            id: numberLabel
            anchors.centerIn: parent
            font.pointSize: 42 * window.scaleFactor
            font.family: "Overpass"
            font.weight: Font.Light
            color: "#212121"
            text: root.number
        }
    }

    Text {
        id: nameLabel
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 42 * window.scaleFactor
        font.letterSpacing: -2
        font.family: "Pingfang TC"
        font.weight: Font.Normal
        color: root.textColor
        text: root.name
    }

    transitions: [
        Transition {
            to: "elected"
            SequentialAnimation {
                ColorAnimation { target: root; property: "textColor"; to: Qt.lighter(partyColor, 1.66); duration: 300 }
                ColorAnimation { target: root; property: "textColor"; to: "white"; duration: 100 }
                ColorAnimation { target: root; property: "textColor"; to: Qt.lighter(partyColor, 1.5); duration: 200 }
            }
        },
        Transition {
            to: ""
            ColorAnimation { target: root; property: "textColor"; to: "white"; duration: 200 }
        }

    ]
}
