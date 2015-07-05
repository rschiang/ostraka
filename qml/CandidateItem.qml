import QtQuick 2.0

Item {
    id: root
    property string candidateName
    property int majorUnit
    property int minorUnit
    property real percentage
    property color partyColor
    property alias avatar: avatar.source

    Rectangle {
        id: nameBadge
        width: parent.width * 0.1
        height: parent.height
        color: root.partyColor

        Text {
            id: percentageLabel
            height: parent.height * 0.15
            anchors {
                left: parent.left
                right: parent.right
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pixelSize: 45
            font.weight: Font.Bold
            font.family: "Myriad Pro"
            color: "white"
            text: Math.round(root.percentage * 100) + "%"
        }

        Text {
            id: nameLabel
            anchors {
                top: percentageLabel.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            lineHeight: 1.15
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
        }

        Text {
            id: unitLabel
            y: root.height * 0.5
            width: labels.width * 0.1
            fontSizeMode: Text.HorizontalFit
            font.pointSize: 56
            font.weight: Font.DemiBold
            font.letterSpacing: -10
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
