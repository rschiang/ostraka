import QtQuick 2.0

Row {
    id: root
    property string seatName
    property color partyColor
    property alias flagSource: flag.source
    property bool elected: false

    spacing: 5
    state: elected ? "elected" : ""

    Image {
        id: flag
        anchors.verticalCenter: parent.verticalCenter
        width: 60 * window.scaleFactor
        height: width
        fillMode: Image.PreserveAspectCrop
    }

    Text {
        id: nameLabel
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter

        font.pointSize: 42 * window.scaleFactor
        font.letterSpacing: -2
        font.family: "Pingfang TC"
        font.weight: Font.Normal
        color: "white"
        text: root.seatName
    }

    transitions: [
        Transition {
            to: "elected"
            SequentialAnimation {
                ColorAnimation { target: nameLabel; property: "color"; to: root.partyColor; duration: 300 }
                ColorAnimation { target: nameLabel; property: "color"; to: "white"; duration: 100 }
                ColorAnimation { target: nameLabel; property: "color"; to: root.partyColor; duration: 200 }
            }
        },
        Transition {
            to: ""
            ColorAnimation { target: nameLabel; property: "color"; to: "white"; duration: 200 }
        }

    ]
}
