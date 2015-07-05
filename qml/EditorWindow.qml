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
            width: parent.width

            Repeater {
                model: 3

                Row {
                    width: parent.width

                    SpinBox {
                        id: ballotSpin
                        width: parent.width / 6
                        font.pointSize: 14
                        decimals: 0
                        minimumValue: 0
                        maximumValue: 999
                        stepSize: 1
                        suffix: " 選票"
                        onValueChanged: {
                            var ballots = value * 53000 + Math.round(Math.random() * 500)
                            majorSpin.value = Math.floor(ballots / 10000)
                            minorSpin.value = ballots % 10000
                            candidatePercentSpin.value = Math.round(ballots * 100 / 6891139)
                        }
                    }

                    SpinBox {
                        id: majorSpin
                        width: parent.width / 6
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
                        width: parent.width / 6
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
                        width: parent.width / 6
                        font.pointSize: 14
                        decimals: 0
                        minimumValue: 0
                        maximumValue: 100
                        stepSize: 1
                        suffix: " %"
                        onValueChanged: {
                            app.parties[index].candidatePercentage = value / 100.0
                        }
                    }
                }
            }
        }

        TextArea {
            id: marqueeField
            width: parent.width
            Layout.fillHeight: true
            font.pointSize: 14
            text: "跑馬燈這裡要放總共最多十五個字"
            onTextChanged: app.marqueeText = text
        }
    }
}
