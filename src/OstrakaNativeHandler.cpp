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

QString OstrakaNativeHandler::readFile(QString path) {
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly)) {
        return "";
    }

    QTextStream in(&file);
    QString result = in.readAll();

    file.close();
    return result;
}

QString OstrakaNativeHandler::getFilePath(QString path) {
    QDir dir = QDir(QGuiApplication::applicationDirPath());
#ifdef Q_OS_MAC
    dir.cdUp();
    dir.cdUp();
    dir.cdUp();
#endif
    return dir.absoluteFilePath(path);
}
