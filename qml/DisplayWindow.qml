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

    Column {
        id: candidates
        width: window.width / 4
        anchors {
            top: parent.top
            bottom: statusBar.top
            left: parent.left
            margins: 8
        }
        spacing: 8

        CandidateItem {
            width: parent.width
            height: parent.height / 3
            candidateName: party1.candidateName
            partyColor: party1.partyColor
            majorUnit: party1.majorUnit
            minorUnit: party1.minorUnit
            percentage: party1.candidatePercentage
            avatar: party1.candidateSource
            elected: party1.candidateElected
        }

        CandidateItem {
            width: parent.width
            height: parent.height / 3
            candidateName: party2.candidateName
            partyColor: party2.partyColor
            majorUnit: party2.majorUnit
            minorUnit: party2.minorUnit
            percentage: party2.candidatePercentage
            avatar: party2.candidateSource
            elected: party2.candidateElected
        }

        CandidateItem {
            width: parent.width
            height: parent.height / 3
            candidateName: party3.candidateName
            partyColor: party3.partyColor
            majorUnit: party3.majorUnit
            minorUnit: party3.minorUnit
            percentage: party3.candidatePercentage
            avatar: party3.candidateSource
            elected: party3.candidateElected
        }
    }

    Row {
        id: parties
        height: window.height * 0.25
        anchors {
            bottom: titleBar.top
            left: candidates.right
            right: parent.right
        }

        PartyItem {
            width: parent.width / 3
            height: parent.height
            partyName: party1.partyName
            partyColor: party1.partyColor
            seats: party1.seats
            percentage: party1.seatPercentage
            flagSource: party1.flagSource
        }

        PartyItem {
            width: parent.width / 3
            height: parent.height
            partyName: party2.partyName
            partyColor: party2.partyColor
            seats: party2.seats
            percentage: party2.seatPercentage
            flagSource: party2.flagSource
        }

        PartyItem {
            width: parent.width / 3
            height: parent.height
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
            bottom: parties.top
            left: candidates.right
            right: parent.right
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
    }

    Rectangle {
        id: titleBar
        height: parent.height / 10
        anchors.left: candidates.right
        anchors.right: parent.right
        anchors.bottom: statusBar.top
        color: "orange"

        Text {
            id: titleLabel
            x: parent.width * 0.05
            y: parent.height * 0.02
            font.pointSize: 112
            font.weight: Font.Bold
            font.letterSpacing: -5
            font.family: "Pingfang TC"
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

    Item {
        id: statusBar
        width: parent.width
        height: parent.height * 0.1
        anchors.bottom: parent.bottom

        ClockItem {
            id: clockArea
            width: parent.width * 0.15
            height: parent.height
        }

        Item {
            id: marquee
            height: parent.height
            anchors.left: clockArea.right
            anchors.right: parent.right
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
    }
}
