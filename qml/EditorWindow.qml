import QtQuick 2.1
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Window {
    id: window
    title: "Ostraka"

    function init() {
        window.flags |= Qt.WindowStaysOnTopHint
        window.width = Qt.binding(function() { return (helper.width + 20) })
        window.height = Qt.binding(function() { return (helper.height + 20) })
        window.show()
    }

    onClosing: Qt.quit()

    // ========= Window controls =========

    Item {
        id: helper
        anchors {
            top: presidentals.top
            right: localSeats.right
            bottom: localSeats.bottom
            left: localSeats.left
        }
    }

    ColumnGroup {
        id: presidentals
        anchors {
            top: parent.top
            left: parent.left
            margins: 10
        }

        text: "總統候選人"
        color: "#DCEDC8"

        Repeater {
            model: 3

            CandidateEditor {
                candidateName: app.parties[index].candidateName
                onBallotChanged: {
                    var ballots = ballot * 53000 + Math.round(Math.random() * 500)
                    majorValue = Math.floor(ballots / 10000)
                    minorValue = ballots % 10000
                    percentage = Math.round(ballots * 10000 / app.totalElectors) / 100
                }
                onMajorValueChanged: app.parties[index].majorUnit = majorValue
                onMinorValueChanged: app.parties[index].minorUnit = minorValue
                onPercentageChanged: app.parties[index].candidatePercentage = percentage / 100
                onElectedChanged: app.parties[index].candidateElected = elected
            }
        }
    }

    RowGroup {
        id: nationalSeats
        anchors {
            top: subtitles.bottom
            left: presidentals.right
            margins: 10
        }

        text: "不分區立委"
        color: "#B2EBF2"

        Repeater {
            model: 3

            SeatEditor {
                partyName: app.parties[index].partyName
                onBallotChanged: {
                    var percent = ballot / app.totalBallots
                    percentage = Math.round(percent * 10000) / 100
                    seats = Math.floor(percent * app.totalSeats)
                }
                onSeatsChanged: app.parties[index].seats = seats
                onPercentageChanged: app.parties[index].seatPercentage = percentage / 100
            }
        }
    }

    RowGroup {
        id: localSeats
        anchors {
            top: presidentals.bottom
            left: parent.left
            margins: 10
        }

        text: "區域立委"
        color: "#FFECB3"

        Repeater {
            model: 4

            Column {
                id: regionColumn
                spacing: 10
                property int regionIndex: index

                Text {
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    color: "#212121"
                    text: app.regions[index].name
                }

                Repeater {
                    model: 3

                    CandidateEditor {
                        candidateName: app.regions[regionColumn.regionIndex].candidates[index].candidateName
                        onBallotChanged: {
                            var ballots = ballot * 53000 + Math.round(Math.random() * 500)
                            majorValue = Math.floor(ballots / 10000)
                            minorValue = ballots % 10000
                            percentage = Math.round(ballot * 10000 / app.regions[regionIndex].totalBallots) / 100
                        }
                        onMajorValueChanged: app.regions[regionIndex].candidates[index].majorUnit = majorValue
                        onMinorValueChanged: app.regions[regionIndex].candidates[index].minorUnit = minorValue
                        onPercentageChanged: app.regions[regionIndex].candidates[index].percentage = percentage / 100
                        onElectedChanged: app.regions[regionIndex].candidates[index].elected = elected
                    }
                }
            }
        }
    }

    ColumnGroup {
        id: variables
        anchors {
            top: subtitles.bottom
            left: nationalSeats.right
            margins: 10
        }

        text: "參數"
        spacing: 2

        Row {
            spacing: 6

            Text {
                anchors.baseline: seatsSpin.baseline
                text: "不分區總席次"
            }

            SpinBox {
                id: seatsSpin
                decimals: 0
                minimumValue: 0
                maximumValue: 225
                suffix: " 位"
                stepSize: 1
                onValueChanged: app.totalSeats = value
                Component.onCompleted: value = app.totalSeats
            }
        }

        Row {
            spacing: 6

            Text {
                anchors.baseline: ballotsSpin.baseline
                text: "實際選舉人"
            }

            SpinBox {
                id: ballotsSpin
                decimals: 0
                minimumValue: 0
                maximumValue: 1000
                suffix: " 票"
                stepSize: 1
                onValueChanged: app.totalBallots = value
                Component.onCompleted: value = app.totalBallots
            }
        }

        Row {
            spacing: 6

            Text {
                anchors.baseline: electorsSpin.baseline
                text: "總選舉人"
            }

            SpinBox {
                id: electorsSpin
                decimals: 0
                minimumValue: 0
                maximumValue: 2147483647
                suffix: " 名"
                stepSize: 1
                onValueChanged: app.totalElectors = value
                Component.onCompleted: value = app.totalElectors
            }
        }
    }

    RowGroup {
        id: subtitles
        anchors {
            top: parent.top
            left: presidentals.right
            margins: 10
        }

        text: "字幕"
        spacing: 5

        TextField {
            id: subtitleField
            width: 320
            text: "投票時間結束 各開票所陸續回報狀態中"
            Keys.onReturnPressed: setSubtitleButton.clicked()
            Component.onCompleted: setSubtitleButton.clicked()
        }

        Button {
            id: setSubtitleButton
            anchors.baseline: subtitleField.baseline
            text: "置換"
            onClicked: if (subtitleField.length) app.titleText = subtitleField.text
        }
    }

    RowGroup {
        id: controls
        anchors {
            top: parent.top
            left: subtitles.right
            margins: 10
        }

        text: "導播模式"
        spacing: 5

        Button {
            text: "圖表"
            onClicked: app.viewState = "chart"
        }

        Button {
            text: "區域立委"
            onClicked: app.viewState = "seats"
        }

        Button {
            text: "影音"
            onClicked: app.viewState = "camera"
        }
    }
}
