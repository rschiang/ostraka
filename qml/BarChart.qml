import QtQuick 2.0

Rectangle {
    id: root

    // Properties
    property string title
    property string description
    property list<ChartItem> items

    // Display properties
    property int barSpacing: 5
    property int rightMargin: 60 * window.scaleFactor
    readonly property int barHeight: (chartArea.height - barSpacing * (items.length - 1)) / items.length

    color: "#607D8B"

    // Components
    Image {
        anchors.fill: parent
        source: "qrc:/assets/ambient.svg"
    }

    Rectangle {
        id: titleBlock
        anchors {
            top: parent.top
            left: parent.left
            margins: 10
        }
        width: titleLabel.contentWidth + 8
        height: titleLabel.contentHeight - 8

        radius: 2
        color: "white"
    }

    Text {
        id: titleLabel
        anchors.centerIn: titleBlock

        font.pointSize: 32 * window.scaleFactor
        font.letterSpacing: -1
        font.family: "Pingfang TC"
        font.weight: Font.DemiBold
        color: "#1D262A"
        text: root.title
    }

    Text {
        id: descriptionLabel
        anchors {
            left: titleBlock.right
            leftMargin: 10
            baseline: titleLabel.baseline
        }

        font.pointSize: 32 * window.scaleFactor
        font.letterSpacing: -1
        font.family: "Pingfang TC"
        font.weight: Font.Normal
        color: "white"
        text: root.description
    }

    Column {
        id: chartArea
        anchors {
            top: titleBlock.bottom
            right: parent.right
            bottom: parent.bottom
            left: parent.left
            margins: 10
        }
        spacing: root.barSpacing

        Repeater {
            model: root.items

            Item {
                id: barItem
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: root.barHeight

                Rectangle {
                    id: bar
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: parent.left
                    }

                    width: (parent.width - root.rightMargin) * modelData.percentage
                    color: modelData.color
                }

                Image {
                    anchors.fill: bar
                    source: "qrc:/assets/bar.svg"
                    fillMode: Image.Stretch
                }

                Text {
                    id: label
                    anchors {
                        left: bar.right
                        leftMargin: 5
                        verticalCenter: bar.verticalCenter
                    }

                    font.pointSize: 24 * window.scaleFactor
                    font.letterSpacing: -2
                    font.family: "Overpass"
                    font.weight: Font.DemiBold
                    color: Qt.lighter(modelData.color, 1.66)
                    text: (modelData.percentage * 100).toFixed(1) + "%"
                }
            }
        }
    }
}
