/*
 * 'videobridge' - simple QML sample to show two UDP video streams.
 *
 * Based on:  https://github.com/b2open/qt-rtsp-test/tree/qml
 *
 * Required packages:
 * libqt5multimedia5-plugins qml-module-qtmultimedia5 libqt5multimedia
 * qml-module-qtquick-controls2 qtdeclarative5-dev
 *
 *
 */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include "bridge.h"

bridge *vBridge;

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    vBridge = new bridge();
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("vBridge", vBridge);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    return app.exec();
}
