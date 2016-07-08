import QtQuick 2.0

Item {
    id: marquee
    clip: true

    // Properties
    default property alias contents: items.children
    property alias speed: effect.duration

    Row {
        id: items
        anchors {
            top: parent.top
            bottom: parent.bottom
        }
        x: 0
        spacing: 60 * window.scaleFactor
    }

    NumberAnimation {
        id: effect
        target: items
        property: "x"
        duration: 12500
        easing.type: Easing.Linear
        onStopped: scroll()
        Component.onCompleted: scroll()

        function scroll() {
            to = items.x - marquee.width
            if (-to >= (marquee.width + items.width)) {
                items.x = marquee.width
                to = 0
            }
            start()
        }
    }
}
