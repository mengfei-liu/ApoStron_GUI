import QtQuick 2.7
import QtQuick.Controls 2.0

import FileIO 1.0
import MyTouchscrrenMonitor 1.0
import "./Pages"
import "./Widgets"
import "./Popup"
import "./Keyboard"
import "./Dialog"
import "./JS/UnitConvert.js" as UC
import "./JS/UnitConvert_toFt.js" as M2ft
import "./JS/MyNumPad.js" as MyNumPad
import "./JS/InputValidation.js" as ValidateInput
import "./JS/Database.js" as DB



ApplicationWindow
{
    id: window
    visible: true
    width: 480
    height: 800
    title: qsTr("Stack")
    objectName: "Main_Window"

    //Item
//    property Item shutDown_dlg: dlg_pwrMenu
//    property Item shutDown_timer_dlg: dlg_pwrMenu_timer
//    property Item discard_dlg: dlg_discard
//    property Item settingsTip_dkg: dlg_settingsTip
//    property Item warning_dlg: dlg_warning



    // colors
    property color clr_gray1: Qt.rgba(128/255,127/255,131/255,1)
    property color clr_gray2: Qt.rgba(82/255,88/255,97/255,1)
    property color clr_gray3: Qt.rgba(223/255,225/255,223/255,1)
    property color clr_orange: Qt.rgba(227/255,114/255,34/255,1)
    property color clr_black: Qt.rgba(0,0,0,1)
    property color clr_ltblack: Qt.rgba(20/255,20/255,20/255,1)
    property color clr_red: Qt.rgba(1,0,0,1)
    property color clr_green: (Qt.rgba(0,150/255,0,1)) //Qt.lighter
    property color clr_batterygreen: (Qt.rgba(0,200/255,0,1))

    // font size
    property int fsize_3xs: 10
    property int fsize_2xs: 12
    property int fsize_xs: 16
    property int fsize_small: 18

    property int fsize_med: 22

    property int fsize_large: 36


    // keyboard color
    property color clr_keybord_gray: Qt.rgba(171/255,181/255,191/255,1)
    property color clr_keybord_grayDark: Qt.rgba(102/255,118/255,134/255,1)
    property color clr_keybordBKG_gray: Qt.rgba(191/255,191/255,199/255,1)
    property color clr_keybordNum_gray: Qt.rgba(161/255,161/255,161/255,1)
    property color clr_keybordNum_grayDark: Qt.rgba(120/255,120/255,120/255,1)

    // parameters settings
    property bool firstTimeTip: true
    property bool isSettingsChanged: false

    //property bool is_Unit_Imperial: false
    property bool is_Unit_Imperial: true
    property string unit_dist: is_Unit_Imperial ? "ft" : "m"
    property string unit_swing: "\xB0"


    property string str_HoleiD
    property string str_ReferenceLineAngle
    property string str_OffsetAngle
    property string str_OffsetDistance
    property string str_OffsetDistance_ft

    property real modeBtnHeight: (615 - 3 * 7 )/8
    property int referenceMode: 1
    property variant arr_measuredDist:[]
    property double dDistOffset
    property string sDistOffset
    property double dSwingOffset

    property double dist_offset_range: 30
    //property double dist_offset_range: 50

    property double swing_offset_range: 30
    property int num_Measured: 0
    property int mode: 1
    property int pageModeSelection_Mode: 0
    property int tolerance: 1
    property double tolerance_value:0.02 //0.05

    property string myLanguage
    property string help_title
    property string myIPaddress

    // time settings
    property date bootTime
    property date myStartTime
    property date myEndTime
    property string myDate
    property string startTime
    property string endTime
    property string totalElapsedTime

    property string myYear
    property string myMonth
    property string myDay
    property string myHour
    property string myMin
    property string mySec

    property int years
    property int months
    property int days
    property int hours
    property int minutes
    property int seconds

    property date mycurrentTime
    property date mySysTime

    property int second_elapsed: 0
   // property date mydate: new Date();

    property int markedPoints:0
    property double levelX: 0.0
    property double levelY: 0.0


    property double dip_Distance: 0.0
    property double dip_Angle: 0.0
    property double dip_Accuracy: 0.0

    property bool global_wip: false;
    property bool footerPoped: false
    property string password
    property string degree_symbol: "\xB0"
    property string myVer: "Ver. 3.0"
    property string myVerDate: "2019/10/29"

    property bool isDTRCorrect: false
    property int inputMode: 0
    property bool inputIsCW_ModeSwing: true
    property bool inputIsCW_ModeDistSwing: true
    property alias keyboardMode1:popup_page3_input_distance.input_dist
    property alias keyboardMode2:popup_page3_input_angle.input_swing
    property alias keyboardMode3:popup_page3_input_both.input_dist
    property alias keyboardMode4:popup_page3_input_both.input_swing

    //Item
    property Item shutDown_dlg: dlg_pwrMenu
    property Item shutDown_timer_dlg: dlg_pwrMenu_timer
    property Item settingsTip_dkg: dlg_settingsTip
    property Item warning_dlg: dlg_warning

    onIs_Unit_ImperialChanged:
    {
        if(is_Unit_Imperial)
        {
//            pageSettings.radio_h_text = UC.m2fractional_Ft_Inches_Style(0.01)
//            pageSettings.radio_m_text = UC.m2fractional_Ft_Inches_Style(0.02)
//            pageSettings.radio_l_text = UC.m2fractional_Ft_Inches_Style(0.04)
            pageSettings.radio_h_text = UC.m2fractional_Ft_Inches(0.01)
            pageSettings.radio_m_text = UC.m2fractional_Ft_Inches(0.02)
            pageSettings.radio_l_text = UC.m2fractional_Ft_Inches(0.04)

        }
        else
        {
            pageSettings.radio_h_text = "0.01m"
            pageSettings.radio_m_text = "0.02m"
            pageSettings.radio_l_text = "0.04m"
        }

    }

    FontLoader
    {
        id:titleFont
        source: Qt.resolvedUrl("qrc:/Fonts/AgencyFBBoldCondensed.ttf");
    }

    FontLoader
    {
        id:bodyFont
        source: Qt.resolvedUrl("qrc:/Fonts/HELR45W.ttf");
    }

    //File
    FileIO
    {
        id: myFile
        //source: "C:\\Users\\Mengfei\\Desktop\\LogData.txt"
        source: "//home//pi//LogData.txt"

    }

    FileIO
    {
        id:myupdatefile
        source: "//home//pi//updatefile.txt"
    }

    Timer
    {
        id:brightnessTimer
        interval: 300000
        running: true
        onTriggered:
        {
            mySerialThread.screenDark();
        }
    }

    Timer
    {
        id: timer_elapsed
        interval: 1000;
        running: false;

        repeat: true

        onTriggered:
        {
            second_elapsed ++;
        }
    }

    Timer
    {
        id : timer
        //interval: 500;
        interval: 1000;
        running: true;
        repeat: true
        onTriggered:
        {
            mySysTime = new Date();

            myheader.dateString  = Qt.formatDateTime(mySysTime, "yyyy-MM-dd");
            myheader.timeString = Qt.formatDateTime(mySysTime, "hh:mm:ss");

            hours = mySysTime.getHours();
            minutes = mySysTime.getMinutes();
            seconds = mySysTime.getSeconds();

            years = mySysTime.getFullYear();
            months = mySysTime.getMonth()+1;
            days = mySysTime.getDay();
        }
    }

    ListModel
    {
        id: myyearModel;
        ListElement {numberText:"2019" }
        ListElement {numberText:"2020" }
        ListElement {numberText:"2021" }
        ListElement {numberText:"2022" }
        ListElement {numberText:"2023" }
        ListElement {numberText:"2024" }
    }

    ListModel
    {
        id:mylist_help_v2
        ListElement { help_content:""}
    }

    ListModel
    {
        id: mylanguageModel;
        ListElement {lang:"English" }
        ListElement {lang:"French" }
        ListElement {lang:"Spanish" }
    }

    ListModel
    {
        id:mylist_review
        ListElement { review_data: qsTr("");}
    }

    ListModel
    {
        id:mylist_Auditlog
        ListElement { log_date: qsTr("");log_starttime: qsTr("");log_endtime: qsTr("");log_ElapsedTime: qsTr("");log_unit: qsTr("");log_accuracy: qsTr("");log_mode: qsTr("");log_dtr: qsTr("");log_swing: qsTr("");log_measuredPts: qsTr("");log_dtt: qsTr("");}
    }

    Connections
    {
        target: mySerialThread

        onUnitChanged:
        {

            is_Unit_Imperial = mySerialThread.unit
            console.log("get unit changed, is_Unit_Imperial = ",is_Unit_Imperial)
            if(is_Unit_Imperial)
            {
                console.log("Imperial")
            }
            else
                console.log("Not Imperial")
        }

        onToleranceChanged:
        {
            tolerance = mySerialThread.tolerance;

            switch (tolerance)
            {
                case 0:
                    //tolerance_value = 0.1
                    tolerance_value = 0.04 //project version 3
                break;

                case 1:
                    //tolerance_value = 0.05
                    tolerance_value = 0.02  //project version 3
                break;

                case 2:
                  //tolerance_value = 0.02
                    tolerance_value = 0.01      //project version 3
                break;
            }
        }

        onBatteryChanged:
        {
            var iBattery = mySerialThread.iBattery;
            myheader.iBatteryPercentage = iBattery;
        }


        onShowErrorPage:
        {
            stack.push(Qt.resolvedUrl("qrc:/Pages/Page_Error_Message.qml"));
        }

        onIsScanDISDETDONE_confirmedChanged:
        {
            if(mySerialThread.isScanDISDETDONE_confirmed)
            {
                mySerialThread.setPkg(2,0,dDistOffset);
                //console.log("Parameters Update Mode 2")

                if(is_Unit_Imperial)
                {
                    //area_d2r.mynum =  input_dist.input_value
                    page6.area_d2rNum  = UC.m2fractional_Ft_Inches_Style(dDistOffset)
                }
                else
                {
                    //area_d2r.mynum =  input_dist.input_value+"m";
                    //page6.area_d2rNum  =  String(dDistOffset.toFixed(3)) + "m"
                    page6.area_d2rNum  =  String(dDistOffset.toFixed(2)) + "m"
                }
            }
        }

        onIsMode22ndModeCMD_confirmedChanged:
        {
            if(mySerialThread.isMode2_2ndModeCMD_confirmed)
            {

            }
        }

        onIsScanDISDETDONE_completeChanged:
        {
            if(mySerialThread.isScanDISDETDONE_completed)
            {
                //scan start
                mySerialThread.setPkg("Scan","start");
                //console.log("Scan Start")
            }
        }
    }

    Component.onCompleted:
    {
        DB.initialize();
        //myFile.createFile();
        //mySerialThread.systemRights(myFile.source);
        //console.log( "Read Log File: " + myFile.read()+ "\r\n");
        //ReadSD2Log.readSD2Log(myFile.read(),mylist_Auditlog);

        //mySerialThread.start();
        mySerialThread.openAndSetPort();
        mySysTime = new Date();
        bootTime = mySysTime;
    }

    //Touch Event
    Connections
    {
        target: MyTouchscrrenMonitor

        onTouchBegin:
        {
//            if(touchTimer.running)
//            {
//                touchTimer.stop();
//                //console.log("timer stop")
//                brightnessTimer.stop();
//            }

            if(brightnessTimer.running)
            {
                brightnessTimer.stop();
            }
        }

        onTouchEnd:
        {
//            if(touchTimer.running === false)
//            {
//                touchTimer.restart();
//                // console.log("timer restart")
//                brightnessTimer.restart();
//                mySerialThread.screenLight();
//            }

            if(brightnessTimer.running === false)
            {
                brightnessTimer.restart();
                mySerialThread.screenLight();
            }
        }
    }

    Dlg_SettingsTip
    {
        id:dlg_settingsTip
        height: 350
        anchors.verticalCenter: stack.verticalCenter
    }

    Dlg_Warning
    {
        id:dlg_warning
        height: 350
        anchors.verticalCenter: stack.verticalCenter
    }

    Dlg_Pwr_Menu_Main
    {
        id:dlg_pwrMenu
        height: 350
        anchors.verticalCenter: stack.verticalCenter
    }

    Dlg_Pwr_Menu_Sub_Timer
    {
        id:dlg_pwrMenu_timer
        height: 350
        anchors.verticalCenter: stack.verticalCenter
    }

    Popup_Main_V2
    {
        id:popup_pwrMenu
        titleText: qsTr("Shut Down")
        contentText1: qsTr("Click <b>Shut Down</b> to turn off the device.")
        lBtn_text: qsTr("Cancel")
        rBtn_text: qsTr("Shut Down")
        onLBtn_Clicked:
        {
            popup_pwrMenu.close();
        }
        onRBtn_Clicked:
        {
            popup_pwrMenu.close();
            popup_pwrMenu_timer.lBtn_text = qsTr("Cancel")
            popup_pwrMenu_timer.open();
            popup_pwrMenu_timer.seconds = 5;
            popup_pwrMenu_timer.startTimer();
        }
    }

    Popup_Main_V2
    {
        id:popup_pwrMenu_timer
        titleText: qsTr("Shutting Down")
        contentText1: qsTr(" ")
        contentAlertMsg: "The device will shut down in <font size='6'><b>" + defaultSeconds + "</b></font> seconds."
        lBtn_text: qsTr("Cancel")

        property int defaultSeconds: 5
        property int seconds: defaultSeconds

        function startTimer()
        {
            superReset_Timer.start();
        }

        Timer {
            id: superReset_Timer

            interval: 1000
            repeat: true

            onTriggered:
            {
                //visible = false
                //page1.timeout();
                if(popup_pwrMenu_timer.seconds > 0)
                {
                    popup_pwrMenu_timer.seconds--;
                    popup_pwrMenu_timer.contentAlertMsg =  "The device will shut down in <font size='6'><b>" + popup_pwrMenu_timer.seconds + "</b></font> seconds."
                }
                else
                {
                    popup_pwrMenu_timer.contentAlertMsg = "<font size='5'>Shutting Down ...</font>";
                    //popup_pwrMenu_timer.lBtn.visible = false;
                   // popup_pwrMenu_timer.lBtn.enabled = false;
                   // popup_pwrMenu_timer.hor_devider.visible = false;
                    popup_pwrMenu_timer.lBtn_text = ""
                    popup_pwrMenu_timer.lBtn.enabled = false;
                    superReset_Timer.stop()
                    mySerialThread.superReset(0);
                }
            }
        }

        onLBtn_Clicked:
        {
            superReset_Timer.stop()
            popup_pwrMenu_timer.seconds = defaultSeconds;
            popup_pwrMenu_timer.contentAlertMsg = "The device will shut down in <font size='6'><b>" + seconds + "</b></font> seconds."
            popup_pwrMenu_timer.close();
        }
    }

    //Page Component
    Page_1_SplashScreen
    {
        onTimeout:
        {
            myheader.visible = true;
            myfooter.visible = true;
            stack.visible = true;
            popup_page2_alert.open();
        }
    }

    Page_2_Initialize_Laser_Device
    {
        id:page2
        visible: false
    }

    Page_3_Mode_Selection
    {
        id:page3
        visible: false
    }

    Page_4_Reference_Scan
    {
        id:page4
        visible: false
    }

    Page_5_Pivot_Scan
    {
        id:page5
        visible: false
    }

    Page_6_Measuring
    {
        id:page6
        visible: false
    }

    Page_7_Alignment_Review
    {
        id:page7
        visible: false
    }

    Page_Settings
    {
        id:pageSettings
        visible: false
    }

    Popup_Main_V2
    {
        id:popup_page2_alert
        titleText: qsTr("Set up Tripod")
        contentText1: qsTr("Assemble the tripod and laser alignment head in a location with good visibility to the rig and reference points.")
        contentText2: qsTr("Rotate device and/or adjust tripod legs until the disk is centered within the alignment zone.")
        contentAlertMsg: qsTr("The tripod location cannot be moved after it has been levelled.")
        lBtn_text: qsTr("OK")
        onLBtn_Clicked:
        {
            popup_page2_alert.close();

        }
    }

    Popup_Main_V2
    {
        id:popup_page3_alert
        titleText: qsTr("Choose Alignment Mode")
        contentText1: qsTr("The chosen selection will provide workflow guidance during the alignment process.")
        contentAlertMsg: qsTr("The tripod location cannot be moved after it has been levelled.")
        lBtn_text: qsTr("OK")
        onLBtn_Clicked:
        {
            popup_page3_alert.close();

            if(isSettingsChanged || firstTimeTip)
            {
                //dlg_settingsTip.tipText = "Current Settings"
                //dlg_settingsTip.openMsg();
                popup_settingsTip.contentAlertMsg = popup_settingsTip.updateSettingsContent();
                popup_settingsTip.open();
            }
        }
    }

    Popup_Main_V2
    {
        id:popup_settingsTip
        titleText: qsTr("Current Settings")
        contentText1: qsTr(" ")
        contentAlertMsg: updateSettingsContent()
        lBtn_text: qsTr("OK")

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
                    //settings_tolerance += "Low"
                    settings_tolerance += is_Unit_Imperial ? UC.m2fractional_Ft_Inches(0.04) : "0.04m"
                }
                break;

                case 1:
                {
                    //settings_tolerance += "Medium"
                    settings_tolerance += is_Unit_Imperial ? UC.m2fractional_Ft_Inches(0.02) : "0.02m"
                }
                break;

                case 2:
                {
                    //settings_tolerance += "High"
                    settings_tolerance += is_Unit_Imperial ? UC.m2fractional_Ft_Inches(0.01) : "0.01m"
                }
                break;
            }

            var settingsContent = settings_unit + "<br />" +settings_tolerance ;
            return settingsContent;
        }

        onLBtn_Clicked:
        {

            isSettingsChanged  = false;
            firstTimeTip = false;
            popup_settingsTip.close();
        }
    }

    Popup_Main_V2
    {
        id:popup_page3_alert_input
        titleText: qsTr("Input Error")
        contentText1: qsTr("The line offset Distance should be -30 ~ +30.")
        contentAlertMsg: qsTr("Current in put is 60.")
        lBtn_text: qsTr("OK")
        onLBtn_Clicked:
        {
            popup_page3_alert_input.close();
        }
    }


    Popup_Main_V2
    {
        id:popup_page3_input_distance
        objectName: "input_distance"
        titleText: qsTr("What is the Offset Distance?")
        pic1_url:  Qt.resolvedUrl("qrc:/Images/input_mode2.png")
        //contentText1: qsTr("A positive offset value (<table><img width=\"25\" height=\"25\" align=\"middle\" src=\"qrc:/Icons/D4text.svg\" ></table>) will move the target line away from a scanned reference line and tripod.")
        //contentText2: qsTr("A negative offset value (<table><img width=\"25\" height=\"25\" align=\"middle\" src=\"qrc:/Icons/D4text.svg\" ></table>) will move the target line towards the tripod in the opposite direction of the scanned reference line.")
        contentText1: qsTr(" ")
        input_dist_title: "Enter Distance Offset"
        input_dist_unit: unit_dist
        lBtn_text: qsTr("Back")
        rBtn_text: qsTr("OK")
        onLBtn_Clicked:
        {
            if(is_Unit_Imperial)
            {
                popup_page3_input_distance.input_dist.input_value = "0ft 0-0/8in";
            }
            else
                popup_page3_input_distance.input_dist.input_value = "0";

            popup_page3_input_distance.close();
        }

        onRBtn_Clicked:
        {
           // ValidateInput.validateInput(dist_offset_range,is_Unit_Imperial,inputMode,input_dist.input_value)
           // popup_page3_alert_input.contentAlertMsg =  qsTr("Current in put is ") + input_dist.input_value
            var isValid = ValidateInput.validateInput(dist_offset_range,is_Unit_Imperial,inputMode,input_dist.input_value);
            console.log("isValid = ",isValid)
            if(isValid[0] === false )
            {
                popup_page3_input_distance.input_dist.input_value = isValid[2]

                if(is_Unit_Imperial)
                {
                    popup_page3_alert_input.contentText1 =  qsTr("The Line Offset Distance should be -" + isValid[3] +" ~ +"+isValid[3])
                    if(isValid[1] === isValid[2])
                        popup_page3_alert_input.contentAlertMsg =  qsTr("Current in put is ") +  isValid[1] +  " is outranged ±" + isValid[3]
                    else
                       popup_page3_alert_input.contentAlertMsg =  qsTr("Current in put is ") +  isValid[1] + "(" + isValid[2] + ") is outranged ±" + isValid[3]
                }
                else
                {
                    popup_page3_alert_input.contentText1 =  qsTr("The Line Offset Distance should be -" + isValid[3] +"m ~ +"+isValid[3]+ "m")
                    popup_page3_alert_input.contentAlertMsg =  qsTr("Current in put is ") +  isValid[1] +  "m is outranged ±" + isValid[3] + "m"
                }
                popup_page3_alert_input.open();
            }
            else
            {
                popup_page3_input_distance.close();
                //dDistOffset = Number(isValid[1]).toFixed(3);
                dDistOffset = UC.toFixed(Number(isValid[1]),2);

                console.log("distance input = ",dDistOffset,"m")
                mySerialThread.setPkg(3,0,dDistOffset);

                //mySerialThread.setPkg("scan","start"); //20190614
                page4.page4Ini();
                stack.push(page4);
                //myheader.titleStr = "Reference Scanning"
                page4.popupOpen();
                //stack.push(Qt.resolvedUrl("qrc:/Pages/Page_4_Reference_Scan.qml"))
                //stack.currentItem.popupOpen();
            }

           // stack.push(Qt.resolvedUrl("qrc:/Pages/Page_4_Reference_Scan.qml"))
        }

        onInput_dist_Clicked:
        {
            inputMode = 1;
            vk_num_page3.surface = page3
            vk_num_page3.container = popup_page3_input_distance
            vk_num_page3.haveSign = true;

            if(is_Unit_Imperial)
            {
                vk_num_page3.btn_func_visible = true;
            }
            else
                vk_num_page3.btn_func_visible = false;

            vk_num_page3.show();
        }
    }

    Popup_Main_V2
    {
        //input6
        id:popup_page3_input_angle
        objectName: "input_angle"
        titleText: qsTr("What is the Swing Angle?")
        pic1_url: Qt.resolvedUrl("qrc:/Images/input_mode4.png")
        //contentText1: qsTr("A positive swing angle value will rotate the target line about the scanned pivot point (<img width=\"20\" height=\"20\" align=\"middle\" src=\"qrc:/Icons/X4text.png\" >) in a (CCW) direction. A negative value will do the opposite. The offset distance of the pivot point is determined by the scanned location.")
        //contentText1: qsTr("<b>Positive:</b> Counter Clockwise(CCW)" + "<br><b>Negative:</b> Clockwise(CW)</br>" + "<br><b>Pivot:</b> Scanned Point <img width=\"20\" height=\"20\"src=\"qrc:/Icons/X4text.png\"></br>")
        contentText1: qsTr("The swing angle is the angle between the original reference line azimuth and the new line.")
        input_swing_title: qsTr("Enter Swing Angle")
        input_swing_unit: unit_swing
        lBtn_text: qsTr("Back")
        rBtn_text: qsTr("OK")

        onLBtn_Clicked:
        {
            popup_page3_input_angle.input_swing.input_value = "0";
            popup_page3_input_angle.close();
        }

        onRBtn_Clicked:
        {
           // ValidateInput.validateInput(dist_offset_range,is_Unit_Imperial,inputMode,input_dist.input_value)
           // popup_page3_alert_input.contentAlertMsg =  qsTr("Current in put is ") + input_dist.input_value
            var isValid = ValidateInput.validateInput(swing_offset_range,is_Unit_Imperial,inputMode,input_swing.input_value);
            console.log("isValid = ",isValid)
            if(isValid[0] === false )
            {
                popup_page3_alert_input.contentText1 =  qsTr("The Swing Offset Angle should be -" + isValid[3] +"\xB0 ~ +"+isValid[3]+"\xB0")
                popup_page3_alert_input.contentAlertMsg =  qsTr("Current in put is ") +  isValid[1] +  "\xB0 is outranged ±" + isValid[3] + "\xB0"

                popup_page3_alert_input.open();

            }
            else
            {
                popup_page3_input_angle.close();
                dSwingOffset = Number(isValid[1]);

               // mySerialThread.setPkg(4,dSwingOffset,0);  // swing anticlockwise
                //mySerialThread.setPkg(4,(-1 * dSwingOffset),0);//project version 3 clockwise
                if(inputIsCW_ModeSwing)
                {
                    dSwingOffset = -1 * dSwingOffset;
                }
                console.log("Swing input = ",dSwingOffset,"\xB0")
                mySerialThread.setPkg(4,dSwingOffset,0);//project version 3 clockwise

                page4.page4Ini();
                stack.push(page4);
                //myheader.titleStr = "Reference Scanning"
                page4.popupOpen();
                //stack.push(Qt.resolvedUrl("qrc:/Pages/Page_4_Reference_Scan.qml"))
                // stack.currentItem.popupOpen();
            }

           // stack.push(Qt.resolvedUrl("qrc:/Pages/Page_4_Reference_Scan.qml"))
        }

        onInput_swing_Clicked:
        {

            inputMode = 2;
            vk_num_page3.surface = page3
            vk_num_page3.container = popup_page3_input_angle
            vk_num_page3.btn_func_visible = false;
          //  keyboardObj = popup_page3_input_angle.input_swing_value
            vk_num_page3.haveSign = false;
            vk_num_page3.show();
        }
    }

    Popup_Main_V2
    {
        //input4
        id:popup_page3_input_both
        objectName: "input_both"
        titleText: qsTr("What is the Offset Distance & \nSwing Angle?")
        pic1_url: Qt.resolvedUrl("qrc:/Images/input_mode5.png")
        //contentText1: qsTr("A positive swing angle value will rotate the target line about the scanned pivot point (<img width=\"25\" height=\"25\" align=\"middle\" src=\"qrc:/Icons/X4text.png\" >) in a (CCW) direction. A negative value will do the opposite. The offset distance of the pivot point is determined the entered value. The position of the pivot is determined by scanning a point")
        //contentText1: qsTr("<b>Positive:</b> Counter Clockwise(CCW)" + "<br><b>Negative:</b> Clockwise(CW)</br>" + "<br><b>Pivot:</b> Scanned Point <img width=\"20\" height=\"20\"src=\"qrc:/Icons/X4text.png\"></br>")
        contentText1: qsTr("The swing angle is the angle between the original reference line azimuth and the new line.")
        input_dist_title: qsTr("Enter Offset Distance")
        input_dist_unit: unit_dist
        input_swing_title: qsTr("Enter Swing Angle")
        input_swing_unit: unit_swing
        lBtn_text: qsTr("Back")
        rBtn_text: qsTr("OK")

        onLBtn_Clicked:
        {
            popup_page3_input_both.input_swing.input_value = "0";

            if(is_Unit_Imperial)
            {
                popup_page3_input_both.input_dist.input_value = "0ft 0-0/8in";
            }
            else
                popup_page3_input_both.input_dist.input_value = "0";


            popup_page3_input_both.close();
        }

        onRBtn_Clicked:
        {
            var isValid_distance = ValidateInput.validateInput(dist_offset_range,is_Unit_Imperial,3,input_dist.input_value);
            var isValid_swing = ValidateInput.validateInput(swing_offset_range,is_Unit_Imperial,4,input_swing.input_value);
            console.log("isValid = ",isValid_distance)
            if(isValid_distance[0] && isValid_swing[0])
            {
                popup_page3_input_both.close();

                //dDistOffset = Number(isValid_distance[1]).toFixed(3);
                dDistOffset = UC.toFixed(Number(isValid_distance[1]),2);
                console.log("Dist input = ",dDistOffset,"m")
                dSwingOffset = Number(isValid_swing[1]);

                //mySerialThread.setPkg(5,dSwingOffset,dDistOffset);    //swing anticlockwise
               // mySerialThread.setPkg(5,(-1 * dSwingOffset),dDistOffset);;//project version 3 clockwise
                if(inputIsCW_ModeDistSwing)
                {
                    dSwingOffset = -1 * dSwingOffset;
                }
                console.log("Swing input = ",dSwingOffset,"\xB0")
                mySerialThread.setPkg(5,dSwingOffset,dDistOffset);
                page4.page4Ini();
                stack.push(page4);
                //myheader.titleStr = "Reference Scanning"
                page4.popupOpen();
                //stack.push(Qt.resolvedUrl("qrc:/Pages/Page_4_Reference_Scan.qml"))
                //stack.currentItem.popupOpen();
            }
            else
            {
                var alertPostMsg = "";
                var alertPreMsg = "";
                if(isValid_distance[0] === false && isValid_swing[0] === true)
                {
                    alertPreMsg = qsTr("Distance Offset: ");
                    popup_page3_input_both.input_dist.input_value = isValid_distance[2]

                    if(is_Unit_Imperial)
                    {
                        popup_page3_alert_input.contentText1 =  qsTr("The Line Offset Distance should be -" + isValid_distance[3] +" ~ +"+isValid_distance[3])
                        if(isValid_distance[1] === isValid_distance[2])
                         alertPostMsg = isValid_distance[1] +  " is outranged ±" + isValid_distance[3];
                        else
                          alertPostMsg = isValid_distance[1] + "(" + isValid_distance[2] + ") is outranged ±" + isValid_distance[3];
                    }
                    else
                    {
                        popup_page3_alert_input.contentText1 =  qsTr("The Line Offset Distance should be -" + isValid_distance[3] +"m ~ +"+isValid_distance[3]+"m")
                        alertPostMsg = isValid_distance[1] +  "m is outranged ±" + isValid_distance[3] + "m";
                    }

                    popup_page3_alert_input.contentAlertMsg = alertPreMsg + alertPostMsg;
                }
                else if(isValid_swing[0] === false && isValid_distance[0] === true)
                {
                    popup_page3_alert_input.contentText1 =  qsTr("The Swing Offset Angle should be -" + isValid_swing[3] +"\xB0 ~ +"+isValid_swing[3]+"\xB0")
                    alertPreMsg = qsTr("Swing Offset: ");
                    alertPostMsg = isValid_swing[1] +  "\xB0 is outranged ±" + isValid_swing[3] + "\xB0"
                    popup_page3_alert_input.contentAlertMsg = alertPreMsg + alertPostMsg;
                }
                else if(isValid_swing[0] === false && isValid_distance[0] === false)
                {
                    var alertTitle =""
                    alertPreMsg = qsTr("Distance Offset: ");
                    popup_page3_input_both.input_dist.input_value = isValid_distance[2]

                    if(isValid_distance[1] === isValid_distance[2])
                    {
                        if(is_Unit_Imperial)
                        {
                            alertPostMsg = isValid_distance[1] +  " is outranged ±" + isValid_distance[3];
                            alertTitle = qsTr("The Line Offset Distance should be -") + isValid_distance[3] + " ~ +"+isValid_distance[3]
                        }
                        else
                        {
                            alertPostMsg = isValid_distance[1] +  "m is outranged ±" + isValid_distance[3] + "m";
                            alertTitle = qsTr("The Line Offset Distance should be -") + isValid_distance[3] + "m ~ +"+isValid_distance[3]+ "m";
                        }
                    }
                    else
                    {
                        if(is_Unit_Imperial)
                        {
                            alertPostMsg = isValid_distance[1] + "(" + isValid_distance[2] + ") is outranged ±" + isValid_distance[3];
                            alertTitle = qsTr("The Line Offset Distance should be -") + isValid_distance[3] + " ~ +"+isValid_distance[3]
                        }
                        else
                        {
                            alertPostMsg = isValid_distance[1] +  "m is outranged ±" + isValid_distance[3] + "m";
                            alertTitle = qsTr("The Line Offset Distance should be -") + isValid_distance[3] + "m ~ +"+isValid_distance[3]+ "m";
                        }
                    }
                    popup_page3_alert_input.contentAlertMsg = alertPreMsg + alertPostMsg;
                    popup_page3_alert_input.contentText1 = alertTitle;

                    alertPreMsg = qsTr("Swing Offset: ");
                    alertPostMsg = isValid_swing[1] +  "\xB0 is outranged ±" + isValid_swing[3] + "\xB0"
                    alertTitle = qsTr(" & The Swing Offset Angle should be -") + isValid_swing[3] + "\xB0 ~ +"+ isValid_swing[3] + "\xB0"

                    popup_page3_alert_input.contentAlertMsg += "\r\n" + alertPreMsg + alertPostMsg;
                    popup_page3_alert_input.contentText1 +=  alertTitle;
                }

                 popup_page3_alert_input.open();
            }
        }

        onInput_dist_Clicked:
        {

            inputMode = 3;
            vk_num_page3.surface = page3
            vk_num_page3.container = popup_page3_input_both
            vk_num_page3.haveSign = true;

            if(is_Unit_Imperial)
            {
                vk_num_page3.btn_func_visible = true;
            }
            else
                vk_num_page3.btn_func_visible = false;
           // keyboardObj = popup_page3_input_both.input_dist_value
            vk_num_page3.show();
        }

        onInput_swing_Clicked:
        {

            inputMode = 4;
            vk_num_page3.surface = page3
            vk_num_page3.container = popup_page3_input_both
            vk_num_page3.btn_func_visible = false;
            vk_num_page3.haveSign = false;
            vk_num_page3.show();
        }
    }

    Kb_Num_KeyPad_v2
    {
        id:vk_num_page3
        btn_func_visible: false
        z:1

        onButtonPressed:
        {
           // popup_page3_input_distance.input_dist_value = MyNumPad.buttonPressed(popup_page3_input_distance.input_dist_value,btnText);

            var keyboard;
            switch (inputMode)
            {
            case 1:
                keyboard = keyboardMode1;
                break;

            case 2:
                keyboard = keyboardMode2;
                break;

            case 3:
                keyboard = keyboardMode3;
                break;

            case 4:
                keyboard = keyboardMode4;
                break;
            }
            MyNumPad.buttonPressed(is_Unit_Imperial,inputMode,keyboard,btnText)
        }

        onBtnBackHold:
        {
            var keyboard;
            switch (inputMode)
            {
                case 1:
                    keyboard = keyboardMode1;
                    if(is_Unit_Imperial)
                    {
                       keyboard.input_value = "0ft 0-0/8in";
                       keyboard.cursorPosition = keyboard.input_value.indexOf("f");
                       vk_num_page3.setFuncBtnVisible();
                    }
                    else
                    {
                       keyboard.input_value = "0";
                       keyboard.cursorPosition = keyboard.input_value.length;
                    }
                break;

                case 2:
                    keyboard = keyboardMode2;
                    keyboard.input_value = "0";
                    keyboard.cursorPosition = keyboard.input_value.length;
                break;

                case 3:
                    keyboard = keyboardMode3;
                    if(is_Unit_Imperial)
                    {
                       keyboard.input_value = "0ft 0-0/8in";
                       keyboard.cursorPosition = keyboard.input_value.indexOf("f");
                        vk_num_page3.setFuncBtnVisible();
                    }
                    else
                    {
                       keyboard.input_value = "0";
                       keyboard.cursorPosition = keyboard.input_value.length;
                    }
                break;

                case 4:
                    keyboard = keyboardMode4;
                    keyboard.input_value = "0";
                    keyboard.cursorPosition = keyboard.input_value.length;
                break;
            }
        }
    }

    Popup_Main_V2
    {
        id:popup_page3_dip
        titleText: qsTr("Install Targets")
        contentText1: qsTr("Install targets on feed frame. Targets must be placed a minimum of 1m apart and parallel to rods as indicated in the image below.")
        pic1_url:Qt.resolvedUrl("qrc:/Images/dip_pop.png")
        lBtn_text: qsTr("Back")
        rBtn_text : qsTr("Confirm")
        onLBtn_Clicked:
        {
           popup_page3_dip.close();
        }
        onRBtn_Clicked:
        {
            popup_page3_dip.close();
            referenceMode = 1;
            mySerialThread.setPkg(6,0,0);
            stack.push(page4);
            page4.page4Ini();
            //page4.popupOpen();
        }
    }

    Popup_Main_V2
    {
        id:popup_page3
        titleText: qsTr("1")
        contentText1: qsTr(" ")
        //contentText2: qsTr("")
        //pic1_url: ""
        //contentAlertMsg: qsTr("")
        lBtn_text: qsTr("Back")
        rBtn_text : qsTr("Confirm")
        onLBtn_Clicked:
        {
            popup_page3.close();
        }

        onRBtn_Clicked:
        {
            popup_page3.close()
            isDTRCorrect = false;
            page6.btn_doneEnabled = isDTRCorrect;

            num_Measured = 0;
            arr_measuredDist = [];

            if(is_Unit_Imperial)
            {
                page6.area_d2rNum =  UC.m2fractional_Ft_Inches_Style(0.0)
                page6.area_lmNum = UC.m2fractional_Ft_Inches_Style(0.0)
                page6.area_d2tNum = UC.m2fractional_Ft_Inches_Style(0.0)

            }
            else
            {
                page6.area_d2rNum = "0m"
                page6.area_lmNum = "0m"
                page6.area_d2tNum = "0m"
            }


            switch(pageModeSelection_Mode)
            {
                case 0 :    //relevel
                    mySerialThread.setPkg("LevelAdjust");
                    myheader.titleStr = "INITIALIZE Laser Device"
                    page2.page2ini();
                    stack.pop();
                break;

                case 1 :    //Align to Reference
                    referenceMode = 1;
                    mySerialThread.setPkg(1,0,0);
                    page4.page4Ini();
                    stack.push(page4);
                    //myheader.titleStr = "Reference Scanning"
                    page4.popupOpen();
                    //stack.currentItem.popupOpen();
                break;

                case 2 :    //Measure Line Offset
                    referenceMode = 1;
                    mySerialThread.setPkg(2,0,0);
                    page4.page4Ini();
                    stack.push(page4);
                    //myheader.titleStr = "Reference Scanning"
                    page4.popupOpen();
                     //stack.currentItem.popupOpen();
                break;

                case 3 :    //Enter Line Offset
                    referenceMode = 1;
                    inputMode = 1;

                    if(is_Unit_Imperial)
                    {
                        popup_page3_input_distance.input_dist.input_value = "0ft 0-0/8in";
                    }
                    else
                        popup_page3_input_distance.input_dist.input_value = "0";

                    popup_page3_input_distance.open();
                break;

                case 4 :    //Enter Swing Offset
                    referenceMode = 2;
                    inputMode = 2;
                    popup_page3_input_angle.input_swing.input_value = "0";
                    popup_page3_input_angle.open();
                break;

                case 5 :    //Enter Dist & Swing Offset
                    referenceMode = 2;
                    popup_page3_input_both.input_swing.input_value = "0";

                    if(is_Unit_Imperial)
                    {
                        popup_page3_input_both.input_dist.input_value = "0ft 0-0/8in";
                    }
                    else
                        popup_page3_input_both.input_dist.input_value = "0";


                    popup_page3_input_both.open();
                break;

                case 6 :    //Measure Dip
                    popup_page3.close();
                    popup_page3_dip.open()
                break;

                case 7:
                    popup_page3.close();
                    referenceMode = 1;
                    mySerialThread.setPkg(7,0,0);
                    page4.page4Ini();
                    stack.push(page4);
                break;
            }
        }
    }

    Popup_Main_V2
    {
        id:popup_page4_alert
        titleText: qsTr("Scan References")
        contentText1: qsTr("Aim laser pointer at reference points.")
        contentAlertMsg: qsTr("The tripod location cannot be moved after it has been levelled.")
        lBtn_text: qsTr("OK")
        onLBtn_Clicked:
        {
            popup_page4_alert.close();
        }
    }

    Popup_Main_V2
    {
        id:popup_page6_alert
        titleText: qsTr("Measure Rig Location")
        contentText1: qsTr("Aim the laser at a rig reference point to measure a distance to the scanned reference line. Press the measure button to record a distance ( D ) into the audit log.")
        contentText2: qsTr("A green laser indicator will appear when the measured position is aligned with the offset reference line.")
        //contentAlertMsg: qsTr("The tripod location cannot be moved after it has been levelled.")
        pic1_url: "qrc:/Images/mode1_1.png"
        pic2_url: "qrc:/Images/mode1_2.png"
        lBtn_text: qsTr("OK")

        onLBtn_Clicked:
        {
            popup_page6_alert.close();
        }
    }

    Popup_Main_V2
    {
        id:popup_page6_measure
        titleText: qsTr("Distance Measured!")
        url_arrow: Qt.resolvedUrl("qrc:/Icons/green_arrow.svg")
        arrow_visable: true
        popmeasure_d2t: qsTr("0ft 0-0/64in")
        contentText1: qsTr("Measured distance is NOT aligned to target line.")
        lBtn_text: qsTr("Measure Again?")
        rBtn_text: qsTr("Done!")
        lBtn_fontSize:fsize_2xs
        rBtn_fontSize: fsize_2xs
        onLBtn_Clicked:
        {
            if(pageModeSelection_Mode !== 2)
            {
                page6.btn_doneEnabled = false;
            }
            else if(pageModeSelection_Mode === 2 && isDTRCorrect === false)
            {

            }
            else if(pageModeSelection_Mode === 2 && isDTRCorrect === true)
            {
                page6.btn_doneEnabled = false;
            }
           // isDTRCorrect = false;
            popup_page6_measure.close();
        }

        onRBtn_Clicked:
        {
            //popup_page6_measure.close();
            //popup_page6_measure.arrow_visable = false
            if(pageModeSelection_Mode === 2)    //yes btn
            {
                if(!isDTRCorrect)
                {
                    if(is_Unit_Imperial)
                    {
                        popup_page6_input_distance.input_dist.input_value = UC.m2fractional_Ft_Inches_old(page6.dtr);
                        page6.area_d2rNum =  UC.m2fractional_Ft_Inches_Style(page6.dtr)

                      //  popup_page6_input_distance.input_dist.input_value = UC.m2fractional_Ft_Inches(page6.dtt);
                      //  page6.area_d2rNum =  UC.m2fractional_Ft_Inches(page6.dtt)

                    }
                    else
                    {
                        if(page6.dtr === 0)
                        {
                           popup_page6_input_distance.input_dist.input_value  = "0";
                        }
                        else
                        {
                            //popup_page6_input_distance.input_dist.input_value = String(page6.dtr.toFixed(3));
                            popup_page6_input_distance.input_dist.input_value = String(UC.toFixed(page6.dtr,2));
                        }

                        //page6.area_d2rNum  =  String(page6.dtr.toFixed(3))+"m";
                        page6.area_d2rNum  =  String(page6.dtt.toFixed(2))+"m";

                    }

                    isDTRCorrect = true;
                    popup_page6_input_distance.open()
                }
                else
                {
                    num_Measured += 1;
                    console.log("num_Measured = ",num_Measured)
                    mySerialThread.setPkg("Scan","mark");

                    if(is_Unit_Imperial)
                    {
                        //area_lm.mynum =  UC.m2fractional_Ft_Inches(page6.dtt)
                        page6.area_lmNum =  UC.m2fractional_Ft_Inches(page6.dtt)
                    }
                    else
                    {
                       // area_lm.mynum =  String(page6.dtt.toFixed(2))+"m";
                        page6.area_lmNum =  String(page6.dtt.toFixed(2))+"m";
                    }
                    arr_measuredDist[0] = num_Measured;
                    arr_measuredDist.push(page6.dtt);

                    page6.btn_doneEnabled = isDTRCorrect; //20190613
                }
                popup_page6_measure.close();
            }
            else
            {
                num_Measured += 1;
                console.log("num_Measured",num_Measured)

                if(is_Unit_Imperial)
                {
                    //area_lm.mynum =  UC.m2fractional_Ft_Inches(page6.dtt)
                    page6.area_lmNum =  UC.m2fractional_Ft_Inches(page6.dtt)
                }
                else
                {
                   // area_lm.mynum =  String(page6.dtt.toFixed(2))+"m";
                    page6.area_lmNum=  String(page6.dtt.toFixed(2))+"m";
                }

                arr_measuredDist[0] = num_Measured;
                arr_measuredDist.push(page6.dtt);

                popup_page6_measure.close();
                //btn_done.enabled = true;
                page6.btn_doneEnabled = true;

            }
        }
    }

    Popup_Main
    {
        id:popup_page6_alert_input
        titleText: qsTr("Input Error")
        contentText1: qsTr("The line offset Distance should be -30 ~ +30.")
        contentAlertMsg: qsTr("Current in put is 60.")
        lBtn_text: qsTr("OK")
        onLBtn_Clicked:
        {
            popup_page6_alert_input.close();
        }
    }

    Popup_Main_V2
    {
        id:popup_page6_input_distance
        objectName: "input_distance"
        titleText: qsTr("What is the Offset Distance?")
        pic1_url:  Qt.resolvedUrl("qrc:/Images/input_mode2.png")
        //contentText1: qsTr("A positive offset value (<img width=\"25\" height=\"25\" align=\"middle\" src=\"qrc:/Icons/D4text.svg\">) will move the target line away from a scanned reference line and tripod.")
        //contentText2: qsTr("A negative offset value (<img width=\"25\" height=\"25\" align=\"middle\" src=\"qrc:/Icons/D4text.svg\">) will move the target line towards the tripod in the opposite direction of the scanned reference line.")
        contentText1: qsTr(" ")
        input_dist_title: "Enter Distance Offset"
        input_dist_unit: unit_dist
        lBtn_text: qsTr("Back")
        rBtn_text: qsTr("OK")
        onLBtn_Clicked:
        {
            if(is_Unit_Imperial)
            {
                popup_page6_input_distance.input_dist.input_value = "0ft 0-0/8in";
            }
            else
                popup_page6_input_distance.input_dist.input_value = "0";

            //isDTRCorrect =false;
            popup_page6_input_distance.close();
        }

        onRBtn_Clicked:
        {
           // ValidateInput.validateInput(dist_offset_range,is_Unit_Imperial,page6.inputMode,input_dist.input_value)
           // popup_page6_alert_input.contentAlertMsg =  qsTr("Current in put is ") + input_dist.input_value
            var isValid = ValidateInput.validateInput(dist_offset_range,is_Unit_Imperial,page6.inputMode,input_dist.input_value);
            console.log("isValid = ",isValid)
            if(isValid[0] === false )
            {
                popup_page6_input_distance.input_dist.input_value = isValid[2]

                if(is_Unit_Imperial)
                {
                    popup_page6_alert_input.contentText1 =  qsTr("The Line Offset Distance should be -" + isValid[3] +" ~ +"+isValid[3])
                    if(isValid[1] === isValid[2])
                        popup_page6_alert_input.contentAlertMsg =  qsTr("Current in put is ") +  isValid[1] +  " is outranged ±" + isValid[3]
                    else
                       popup_page6_alert_input.contentAlertMsg =  qsTr("Current in put is ") +  isValid[1] + "(" + isValid[2] + ") is outranged ±" + isValid[3]
                }
                else
                {
                    popup_page6_alert_input.contentText1 =  qsTr("The Line Offset Distance should be -" + isValid[3] +"m ~ +"+isValid[3] + "m")
                    popup_page6_alert_input.contentAlertMsg =  qsTr("Current in put is ") +  isValid[1] +  "m is outranged ±" + isValid[3] + "m"
                }

                popup_page6_alert_input.open();

            }
            else
            {
                mySerialThread.setPkg("Scan","DISDETDONE");
                console.log("Scan DISDETDONE")


                if(is_Unit_Imperial)
                {
                    //area_d2r.mynum =  input_dist.input_value
                    page6.area_d2rNum  =  input_dist.input_value
                }
                else
                {
                    //area_d2r.mynum =  input_dist.input_value+"m";
                    page6.area_d2rNum  =  input_dist.input_value
                }

                dDistOffset = Number(isValid[1]).toFixed(3);
                console.log("distance input = ",dDistOffset,"m")


//                mySerialThread.setPkg(2,0,Number(isValid[1]));
//                console.log("Mode")



                //star time here
                myStartTime = new Date();
                startTime = myStartTime.toTimeString();
                myDate = Qt.formatDateTime(myStartTime, "yyyy-MM-dd");
                second_elapsed = 0;
                timer_elapsed.start();

//                //scan start
//                mySerialThread.setPkg("Scan","start");

                popup_page6_input_distance.close();
                //page6.btn_doneEnabled = true;
            }
        }

        onInput_dist_Clicked:
        {
            page6.inputMode = 1;
            vk_num.surface = page6
            vk_num.container = popup_page6_input_distance

            if(is_Unit_Imperial)
            {
                vk_num.btn_func_visible = true;
            }
            else
                vk_num.btn_func_visible = false;

            vk_num.show();
        }
    }

    Kb_Num_KeyPad_v2_Scan
    {
        id:vk_num
        btn_func_visible: false
        z:1

        onButtonPressed:
        {
           // popup_page6_input_distance.input_dist_value = MyNumPad.buttonPressed(popup_page6_input_distance.input_dist_value,btnText);

            var keyboard = popup_page6_input_distance.input_dist;
            MyNumPad.buttonPressed(is_Unit_Imperial,page6.inputMode,keyboard,btnText)
        }

        onBtnBackHold:
        {
            var keyboard = popup_page6_input_distance.input_dist;

            if(is_Unit_Imperial)
            {
               keyboard.input_value = "0ft 0-0/8in";
               keyboard.cursorPosition = keyboard.input_value.indexOf("f");
               vk_num.setFuncBtnVisible();
            }
            else
            {
               keyboard.input_value = "0";
               keyboard.cursorPosition = keyboard.input_value.length;
            }
        }
    }


    header:Rect_Header_Main
    {
        id:myheader
        visible:false
    }

    StackView
    {
        id: stack
        objectName: "StackView"
        height: parent.height - myheader.height - myfooter.height
        anchors.fill: parent
        visible:false
       // initialItem: Qt.resolvedUrl("qrc:/Pages/Page_2_Initialize_Laser_Device.qml")
        initialItem:Qt.resolvedUrl("qrc:/Pages/Page_3_Mode_Selection.qml")
       // initialItem:Qt.resolvedUrl("qrc:/Pages/Page_4_Reference_Scan.qml")
       // initialItem:Qt.resolvedUrl("qrc:/Pages/Page_5_Pivot_Scan.qml")
       // initialItem:Qt.resolvedUrl("qrc:/Pages/Page_6_Measuring.qml")


//        initialItem: Qt.resolvedUrl("qrc:/Pages/Page_AdminSetup_1.qml")
//        initialItem: Qt.resolvedUrl("qrc:/Pages/Page_AdminSetup_2.qml")
//        initialItem: Qt.resolvedUrl("qrc:/Pages/Page_Audit_Logs.qml")
    }

    footer: Rect_Footer
    {
        id:myfooter
        visible:false
    }


}
