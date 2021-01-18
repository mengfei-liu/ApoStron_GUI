import QtQuick 2.6
import QtQuick.Controls 2.1

Switch
{
    id: control

    indicator:
    Rectangle
    {
       anchors.centerIn: root
       implicitWidth:196
       implicitHeight:26
       //radius: root.radius
       color: "transparent"
       clip:true

       Rectangle
       {
           id:rect_Metric
           width: 100
           height: parent.height
           anchors.right: parent.horizontalCenter
           anchors.top: parent.top

           color: control.checked ? "white" : clr_gray2

           Text
           {
               anchors.centerIn: rect_Metric
               color: control.checked ? clr_gray2 : "white"

               font.family: bodyFont.name
               font.pointSize: 17

               text: "Metric"
           }
       }

       Rectangle
       {
           id:rect_Imperial
           width: 100
           height: parent.height
           anchors.top: parent.top
           anchors.left: parent.horizontalCenter

           color: control.checked ?  clr_gray2 : "white"

           Text
           {
               anchors.centerIn: rect_Imperial

               font.family: bodyFont.name
               font.pointSize: 17


               color: control.checked ? "white" : clr_gray2
               text: "Imperial"
           }
       }
    }

    background:
        Rectangle
        {
            id:root
            width: 200
            height: 30
            radius: 5
            border.color: clr_gray2
            border.width: 3
            color: "transparent"
        }
}
