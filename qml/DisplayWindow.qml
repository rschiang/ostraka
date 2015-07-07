import QtQuick 2.1
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Window {
    id: window
    title: "Ostraka"
    width: 800
    height: 600
    visible: true
    color: "black"

    Component.onCompleted: {
        window.flags |= Qt.WindowDoesNotAcceptFocus
    }

    Image {
        id: logo
        width: parent.width * 0.1
        height: width
        anchors {
            top: parent.top
            right: parent.right
            topMargin: parent.height * 0.05
            rightMargin: parent.width * 0.05
        }
        z: 100
        horizontalAlignment: Image.AlignRight
        verticalAlignment: Image.AlignTop
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/logo.png"
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
                percentage: party1.candidatePercentage
                avatar: party1.candidateSource
            }

            CandidateItem {
                width: table.width / 3
                height: table.height / 3
                candidateName: party2.candidateName
                partyColor: party2.partyColor
                majorUnit: party2.majorUnit
                minorUnit: party2.minorUnit
                percentage: party2.candidatePercentage
                avatar: party2.candidateSource
            }

            CandidateItem {
                width: table.width / 3
                height: table.height / 3
                candidateName: party3.candidateName
                partyColor: party3.partyColor
                majorUnit: party3.majorUnit
                minorUnit: party3.minorUnit
                percentage: party3.candidatePercentage
                avatar: party3.candidateSource
            }
        }

        Column {
            Row {
                PieChart {
                    id: candidateChart
                    width: table.width / 3
                    height: table.height * (2 / 3)
                }

                PieChart {
                    id: seatChart
                    width: table.width / 3
                    height: table.height * (2 / 3)
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
            font.pointSize: 56
            font.weight: Font.Bold
            font.letterSpacing: -2
            font.family: "Myriad Pro"
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

            GridLayout {
                id: marqueeItems
                width: parent.width
                columns: 4
                rowSpacing: 0

                property int itemWidth: marquee.width / marqueeItems.columns

                Repeater {
                    model: party1.seatCandidates

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
                    model: party2.seatCandidates

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
                    model: party3.seatCandidates

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
                font.family: "Apple LiGothic"
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
    }
}
