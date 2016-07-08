import QtQuick 2.1

Item {
    id: root

    Text {
        id: clock
        anchors.fill: parent
        anchors.margins: 6
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height * 0.75
        font.weight: Font.Normal
        font.letterSpacing: -5
        font.family: "Overpass"
        color: "black"
        text: "12:07"
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            var date = new Date()
            var hour = date.getHours()
            var minute = date.getMinutes()
            var second = date.getSeconds()
            clock.text = (hour >= 10 ? hour : "0" + hour) + ":" +
                         (minute >= 10 ? minute : "0" + minute)
        }
    }
}
