import QtQuick 2.0
import QtQuick.Controls 2.1

Switch
{
        id: control
        checked: false

        indicator:
            Rectangle
            {
            implicitWidth: 180
            implicitHeight: 60
            x: control.width - width - control.rightPadding
            y: parent.height / 2 - height / 2
            radius: 30
            color: control.checked ? clr_gray1 : clr_orange
            border.color: "black"

            Rectangle
            {
                id:indicator
                x: control.checked ? parent.width - width : 0
                width: 60
                height: 60
                radius: 30
                border.color: "black"
            }

            Text {
                id: text
                anchors.verticalCenter: indicator.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: control.checked ? qsTr("CCW") : qsTr("CW")
                color: control.checked ? "black" : "white"
                font.family: bodyFont.name
                font.pointSize: fsize_xs
                font.bold: true
                fontSizeMode: Text.Fit
            }
        }

}
