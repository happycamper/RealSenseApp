import QtQuick 2.0

Item{
    id: mainContainer

    signal loginClicked


    Rectangle {
        id: mainForm
        width: 300
        height: 300
        color: 'transparent'

        Text{
            id: usernameText
            text: "Login:"
            color: 'white'
        }

        Rectangle{
            id: usernameWrapper
            width: 100
            height: 25
            color: 'transparent'
            border.color: "#ed7d31"
            border.width: 2
            radius: 4
            anchors.left: usernameText.right
            anchors.leftMargin: 10

            TextInput{
                id: username
                anchors.fill: parent
                color: "#00b0f0"
                anchors.leftMargin: 5
            }
        }

        Text{
            id: passwordText
            text: "Pass:"
            color: 'white'
            anchors.top: usernameText.bottom
            anchors.topMargin: 10
            anchors.left: usernameText.left
            font.family: "Eras Bold ITC"
        }

        Rectangle{
            id: passwordWrapper
            width: 100
            height: 25
            color: 'transparent'
            border.color: "#ed7d31"
            border.width: 2
            radius: 4
            anchors.left: usernameText.right
            anchors.leftMargin: 10
            anchors.top: usernameWrapper.bottom
            anchors.topMargin: 5

            TextInput{
                id: password
                anchors.fill: parent
                color: "#00b0f0"
                echoMode: TextInput.Password
                anchors.leftMargin: 5
            }
        }

        CameraButton {
            id: loginButton
            text: "Submit"
            onClicked: {
                loginClicked();
            }
            anchors.top: passwordWrapper.bottom
            anchors.topMargin: 10
            anchors.left: passwordWrapper.left
            width: 75
            height: 35
        }

    }
}

