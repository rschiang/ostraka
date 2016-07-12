import QtQuick 2.0
import QtMultimedia 5.5

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

    Camera {
        id: camera
    }

    VideoOutput {
        id: screen
        anchors {
            top: parent.top
            left: candidate1.right
            leftMargin: window.marginUnit
            right: parent.right
            bottom: parent.bottom
        }

        source: camera
        fillMode: VideoOutput.PreserveAspectCrop

        DropShadow {}

        Rectangle {
            id: subtitle
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 84 * window.scaleFactor
            color: "#99000000"

            FlexText {
                anchors {
                    left: parent.left
                    leftMargin: 10
                    right: parent.right
                    rightMargin: 10
                    verticalCenter: parent.verticalCenter
                }

                font.pointSize: 60 * window.scaleFactor
                font.letterSpacing: -3
                font.family: "Pingfang TC"
                font.weight: Font.Bold
                color: "white"
                text: app.titleText
            }
        }
    }
}
