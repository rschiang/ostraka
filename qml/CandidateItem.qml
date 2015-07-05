import QtQuick 2.0

Item {
    id: root
    property string candidateName
    property int majorUnit
    property int minorUnit
    property color partyColor
    property alias avatar: avatar.source

    Rectangle {
        id: nameBadge
        width: parent.width * 0.1
        height: parent.height
        color: root.partyColor

        Text {
            id: nameLabel
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pixelSize: 45
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
            text: root.majorUnit
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
            text: root.minorUnit
            transformOrigin: Item.TopLeft
            transform: [
                Scale { yScale: root.height / minorLabel.contentHeight * 1.25 }
            ]
        }
    }
}
