import QtQuick 2.0

Text {
    id: label

    onTextChanged: {
        if (effect.running)
            effect.stop()
        effect.start()
    }

    NumberAnimation on opacity {
        id: effect
        from: 0; to: 1
        duration: 500
        easing.type: Easing.OutQuad
    }
}
