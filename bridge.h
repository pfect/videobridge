#ifndef BRIDGE_H
#define BRIDGE_H

#include <QObject>

class bridge : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString remoteVideoUrl READ getRemoteVideoUrl NOTIFY remoteVideoUrlChanged)
    Q_PROPERTY(QString localVideoUrl READ getLocalVideoUrl NOTIFY localVideoUrlChanged)

private:
    QString mRemoteVideoUrl;
    QString mLocalVideoUrl;

public:
    explicit bridge(QObject *parent = nullptr);
    Q_INVOKABLE QString getRemoteVideoUrl();
    Q_INVOKABLE QString getLocalVideoUrl();
    Q_INVOKABLE void writeSettings(QString localUrl, QString remoteUrl);
    Q_INVOKABLE void mediaLive();
    Q_INVOKABLE void mediaMute();
    Q_INVOKABLE void mediaOff();

signals:
    void remoteVideoUrlChanged();
    void localVideoUrlChanged();

public slots:
    void readSettings();

};

#endif // BRIDGE_H
