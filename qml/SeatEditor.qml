import QtQuick 2.0
import QtQuick.Controls 1.2

Column {
    id: root

    property alias partyName: label.text
    property alias ballot: ballotSpin.value
    property alias seats: seatSpin.value
    property alias percentage: percentSpin.value

    Row {
        Text {
            id: label
        }

        SpinBox {
            id: ballotSpin
            anchors.baseline: label.baseline
            decimals: 0
            minimumValue: 0
            maximumValue: 240
            stepSize: 1
        }
    }

    Row {
        SpinBox {
            id: seatSpin
            font.pointSize: 14
            decimals: 0
            minimumValue: 0
            maximumValue: app.totalSeats
            stepSize: 1
            suffix: " 席"
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
