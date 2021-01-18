import QtQuick 2.0

Rectangle
{
    id:root
   // width: 30
   // height: 40
    width: 43
    height: 50
    radius: 5
    z:1

    color: "white"


    signal clicked(string op)
    signal pressed()
    signal released()

    property string op: ""
    property alias text: buttonText.text
    property alias fontPixelSize: buttonText.font.pixelSize


    Rectangle
    {
        id: shade
        width: root.width
        height: root.height/2
        radius: root.radius
        anchors.top: root.verticalCenter
        anchors.topMargin: 1
        anchors.left: root.left
        color: "black";
        opacity: 0.5
        z:-1
    }

    Text {
        id: buttonText
        anchors.centerIn: root
        font.family: bodyFont.name
        font.pixelSize: root.width > root.height ? root.height * 0.6 : root.width * 0.6
    }

    MouseArea {
        id: btn_mouseArea
        anchors.fill: parent
        onClicked: root.clicked(op)
        onPressed: root.pressed()
        onReleased: root.released()
    }

    states: State
    {
        name: "pressed";
        when: btn_mouseArea.pressed === true
        PropertyChanges
        {
            target: shade;
            opacity: 1;
        }
        PropertyChanges
        {
            target: buttonText
            font.pixelSize: root.width > root.height ? root.height * 0.8 : root.width * 0.8
        }
    }
}
