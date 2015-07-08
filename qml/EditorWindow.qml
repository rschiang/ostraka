import QtQuick 2.1
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Window {
    id: window
    title: "Ostraka"

    function init() {
        window.flags |= Qt.WindowStaysOnTopHint
        window.width = 400
        window.height = 300
        window.show()
    }

    onClosing: Qt.quit()

    // ========= Window controls =========

    Column {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        TextField {
            id: titleField
            width: parent.width
            font.pointSize: 21
            font.weight: Font.DemiBold
            placeholderText: "震驚！舟山河親水樂園捕獲鯰魚"
            text: "震驚！舟山河親水樂園捕獲鯰魚"
            onTextChanged: app.titleText = text
        }

        Column {
            Row {
                spacing: 6

                Text {
                    width: contentWidth
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                    text: "總選舉人"
                }

                SpinBox {
                    id: electorsSpin
                    font.pointSize: 14
                    decimals: 0
                    minimumValue: 0
                    maximumValue: 2147483647
                    stepSize: 1
                    onValueChanged: app.totalElectors = value
                    Component.onCompleted: value = app.totalElectors
                }
            }

            Row {
                spacing: 6

                Text {
                    width: contentWidth
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 14
                    text: "不分區總席次"
                }

                SpinBox {
                    id: seatsSpin
                    font.pointSize: 14
                    decimals: 0
                    minimumValue: 0
                    maximumValue: 225
                    stepSize: 1
                    onValueChanged: app.totalSeats = value
                    Component.onCompleted: value = app.totalSeats
                }
            }
        }

        Column {
            Repeater {
                model: 3

                Row {
                    CheckBox {
                        id: electedCheckBox
                        anchors.verticalCenter: parent.verticalCenter
                        text: app.parties[index].candidateName + " "
                        onCheckedChanged: {
                            app.parties[index].candidateElected = checked
                        }
                    }

                    SpinBox {
                        id: ballotSpin
                        font.pointSize: 14
                        decimals: 0
                        minimumValue: 0
                        maximumValue: 999
                        stepSize: 1
                        onValueChanged: {
                            var ballots = value * 53000 + Math.round(Math.random() * 500)
                            majorSpin.value = Math.floor(ballots / 10000)
                            minorSpin.value = ballots % 10000
                            candidatePercentSpin.value = Math.round(ballots * 1000 / app.totalElectors) / 10
                        }
                    }

                    Text {
                        width: contentWidth
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 14
                        text: "→"
                    }

                    SpinBox {
                        id: majorSpin
                        font.pointSize: 14
                        decimals: 0
                        minimumValue: 0
                        maximumValue: 689
                        stepSize: 1
                        suffix: " 萬"
                        onValueChanged: {
                            app.parties[index].majorUnit = value
                        }
                    }

                    SpinBox {
                        id: minorSpin
                        font.pointSize: 14
                        decimals: 0
                        minimumValue: 0
                        maximumValue: 9999
                        stepSize: 1
                        suffix: " 票"
                        onValueChanged: {
                            app.parties[index].minorUnit = value
                        }
                    }

                    SpinBox {
                        id: candidatePercentSpin
                        font.pointSize: 14
                        decimals: 1
                        minimumValue: 0
                        maximumValue: 100
                        stepSize: 1
                        suffix: " %"
                        onValueChanged: {
                            app.parties[index].candidatePercentage = value / 100.0
                        }
                    }

                    Image {
                        id: electedIcon
                        anchors.verticalCenter: parent.verticalCenter
                        width: 16
                        height: 16
                        source: "qrc:/assets/elected.png"
                        visible: electedCheckBox.checked
                    }
                }
            }
        }

        Column {
            Repeater {
                model: 3

                Row {
                    Text {
                        width: contentWidth + 6
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 14
                        text: app.parties[index].partyName
                    }

                    SpinBox {
                        id: seatSpin
                        font.pointSize: 14
                        decimals: 0
                        minimumValue: 0
                        maximumValue: app.totalSeats
                        stepSize: 1
                        suffix: " 席"
                        onValueChanged: {
                            app.parties[index].seats = value
                            seatPercentageSpin.value = value * 100 / app.totalSeats
                        }
                    }

                    SpinBox {
                        id: seatPercentageSpin
                        font.pointSize: 14
                        decimals: 0
                        minimumValue: 0
                        maximumValue: 100
                        stepSize: 1
                        suffix: " %"
                        onValueChanged: {
                            app.parties[index].seatPercentage = value / 100.0
                        }
                    }
                }
            }
        }

        Row {
            spacing: 6

            Text {
                width: contentWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 14
                text: "備用標題"
            }

            TextField {
                id: altTitleField
                //width: window.width / 2
                font.pixelSize: 14
                text: "中央氣象局呼籲選民積極出門投票"
            }

            Button {
                id: swapTitleButton
                text: "置換"
                onClicked: {
                    if (altTitleField.length) {
                        var str = titleField.text
                        titleField.text = altTitleField.text
                        altTitleField.text = str
                    }
                }
            }
        }
    }
}
