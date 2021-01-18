import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: dlg_pwrMenu
    anchors.centerIn: parent
    //提示框内容
    property alias tipText: msg.text
    //property alias btn_action_text: btn_action_text.text
    //提示框颜色
    property string backGroundColor: "white"
    property Item parentItem : Rectangle {}

    // 提示框的最小宽度是 100
    width: {
        if(msg.implicitWidth < 350 || msg.implicitWidth == 350)
            return 350;
        else
            return msg.implicitWidth > 350 ? 350 + 24 : (msg.implicitWidth + 24);
    }
    height: msg.implicitHeight + 24 + 100

    function openMsg() {
        dlg_pwrMenu.x = (parent.width - dialog.width) * 0.5
        dlg_pwrMenu.y = (parent.height - dialog.height) * 0.5
        dialog.open();
    }

    function stackIni()
    {
       // is_Unit_Imperial =  false
       // unit_dist =  "m"
//        str_HoleiD = ""
//        str_ReferenceLineAngle = ""
//        str_OffsetAngle = ""
//        str_OffsetDistance = ""
        //mode =  1
        //tolerance =  1
        //tolerance_value =0.05
        //markedPoints = 0;

        referenceMode = 0;
        arr_measuredDist=[];
        dDistOffset = 0.0;
        dSwingOffset = 0.0;
        num_Measured = 0;
        mode =  0;
        pageModeSelection_Mode = 0;
        tolerance =  1;
        tolerance_value = 0.02;
        second_elapsed= 0;
        markedPoints = 0;
        levelX = 0.0;
        levelY = 0.0;
        global_wip = false;
        footerPoped = false;
        isDTRCorrect = false;
        inputMode =0;
        page4.page4Ini();
        page5.page5Ini();
        page6.page6Ini();

        stack.pop(null);
        page2.page2ini();
        stack.initialItem = Qt.resolvedUrl("qrc:/Page_2_Initialize_Laser_Device.qml")

    }

    Dialog {
        id: dialog
        width: dlg_pwrMenu.width
        height: dlg_pwrMenu.height
        modal: true


        background:
            Rectangle
            {
                color: backGroundColor
                anchors.fill: parent
                radius: 5
            }

        contentItem:
            Rectangle
            {
                id:content_rect
                width:dialog.width
                height:dialog.height

                color: backGroundColor

                Column
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 30

                    Text
                    {
                        width:dialog.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter

                        font.family:bodyFont.name
                        font.pointSize: fsize_small + 2
                        font.bold: true
                        //color: clr_orange
                        color: clr_black

                        text: msg.text

                    }

                    Button
                    {
                        id:btn_Reset
                        width: dialog.width -10
                        height: 60
                        anchors.horizontalCenter: parent.horizontalCenter

                        background:
                            Rectangle
                            {
                                anchors.centerIn: parent
                                width: parent.width
                                height: parent.height
                                radius: 5
                                border.color: clr_orange
                                border.width: 2
                                //color: backGroundColor
                                color: btn_Reset.pressed ?  backGroundColor : clr_orange
                                Text
                                {
                                    anchors.centerIn: parent
                                    //font.family: titleFont.name
                                    font.family:bodyFont.name
                                    font.bold: true
                                    font.pointSize: fsize_med
                                    color: btn_Reset.pressed ? clr_orange : backGroundColor
                                    text: "Reset"
                                }
                            }

                        onClicked:
                        {
                            if(stack.currentItem.objectName !== "Page_Initialize" && global_wip === false)
                            {
                                console.log("Reset");
                                dlg_pwrMenu.stackIni();
                                mySerialThread.superReset(1);
                            }
                            else
                            {
                                console.log("Work In Progress, cannot reset")
                            }
                            dialog.close()
                        }
                    }

                    Button
                    {
                        id:btn_ShutDown
                        width: btn_Reset.width
                        height: btn_Reset.height
                        anchors.horizontalCenter: parent.horizontalCenter

                        background: Rectangle {
                            anchors.centerIn: parent
                            width: parent.width
                            height: parent.height
                            radius: 5
                            border.color: clr_orange
                            border.width: 2
                            color: btn_ShutDown.pressed ? backGroundColor : clr_orange
                            Text {
                                anchors.centerIn: parent
                                font.family:bodyFont.name
                                font.bold: true
                                font.pointSize: fsize_med
                                color: btn_ShutDown.pressed ? clr_orange : backGroundColor
                                text: "Shut Down"
                            }
                        }

                        onClicked:
                        {
                            shutDown_timer_dlg.tipText = "System will Shut Down in"
                            shutDown_timer_dlg.openMsg();
                        }
                    }

                    Button
                    {
                        id:btn_Cancel
                        width: btn_Reset.width
                        height: btn_Reset.height
                        anchors.horizontalCenter: parent.horizontalCenter

                        background: Rectangle {
                            anchors.centerIn: parent
                            width: parent.width
                            height: parent.height
                            radius: 5
                            border.color: clr_orange
                            border.width: 2
                            color: btn_Cancel.pressed ? backGroundColor : clr_orange
                            Text {
                                anchors.centerIn: parent
                                font.family:bodyFont.name
                                font.bold: true
                                font.pointSize: fsize_med
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
                } // row
            }
    }

    //利用Text 的implicitWidth属性来调节提示框的大小
    //该Text的字体格式需要与contentItem中的字体一模一样
    Text {
        id: msg
        visible: false
        //width: 300
        //wrapMode: Text.WordWrap
        //font.family: "Microsoft Yahei"
        font.family:bodyFont.name
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }


}
