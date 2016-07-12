import QtQuick 2.0
import QtQuick.Layouts 1.1

Rectangle {
    id: root
    implicitWidth: row.implicitWidth + 2 * margins
    implicitHeight: row.implicitHeight + 3 * margins + label.height

    // Properties
    property int margins: 10
    property alias text: label.text
    property alias spacing: row.spacing
    default property alias contents: row.children
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

    RowLayout {
        id: row
        anchors {
            top: label.bottom
            left: parent.left
            margins: root.margins
        }
    }
}
