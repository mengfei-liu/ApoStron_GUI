import QtQuick 2.0
import QtQuick.Controls 2.0

import "../Widgets"
import "../Popup"
import "../Keyboard"
import "../Pages"
//import "../JS/Operate_MyNumPad.js" as MyNumPad
import "../JS/UnitConvert_toFt.js" as M2ft
import "../JS/MyNumPad.js" as MyNumPad
import "../JS/InputValidation.js" as ValidateInput

Rectangle
{
    id:page3
    objectName: "Page_ModeSelection"
    width: 480
    height: 615
    property string pageTitle: qsTr("Choose Alignment Mode")
    property alias col: btns_column

//    property int inputMode: 0
//    property alias keyboardMode1:popup_page3_input_distance.input_dist
//    property alias keyboardMode2:popup_page3_input_angle.input_swing
//    property alias keyboardMode3:popup_page3_input_both.input_dist
//    property alias keyboardMode4:popup_page3_input_both.input_swing



    function popupOpen()
    {
        popup_page3_alert.open();
    }


    Component.onCompleted:
    {
        myheader.titleStr = pageTitle;
        vk_num.state = "inactive";
        //popup_page3_alert.open();
    }

    Connections
    {
        target: window
        onIsSettingsChangedChanged:
        {
            if(isSettingsChanged)
            {
                //dlg_settingsTip.tipText = qsTr("Current Settings")
                //dlg_settingsTip.openMsg();

                popup_settingsTip.contentAlertMsg = popup_settingsTip.updateSettingsContent();
                popup_settingsTip.open();
            }
        }
    }

    Column
    {
        id:btns_column
        anchors.top: page3.top
        anchors.bottom: page3.bottom
        anchors.left: page3.left
        anchors.right: page3.right
        spacing: 3 //(page3.height - 6 * btn_mode1.height)/5



        Btn_Static
        {
            id:btn_mode2
            btn_name: "mode"
            fontPtSize: fsize_med
            //text: qsTr("Measure Line Offset")
            text: qsTr("Check Line")   //project version 3
            onBtnClick:
            {
                pageModeSelection_Mode = 2;
                popup_page3.titleText = btn_mode2.text;
                popup_page3.contentText1 = qsTr("Position the rig at new location and measure the distance from a scanned refrence line.");
                popup_page3.open();
                console.log("col height:",btns_column.height)
            }
        }

        Btn_Static
        {
            id:btn_mode3
            btn_name: "mode"
            fontPtSize: fsize_med
            //text: qsTr("Enter Line Offset")
            text: qsTr("Offset Drill")   //project version 3
            onBtnClick:
            {
                pageModeSelection_Mode = 3;
                popup_page3.titleText = btn_mode3.text;
                popup_page3.contentText1 = qsTr("Position the rig at new location using an entered offset distance from a scanned reference line.");
                popup_page3.open();
            }
        }

        Btn_Static
        {
            id:btn_mode1
            btn_name: "mode"
            fontPtSize: fsize_med
            //text: qsTr("Align to Reference Line")
            text: qsTr("Put Drill on Line")   //project version 3
            onBtnClick:
            {
                pageModeSelection_Mode = 1;
                popup_page3.titleText = btn_mode1.text;
                popup_page3.contentText1 = qsTr("Position the rig directly under a line created by scanning two reference points.") ;
                popup_page3.open();
            }
        }

        Btn_Static
        {
            id:btn_mode4
            btn_name: "mode"
            fontPtSize: fsize_med
           // text: qsTr("Enter Swing Offset")
            text: qsTr("Swing Drill")   //project version 3
            onBtnClick:
            {
                pageModeSelection_Mode = 4;
                popup_page3.titleText = btn_mode4.text;
                popup_page3.contentText1 = qsTr("Position the rig at new location using a predetermined swing offset angle with scanned rig reference and pivot points.");
                popup_page3.open();
            }
        }
        Btn_Static
        {
            id:btn_mode5
            btn_name: "mode"
            fontPtSize: fsize_med
            //text: qsTr("Enter Swing & Line Offset")
            text: qsTr("Offset & Swing Drill")   //project version 3
            onBtnClick:
            {
                pageModeSelection_Mode = 5;
                popup_page3.titleText = btn_mode5.text;
                popup_page3.contentText1 = qsTr("Position the rig at new location using an entered swing angle and offset distance with scanned rig reference and pivot points.");
                popup_page3.open();
            }
        }

        Btn_Static
        {
            id:btn_mode6
            btn_name: "mode"
            fontPtSize: fsize_med
            text: qsTr("Measure Dip")
            onBtnClick:
            {
                pageModeSelection_Mode = 6;
                popup_page3.titleText = btn_mode6.text;
                popup_page3.contentText1 = qsTr("Measure the dip angle of the drill");
                popup_page3.open();
            }
        }

        Btn_Static
        {
            id:btn_mode7
            btn_name: "mode"
            fontPtSize: fsize_med
            text: qsTr("Level Platform")
            onBtnClick:
            {
                pageModeSelection_Mode = 7;
                popup_page3.titleText = btn_mode7.text;
                popup_page3.contentText1 = qsTr("Start or continue building a platform.\r\nVerify an existing platform is level.");
                popup_page3.open();
            }
        }

        Btn_Static
        {
            id:btn_relevel
            height: btns_column.btnHeight
            btn_name: "relevel2"
            fontPtSize: fsize_med
            text: qsTr("Re-Level?")
            onBtnClick:
            {
                pageModeSelection_Mode = 0;
                popup_page3.titleText = "Re-Level?";
                popup_page3.contentText1 = qsTr("Reset/Re-Level Tripod?");
                popup_page3.open();
            }
        }
    }
}
