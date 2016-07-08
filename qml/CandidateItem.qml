import QtQuick 2.0

Rectangle {
    id: root
    property int candidateNumber
    property string candidateName
    property int majorUnit
    property int minorUnit
    property color partyColor
    property real percentage
    property alias avatar: avatar.source
    property bool elected: false

    color: partyColor

    // Events
    onPercentageChanged: {
        var p = (percentage * 100).toFixed(2) + '%'
        percentMajorLabel.text = p.substring(0, p.indexOf('.'))
        percentMinorLabel.text = p.substring(p.indexOf('.'))
    }

    // Components
    DropShadow {}

    Image {
        anchors.fill: parent
        source: "qrc:/assets/spectacle.svg"
    }

    Image {
        id: avatar
        anchors {
            top: parent.top
            right: parent.right
        }
        width: parent.width / 3
        height: parent.height * (5 / 6)
        fillMode: Image.PreserveAspectCrop
    }


    Image {
        id: electedIcon
        anchors {
            right: avatar.right
            bottom: avatar.bottom
            margins: 5
        }

        width: 64
        height: 64
        source: "qrc:/assets/elected.png"
        visible: root.elected
    }

    Rectangle {
        id: numberBlock
        anchors {
            top: percentBlock.top
            bottom: percentBlock.bottom
            left: parent.left
        }
        width: height
        color: Qt.lighter(root.partyColor, 1.66)

        Text {
            id: numberLabel
            anchors.centerIn: parent

            font.pointSize: 28 * window.scaleFactor
            font.weight: Font.DemiBold
            font.family: "Overpass"
            color: Qt.darker(root.partyColor, 3.0)
            text: root.candidateNumber
        }
    }

    Text {
        id: nameLabel
        anchors {
            left: numberBlock.right
            leftMargin: 5
            verticalCenter: numberBlock.verticalCenter
        }

        font.pointSize: 28 * window.scaleFactor
        font.weight: Font.DemiBold
        font.family: "Pingfang TC"
        color: Qt.lighter(root.partyColor, 1.66)
        text: root.candidateName
    }

    Rectangle {
        id: percentBlock
        anchors {
            top: avatar.bottom
            right: parent.right
            bottom: parent.bottom
            left: avatar.left
        }
        color: Qt.darker(root.partyColor, 3.0)

        Text {
            id: percentMajorLabel
            anchors {
                verticalCenter: parent.verticalCenter
                right: percentMinorLabel.left
            }

            font.pointSize: 36 * window.scaleFactor
            font.letterSpacing: -2
            font.family: "Overpass"
            font.weight: Font.DemiBold
            color: root.partyColor
            text: "0"
        }

        Text {
            id: percentMinorLabel
            anchors {
                baseline: percentMajorLabel.baseline
                right: parent.right
                rightMargin: 5
            }

            font.pointSize: 28 * window.scaleFactor
            font.letterSpacing: -2
            font.family: "Overpass"
            font.weight: Font.DemiBold
            color: root.partyColor
            text: ".00%"
        }
    }

    Text {
        id: majorLabel
        anchors {
            top: parent.top
            left: parent.left
            right: parent.horizontalCenter
        }
        horizontalAlignment: Text.AlignRight

        font.pointSize: 108 * window.scaleFactor
        font.letterSpacing: -5
        font.family: "Overpass"
        font.weight: Font.Bold

        color: "white"
        text: root.majorUnit
    }

    Text {
        id: unitLabel1
        anchors.left: root.horizontalCenter
        anchors.baseline: majorLabel.baseline

        font.pointSize: 36 * window.scaleFactor
        font.weight: Font.DemiBold
        font.family: "Pingfang TC"
        color: "white"
        text: "萬"
    }

    Text {
        id: minorLabel
        anchors {
            left: numberBlock.right
            right: minorUnitLabel.left
            baseline: minorUnitLabel.baseline
        }
        horizontalAlignment: Text.AlignRight

        font.pointSize: 84 * window.scaleFactor
        font.weight: Font.DemiBold
        font.letterSpacing: -5
        font.family: "Overpass"

        color: "white"
        text: root.minorUnit
    }

    Text {
        id: minorUnitLabel
        anchors {
            right: avatar.left
            rightMargin: 5
            baseline: avatar.bottom
        }
        horizontalAlignment: Text.AlignRight

        font.pointSize: 36 * window.scaleFactor
        font.weight: Font.DemiBold
        font.family: "Pingfang TC"
        color: "white"
        text: "票"
    }
}
