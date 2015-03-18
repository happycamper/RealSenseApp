import QtQuick 2.0

Rectangle {
    id: userDisplay
    width: 400
    height: 120
    color: 'transparent'
    border.color: 'white'
    border.width: 1
    radius: 4

    signal newUserClicked
    signal backClicked
    signal addClicked

    onVisibleChanged: {
        if(userDisplay.visible)
            faceCountDown.start();
    }

    Text{
        id: adminText
        text: "User Information"
        color: 'white'
        font.pointSize: 18
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Timer{
        id: faceCountDown
        interval: 5000
        running: false
        repeat: false

        onRunningChanged: {
            if(!faceCountDown.running){
                faceScanned.visible = true;
                hideScanComplete.start();
            }
        }

    }

    Timer{
        id: hideScanComplete
        interval: 1000
        running: false
        repeat: false

        onRunningChanged: {
            if(!hideScanComplete.running){
                faceScanned.visible = false;
                userInfo.name = "Jeff";
                userInfo.job = "IT";
                userInfo.level = "Low";
            }
        }

    }

    Text{
        id: faceScanned
        text: "Scan Complete"
        color: 'white'
        anchors.top: backButton.bottom
        anchors.topMargin: 10
        visible: false
        anchors.left: parent.left
        anchors.leftMargin: 10

    }

    InfoPanel{
        id: userInfo
        anchors.left: adminText.right
        anchors.leftMargin: 50
        anchors.top: adminText.top
    }


    CameraButton {
        id: backButton
        text: "Back"
        onClicked: {
            backClicked();
        }

        width: 100
        height: 35
        anchors.top: adminText.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
    }
}

