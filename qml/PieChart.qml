import QtQuick 2.0
import QtCanvas3D 1.0
import "PieChart.js" as Script

Canvas3D {
    id: root

    // Properties
    property list<ChartItem> items

    // Drawing events

    onInitializeGL: Script.initializeGL(root)
    onPaintGL: Script.paintGL(root)
    onResizeGL: Script.resizeGL(root)
}
