import QtQuick 2.0
import QtQuick.Controls 1.2

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
