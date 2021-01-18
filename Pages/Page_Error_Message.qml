import QtQuick 2.0

Rectangle
{
    id:root
    width: 480
    height: 615
    color: "red"

    Component.onCompleted:
    {
        myheader.titleStr = qsTr("Error");
    }
    Text
    {
        anchors.centerIn: root
        text: qsTr("Error Page")
        color: "white"
        font.family: bodyFont.name
        font.pointSize: fsize_med
    }

    MouseArea
    {
        anchors.fill: root
        onClicked:
        {
            stack.pop();
        }
    }
}
