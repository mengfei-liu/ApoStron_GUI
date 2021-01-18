import QtQuick 2.0
import "../Widgets"

Rectangle
{
   id:root
   width: 480
   height: 70

   color: clr_gray3

   property int itemMargin: 20
   property alias titleText: text_item_name.text

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
       anchors.leftMargin: itemMargin
       anchors.verticalCenter: root.verticalCenter

       color: clr_gray2
       font.family: bodyFont.name
       font.pointSize: fsize_med
   }
}
