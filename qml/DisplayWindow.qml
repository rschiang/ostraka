import QtQuick 2.1
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Window {
    id: window

    // Basic settings
    color: "black"
    title: "Ostraka"
    visible: true
    width: 800
    height: 600

    // Resources
    FontLoader { source: "qrc:/assets/fonts/Overpass-Regular.ttf" }
    FontLoader { source: "qrc:/assets/fonts/Overpass-Light.ttf" }
    FontLoader { source: "qrc:/assets/fonts/Overpass-Bold.ttf" }

    // Display properties
    property real scaleFactor: (height > 0) ? height / 900.0 : 1
    property int marginUnit: 15 * scaleFactor

    // Events
    Component.onCompleted: {
        window.flags |= Qt.WindowDoesNotAcceptFocus
    }

    // Components
    Image {
        id: background
        anchors.fill: parent
        source: "qrc:/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Image {
        id: logo
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 30 * window.scaleFactor
            rightMargin: 30 * window.scaleFactor
        }
        z: 100
        source: "qrc:/assets/logo.svg"
        smooth: false
    }

    Item {
        id: boundary
        anchors {
            fill: parent
            topMargin: window.marginUnit
            rightMargin: window.marginUnit * 2
            bottomMargin: window.marginUnit
            leftMargin: window.marginUnit * 2
        }

        // Computed properties
        property int columnWidth: (width - window.marginUnit * 2) / 3
        property int rowHeight: (height - window.marginUnit * 10) / 11
        property int threeRowHeight: rowHeight * 3 + window.marginUnit * 2
    }

    Rectangle {
        id: topStatusBar
        anchors {
            top: boundary.top
            left: boundary.left
            right: logo.left
            rightMargin: window.marginUnit * 2
        }
        height: boundary.rowHeight
        color: "#212121"

        DropShadow {}

        Text {
            id: topIndicator
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                leftMargin: 10
            }

            font.pointSize: 42 * window.scaleFactor
            font.letterSpacing: -2
            font.family: "Pingfang TC"
            font.weight: Font.DemiBold
            color: "white"
            text: "區域立委"
        }

        MarqueeItem {
            id: topMarquee
            anchors {
                top: parent.top
                right: parent.right
                bottom: parent.bottom
                left: topIndicator.right
                leftMargin: window.marginUnit
            }
            speed: 8000

            Repeater {
                model: party1.localCandidates

                SeatItem {
                    height: topMarquee.height
                    seatName: modelData
                    partyColor: party1.partyColor
                    flagSource: party1.flagSource
                    elected: index < party1.seats
                }
            }
        }
    }

    CandidateItem {
        id: candidate1
        anchors {
            top: topStatusBar.bottom
            topMargin: window.marginUnit
            left: boundary.left
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
            left: boundary.left
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
            left: boundary.left
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
            top: topStatusBar.bottom
            topMargin: window.marginUnit
            left: candidate1.right
            leftMargin: window.marginUnit
            right: boundary.right
            bottom: statusBar.top
            bottomMargin: window.marginUnit
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

    Rectangle {
        id: statusBar
        anchors {
            left: boundary.left
            right: boundary.right
            bottom: boundary.bottom
        }
        height: boundary.rowHeight
        color: "#212121"

        DropShadow {}

        Text {
            id: indicator
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                leftMargin: 10
            }

            font.pointSize: 42 * window.scaleFactor
            font.letterSpacing: -2
            font.family: "Pingfang TC"
            font.weight: Font.DemiBold
            color: "white"
            text: "不分區立委"
        }

        MarqueeItem {
            id: marquee
            anchors {
                top: parent.top
                right: clock.left
                bottom: parent.bottom
                left: indicator.right
                leftMargin: window.marginUnit
            }

            Repeater {
                model: party1.nationalCandidates

                SeatItem {
                    height: marquee.height
                    seatName: modelData
                    partyColor: party1.partyColor
                    flagSource: party1.flagSource
                    elected: index < party1.seats
                }
            }

            Repeater {
                model: party2.nationalCandidates

                SeatItem {
                    height: marquee.height
                    seatName: modelData
                    partyColor: party2.partyColor
                    flagSource: party2.flagSource
                    elected: index < party2.seats
                }
            }

            Repeater {
                model: party3.nationalCandidates

                SeatItem {
                    height: marquee.height
                    seatName: modelData
                    partyColor: party3.partyColor
                    flagSource: party3.flagSource
                    elected: index < party3.seats
                }
            }
        }

        ClockItem {
            id: clock
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }
        }
    }

}
