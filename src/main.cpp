#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "OstrakaNativeHandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("Ostraka");
    app.setOrganizationName("NTUOSC");
    app.setOrganizationDomain("ostraka.ntuosc.org");

    LitNativeHandler native(&app);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Native", &native);
    engine.load(QUrl("qrc:/qml/main.qml"));

    return app.exec();
}
