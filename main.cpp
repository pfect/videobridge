/*
 * 'videobridge' - simple QML sample to show two UDP video streams.
 *
 * Based on:  https://github.com/b2open/qt-rtsp-test/tree/qml
 *
 * Required packages:
 * libqt5multimedia5-plugins qml-module-qtmultimedia libqt5multimedia
 * qml-module-qtquick-controls2
 *
 *
 */

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
