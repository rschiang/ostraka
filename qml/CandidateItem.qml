import QtQuick 2.0

Rectangle {
    id: root
    property string candidateName
    property int majorUnit
    property int minorUnit
    property color partyColor
    property real percentage
    property alias avatar: avatar.source

    border.color: partyColor
    border.width: 6
    color: "white"
    clip: true

    Rectangle {
        id: nameBadge
        width: parent.width * 0.1
        height: parent.height
        color: root.partyColor

        Rectangle {
            id: percentageBadge
            width: parent.width
            height: parent.height * 0.15
            color: "yellow"
            radius: 2

            Text {
                id: percentageLabel
                x: (parent.width - percentageLabel.contentWidth - percentageUnit.contentWidth) / 2
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.VerticalFit
                font.pixelSize: 45
                font.weight: Font.Bold
                font.letterSpacing: -2
                font.family: "Myriad Pro"
                color: Qt.darker(root.partyColor, 1.5)
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
                height: parent.height * 0.2
                anchors.left: percentageLabel.left
                anchors.leftMargin: percentageLabel.contentWidth + 1
                anchors.baseline: percentageLabel.baseline
                fontSizeMode: Text.VerticalFit
                font.pixelSize: 34
                font.family: "Myriad Pro"
                color: "black"
                text: "%"
            }
        }

        Text {
            id: nameLabel
            anchors {
                top: percentageBadge.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: 6
            }

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pixelSize: 45
            font.family: "Apple LiGothic"
            color: "white"
            text: updateText(root.candidateName)

            function updateText(source) {
                var target = ""
                for (var i in source)
                    target += source[i] + "\n"
                nameLabel.text = target.trim()
            }
        }
    }

    Image {
        id: avatar
        width: parent.width * 0.25
        height: parent.height
        anchors.left: nameBadge.right
        fillMode: Image.PreserveAspectCrop
    }

    Row {
        id: labels
        anchors.left: avatar.right
        anchors.leftMargin: -root.border.width
        width: parent.width * 0.65
        spacing: parent.width * 0.005

        Text {
            id: majorLabel
            width: labels.width * 0.375
            fontSizeMode: Text.HorizontalFit
            font.pointSize: 112
            font.weight: Font.DemiBold
            font.letterSpacing: -5
            font.family: "Myriad Pro"
            color: root.partyColor
            text: app.padRight(root.majorUnit, 3, " ")
            transformOrigin: Item.TopLeft
            transform: [
                Scale { yScale: root.height / majorLabel.contentHeight * 1.25 }
            ]

            onTextChanged: majorEffect.play()
            ParallelAnimation {
                id: majorEffect
                NumberAnimation {
                    target: majorLabel
                    property: "y"
                    from: root.height * 0.2; to: 0
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
            id: unitLabel
            y: root.height * 0.5
            width: labels.width * 0.1
            fontSizeMode: Text.HorizontalFit
            font.pointSize: 56
            font.weight: Font.DemiBold
            font.family: "Hiragino Sans GB"
            color: root.partyColor
            text: "萬"
            transformOrigin: Item.TopLeft
            transform: [
                Scale { yScale: root.height * 0.5 / unitLabel.contentHeight }
            ]
        }

        Text {
            id: minorLabel
            width: labels.width * 0.5
            fontSizeMode: Text.HorizontalFit
            font.pointSize: 112
            font.weight: Font.DemiBold
            font.letterSpacing: -5
            font.family: "Myriad Pro"
            color: root.partyColor
            text: app.padRight(root.minorUnit, 4, "0")
            transformOrigin: Item.TopLeft
            transform: [
                Scale { yScale: root.height / minorLabel.contentHeight * 1.25 }
            ]
        }
    }
}
