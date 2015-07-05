import QtQuick 2.1
import QtQuick.Window 2.2
import "jbQuick/Charts"
import "jbQuick/Charts/QChart.js" as Charts

Window {
    id: window
    title: "Ostraka"
    width: 800
    height: 600
    visible: true

    Component.onCompleted: {
        window.flags |= Qt.WindowDoesNotAcceptFocus
    }

    Row {
        id: table
        anchors {
            top: parent.top
            bottom: titleBar.top
            left: parent.left
            right: parent.right
        }

        Column {
            id: candidates
            CandidateItem {
                width: table.width / 3
                height: table.height / 3
                candidateName: party1.candidateName
                partyColor: party1.partyColor
                majorUnit: party1.majorUnit
                minorUnit: party1.minorUnit
                avatar: party1.candidateSource
            }

            CandidateItem {
                width: table.width / 3
                height: table.height / 3
                candidateName: party2.candidateName
                partyColor: party2.partyColor
                majorUnit: party2.majorUnit
                minorUnit: party2.minorUnit
                avatar: party2.candidateSource
            }

            CandidateItem {
                width: table.width / 3
                height: table.height / 3
                candidateName: party3.candidateName
                partyColor: party3.partyColor
                majorUnit: party3.majorUnit
                minorUnit: party3.minorUnit
                avatar: party3.candidateSource
            }
        }

        Column {
            Row {
                height: table.height * (2 / 3)

                Chart {
                    id: pieChart
                    width: window.width / 3
                    height: parent.height
                    chartAnimated: false
                    chartType: Charts.ChartType.PIE
                    chartData: ([
                        { value: 10, color: party1.partyColor },
                        { value: 10, color: party2.partyColor },
                        { value: 10, color: party3.partyColor },
                    ])

                    function getChartData() {
                        return [
                                    { value: party1.seatPercentage, color: party1.partyColor },
                                    { value: party2.seatPercentage, color: party2.partyColor },
                                    { value: party3.seatPercentage, color: party3.partyColor },
                                ]
                    }

                    function update() {
                        pieChart.chartData = getChartData()
                    }

                    Connections {
                        target: party1
                        onSeatPercentageChanged: pieChart.update()
                    }

                    Connections {
                        target: party2
                        onSeatPercentageChanged: pieChart.update()
                    }

                    Connections {
                        target: party3
                        onSeatPercentageChanged: pieChart.update()
                    }
                }

                Image {
                    id: screen
                    width: window.width / 3
                    height: parent.height
                    source: "file:///Users/RSChiang/Desktop/placeholder.jpg"
                    fillMode: Image.PreserveAspectCrop
                    horizontalAlignment: Image.AlignHCenter
                }
            }

            Row {
                height: table.height / 3

                PartyItem {
                    width: table.width * (2 / 9)
                    height: parent.height
                    partyName: party1.partyName
                    partyColor: party1.partyColor
                    seats: party1.seats
                    percentage: party1.seatPercentage
                    flagSource: party1.flagSource
                }

                PartyItem {
                    width: table.width * (2 / 9)
                    height: parent.height
                    partyName: party2.partyName
                    partyColor: party2.partyColor
                    seats: party2.seats
                    percentage: party2.seatPercentage
                    flagSource: party2.flagSource
                }

                PartyItem {
                    width: table.width * (2 / 9)
                    height: parent.height
                    partyName: party3.partyName
                    partyColor: party3.partyColor
                    seats: party3.seats
                    percentage: party3.seatPercentage
                    flagSource: party3.flagSource
                }
            }
        }
    }

    Rectangle {
        id: titleBar
        width: parent.width
        height: parent.height * 0.2
        anchors.bottom: statusBar.top
        color: "orange"

        Text {
            id: titleLabel
            x: parent.width * 0.05
            y: parent.height * 0.02
            font.pointSize: 112
            font.weight: Font.Bold
            font.letterSpacing: -5
            font.family: "Hiragino Kaku Gothic ProN W6"
            color: "black"
            text: app.titleText

            transformOrigin: Item.TopLeft
            transform: [
                Scale {
                    xScale: Math.min(titleBar.width * 0.9 / titleLabel.contentWidth, 1)
                    yScale: titleBar.height * 0.96 / titleLabel.contentHeight
                }
            ]
        }
    }

    Rectangle {
        id: statusBar
        width: parent.width
        height: parent.height * 0.1
        anchors.bottom: parent.bottom
        color: "black"

        Text {
            id: clock
            width: parent.width * 0.15
            height: parent.height
            anchors.left: parent.left
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            fontSizeMode: Text.Fit
            font.pointSize: 45
            font.weight: Font.DemiBold
            font.letterSpacing: 2
            font.family: "Avenir Next Condensed"
            color: "white"
            text: "12:07:05"
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                var date = new Date()
                var hour = date.getHours()
                var minute = date.getMinutes()
                var second = date.getSeconds()
                clock.text = (hour >= 10 ? hour : "0" + hour) + ":" +
                             (minute >= 10 ? minute : "0" + minute) + ":" +
                             (second >= 10 ? second : "0" + second)
            }
        }

        Item {
            id: marquee
            height: parent.height
            anchors.left: clock.right
            anchors.right: parent.right
            clip: true

            Row {
                id: marqueeItems
                height: parent.height

                Repeater {
                    model: party1.seatCandidates

                    SeatItem {

                    }
                }
            }

            NumberAnimation {
                target: marqueeItems
                property: "x"
                from: window.width
                to: -(window.width)
                loops: Animation.Infinite
                duration: 10000
                running: true
            }
        }
    }
}
