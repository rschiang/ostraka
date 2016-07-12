import QtQuick 2.0

Text {
    id: label
    transformOrigin: Item.TopLeft
    transform: [
        Scale {
            xScale: Math.min(label.width / label.contentWidth, 1)
        }
    ]
}
