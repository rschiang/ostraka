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
            top: parent.top
            left: presidentals.right
            margins: 10
        }

        text: "不分區立委"

        Repeater {
            model: 3

            SeatEditor {
                partyName: app.parties[index].partyName
                onBallotChanged: {
                    var percent = ballot / 300
                    percentage = Math.round(percent * 10000) / 100
                    seats = Math.round(percent * app.totalSeats)
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
}
