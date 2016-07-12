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

    BarChart {
        Layout.fillWidth: true
        Layout.fillHeight: true

        title: "選區一"
        description: "應選 1 席"
        items: [
            ChartItem {
                color: party1.partyColor
                percentage: 0.516
            },
            ChartItem {
                color: party2.partyColor
                percentage: 0.312
            },
            ChartItem {
                color: party3.partyColor
                percentage: 0.140
            }
        ]
    }

    Repeater {
        model: 15

        LocalSeatItem {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
