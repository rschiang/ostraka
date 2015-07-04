#ifndef OSTRAKANATIVEHANDLER_H
#define OSTRAKANATIVEHANDLER_H

#include <QObject>
#include <QWindow>
#include <QScreen>
#include <QQmlEngine>
#include <QGuiApplication>

class OstrakaNativeHandler : public QObject
{
    Q_OBJECT
public:
    explicit OstrakaNativeHandler(QGuiApplication* parent);
    Q_INVOKABLE QVariantList getScreens();
    Q_INVOKABLE QScreen* getPrimaryScreen();
    Q_INVOKABLE void setScreen(QWindow* window, QScreen* screen);

private:
    QGuiApplication* app;
};

#endif // OSTRAKANATIVEHANDLER_H
