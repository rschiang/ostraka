import QtQuick 2.0

Row {
    id: root
    property string seatName
    property color partyColor
    property alias flagSource: flag.source
    property bool elected: false

    spacing: 4

    Image {
        id: flag
        width: parent.height
        height: parent.height * (2 / 3)
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: nameLabel
        height: parent.height * 0.8
        anchors.verticalCenter: parent.verticalCenter
        fontSizeMode: Text.VerticalFit
        font.pointSize: 56
        font.family: "Apple LiGothic"
        color: root.elected ? partyColor : "white"
    }
}
