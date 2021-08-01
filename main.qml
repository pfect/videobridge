import QtQuick 2.15 // 2.9
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.2
import QtQuick.Window 2.14 //2.2
import QtQuick.Controls.Material 2.15 // 2.3
import QtQuick.VirtualKeyboard 2.15 // 2.2
import QtQuick.Controls.Styles 1.4
import QtMultimedia 5.8

Window {
    id: window
    visible: true
    visibility: Window.FullScreen
    color: "#212529"
    Material.theme: Material.Light
    width: 720
    height: 1440
    title: qsTr("Video Bridge")

    Dialog {
        id: opsecDialog
        visible: myEnv.dialogVisible
        modal: true
        closePolicy: Popup.CloseOnEscape
        parent: window
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 600
        height: 500
        background: Rectangle {
                color: "#313539"
                border.color: "red"
                border.width: 4
        }
        Label {
            id: messageText
            font.pixelSize: Qt.application.font.pixelSize * 4
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            color: "#FFFF00" // 28c6a0
            text: "OPSEC NOTIFY"
        }
        Label {
            id: messageText2
            font.pixelSize: Qt.application.font.pixelSize * 3
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            color: "#FFFFFF" // 28c6a0
            text: "Traffic blocked.\n\nNew cell: "+ myEnv.gcValue + "\n\nDo you accept this new cell?"
        }
        Button {
            width: 200
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            Material.background: Material.Orange
            font.pixelSize: Qt.application.font.pixelSize * 3
            Layout.minimumHeight: 70
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            padding: 15
            text: qsTr("Deny")
            onClicked: {
                myEnv.addCellAccepted(myEnv.gcValue) // todo still
                myEnv.addCellAcceptedUi(myEnv.gcValue,false)
                opsecDialog.close()
            }
        }
        Button {
            width: 200
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            Material.background: Material.Green
            font.pixelSize: Qt.application.font.pixelSize * 3
            Layout.minimumHeight: 70
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            padding: 15
            text: qsTr("Accept")
            onClicked: {
                myEnv.addCellAccepted(myEnv.gcValue)
                myEnv.addCellAcceptedUi(myEnv.gcValue,true) //
                opsecDialog.close()
            }
        }
    }

    Label {
        x: 10
        y: 5
        font.pixelSize: Qt.application.font.pixelSize * 4
        text: qsTr("Video Bridge")
        color: "#ffff00" // 28c6a0
    }
    Label {
        x: 620
        y: 5
        font.pixelSize: Qt.application.font.pixelSize * 2
        text: qsTr("") // right top corner label
        color: "#28c6a0" // 28c6a0
    }
    Label {
        x: 10
        y: 80
        color: "#28c6a0"
        font.pixelSize: Qt.application.font.pixelSize * 2.5
        text: qsTr("Video")
    }
    Rectangle {
            x: 10
            y: 115
            width:  680 // line width
            height: 2
            color: "#28c6a0"
    }
    Rectangle {
            id: videoSourceOne
            x: 20
            y: 130
            width:  320
            height: 240
            MediaPlayer {
                id: mediaplayer1
                source: vBridge.remoteVideoUrl;
            }
            VideoOutput {
                id: videoOutOne
                anchors.fill: parent
                source: mediaplayer1
            }
    }
    Rectangle {
            id: videoSourceTwo
            x: 360
            y: 130
            width:  320
            height: 240
            MediaPlayer {
                id: mediaplayer2
                source: vBridge.localVideoUrl;
            }
            VideoOutput {
                id: videoOutTwo
                anchors.fill: parent
                source: mediaplayer2
            }

    }
    Button {
        x: 20
        y: 380
        width: 320
        Material.background: Material.Orange
        font.pixelSize: Qt.application.font.pixelSize * 3
        Layout.minimumHeight: 50
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.fillWidth: true
        padding: 10
        text: qsTr("Disconnect")
        onClicked: {
            vBridge.mediaLive()
            mediaplayer1.stop()
            mediaplayer2.stop()
        }
    }
    Button {
        x: 360
        y: 380
        width: 320
        Material.background: Material.Green
        font.pixelSize: Qt.application.font.pixelSize * 3
        Layout.minimumHeight: 50
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.fillWidth: true
        padding: 10
        text: qsTr("Connect")
        onClicked: {
            mediaplayer1.play()
            mediaplayer2.play()
        }
    }

    Label {
        x: 10
        y: 450
        color: "#28c6a0"
        font.pixelSize: Qt.application.font.pixelSize * 2.5
        text: qsTr("Voice ")
    }
    Rectangle {
            x: 10
            y: 485
            width:  680 // line width
            height: 2
            color: "#28c6a0"
    }

    Button {
        id: rxOff
        x: 20
        y: 500
        width: 160
        Material.background: Material.Orange
        font.pixelSize: Qt.application.font.pixelSize * 3
        Layout.minimumHeight: 80
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.fillWidth: true
        padding: 20
        text: qsTr("RX Off")
        onClicked: {
        }
    }
    Button {
        id: rxOn
        x: 190
        y: 500
        width: 150
        Material.background: Material.Green
        font.pixelSize: Qt.application.font.pixelSize * 3
        Layout.minimumHeight: 80
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.fillWidth: true
        padding: 20
        text: qsTr("RX On")
        onClicked: {
        }
    }
    Button {
        id: pttButton
        x: 360
        y: 500
        width: 320
        Material.background: Material.Blue
        font.pixelSize: Qt.application.font.pixelSize * 3
        Layout.minimumHeight: 80
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.fillWidth: true
        padding: 20
        text: qsTr("TX")
        onClicked: {
        }
    }

    Label {
        x: 10
        y: 590
        color: "#28c6a0"
        font.pixelSize: Qt.application.font.pixelSize * 2.5
        text: qsTr("Telemetry ")
    }
    Rectangle {
            x: 10
            y: 630
            width:  680 // line width
            height: 2
            color: "#28c6a0"
    }
    Rectangle {
       id: logText
       x: 20
       y: 650
       radius: 4
       color: "#212529"
       implicitWidth: 660
       implicitHeight: 300
       border.color: "#2ac8a3"
       border.width: 1
       ListView {
             width: 630; height: 200
             spacing: 5
             clip: true
             model: myEnv.cellsAccepted

             delegate: Rectangle {
               height: 40
               width: 200
               color: "#00000000" // form: #AARRGGBB
               Text {
                   text: modelData;
                   color: "#8BC34A"
                   topPadding: 5
                   leftPadding: 10
                   anchors.leftMargin: parent.left
                   anchors.topMargin: parent.top
                   font.pixelSize: Qt.application.font.pixelSize * 2.5
               }
             }
       }
    }
    TextField {
        id: inputfieldText
        x: 20
        y: 960
        width: 660
        color: "#ffff00"
        placeholderTextColor: "#28c6a0"
        Layout.leftMargin: 10
        placeholderText: ">"
        font.pixelSize: Qt.application.font.pixelSize * 3
        Layout.fillWidth: true

        background: Rectangle {
                    radius: 4
                    color: "#212529"
                    implicitWidth: 100
                    implicitHeight: 24
                    border.color: "#2ac8a3"
                    border.width: 1
                }
    }

//    Label {
//        x: 10
//        y: 120
//        color: "#28c6a0"
//        font.pixelSize: Qt.application.font.pixelSize * 2.5
//        text: "PLMN: <font color=\"#FFFFFF\">" + myEnv.plmnValue + "</font> TAC: <font color=\"#FFFFFF\">" + myEnv.taValue + "</font> Global CellID: <font color=\"#FFFFFF\">" + myEnv.gcValue +"</font>"
//    }
//    Label {
//        x: 10
//        y: 160
//        color: "#28c6a0"
//        font.pixelSize: Qt.application.font.pixelSize * 2.5
//        text: "Serving Cell: <font color=\"#FFFFFF\">" + myEnv.scValue + "</font> AbsCH: <font color=\"#FFFFFF\">" + myEnv.acValue + "</font>"
//    }
//    Label {
//        x: 10
//        y: 200
//        color: "#28c6a0"
//        font.pixelSize: Qt.application.font.pixelSize * 2.5
//        text: "RSRP: <font color=\"#FFFFFF\">"+ myEnv.rsrpValue + "</font> SNR: <font color=\"#FFFFFF\">" + myEnv.snrValue + "</font> RSSI: <font color=\"#FFFFFF\">" + myEnv.rssiValue + "</font>"
//    }
//    Label {
//        x: 10
//        y: 240
//        color: "#28c6a0"
//        font.pixelSize: Qt.application.font.pixelSize * 2.5
//        text: "RSRQ: <font color=\"#FFFFFF\">" + myEnv.rsrqValue + "</font> Voltage: <font color=\"#FFFFFF\">" +myEnv.voltageValue + " V" + "</font>"
//    }

//    CheckBox {
//        id: controlOpsecTraffic
//        checked: false
//        x: 10
//        y: 280
//        text: qsTr("Stop traffic on new cells")
//        onCheckedChanged: {
//            if(controlOpsecTraffic.checked === false){
//                myEnv.controlOpsecTrafficBlock(false);
//            }
//            else {
//                myEnv.controlOpsecTrafficBlock(true);
//            }
//        }
//        indicator: Rectangle {
//                implicitWidth: 30
//                implicitHeight: 30
//                x: controlOpsecTraffic.leftPadding
//                y: parent.height / 2 - height / 2
//                radius: 3
//                border.color: controlOpsecTraffic.down ? "#28c6a0" : "#28c6a0"

//                Rectangle {
//                    width: 18
//                    height: 18
//                    x: 6
//                    y: 6
//                    radius: 2
//                    color: controlOpsecTraffic.down ? "#28c6a0" : "#28c6a0"
//                    visible: controlOpsecTraffic.checked
//                }
//            }
//            contentItem: Text {
//               text: controlOpsecTraffic.text
//               font.pixelSize: Qt.application.font.pixelSize * 2.5
//               opacity: enabled ? 1.0 : 0.3
//               color: controlOpsecTraffic.down ? "#28c6a0" : "#28c6a0"
//               verticalAlignment: Text.AlignVCenter
//               leftPadding: controlOpsecTraffic.indicator.width + controlOpsecTraffic.spacing
//           }
//    }
//    CheckBox {
//        id: controlOpsecNotify
//        checked: false
//        x: 430
//        y: 280
//        text: qsTr("Notify new cells")
//        onCheckedChanged: {
//            if(controlOpsecNotify.checked === false){
//                myEnv.controlOpsecNotify(false);
//            }
//            else {
//                myEnv.controlOpsecNotify(true);
//            }
//        }

//        indicator: Rectangle {
//                implicitWidth: 30
//                implicitHeight: 30
//                x: controlOpsecNotify.leftPadding
//                y: parent.height / 2 - height / 2
//                radius: 3
//                border.color: controlOpsecNotify.down ? "#28c6a0" : "#28c6a0"

//                Rectangle {
//                    width: 18
//                    height: 18
//                    x: 6
//                    y: 6
//                    radius: 2
//                    color: controlOpsecNotify.down ? "#28c6a0" : "#28c6a0"
//                    visible: controlOpsecNotify.checked
//                }
//            }
//            contentItem: Text {
//               text: controlOpsecNotify.text
//               font.pixelSize: Qt.application.font.pixelSize * 2.5
//               opacity: enabled ? 1.0 : 0.3
//               color: controlOpsecNotify.down ? "#28c6a0" : "#28c6a0"
//               verticalAlignment: Text.AlignVCenter
//               leftPadding: controlOpsecNotify.indicator.width + controlOpsecNotify.spacing
//           }
//    }



//    Label {
//        x: 10
//        y: 580
//        color: "#28c6a0"
//        font.pixelSize: Qt.application.font.pixelSize * 2.5
//        text: qsTr("Tunnel component for LTE outbound traffic")

//    }
//    Rectangle {
//            x: 10
//            y: 410
//            width:  680
//            height: 2
//            color: "#28c6a0"
//    }

//    Rectangle {
//       x: 40
//       y: 430
//       radius: 4
//       color: "#212529"
//       implicitWidth: 630
//       implicitHeight: 60
//       border.color: "#2ac8a3"
//       border.width: 1

//       Label {
//           width: 630
//           topPadding: 5
//           leftPadding: 10
//           color: "#28c6a0"
//           font.pixelSize: Qt.application.font.pixelSize * 3
//           text: qsTr("inactive")
//       }

//    }

//    TextField {
//        id: inputfieldText
//        x: 40
//        y: 500
//        width: 300
//        color: "#ffff00"
//        placeholderTextColor: "#28c6a0"
//        Layout.leftMargin: 10
//        placeholderText: "[Gateway IP]"
//        font.pixelSize: Qt.application.font.pixelSize * 3
//        Layout.fillWidth: true

//        background: Rectangle {
//                    radius: 4
//                    color: "#212529"
//                    implicitWidth: 100
//                    implicitHeight: 24
//                    border.color: "#2ac8a3"
//                    border.width: 1
//                }
//    }
//    TextField {
//        id: secretText
//        x: 370
//        y: 500
//        width: 300
//        color: "#ffff00"
//        placeholderTextColor: "#28c6a0"
//        Layout.leftMargin: 10
//        placeholderText: "[Secret]"
//        font.pixelSize: Qt.application.font.pixelSize * 3
//        Layout.fillWidth: true

//        background: Rectangle {
//                    radius: 4
//                    color: "#212529"
//                    implicitWidth: 100
//                    implicitHeight: 24
//                    border.color: "#2ac8a3"
//                    border.width: 1

//                }
//    }





    // IP information
//    Rectangle {
//       x: 40
//       y: 750
//       radius: 4
//       color: "#212529"
//       implicitWidth: 300
//       implicitHeight: 200
//       border.color: "#2ac8a3"
//       border.width: 1
//       Label {
//           width: 300
//           topPadding: 5
//           leftPadding: 10
//           color: "#8BC34A"
//           font.pixelSize: Qt.application.font.pixelSize * 2
//           text: myEnv.usbIpValue
//       }
//    }

//    Rectangle {
//       x: 370
//       y: 750
//       radius: 4
//       color: "#212529"
//       implicitWidth: 300
//       implicitHeight: 200
//       border.color: "#2ac8a3"
//       border.width: 1
//       Label {
//           width: 300
//           topPadding: 5
//           leftPadding: 10
//           color: "#8BC34A"
//           font.pixelSize: Qt.application.font.pixelSize * 2
//           text: myEnv.wwanIpValue
//       }
//    }
//    Label {
//        x: 40
//        y: 960
//        color: "#28c6a0"
//        font.pixelSize: Qt.application.font.pixelSize * 2.5
//        text: qsTr("Cell log [") + myEnv.cellAcceptedCounter + "/" + myEnv.cellDeniedCounter +"]"
//    }





    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        anchors.topMargin: 5
        anchors.left: window.left
        anchors.right: window.right

        anchors.bottomMargin: {
            return Qt.inputMethod.visible ? -90 : undefined
        }
        y: {
            return Qt.inputMethod.visible ? Qt.inputMethod.keyboardRectangle.height : window.height
        }
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
