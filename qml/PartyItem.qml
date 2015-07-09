import QtQuick 2.0

Rectangle {
    id: root

    property color partyColor
    property string partyName
    property int seats
    property real percentage
    property alias flagSource: flag.source

    color: partyColor

    Column {
        Image {
            id: flag
            width: root.width
            height: root.height * 0.6
            fillMode: Image.PreserveAspectCrop
        }

        Text {
            id: nameLabel
            width: root.width
            height: root.height * 0.15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pointSize: 45
            font.family: "LiHei Pro"
            color: "white"
            text: partyName + " " + seats + "席"
        }

        Text {
            id: percentageLabel
            width: root.width
            height: root.height * 0.25
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pointSize: 56
            font.weight: Font.Bold
            font.family: "Myriad Pro"
            color: "white"
            text: Math.round(percentage * 100) + "%"

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
    }
}
