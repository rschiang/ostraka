import QtQuick 2.0
import QtQuick.Layouts 1.1

GridLayout {
    id: root
    anchors.fill: parent

    columns: 4
    rows: 4
    flow: GridLayout.TopToBottom

    columnSpacing: window.marginUnit
    rowSpacing: window.marginUnit

    Repeater {
        model: 16
        LocalSeatItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
