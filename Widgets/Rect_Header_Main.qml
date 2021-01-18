import QtQuick 2.0

Rectangle
{
    id:root
    width: parent.width
    height: 85
    //color:clr_gray2
    color:"black"

    property Item timeDate: header_time

    property alias titleStr: header_title.titleStr
    property alias timeString: header_time.timeString
    property alias dateString: header_time.dateString
    property alias iBatteryPercentage: btn_battery.iBatteryPercentage

    Btn_Footer
    {
        id:btn_pwr
        anchors.left: root.left
        anchors.leftMargin: 0
        btn_name: "power"

        onBtnClick:
        {
            //shutDown_dlg.tipText =  "Shut Down";
            //shutDown_dlg.openMsg();
            popup_pwrMenu.open();
        }
    }

   Rect_Header_Time
   {
       id:header_time
       anchors.horizontalCenter: root.horizontalCenter
       anchors.top: root.top
   }

   Rect_Header_Title
   {
       id:header_title
        anchors.horizontalCenter: root.horizontalCenter
       anchors.bottom: root.bottom

       MouseArea
       {
           anchors.fill: header_title

           onPressAndHold:
           {
               if(stack.currentItem.objectName !== "Page_Initialize" )
               {
                   stack.push(Qt.resolvedUrl("qrc:/Pages/Page_AdminSetup_1.qml"),{page_container:stack.currentItem});
               }

              // stack.push(Qt.resolvedUrl("qrc:/Pages/Page_AdminSetup_1.qml"),{page_container:stack.currentItem});
           }
       }
   }

   Rect_Battery_Bar
   {
       id:btn_battery
       x: 314
       anchors.right: root.right
       anchors.rightMargin: 16
       anchors.top: root.top
       anchors.topMargin: 35
       width: 30
       height: 15
   }
}
