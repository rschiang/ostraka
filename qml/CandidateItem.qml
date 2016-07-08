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
        font.weight: Font.Normal
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
        width: root.width / 2
        height: root.height / 2
        horizontalAlignment: Text.AlignRight

        font.pixelSize: height
        font.weight: Font.DemiBold
        font.letterSpacing: -10
        font.family: "Overpass"

        color: "white"
        text: root.majorUnit

        onTextChanged: majorEffect.play()

        ParallelAnimation {
            id: majorEffect
            NumberAnimation {
                target: majorLabel
                property: "y"
                from: 40; to: 0
                easing.type: Easing.OutElastic
                duration: 500
            }
            NumberAnimation {
                target: majorLabel
                property: "opacity"
                from: 0; to: 1
                easing.type: Easing.OutElastic
                duration: 500
            }

            function play() {
                if (majorEffect.running)
                    majorEffect.stop()
                majorEffect.start()
            }
        }
    }

    Text {
        id: unitLabel1
        anchors.left: root.horizontalCenter
        anchors.bottom: root.verticalCenter
        font.pixelSize: root.height / 6
        font.weight: Font.DemiBold
        font.family: "Pingfang TC"
        color: "white"
        text: "萬"
    }

    Text {
        id: minorLabel
        width: root.width / 2
        height: root.height / 3
        x: root.width / 8
        y: root.height / 2
        horizontalAlignment: Text.AlignRight

        font.pointSize: height
        font.weight: Font.DemiBold
        font.letterSpacing: -5
        font.family: "Overpass"

        color: "white"
        text: root.minorUnit
    }

    Text {
        id: unitLabel2
        anchors.left: minorLabel.right
        anchors.baseline: minorLabel.baseline
        font.pixelSize: root.height / 6
        font.weight: Font.DemiBold
        font.family: "Pingfang TC"
        color: "white"
        text: "票"
    }

    Image {
        id: electedIcon
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: avatar.left
        width: 64
        height: 64
        source: "qrc:/assets/elected.png"
        visible: root.elected
    }
}
