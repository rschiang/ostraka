import QtQuick 2.1

Rectangle {
    id: root
    color: "#455A64"
    implicitWidth: 160 * window.scaleFactor

    Text {
        id: clock
        anchors.centerIn: parent
        font.pixelSize: 54 * window.scaleFactor
        font.family: "Overpass"
        font.weight: Font.Light
        font.letterSpacing: -2
        color: "white"
        text: "16:03"
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
