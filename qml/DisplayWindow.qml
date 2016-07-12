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

        MarqueeItem {
            id: topMarquee
            anchors.fill: parent
            speed: 8000
            spacing: 120 * window.scaleFactor

            Repeater {
                model: app.regions

                Row {
                    spacing: 60 * window.scaleFactor

                    Text {
                        id: regionLabel
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 42 * window.scaleFactor
                        font.letterSpacing: -2
                        font.family: "Pingfang TC"
                        font.weight: Font.DemiBold
                        color: "white"
                        text: modelData.name
                    }

                    Repeater {
                        model: modelData.candidates

                        LocalCandidateBadge {
                            anchors.verticalCenter: parent.verticalCenter
                            number: index + 1
                            name: modelData.candidateName
                            votes: modelData.majorUnit * 10000 + modelData.minorUnit
                            partyColor: modelData.partyColor
                            elected: modelData.elected
                        }
                    }
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
            text: "全國不分區"
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

                CandidateBadge {
                    anchors.verticalCenter: parent.verticalCenter
                    name: modelData
                    number: index + 1
                    partyColor: party1.partyColor
                    elected: index < party1.seats
                }
            }

            Repeater {
                model: party2.nationalCandidates

                CandidateBadge {
                    anchors.verticalCenter: parent.verticalCenter
                    name: modelData
                    number: index + 1
                    partyColor: party2.partyColor
                    elected: index < party2.seats
                }
            }

            Repeater {
                model: party3.nationalCandidates

                CandidateBadge {
                    anchors.verticalCenter: parent.verticalCenter
                    name: modelData
                    number: index + 1
                    partyColor: party3.partyColor
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
