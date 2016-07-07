#ifndef OSTRAKANATIVEHANDLER_H
#define OSTRAKANATIVEHANDLER_H

#include <QObject>
#include <QWindow>
#include <QScreen>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QFile>
#include <QTextStream>
#include <QDir>

class OstrakaNativeHandler : public QObject
{
    Q_OBJECT
public:
    explicit OstrakaNativeHandler(QGuiApplication* parent);
    Q_INVOKABLE QVariantList getScreens();
    Q_INVOKABLE QScreen* getPrimaryScreen();
    Q_INVOKABLE void setScreen(QWindow* window, QScreen* screen);
    Q_INVOKABLE QString readFile(QString path);
    Q_INVOKABLE QString getFilePath(QString path);

private:
    QGuiApplication* app;
};

#endif // OSTRAKANATIVEHANDLER_H
