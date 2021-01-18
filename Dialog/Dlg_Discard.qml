import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: dlg_discard
    anchors.centerIn: parent
    //提示框内容
    property alias tipText: msg.text
    //property alias btn_action_text: btn_action_text.text
    //提示框颜色
    property string backGroundColor: "white"
    property Item parentItem : Rectangle {}

    //Dialog header、contentItem、footer之间的间隔默认是12
    // 提示框的最小宽度是 100
    width: {
        if(msg.implicitWidth < 350 || msg.implicitWidth == 350)
            return 350;
        else
            return msg.implicitWidth > 350 ? 350 + 24 : (msg.implicitWidth + 24);
    }
    height: msg.implicitHeight + 24 + 100

    function discardLog()
    {
        mySerialThread.setPkg("done");
        //add to log
        if(mylist_Auditlog.count >0)
        {
            if(mylist_Auditlog.get(0).log_holeid === "")
            {
                mylist_Auditlog.remove(0);
            }
        }

//        mylist_Auditlog.append({"log_date": Qt.formatDateTime(mySysTime, "yyyy-MM-dd"),"log_holeid":str_HoleiD,
//                                   "log_startTime":mylist_summary.get(1).item_value,"log_endTime":mylist_summary.get(2).item_value,"log_totalElapsedTime":mylist_summary.get(3).item_value,
//                                   "log_markedPoints":mylist_summary.get(4).item_value,"log_type":"Discard"});


//        mylist_Auditlog.insert(0,{"log_date": Qt.formatDateTime(mySysTime, "yyyy-MM-dd"),"log_holeid":str_HoleiD,
//                                   "log_startTime":mylist_summary.get(1).item_value,"log_endTime":mylist_summary.get(2).item_value,"log_totalElapsedTime":mylist_summary.get(3).item_value,
//                                   "log_markedPoints":mylist_summary.get(4).item_value,"log_type":"Discard"});

        mylist_Auditlog.insert(0,{"log_date": Qt.formatDateTime(mySysTime, "yyyy-MM-dd"),
                                   "log_holeid":str_HoleiD,
                                   "log_startTime":mylist_summary.get(2).item_value,
                                   "log_endTime":mylist_summary.get(3).item_value,
                                   "log_totalElapsedTime":mylist_summary.get(4).item_value,
                                   "log_RefAngle":mylist_summary.get(5).item_value,
                                   "log_OffsetAngle":mylist_summary.get(6).item_value,
                                   "log_OffsetDist":mylist_summary.get(7).item_value + " " + unit_dist,
                                   "log_markedPoints":mylist_summary.get(8).item_value,
                                   "log_type":"Discard"});


//            myFile.write(mylist_Auditlog.get(mylist_Auditlog.count-1).log_date + " " + mylist_Auditlog.get(mylist_Auditlog.count-1).log_holeid + " " + mylist_Auditlog.get(mylist_Auditlog.count-1).log_startTime + " " +
//                         mylist_Auditlog.get(mylist_Auditlog.count-1).log_endTime + " " + mylist_Auditlog.get(mylist_Auditlog.count-1).log_totalElapsedTime + " " + mylist_Auditlog.get(mylist_Auditlog.count-1).log_markedPoints
//                         + " " + mylist_Auditlog.get(mylist_Auditlog.count-1).log_type);

//        myFile.write(mylist_Auditlog.get(0).log_date + " " + mylist_Auditlog.get(0).log_holeid + " " + mylist_Auditlog.get(0).log_startTime + " " +
//                     mylist_Auditlog.get(0).log_endTime + " " + mylist_Auditlog.get(0).log_totalElapsedTime + " " + mylist_Auditlog.get(0).log_markedPoints
//                     + " " + mylist_Auditlog.get(0).log_type);

//        myFile.write(mylist_Auditlog.get(0).log_date + " " +
//                     mylist_Auditlog.get(0).log_holeid + " " +
//                     mylist_Auditlog.get(0).log_startTime + " " +
//                     mylist_Auditlog.get(0).log_endTime + " " +
//                     mylist_Auditlog.get(0).log_totalElapsedTime + " " +
//                     mylist_Auditlog.get(0).log_RefAngle + " " +
//                     mylist_Auditlog.get(0).log_OffsetAngle + " " +
//                     mylist_Auditlog.get(0).log_OffsetDist + " " + unit_dist + " "+
//                     mylist_Auditlog.get(0).log_markedPoints+ " " +
//                     mylist_Auditlog.get(0).log_type);


        myFile.write(mylist_Auditlog.get(0).log_date + " " +
                     mylist_Auditlog.get(0).log_holeid + " " +
                     mylist_summary.get(2).item_value + " " +
                     mylist_summary.get(3).item_value + " " +
                     mylist_summary.get(4).item_value + " " +
                     mylist_summary.get(5).item_value + " " +
                     mylist_summary.get(6).item_value + " " +
                     mylist_summary.get(7).item_value + " " + unit_dist + " "+
                     mylist_summary.get(8).item_value+ " " +
                     "Discard");



        var resultItem = stack.find(
                                     function(item){
                                                 console.log(item.objectName);
                                                return item.objectName === "Page_DrillPlan_Inputs" ? true : false;
                                            }
                                    );

         if(resultItem !== null)
         {
             console.log("Pop back to Page3")

             myheader.titleStr = "ENTER DRILL PLAN INPUTS";
             is_Unit_Imperial= false

             str_HoleiD = "";
             str_ReferenceLineAngle = "";
             str_OffsetAngle = "";
             str_OffsetDistance  = "";

             markedPoints = 0;

             //mode = 1;
             //tolerance = 1;
             //tolerance_value = 0.05 ;

             mylist_input.setProperty(0,"item_value",qsTr(""),"item_unit",qsTr(""));
             mylist_input.setProperty(1,"item_value",qsTr("0"),"item_unit",qsTr("\xB0"));
             mylist_input.setProperty(2,"item_value",qsTr("0"),"item_unit",qsTr("\xB0"));
             mylist_input.setProperty(3,"item_value",qsTr("0"),"item_unit",unit_dist);

             stack.pop(resultItem);

             dialog.close();
         }
    }


    Dialog {
        id: dialog
        width: dlg_discard.width
        height: dlg_discard.height
        modal: true


        background: Rectangle {
            color: backGroundColor
            anchors.fill: parent
            radius: 5
        }

        contentItem: Rectangle
        {
            id:content_rect
            width:dialog.width
            height:dialog.height
            color: backGroundColor


            Text
            {
                id:msg
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 100
                width:dialog.width

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.pointSize: fsize_med
                font.bold: true
                color: clr_black
                //color: clr_orange
            }

            Button
            {
                id:btn_Discard
                width: 100//dialog.width -10
                height: 60
                anchors.top: msg.bottom
                anchors.topMargin: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -80

                background:
                    Rectangle
                    {
                        anchors.centerIn: parent
                        width: parent.width
                        height: parent.height
                        radius: 5
                        border.color: clr_red
                        border.width: 2
                        color: btn_Discard.pressed ?  backGroundColor : clr_red
                        Text
                        {
                            anchors.centerIn: parent
                            font.family: bodyFont.name
                            font.bold: true
                            font.pointSize: fsize_small
                            color: btn_Discard.pressed ? clr_red : backGroundColor
                            text: "Discard"
                        }
                    }

                onClicked:
                {
                    dlg_discard.discardLog();
                }
            }

            Button
            {
                id:btn_Cancel
                width: btn_Discard.width//dialog.width -10
                height: btn_Discard.height
                anchors.top: msg.bottom
                anchors.topMargin: 100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 80

                background:
                    Rectangle
                    {
                        anchors.centerIn: parent
                        width: parent.width
                        height: parent.height
                        radius: 5
                        border.color: clr_orange
                        border.width: 2
                        color: btn_Cancel.pressed ?  backGroundColor : clr_orange
                        Text {
                            anchors.centerIn: parent
                            font.family: bodyFont.name
                            font.bold: true
                            font.pointSize: fsize_small
                            color: btn_Cancel.pressed ? clr_orange : backGroundColor
                            text: "Cancel"
                        }
                    }

                onClicked:
                {
                    console.log("Cancel");
                    dialog.close();
                }
            }
        }
    }

    //利用Text 的implicitWidth属性来调节提示框的大小
    //该Text的字体格式需要与contentItem中的字体一模一样
   /* Text {
        id: msg
        visible: false
        width: 300
        wrapMode: Text.WordWrap
        font.family: "Microsoft Yahei"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }*/

    function openMsg() {
        dlg_discard.x = (parent.width - dialog.width) * 0.5
        dlg_discard.y = (parent.height - dialog.height) * 0.5
        dialog.open();
    }
}
