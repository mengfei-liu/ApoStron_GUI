import QtQuick 2.0

Rectangle
{
    id:text_Alert
    //width: dialog.width
    height: text_Alert_text.implicitHeight < width/2.5 ? width/2.5 : text_Alert_text.implicitHeight *1.2
    color: clr_orange

    property string alertMsg

    Rectangle
    {
        width: parent.width * 0.9
        height: parent.height * 0.9

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"

        Image
        {
            id: text_Alert_icon
            //height: parent.height
            //width: height
            height: 70
            width: height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: "qrc:/Icons/explosionMark.svg"
            cache: false
            fillMode: Image.PreserveAspectFit
        }

        Text
        {
            id:text_Alert_text
            //anchors.verticalCenter: text_Alert_icon.verticalCenter
            anchors.left: text_Alert_icon.right
            anchors.leftMargin: 15
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            //verticalAlignment: Text.AlignTop
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            font.family: bodyFont.name
            font.pointSize:fsize_2xs
            color: "white"
            //minimumPointSize:1
            minimumPixelSize :1
            //font.pointSize: 20
            fontSizeMode: Text.VerticalFit

            text:"<b>Attention:</b>" + "<br>" + alertMsg + "<br/>"
        }
    }
}
