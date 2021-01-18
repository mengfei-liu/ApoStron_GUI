import QtQuick 2.0

Rectangle
{
    id:root
    color: "transparent"
    width: parent.width/2
    height: parent.height/2

    property alias titleStr: text_title.text

    Text {
        id: text_title
        anchors.verticalCenter: root.verticalCenter
        anchors.horizontalCenter: root.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        font.family: titleFont.name
        font.pointSize: 28
        font.bold: true
        font.capitalization: Font.AllUppercase
    }
}
