import QtQuick 2.0
import QtQuick.Controls 2.0

import "../Widgets"

Component
{
    id:delegate_page6_confirm

    Rectangle
    {
        id:root
        width: parent.width
        height: 50
        color: clr_gray3//Qt.darker(clr_gray3)
        focus: false
        z: -1
        property int itemMargin: 15

        Border_Custom
        {
            commonBorder: false
            lBorderwidth: 0
            rBorderwidth: 0
            tBorderwidth: 1
            bBorderwidth: 1
            borderColor: clr_gray2
        }

        Text
        {
            id: text_item_name
            anchors.left: root.left
            anchors.leftMargin: root.itemMargin
            anchors.verticalCenter: root.verticalCenter
            font.family: bodyFont.name
            font.pointSize: fsize_med
            color: clr_gray2

            text: mylist_title + mytrans.emptyString
        }

        Rectangle
        {
            id:value_area
            width: 150
            height: 35
            radius: 5

            anchors.right: root.right
            anchors.rightMargin: root.itemMargin
            anchors.verticalCenter: root.verticalCenter
            color: clr_gray2

            Text
            {
                id: text_item_value
                anchors.centerIn: value_area
                font.family: bodyFont.name
                font.pointSize: fsize_xs
                font.wordSpacing: 0
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                color: "white"

                text: (item_unit === "") ? item_value : item_value +" "+ item_unit
            }
        }
   }

}
