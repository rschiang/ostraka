import QtQuick 2.0

Rectangle {
    id: root
    property string candidateName
    property int majorUnit
    property int minorUnit
    property color partyColor
    property real percentage
    property alias avatar: avatar.source
    property bool elected: false

    color: partyColor
    clip: true

    Image {
        anchors.fill: parent
        source: "qrc:/assets/spectacle.svg"
    }

    Image {
        id: avatar
        height: parent.height * (5 / 6)
        width: parent.width / 3
        anchors.top: parent.top
        anchors.right: parent.right

        fillMode: Image.PreserveAspectCrop
        clip: false
    }

    Text {
        id: nameLabel
        anchors.baseline: percentageUnit.baseline
        font.pixelSize: root.height / 8
        font.weight: Font.Bold
        font.family: "Pingfang TC"
        color: Qt.lighter(root.partyColor, 1.33)
        text: root.candidateName
    }

    Text {
        id: percentageLabel
        anchors.right: percentageUnit.left
        anchors.baseline: percentageUnit.baseline

        font.pixelSize: root.height / 6
        font.weight: Font.DemiBold
        font.family: "Overpass"
        color: Qt.lighter(root.partyColor, 1.33)
        text: Math.round(root.percentage * 100)

        onTextChanged: {
            if (percentageEffect.running)
                percentageEffect.stop()
            percentageEffect.start()
        }

        NumberAnimation on opacity {
            id: percentageEffect
            from: 0; to: 1
            duration: 500
            easing.type: Easing.OutQuad
        }
    }


    Text {
        id: percentageUnit
        anchors.right: parent.right
        anchors.baseline: parent.bottom
        anchors.baselineOffset: -root.height / 40

        font.pixelSize: root.height / 6 * 0.8
        font.family: "Overpass"
        color: percentageLabel.color
        text: "%"
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
