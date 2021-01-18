import QtQuick 2.0
import QtQuick.Controls 2.0

Item
{
    id:delegate_help
    width: 480
    height: text_help_content.height

    Text
    {
        id: text_help_content
        textFormat: Text.StyledText
        anchors.left : delegate_help.left
        anchors.leftMargin : 10
        anchors.right: delegate_help.right
        anchors.rightMargin: 10

        anchors.top: delegate_help.top
        anchors.topMargin: 10
        wrapMode: Text.Wrap
        font.family: bodyFont.name
        font.pointSize: fsize_small
        color: clr_gray2
        text: help_content
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
    }
}
