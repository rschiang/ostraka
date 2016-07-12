import QtQuick 2.0

Rectangle {
    id: root

    // Properties
    property color partyColor
    property int partyNumber
    property string partyName
    property int seats
    property real percentage
    property alias flagSource: flag.source

    // Display properties
    property color textColor: Qt.lighter(partyColor, 1.66)

    color: partyColor

    // Components

    Image {
        id: flag
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 0.4
    }

    Image {
        id: overlay
        anchors.fill: parent
        anchors.rightMargin: -1 /* fix rounding edges */
        source: "qrc:/assets/overlay.svg"
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        id: numberBlock
        anchors {
            top: parent.top
            left: parent.left
            margins: 10
        }
        width: 75 * window.scaleFactor
        height: width

        radius: 5
        color: root.textColor

        Text {
            id: numberLabel
            anchors.centerIn: parent
            font.pointSize: 72 * window.scaleFactor
            font.family: "Overpass"
            font.weight: Font.Light
            color: Qt.darker(root.partyColor, 2.0)
            text: root.partyNumber
        }
    }


    Text {
        id: nameLabel
        anchors {
            top: parent.top
            left: numberBlock.right
            leftMargin: 10
        }

        font.pointSize: 48 * window.scaleFactor
        font.letterSpacing: -2
        font.family: "Pingfang TC"
        font.weight: Font.Normal
        color: root.textColor
        text: root.partyName
    }

    Text {
        id: percentageLabel
        anchors {
            top: nameLabel.baseline
            left: nameLabel.left
        }

        font.pointSize: 32 * window.scaleFactor
        font.letterSpacing: -2
        font.family: "Overpass"
        font.weight: Font.Normal
        color: root.textColor
        text: (root.percentage * 100).toFixed(2) + "%"
    }

    Text {
        id: seatLabel
        anchors {
            top: numberBlock.bottom
            left: numberBlock.left
            right: seatUnitLabel.left
            rightMargin: 10
        }
        horizontalAlignment: Text.AlignRight

        font.pointSize: 120 * window.scaleFactor
        font.letterSpacing: -5
        font.family: "Overpass"
        font.weight: Font.Normal
        color: "white"
        text: root.seats
    }

    Text {
        id: seatUnitLabel
        anchors {
            baseline: seatLabel.baseline
            right: parent.right
            rightMargin: 20
        }
        horizontalAlignment: Text.AlignRight

        font.pointSize: 36 * window.scaleFactor
        font.weight: Font.DemiBold
        font.family: "Pingfang TC"
        color: "white"
        text: "席"
    }
}
