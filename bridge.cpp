#include "bridge.h"
#include <QSettings>
#include <QDebug>

bridge::bridge(QObject *parent) : QObject(parent)
{
    readSettings();
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
    QSettings settings("bridge.ini", QSettings::IniFormat);
    if( settings.contains("sources/localvideourl") && settings.contains("sources/remotevideourl") ) {
        mLocalVideoUrl = settings.value("sources/localvideourl", "udp://127.0.0.1:4999").toString();
        mRemoteVideoUrl = settings.value("sources/remotevideourl", "udp://127.0.0.1:4999").toString();
    }
    else {
        qDebug() << "Could not find bridge.ini, creating default one.";
        writeSettings( "udp://127.0.0.1:4999", "udp://0.0.0.0:5000");
    }
}

void bridge::writeSettings(QString localUrl, QString remoteUrl)
{
    QSettings settings("bridge.ini", QSettings::IniFormat);
    settings.setValue("sources/localvideourl", localUrl);
    settings.setValue("sources/remotevideourl", remoteUrl);
    readSettings();
    emit remoteVideoUrlChanged();
    emit localVideoUrlChanged();
}
