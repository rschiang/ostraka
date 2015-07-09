import QtQuick 2.0

Item {
    id: root
    property string seatName
    property color partyColor
    property alias flagSource: flag.source
    property bool elected: false

    state: elected ? "elected" : ""

    Image {
        id: flag
        width: parent.height
        height: parent.height * (2 / 3)
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: nameLabel
        anchors {
            top: parent.top
            left: flag.right
            right: parent.right
            bottom: parent.bottom
            margins: 8
        }
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        font.pointSize: 56
        font.family: "LiHei Pro"
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
