TEMPLATE = app
TARGET = Ostraka
QT += qml quick

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += \
    src/main.cpp \
    src/OstrakaNativeHandler.cpp

HEADERS += \
    src/OstrakaNativeHandler.h

RESOURCES += \
    main.qrc

OTHER_FILES += qml/*.qml

QML_IMPORT_PATH += qml/

mac {
    QMAKE_INFO_PLIST = platform/mac/Info.plist
    ICON = platform/mac/icon.icns
    QMAKE_MAC_SDK = macosx10.9

    CONFIG(build_release) {
        QMAKE_POST_LINK += macdeployqt Ostraka.app -qmldir=../ostraka/qml/ -verbose=1 -dmg;
    }
}

DISTFILES += \
    qml/CandidateItem.qml
