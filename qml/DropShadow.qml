import QtQuick 2.0

BorderImage {
    id: shadow
    x: -8
    y: -8
    width: parent.width + 16
    height: parent.height + 16

    source: "qrc:/assets/drop_shadow.png"
    border {
        top: 8
        right: 8
        bottom: 8
        left: 8
    }
}
