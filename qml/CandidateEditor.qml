import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Column {
    id: root

    property alias candidateName: electedCheckBox.text
    property alias ballot: ballotSpin.value
    property alias majorValue: majorSpin.value
    property alias minorValue: minorSpin.value
    property alias percentage: percentSpin.value
    property alias elected: electedCheckBox.checked

    Row {
        spacing: 5

        CheckBox {
            id: electedCheckBox
            style: CheckBoxStyle {
                indicator: Rectangle {
                    implicitWidth: 20
                    implicitHeight: 20
                    radius: 4
                    border.width: 1
                    border.color: "#757575"

                    Image {
                        anchors.centerIn: parent
                        visible: control.checked
                        width: 16
                        height: 16
                        source: "qrc:/assets/elected.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }

        SpinBox {
            id: ballotSpin
            anchors.baseline: electedCheckBox.baseline
            decimals: 0
            minimumValue: 0
            maximumValue: app.totalBallots
            stepSize: 1
        }
    }

    Row {
        SpinBox {
            id: majorSpin
            decimals: 0
            minimumValue: 0
            maximumValue: 2300
            stepSize: 1
            suffix: " 萬"
        }

        SpinBox {
            id: minorSpin
            decimals: 0
            minimumValue: 0
            maximumValue: 9999
            stepSize: 1
            suffix: " 票"
        }

        SpinBox {
            id: percentSpin
            decimals: 2
            minimumValue: 0
            maximumValue: 100
            stepSize: 1
            suffix: " %"
        }
    }
}
