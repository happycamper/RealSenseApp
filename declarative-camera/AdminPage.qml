import QtQuick 2.0

Rectangle {
    id: adminPanel
    width: 400
    height: 300
    color: 'transparent'
    border.color: 'white'
    border.width: 1
    radius: 4

    signal newUserClicked
    signal backClicked
    signal addClicked

    Text{
        id: adminText
        text: "Admin Panel"
        color: 'white'
        font.pointSize: 18
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Timer{
        id: faceCountDown
        interval: 4000
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
            }
        }

    }

    Text{
        id: faceScanned
        text: "Scan Complete"
        color: 'white'
        anchors.top: levelWrapper.bottom
        anchors.topMargin: 10
        visible: false
        anchors.left: addUser.right
        anchors.leftMargin: 10

    }

    InfoPanel{
        id: userInfo
        anchors.left: adminText.right
        anchors.leftMargin: 50
        anchors.top: adminText.top
    }

    CameraButton {
        id: registerUser
        text: "New User"
        onClicked: {
            newUserClicked();
            faceCountDown.start();
        }

        width: 175
        height: 35
        anchors.top: adminText.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    CameraButton {
        id: backButton
        text: "Back"
        onClicked: {
            backClicked();
        }

        width: 100
        height: 35
        anchors.top: registerUser.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    CameraButton {
        id: addUser
        text: "Add"
        onClicked: {
            addClicked();
            //var listElement = Qt.createComponent("import QtQuick 2.0 ListElement{ name: 'Jeff'}");
            userModel.append({name : "Jeff", job: "IT", privilege: "Low"} );
        }

        width: 100
        height: 35
        anchors.top: levelWrapper.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Text{
        id: currentUserText
        text: "Current Users"
        x: Math.round(parent.width*.6)
        y: Math.round(parent.height*.3)
        color: 'white'
    }


    Rectangle{
        id: listViewWrapper
        anchors.left: currentUserText.left
        anchors.top: currentUserText.bottom
        anchors.topMargin: 12
        width: 100
        height: 100

        color: 'black'
        anchors.leftMargin: 0

    ListView{
        id: currentUsers
        anchors.rightMargin: -46
        anchors.bottomMargin: -45
        model: userModel
        anchors.fill: parent
        contentHeight: 400
        delegate: listDelegate

    }

    }

    Text{
        id: metaData
        text: "Metadata"
        color: 'white'
        font.pointSize: 18
        anchors.top: backButton.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Text{
        id: usernameText
        text: "Name:"
        color: 'white'
        anchors.top: metaData.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Rectangle{
        id: nameWrapper
        width: 100
        height: 25
        color: 'transparent'
        border.color: "#ed7d31"
        border.width: 2
        radius: 4
        anchors.left: usernameText.right
        anchors.leftMargin: 10
        anchors.top: metaData.bottom
        anchors.topMargin: 5

        TextInput{
            id: username
            anchors.fill: parent
            color: "#00b0f0"
            anchors.leftMargin: 5
        }
    }

    Text{
        id: jobText
        text: "Job:"
        color: 'white'
        anchors.top: nameWrapper.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Rectangle{
        id: jobWrapper
        width: 100
        height: 25
        color: 'transparent'
        border.color: "#ed7d31"
        border.width: 2
        radius: 4
        anchors.left: usernameText.right
        anchors.leftMargin: 10
        anchors.top: nameWrapper.bottom
        anchors.topMargin: 5

        TextInput{
            id: jobinput
            anchors.fill: parent
            color: "#00b0f0"
            anchors.leftMargin: 5
        }
    }

    Text{
        id: levelText
        text: "level:"
        color: 'white'
        anchors.top: jobWrapper.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Rectangle{
        id: levelWrapper
        width: 100
        height: 25
        color: 'transparent'
        border.color: "#ed7d31"
        border.width: 2
        radius: 4
        anchors.left: usernameText.right
        anchors.leftMargin: 10
        anchors.top: jobWrapper.bottom
        anchors.topMargin: 5

        TextInput{
            id: levelInput
            anchors.fill: parent
            color: "#00b0f0"
            anchors.leftMargin: 5
        }
    }



    ListModel{
        id: userModel

        ListElement{
            name: "Joe"
            job: "Maintenance"
            privilege: "Low"
        }
        ListElement{
            name: "Stacy"
            job: "IT"
            privilege: "High"
        }
        ListElement{
            name: "Alex"
            job: "Maintenance"
            privilege: "Low"
        }
    }

    Component{
        id: listDelegate

        Item{
            id: delegateItem
            width: parent.width
            height: 20
            anchors.topMargin: 20

            Rectangle{
                id: rowRect
                anchors.fill: parent
                color: 'black'
                border.color: "#ed7d31"
                border.width: 1

                MouseArea{
                    id: rowRectMA
                    anchors.fill: parent
                    hoverEnabled: true

                    onPressed:{
                        rowRect.color = "#ed73d1"
                    }

                    onEntered: {
                        rowRect.color = "#ed73d1";
                        userInfo.name = name;
                        userInfo.job = job;
                        userInfo.level = privilege;
                    }

                    onExited: {
                        rowRect.color = 'black';
                        userInfo.name = "";
                        userInfo.job = "";
                        userInfo.level = "";
                    }

                }


                Text{
                    id: nameText
                    text: name
                    color: 'white'
                    anchors.centerIn: parent
                }
            }
        }
    }
}

