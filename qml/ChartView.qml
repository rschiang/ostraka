import QtQuick 2.0
import QtQuick.Layouts 1.1

Item {
    id: root
    anchors.fill: parent

    ColumnLayout {
        id: candidates
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
        }
        width: boundary.columnWidth
        spacing: window.marginUnit

        CandidateItem {
            id: candidate1
            Layout.fillWidth: true
            Layout.fillHeight: true

            candidateNumber: 1
            candidateName: party1.candidateName
            partyColor: party1.partyColor
            majorUnit: party1.majorUnit
            minorUnit: party1.minorUnit
            percentage: party1.candidatePercentage
            avatar: party1.candidateSource
            elected: party1.candidateElected
        }

        CandidateItem {
            id: candidate2
            Layout.fillWidth: true
            Layout.fillHeight: true

            candidateNumber: 2
            candidateName: party2.candidateName
            partyColor: party2.partyColor
            majorUnit: party2.majorUnit
            minorUnit: party2.minorUnit
            percentage: party2.candidatePercentage
            avatar: party2.candidateSource
            elected: party2.candidateElected
        }

        CandidateItem {
            id: candidate3
            Layout.fillWidth: true
            Layout.fillHeight: true

            candidateNumber: 3
            candidateName: party3.candidateName
            partyColor: party3.partyColor
            majorUnit: party3.majorUnit
            minorUnit: party3.minorUnit
            percentage: party3.candidatePercentage
            avatar: party3.candidateSource
            elected: party3.candidateElected
        }
    }

    RowLayout {
        id: nationalSeats
        anchors {
            left: candidates.right
            leftMargin: window.marginUnit
            right: parent.right
            bottom: parent.bottom
        }

        height: boundary.threeRowHeight
        spacing: window.marginUnit

        NationalSeatItem {
            Layout.fillWidth: true
            Layout.fillHeight: true

            partyNumber: 1
            partyName: party1.partyName
            partyColor: party1.partyColor
            seats: party1.seats
            percentage: party1.seatPercentage
            flagSource: party1.flagSource
        }

        NationalSeatItem {
            Layout.fillWidth: true
            Layout.fillHeight: true

            partyNumber: 2
            partyName: party2.partyName
            partyColor: party2.partyColor
            seats: party2.seats
            percentage: party2.seatPercentage
            flagSource: party2.flagSource
        }

        NationalSeatItem {
            Layout.fillWidth: true
            Layout.fillHeight: true

            partyNumber: 3
            partyName: party3.partyName
            partyColor: party3.partyColor
            seats: party3.seats
            percentage: party3.seatPercentage
            flagSource: party3.flagSource
        }
    }

    PieChart {
        id: screen
        anchors {
            top: parent.top
            right: parent.right
            bottom: nationalSeats.top
            bottomMargin: window.marginUnit
            left: candidates.right
            leftMargin: window.marginUnit
        }

        items: [
            ChartItem {
                text: party1.candidateName
                color: party1.partyColor
                percentage: party1.candidatePercentage
            },
            ChartItem {
                text: party2.candidateName
                color: party2.partyColor
                percentage: party2.candidatePercentage
            },
            ChartItem {
                text: party3.candidateName
                color: party3.partyColor
                percentage: party3.candidatePercentage
            },
            ChartItem {
                color: "#424242"
                percentage: (1 - party1.candidatePercentage
                               - party2.candidatePercentage
                               - party3.candidatePercentage)
            }
        ]

        DropShadow {}

        Rectangle {
            id: subtitle
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 64 * window.scaleFactor
            color: "#99000000"

            FlexText {
                anchors {
                    left: parent.left
                    leftMargin: 10
                    right: parent.right
                    rightMargin: 10
                    verticalCenter: parent.verticalCenter
                }

                font.pointSize: 48 * window.scaleFactor
                font.letterSpacing: -3
                font.family: "Pingfang TC"
                font.weight: Font.Bold
                color: "white"
                text: app.titleText
            }
        }
    }
}
