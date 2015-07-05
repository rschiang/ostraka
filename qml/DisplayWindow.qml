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
                candidateName: "彭立言"
                partyColor: "#388E3C"
                majorUnit: 689
                minorUnit: 5284
                avatar: "file:///Users/RSChiang/Desktop/avatar.jpg"
            }

            CandidateItem {
                width: table.width / 3
                height: table.height / 3
                candidateName: "彭臥言"
                partyColor: "#0288D1"
                majorUnit: 609
                minorUnit: 902
                avatar: "file:///Users/RSChiang/Desktop/avatar.jpg"
            }

            CandidateItem {
                width: table.width / 3
                height: table.height / 3
                candidateName: "彭仰言"
                partyColor: "#E64A19"
                majorUnit: 15
                minorUnit: 1030
                avatar: "file:///Users/RSChiang/Desktop/avatar.jpg"
            }
        }

        Column {
            Row {
                height: table.height * (2 / 3)

                Chart {
                    id: pieChart
                    width: window.width / 3
                    height: parent.height
                    chartAnimated: true
                    chartAnimationEasing: Easing.OutBack
                    chartAnimationDuration: 2000
                    chartType: Charts.ChartType.PIE
                    chartData: ([
                                    { value: 54, color: "#388E3C" },
                                    { value: 28, color: "#0288D1" },
                                    { value: 18, color: "#E64A19" },
                                ])
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
                    partyName: "綠綠黨"
                    partyColor: "#388E3C"
                    seats: 27
                    percentage: 0.54
                    flagSource: "file:///Users/RSChiang/Desktop/party1.jpg"
                }

                PartyItem {
                    width: table.width * (2 / 9)
                    height: parent.height
                    partyName: "藍藍黨"
                    partyColor: "#0288d1"
                    seats: 14
                    percentage: 0.28
                    flagSource: "file:///Users/RSChiang/Desktop/party2.jpg"
                }

                PartyItem {
                    width: table.width * (2 / 9)
                    height: parent.height
                    partyName: "橘橘黨"
                    partyColor: "#e64a19"
                    seats: 9
                    percentage: 0.18
                    flagSource: "file:///Users/RSChiang/Desktop/party3.png"
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
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    color: "white"
                    font.pointSize: 56
                    text: app.marqueeText
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
