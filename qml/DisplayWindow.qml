import QtQuick 2.1
import QtQuick.Window 2.2

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

    Loader {
        id: content
        anchors {
            top: topStatusBar.bottom
            topMargin: window.marginUnit
            right: boundary.right
            left: boundary.left
            bottom: statusBar.top
            bottomMargin: window.marginUnit
        }

        source: (app.viewState == 'chart' ? "ChartView.qml" :
                 app.viewState == 'seats' ? "LocalSeatView.qml" :
                                            "CameraView.qml")
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
