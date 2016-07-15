import QtQuick 2.0
import "Strings.js" as Strings

Item {
    id: root

    // Properties
    property int number
    property string name
    property color partyColor
    property int votes
    property bool elected: false

    // Display properties
    property color textColor: "white"

    implicitWidth: 400 * window.scaleFactor
    implicitHeight: numberBlock.height
    state: elected ? "elected" : ""

    Rectangle {
        id: numberBlock
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }

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
        anchors {
            left: numberBlock.right
            leftMargin: 5
            verticalCenter: parent.verticalCenter
        }

        font.pointSize: 42 * window.scaleFactor
        font.letterSpacing: -2
        font.family: "Pingfang TC"
        font.weight: Font.Normal
        color: root.textColor
        text: root.name
    }

    AnimatedText {
        id: voteLabel
        anchors {
            baseline: nameLabel.baseline
            right: unitLabel.left
            rightMargin: 5
        }

        font.pointSize: 48 * window.scaleFactor
        font.letterSpacing: -2
        font.family: "Overpass"
        font.weight: Font.Normal
        color: "white"
        text: root.votes
    }

    Text {
        id: unitLabel
        anchors {
            baseline: nameLabel.baseline
            right: parent.right
        }

        font.pointSize: 32 * window.scaleFactor
        font.family: "Pingfang TC"
        font.weight: Font.Normal
        color: "white"
        text: "票"
    }

    transitions: [
        Transition {
            to: "elected"
            SequentialAnimation {
                ColorAnimation { target: root; property: "textColor"; to: Qt.lighter(partyColor, 1.75); duration: 300 }
                ColorAnimation { target: root; property: "textColor"; to: "white"; duration: 100 }
                ColorAnimation { target: root; property: "textColor"; to: Qt.lighter(partyColor, 1.66); duration: 200 }
            }
        },
        Transition {
            to: ""
            ColorAnimation { target: root; property: "textColor"; to: "white"; duration: 200 }
        }
    ]
}
