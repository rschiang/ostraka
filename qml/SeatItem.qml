import QtQuick 2.0

Item {
    id: root
    property string seatName
    property color partyColor
    property alias flagSource: flag.source
    property bool elected: false

    width: flag.width + nameLabel.width + nameLabel.anchors.margins
    height: parent.height

    Image {
        id: flag
        width: parent.height
        height: parent.height * (2 / 3)
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: nameLabel
        height: parent.height * 0.8
        anchors.left: flag.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 8
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.VerticalFit
        font.pointSize: 56
        font.family: "Apple LiGothic"
        color: root.elected ? root.partyColor : "white"
        text: root.seatName
    }
}
