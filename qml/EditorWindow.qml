import QtQuick 2.1
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Window {
    id: window
    title: "Ostraka"

    function init() {
        window.flags |= Qt.WindowStaysOnTopHint
        window.width = 800
        window.height = Qt.binding(function() { return (mainColumn.height + 20) })
        window.show()
    }

    onClosing: Qt.quit()

    // ========= Window controls =========

    Column {
        id: mainColumn
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 10
        }

        ColumnGroup {
            id: presidentalColumn
            text: "總統候選人"

            Row {
                spacing: 10

                Repeater {
                    model: 3

                    CandidateEditor {
                        candidateName: app.parties[index].candidateName
                        onBallotChanged: {
                            var ballots = ballot * 53000 + Math.round(Math.random() * 500)
                            majorValue = Math.floor(ballots / 10000)
                            minorValue = ballots % 10000
                            percentage = Math.round(ballots * 1000 / app.totalElectors) / 10
                        }
                        onMajorValueChanged: app.parties[index].majorUnit = majorValue
                        onMinorValueChanged: app.parties[index].minorUnit = minorValue
                        onPercentageChanged: app.parties[index].candidatePercentage = percentage / 100
                        onElectedChanged: app.parties[index].candidateElected = elected
                    }
                }
            }
        }
    }
}
