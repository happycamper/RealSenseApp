import QtQuick 2.0

Item{
    id: mainContainer
    property string name: ""
    property string job: ""
    property string level: ""


    Rectangle {
        width: 100
        height: 100
        color: 'transparent'

        Text{
            id: nameText
            text: "name: "+name
            color: 'white'
        }

        Text{
            id: jobText
            text: "job: "+job
            color: 'white'
            anchors.top: nameText.bottom
            anchors.topMargin: 5
        }

        Text{
            id: levelText
            text: "level: "+level
            color: 'white'
            anchors.top: jobText.bottom
            anchors.topMargin: 5
        }



    }

}
