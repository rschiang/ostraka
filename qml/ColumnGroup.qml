import QtQuick 2.0

Rectangle {
    id: root
    implicitWidth: column.implicitWidth + 2 * margins
    implicitHeight: column.implicitHeight + 3 * margins + label.height

    // Properties
    property int margins: 10
    property alias text: label.text
    property alias spacing: column.spacing
    default property alias contents: column.children
    color: "#B2DFDB"

    Text {
        id: label
        anchors {
            top: parent.top
            left: parent.left
            margins: root.margins
        }

        font.pixelSize: 20
        font.weight: Font.DemiBold
        color: "#212121"
    }

    Column {
        id: column
        anchors {
            top: label.bottom
            left: parent.left
            margins: root.margins
        }
    }
}
