import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: dlg_pwrMenu_timer
    anchors.centerIn: parent
    //提示框内容
    property alias tipText: msg.text
    //property alias btn_action_text: btn_action_text.text
    //提示框颜色
    property string backGroundColor: "white"
    property Item parentItem : Rectangle {}

    // 提示框的最小宽度是 100
//    width: {
//        if(msg.implicitWidth < 350 || msg.implicitWidth == 350)
//            return 350;
//        else
//            return msg.implicitWidth > 350 ? 350 + 24 : (msg.implicitWidth + 24);
//    }
//    height: msg.implicitHeight + 24 + 100

    width: 350
    height: 380

    property int defaultSeconds: 5
    property int seconds: defaultSeconds

    function openMsg()
    {
        dlg_pwrMenu_timer.x = (parent.width - dialog.width) * 0.5
        dlg_pwrMenu_timer.y = (parent.height - dialog.height) * 0.5

        btn_Cancel.visible = true;
        dlg_pwrMenu_timer.seconds = dlg_pwrMenu_timer.defaultSeconds;
        msg_timer.text = dlg_pwrMenu_timer.seconds;
        superReset_Timer.start();
        dialog.open();
    }

    Timer {
        id: superReset_Timer

        interval: 1000
        repeat: true

        onTriggered:
        {
            //visible = false
            //page1.timeout();
            if(seconds > 0)
            {
                msg.visible = true;
                seconds--;
                msg_timer.text = seconds;
            }
            else
            {
                msg.visible = false;
                msg_timer.text = "Shutting Down ...";
                btn_Cancel.visible = false;
                superReset_Timer.stop()
                console.log("Shut Down");
                mySerialThread.superReset(0);
            }
        }
    }

    Dialog
    {
        id: dialog
        width: dlg_pwrMenu_timer.width
        height: dlg_pwrMenu_timer.height
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

                Text
                {
                    id: msg
                    width:content_rect.width
                    anchors.horizontalCenter: content_rect.horizontalCenter
                    anchors.bottom: msg_timer.top
                    anchors.bottomMargin: 100
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family:bodyFont.name
                    font.pointSize: fsize_small + 2
                    font.bold: true
                    color: clr_black
                    //color: clr_orange
                    text: msg.text
                }

                Text
                {
                    id: msg_timer
                    width:content_rect.width
                    anchors.verticalCenter: content_rect.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family:bodyFont.name
                    font.pointSize: fsize_med//30
                    font.bold: true

                    color: clr_black
                    text: defaultSeconds
                }

                Button
                {
                    id:btn_Cancel
                    width: content_rect.width * 0.8
                    height: 80
                    anchors.horizontalCenter: content_rect.horizontalCenter
                    anchors.top: msg_timer.bottom
                    anchors.topMargin: 60

                    background:
                        Rectangle
                        {
                            anchors.centerIn: parent
                            width: parent.width
                            height: parent.height
                            radius: 5
                            border.color: clr_orange
                            border.width: 2
                            color: btn_Cancel.pressed ? backGroundColor : clr_orange
                            Text
                            {
                                anchors.centerIn: parent
                                font.family: bodyFont.name
                                font.bold: true
                                font.pointSize: fsize_large
                                color: btn_Cancel.pressed ? clr_orange : backGroundColor
                                text: "Cancel"
                            }
                        }

                    onClicked:
                    {
                        console.log("Cancel");
                        superReset_Timer.stop();
                        dlg_pwrMenu_timer.seconds = dlg_pwrMenu_timer.defaultSeconds;
                        dialog.close();
                    }
                }
            }
    }
}
