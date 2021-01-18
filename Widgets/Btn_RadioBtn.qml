import QtQuick 2.6
import QtQuick.Controls 2.1

//RadioButton
RadioDelegate
{
    id: control
    checked: false

    indicator:
        Rectangle
        {

            implicitWidth: 30
            implicitHeight: 30
            x: control.leftPadding
            y: parent.height / 2 - height / 2
            radius: implicitWidth/2
            border.color: clr_gray2
            border.width: 2
            anchors.left: control.left

            Rectangle
            {
                anchors.centerIn: parent
                radius: parent.radius - parent.border.width
                width: radius * 2
                height: width
                color:  control.checked ? clr_orange : "white"
                visible: control.checked
            }
        }

    contentItem:
            Text
            {
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                leftPadding: control.indicator.width/2 + 5

                font.family: bodyFont.name
                font.pointSize: 17

                color: clr_gray2
                text: control.text
            }

    background:
        Rectangle
        {
            color: "transparent"
        }

 }
