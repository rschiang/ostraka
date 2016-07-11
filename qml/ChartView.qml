import QtQuick 2.0

Item {
    id: root
    anchors.fill: parent

    CandidateItem {
        id: candidate1
        anchors {
            top: parent.top
            left: parent.left
        }
        width: boundary.columnWidth
        height: boundary.threeRowHeight

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
        anchors {
            top: candidate1.bottom
            topMargin: window.marginUnit
            left: parent.left
        }
        width: boundary.columnWidth
        height: boundary.threeRowHeight

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
        anchors {
            top: candidate2.bottom
            topMargin: window.marginUnit
            left: parent.left
        }
        width: boundary.columnWidth
        height: boundary.threeRowHeight

        candidateNumber: 3
        candidateName: party3.candidateName
        partyColor: party3.partyColor
        majorUnit: party3.majorUnit
        minorUnit: party3.minorUnit
        percentage: party3.candidatePercentage
        avatar: party3.candidateSource
        elected: party3.candidateElected
    }

    PieChart {
        id: screen
        anchors {
            top: parent.top
            left: candidate1.right
            leftMargin: window.marginUnit
            right: parent.right
            bottom: parent.bottom
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

        SubtitleItem {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: parent.height * 0.12

            color: "#99000000"
            textColor: "white"
            text: app.titleText
        }
    }
}
