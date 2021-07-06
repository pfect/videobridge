// QT 5.11
import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtMultimedia 5.8

ApplicationWindow {
    visible: true
    width: 610
    height: 498
    title: qsTr("Video Bridge")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page {
            MediaPlayer {
                id: mediaplayer1
                source: "udp://10.30.1.2:9000"
                metaData.onMetaDataChanged:
                {
                    logContent.text = metaData.videoCodec
                }
            }

            VideoOutput {
                id: videoOutOne
                anchors.fill: parent
                source: mediaplayer1                
            }

            MediaPlayer {
                id: mediaplayer2
                source: "udp://127.0.0.1:4999"
            }
            Rectangle {
                id: textLog
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.leftMargin: 20
                width: 200
                height: 140
                color: "transparent"
                Text {
                    id: logContent
                    text: qsTr("")
                    color: "white"
                }

            }
            Rectangle {
                id: ownVideo
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.rightMargin: 10
                width: 160
                height: 140
                border.color: "#000000"
                color: "#444444"
                border.width: 3
                radius: 5
                opacity: 1
                VideoOutput {
                    anchors.topMargin: 3
                    anchors.rightMargin: 3
                    anchors.bottomMargin: 25
                    anchors.leftMargin: 3
                    anchors.fill: parent
                    source: mediaplayer2
                }
                Button {
                    text: "On"
                    width: 75
                    height: 20
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    anchors.leftMargin: 4
                    palette {
                            button: "green"
                    }
                    onClicked: {
                        ownVideo.border.color = "#00FF00"
                        ownVideo.opacity = 1
                        msgPage1.visible = false
                        mediaplayer1.play()
                        mediaplayer2.play()
                    }
                }
                Button {
                    text: "Off"
                    width: 75
                    height: 20
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    anchors.rightMargin: 4
                    palette {
                            button: "red"
                    }
                    onClicked: {
                        ownVideo.border.color = "#FF0000"
                        // ownVideo.opacity = 0.2
                        msgPage1.visible = false
                        mediaplayer1.stop()
                        mediaplayer2.stop()
                    }
                }
            }
            Text {
                id: msgPage1
                anchors.centerIn: parent
                font.pointSize: 24
                text: qsTr("Welcome to Video Bridge!")
            }
        }

        Page {
            Text {
                id: msgPage2
                anchors.centerIn: parent
                font.pointSize: 32
                text: qsTr("Settings page")
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Video")
        }
        TabButton {
            text: qsTr("Settings")
        }
    }
}
