import QtQuick 2.0

Item {
    id: root
    property string seatName
    property color partyColor
    property alias flagSource: flag.source
    property bool elected: false

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
        font.family: "Apple LiGothic"
        color: root.elected ? root.partyColor : "white"
        text: root.seatName
    }
}
