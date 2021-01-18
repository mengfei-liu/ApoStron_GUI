import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: dlg_settingsTip
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

    function openMsg()
    {
        dlg_settingsTip.x = (parent.width - dialog.width) * 0.5
        dlg_settingsTip.y = (parent.height - dialog.height) * 0.5
        updateSettingsContent();
        btn_ok.visible = true;
        dialog.open();
    }

    function updateSettingsContent()
    {
        var settings_unit = "<b>Unit : </b>";

        if(is_Unit_Imperial)
        {
            settings_unit += "Imperial"
        }
        else
        {
            settings_unit += "Metric"
        }

        var settings_tolerance = "<b>Accuracy : </b>"
        switch (tolerance)
        {
            case 0:
            {
                settings_tolerance += "Low"
            }
            break;

            case 1:
            {
                settings_tolerance += "Medium"
            }
            break;

            case 2:
            {
                settings_tolerance += "High"
            }
            break;
        }

        msg_settings.text = settings_unit + "<br />" +settings_tolerance ;
    }



    Dialog
    {
        id: dialog
        width: dlg_settingsTip.width
        height: dlg_settingsTip.height
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
                    //anchors.bottom: msg_settings.top
                    //anchors.bottomMargin: 100
                    anchors.top: content_rect.top
                    anchors.topMargin: 20
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family:bodyFont.name
                    font.pointSize: fsize_small+2
                    font.bold: true
                    color: clr_black
                    //color: clr_orange
                    text: msg.text
                }

                Text
                {
                    id: msg_settings
                    width:content_rect.width
                    anchors.verticalCenter: content_rect.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family:bodyFont.name
                    font.pointSize: fsize_small
                    font.bold: false

                    color: clr_black
                }

                Button
                {
                    id:btn_ok
                    width: content_rect.width * 0.8
                    height: 80
                    anchors.horizontalCenter: content_rect.horizontalCenter
                    //anchors.top: msg_settings.bottom
                   // anchors.topMargin: 50
                    anchors.bottom: content_rect.bottom
                    anchors.bottomMargin: 20

                    background:
                        Rectangle
                        {
                            anchors.centerIn: parent
                            width: parent.width
                            height: parent.height
                            radius: 5
                            border.color: clr_orange
                            border.width: 2
                            color: btn_ok.pressed ? backGroundColor : clr_orange
                            Text
                            {
                                anchors.centerIn: parent
//                                font.family: titleFont.name
//                                font.bold: false
//                                font.pointSize: 18
                                font.family: bodyFont.name
                                font.pointSize: fsize_large
                                font.bold: true
                                color: btn_ok.pressed ? clr_orange : backGroundColor
                                text: "OK"
                            }
                        }

                    onClicked:
                    {
                        isSettingsChanged  = false;
                        firstTimeTip = false;
                        dialog.close();
                    }
                }
            }
    }
}
