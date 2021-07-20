#include "bridge.h"
#include <QSettings>
#include <QDebug>

bridge::bridge(QObject *parent) : QObject(parent)
{
    // writeSettings(); // uncomment to write template ini
    readSettings();
    qDebug() << "Local: " << mLocalVideoUrl << " Remote:" << mRemoteVideoUrl;
}

QString bridge::getLocalVideoUrl()
{
    return mLocalVideoUrl;
}

QString bridge::getRemoteVideoUrl()
{
    return mRemoteVideoUrl;
}

void bridge::readSettings()
{
    QSettings settings("/opt/videobridge/bridge.ini", QSettings::IniFormat);
    mLocalVideoUrl = settings.value("sources/localvideourl", "udp://127.0.0.1:4999").toString();
    mRemoteVideoUrl = settings.value("sources/remotevideourl", "udp://127.0.0.1:4999").toString();
}

void bridge::writeSettings(QString localUrl, QString remoteUrl)
{
    QSettings settings("/opt/videobridge/bridge.ini", QSettings::IniFormat);
    settings.setValue("sources/localvideourl", localUrl);
    settings.setValue("sources/remotevideourl", remoteUrl);
    readSettings();
    emit remoteVideoUrlChanged();
    emit localVideoUrlChanged();
}
