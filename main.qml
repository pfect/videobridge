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
                source: vBridge.remoteVideoUrl;
                metaData.onMetaDataChanged:
                {
                    // logContent.text = metaData.videoCodec
                }
            }

            VideoOutput {
                id: videoOutOne
                anchors.fill: parent
                source: mediaplayer1                
            }

            MediaPlayer {
                id: mediaplayer2
                source: vBridge.localVideoUrl;
            }

            /* Hidden at the moment */
            Item {
                visible: false
                id: textLogItem
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.leftMargin: 7
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100
                width: 160
                clip: true
                Rectangle {
                    id: textLog
                    anchors.fill: parent
                    anchors.rightMargin: -border.width
                    anchors.topMargin:  -border.width
                    anchors.bottomMargin: -border.width
                    border.width: 2
                    border.color:"#2ac8a3"
                    color: "transparent"
                    Text {
                        id: logContent
                        padding: 5
                        text: qsTr("[sensor values]")
                        color: "#FFFFFF"
                        font.pixelSize: Qt.application.font.pixelSize * 0.9
                    }
                }
            }
            /* Hidden at the moment */
            TextField {
                id: textEntryTest
                visible: false
                anchors.left: parent.left
                anchors.top: textLogItem.bottom
                anchors.topMargin: 5
                anchors.leftMargin: 5
                width: 160
                color: "#ffff00"
                Layout.leftMargin: 0
                font.pixelSize: Qt.application.font.pixelSize * 0.8
                Layout.fillWidth: true
                background: Rectangle {
                            opacity: 0.8
                            radius: 4
                            color: "#212529"
                            implicitWidth: 100
                            implicitHeight: 20
                            border.color: "#2ac8a3"
                            border.width: 2
                        }
            }

            Rectangle {
                id: ownVideo
                anchors.right: parent.right
                anchors.top: parent.top
                width: mouseArea.containsMouse ? 180 : 160
                height: mouseArea.containsMouse ? 140 : 120
                anchors.topMargin: mouseArea.containsMouse ? 40 : 10
                anchors.rightMargin: mouseArea.containsMouse ? 50 : 10
                border.color: "#000000"
                color: "#444444"
                border.width: 3
                radius: 5
                opacity: 1
                Behavior on width {
                           NumberAnimation {
                               duration: 200 //ms
                           }
                       }
                Behavior on height {
                           NumberAnimation {
                               duration: 200 //ms
                           }
                       }
                scale:  mouseArea.containsMouse ? 1.5 : 1.0
                smooth: mouseArea.containsMouse
                MouseArea {
                   id: mouseArea
                   anchors.fill: parent
                   anchors.margins: -10
                   hoverEnabled: true
                }

                VideoOutput {
                    anchors.topMargin: 3
                    anchors.rightMargin: 3
                    anchors.bottomMargin: 3
                    anchors.leftMargin: 3
                    anchors.fill: parent
                    source: mediaplayer2
                }

            }



            Text {
                id: msgPage1
                anchors.centerIn: parent
                font.pointSize: 24
                text: qsTr("Welcome to Video Bridge!")
            }
            Rectangle {
                id: controlButtons
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 100
                anchors.rightMargin: 10
                width: 80
                height: 200
                border.color: "#000000"
                color: "transparent"
                border.width: 0
                radius: 5
                opacity: 1
                Button {
                    id: videoOnButton
                    text: "Live"
                    width: 75
                    height: 20
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 50
                    opacity: 1
                    palette {
                            button: "green"

                    }
                    onClicked: {
                        ownVideo.border.color = "#00FF00"
                        ownVideo.opacity = 1
                        msgPage1.visible = false
                        vBridge.mediaLive()
                        mediaplayer1.play()
                        mediaplayer2.play()
                    }
                }
                Button {
                    id: testImageOn
                    text: "Mute"
                    width: 75
                    height: 20
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 25
                    opacity: 1
                    palette {
                            button: "yellow"

                    }
                    onClicked: {
                        ownVideo.border.color = "#FFFF00"
                        ownVideo.opacity = 1
                        vBridge.mediaMute()
                    }
                }
                Button {
                    id: videoOffButton
                    text: "Off"
                    width: 75
                    height: 20
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 2
                    anchors.rightMargin: 0
                    opacity: 1
                    palette {
                            button: "red"
                    }
                    onClicked: {
                        ownVideo.border.color = "#FF0000"
                        // ownVideo.opacity = 0.2
                        msgPage1.visible = false
                        vBridge.mediaOff()
                        mediaplayer1.stop()
                        mediaplayer2.stop()
                    }
                }

            }

        }

        Page {
            Label {
                x: 10
                y: 5
                font.pixelSize: Qt.application.font.pixelSize * 1.5
                text: qsTr("Settings")
            }
            Label {
                x: 10
                y: 45
                font.pixelSize: Qt.application.font.pixelSize * 1
                text: qsTr("Local video source:")
            }
            TextField {
                id: localVideoUrlInput
                x: 150
                y: 45
                width: 200
                color: "#ffff00"
                Layout.leftMargin: 0
                text: vBridge.localVideoUrl
                font.pixelSize: Qt.application.font.pixelSize * 1
                Layout.fillWidth: true
                background: Rectangle {
                            radius: 4
                            color: "#212529"
                            implicitWidth: 100
                            implicitHeight: 20
                            border.color: "#2ac8a3"
                            border.width: 1
                        }
            }
            Label {
                x: 10
                y: 85
                font.pixelSize: Qt.application.font.pixelSize * 1
                text: qsTr("Remote video source:")
            }
            TextField {
                id: remoteVideoUrlInput
                x: 150
                y: 85
                width: 200
                color: "#ffff00"
                Layout.leftMargin: 0
                text: vBridge.remoteVideoUrl
                font.pixelSize: Qt.application.font.pixelSize * 1
                Layout.fillWidth: true
                background: Rectangle {
                            radius: 4
                            color: "#212529"
                            implicitWidth: 100
                            implicitHeight: 20
                            border.color: "#2ac8a3"
                            border.width: 1
                        }
            }

            Button {
                x: 400
                y: 45
                width: 100
                height: 30
                font.pixelSize: Qt.application.font.pixelSize * 1
                padding: 0
                text: qsTr("Save")
                onClicked: {
                    vBridge.writeSettings(localVideoUrlInput.text, remoteVideoUrlInput.text);
                }
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
