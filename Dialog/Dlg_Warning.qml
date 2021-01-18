import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id: dlg_warning
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
        dlg_warning.x = (parent.width - dialog.width) * 0.5
        dlg_warning.y = (parent.height - dialog.height) * 0.5

        btn_ok.visible = true;
        dialog.open();
    }


    Dialog
    {
        id: dialog
        width: dlg_warning.width
        height: dlg_warning.height
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
                    anchors.top: content_rect.top
                    anchors.topMargin: 20
                   // anchors.bottom: msg_settings.top
                    //anchors.bottom: msg_col.top
                    //anchors.bottomMargin: 100
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family:bodyFont.name
                    font.pointSize: fsize_small+2
                    font.bold: true
                    color: clr_black
                    //color: clr_orange
                    text: msg.text
                }

//                Column
//                {
//                    id:msg_col
//                    width:content_rect.width
//                    anchors.verticalCenter: content_rect.verticalCenter
//                    spacing: 20
//                    Text
//                    {
//                        id: msg_settings
//                        anchors.horizontalCenter : msg_col.horizontalCenter
//                        verticalAlignment: Text.AlignVCenter
//                        horizontalAlignment: Text.AlignHCenter
//                        font.family:bodyFont.name
//                        font.pointSize: fsize_med
//                        font.bold: true
//                        color: clr_black
//                        //color: "red"
//                        text:
//                        {
//                            "Working in progress"
//                        }
//                    }

//                    Text
//                    {
//                        id: msg_settings_2
//                        anchors.horizontalCenter : msg_col.horizontalCenter
//                        verticalAlignment: Text.AlignVCenter
//                        horizontalAlignment: Text.AlignHCenter
//                        font.family:bodyFont.name
//                        font.pointSize: 16
//                        font.bold: true
//                        color: clr_black
//                        //color: "red"
//                        text:
//                        {
//                            "Settings cannot be changed now"
//                        }
//                    }

//                }

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
                    wrapMode: Text.WordWrap
                    color: clr_black
                    text: "Setting cannot be changed until workflow is complete."
                }

                Button
                {
                    id:btn_ok
                    width: content_rect.width * 0.8
                    height: 80
                    anchors.horizontalCenter: content_rect.horizontalCenter
                    //anchors.top: msg_settings.bottom
                    //anchors.topMargin: 50

                    //anchors.top: msg_col.bottom

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
                        console.log("OK");
                        dialog.close();
                    }
                }
            }
    }
}
