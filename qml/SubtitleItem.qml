import QtQuick 2.0

Rectangle {
    id: root

    // Properties
    property alias text: label.text
    property alias textColor: label.color
    property alias font: label.font

    Text {
        id: label
        anchors {
            left: parent.left
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }

        font.pointSize: (root.height > 0) ? root.height * 0.7 : 60
        font.letterSpacing: -3
        font.family: "Pingfang TC"
        font.weight: Font.Bold

        transformOrigin: Item.TopLeft
        transform: [
            Scale {
                xScale: Math.min((root.width - 20) / label.contentWidth, 1)
            }
        ]
    }
}
