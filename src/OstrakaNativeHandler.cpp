#include "OstrakaNativeHandler.h"

OstrakaNativeHandler::OstrakaNativeHandler(QGuiApplication* parent)
    : QObject(parent)
{
    this->app = parent;
}

QVariantList OstrakaNativeHandler::getScreens() {
    QVariantList screens;
    foreach (QScreen* screen, QGuiApplication::screens()) {
        screens << QVariant::fromValue(screen);
        QQmlEngine::setObjectOwnership(screen, QQmlEngine::CppOwnership);
    }
    return screens;
}

QScreen* OstrakaNativeHandler::getPrimaryScreen() {
    return QGuiApplication::primaryScreen();
}

void OstrakaNativeHandler::setScreen(QWindow *window, QScreen *screen) {
    window->setScreen(screen);
    window->setGeometry(screen->availableGeometry());
}
