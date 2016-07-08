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

    // Display properties
    property real scaleFactor: height / 900.0
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

    GridLayout {
        id: grid
        anchors {
            fill: parent
            topMargin: window.marginUnit
            rightMargin: window.marginUnit * 2
            bottomMargin: window.marginUnit
            leftMargin: window.marginUnit * 2
        }

        columns: 3
        rows: 11
        columnSpacing: window.marginUnit
        rowSpacing: window.marginUnit

        flow: GridLayout.TopToBottom

        Rectangle {
            id: topStatusBar
            color: "#212121"

            Layout.columnSpan: 3
            Layout.preferredWidth: parent.width - 180
            Layout.preferredHeight: parent.height / 11

            DropShadow {}
        }


        CandidateItem {
            Layout.column: 0
            Layout.row: 1
            Layout.rowSpan: 3
            Layout.preferredWidth: parent.width / 3
            Layout.preferredHeight: parent.height * (3 / 11)
            Layout.fillHeight: true
            candidateName: party1.candidateName
            partyColor: party1.partyColor
            majorUnit: party1.majorUnit
            minorUnit: party1.minorUnit
            percentage: party1.candidatePercentage
            avatar: party1.candidateSource
            elected: party1.candidateElected
        }

        CandidateItem {
            Layout.column: 0
            Layout.row: 4
            Layout.rowSpan: 3
            Layout.preferredWidth: parent.width / 3
            Layout.preferredHeight: parent.height * (3 / 11)
            Layout.fillHeight: true
            candidateName: party2.candidateName
            partyColor: party2.partyColor
            majorUnit: party2.majorUnit
            minorUnit: party2.minorUnit
            percentage: party2.candidatePercentage
            avatar: party2.candidateSource
            elected: party2.candidateElected
        }

        CandidateItem {
            Layout.column: 0
            Layout.row: 7
            Layout.rowSpan: 3
            Layout.preferredWidth: parent.width / 3
            Layout.preferredHeight: parent.height * (3 / 11)
            candidateName: party3.candidateName
            partyColor: party3.partyColor
            majorUnit: party3.majorUnit
            minorUnit: party3.minorUnit
            percentage: party3.candidatePercentage
            avatar: party3.candidateSource
            elected: party3.candidateElected
        }

        Rectangle {
            id: statusBar
            color: "#212121"

            Layout.column: 0
            Layout.row: 10
            Layout.columnSpan: 3
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height / 11

            DropShadow {}

            Item {
                id: marquee
                anchors {
                    top: parent.top
                    right: clock.left
                    bottom: parent.bottom
                    left: parent.left
                }
                clip: true

                GridLayout {
                    id: marqueeItems
                    width: parent.width
                    columns: 4
                    rowSpacing: 0

                    property int itemWidth: marquee.width / marqueeItems.columns

                    Repeater {
                        model: party1.nationalCandidates

                        SeatItem {
                            Layout.preferredHeight: marquee.height
                            Layout.preferredWidth: marqueeItems.itemWidth
                            seatName: modelData
                            partyColor: party1.partyColor
                            flagSource: party1.flagSource
                            elected: index < party1.seats
                        }
                    }

                    Repeater {
                        model: party2.nationalCandidates

                        SeatItem {
                            Layout.preferredHeight: marquee.height
                            Layout.preferredWidth: marqueeItems.itemWidth
                            seatName: modelData
                            partyColor: party2.partyColor
                            flagSource: party2.flagSource
                            elected: index < party2.seats
                        }
                    }

                    Repeater {
                        model: party3.nationalCandidates

                        SeatItem {
                            Layout.preferredHeight: marquee.height
                            Layout.preferredWidth: marqueeItems.itemWidth
                            seatName: modelData
                            partyColor: party3.partyColor
                            flagSource: party3.flagSource
                            elected: index < party3.seats
                        }
                    }
                }

                Text {
                    id: marqueeTitle
                    width: parent.width
                    height: marquee.height
                    anchors.top: marqueeItems.bottom
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    font.pointSize: 56
                    font.letterSpacing: 2
                    font.family: "LiHei Pro"
                    color: "white"
                    text: "中華民國不分區立委"
                }

                NumberAnimation {
                    id: scrollMarqueeEffect
                    target: marqueeItems
                    property: "y"
                    from: 0
                    to: -marquee.height
                    easing.type: Easing.OutBack
                    duration: 1000
                    onStopped: {
                        from = to
                        to = from - marquee.height
                        if (-to >= marqueeItems.height) {
                            from = marquee.height
                            to = 0
                        }
                    }
                }

                Timer {
                    interval: 7000
                    repeat: true
                    running: true
                    onTriggered: scrollMarqueeEffect.start()
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

        PieChart {
            id: screen
            Layout.columnSpan: 2
            Layout.rowSpan: 9
            Layout.fillWidth: true
            Layout.fillHeight: true

            DropShadow {}

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
        }
    }
}
