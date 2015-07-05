import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

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
        }

        Row {
            width: parent.width

            Column {
                width: parent.width / 2

                Repeater {
                    model: 3
                    SpinBox {
                        width: parent.width
                        font.pointSize: 14
                        decimals: 0
                        minimumValue: 0
                        maximumValue: 689
                        stepSize: 1
                        suffix: " 萬"
                    }
                }
            }

            Column {
                width: parent.width / 2

                Repeater {
                    model: 3

                    Row {
                        width: parent.width

                        SpinBox {
                            id: delegateSpinBox
                            width: parent.width / 2
                            font.pointSize: 14
                            decimals: 0
                            minimumValue: 0
                            maximumValue: 689
                            stepSize: 1
                            onValueChanged: delegatePercentage.text = value + "%"
                        }

                        TextField {
                            id: delegatePercentage
                            width: parent.width / 2
                            font.pointSize: 14
                            text: "9.2%"
                        }
                    }
                }
            }
        }

        TextArea {
            id: marqueeField
            width: parent.width
            height: 90
            font.pointSize: 14
            text: "跑馬燈這裡要放總共最多十五個字"
        }
    }
}
