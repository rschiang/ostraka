import QtQuick 2.0
import "Strings.js" as Strings

Rectangle {
    id: root

    // Properties
    property int candidateNumber
    property string candidateName
    property int majorUnit
    property int minorUnit
    property color partyColor
    property bool elected: false

    // Display properties
    property color textColor: Qt.lighter(partyColor, 1.66)

    color: partyColor

    // Components
    DropShadow {}

    Image {
        id: overlay
        anchors.fill: parent
        source: "qrc:/assets/ambient.svg"
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        id: numberBlock
        anchors {
            top: parent.top
            left: parent.left
            margins: 10
        }
        width: 56 * window.scaleFactor
        height: width

        radius: 5
        color: root.textColor

        Text {
            id: numberLabel
            anchors.centerIn: parent
            font.pointSize: 56 * window.scaleFactor
            font.family: "Overpass"
            font.weight: Font.Light
            color: Qt.darker(root.partyColor, 2.0)
            text: root.candidateNumber
        }
    }

    Text {
        id: nameLabel
        anchors {
            top: parent.top
            left: numberBlock.right
            leftMargin: 10
        }

        font.pointSize: 56 * window.scaleFactor
        font.letterSpacing: -2
        font.family: "Pingfang TC"
        font.weight: Font.Normal
        color: root.textColor
        text: root.candidateName
    }

    Image {
        id: electedIcon
        anchors {
            left: nameLabel.right
            leftMargin: 5
            verticalCenter: nameLabel.verticalCenter
        }

        width: 48
        height: 48
        source: "qrc:/assets/elected.png"
        visible: root.elected
    }

    Item {
        id: paddingItem
        anchors {
            top: numberBlock.bottom
            right: parent.right
            bottom: parent.bottom
            left: parent.left
            margins: 10
        }
    }

    Row {
        id: labels
        anchors {
            right: paddingItem.right
            verticalCenter: paddingItem.verticalCenter
        }

        Text {
            id: majorLabel
            font.pointSize: 84 * window.scaleFactor
            font.letterSpacing: -5
            font.family: "Overpass"
            font.weight: Font.Normal
            color: "white"
            text: root.majorUnit
        }

        Text {
            id: unitLabel
            anchors.baseline: majorLabel.baseline
            font.pointSize: 32 * window.scaleFactor
            font.weight: Font.DemiBold
            font.family: "Pingfang TC"
            color: "white"
            text: "萬"
        }

        Text {
            id: minorLabel
            anchors.baseline: majorLabel.baseline
            font.pointSize: 64 * window.scaleFactor
            font.weight: Font.Normal
            font.letterSpacing: -5
            font.family: "Overpass"
            color: "white"
            text: Strings.padRight(root.minorUnit, 4, "0")
        }
    }
}
