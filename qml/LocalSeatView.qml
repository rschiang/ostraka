import QtQuick 2.0
import QtQuick.Layouts 1.1

RowLayout {
    id: root
    anchors.fill: parent
    spacing: window.marginUnit

    Repeater {
        model: app.regions

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: window.marginUnit

            BarChart {
                Layout.fillWidth: true
                Layout.fillHeight: true

                title: modelData.name
                description: "應選 1 席"
                items: [
                    ChartItem {
                        color: modelData.candidates[0].partyColor
                        percentage: modelData.candidates[0].percentage
                    },
                    ChartItem {
                        color: modelData.candidates[1].partyColor
                        percentage: modelData.candidates[1].percentage
                    },
                    ChartItem {
                        color: modelData.candidates[2].partyColor
                        percentage: modelData.candidates[2].percentage
                    }
                ]
            }

            Repeater {
                model: modelData.candidates

                LocalSeatItem {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    candidateNumber: index + 1
                    candidateName: modelData.candidateName
                    majorUnit: modelData.majorUnit
                    minorUnit: modelData.minorUnit
                    partyColor: modelData.partyColor
                    elected: modelData.elected
                }
            }
        }
    }
}
