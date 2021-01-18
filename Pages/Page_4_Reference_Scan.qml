/*import QtQuick 2.0
import QtQuick.Controls 2.0

import "../Widgets"
import "../Popup"

Rectangle
{
    id:page4
    width: 480
    height: 615

    objectName: "Page_ReferenceScan"
    property string pageTitle: "Reference Scanning"

//    property bool start_on: false
//    property bool cancel_on: false
//    property bool take_on: false

//    property bool b_spadeA_done: false;
//    property bool b_spadeB_done: false;

//    property bool alreadySendCmd: false;

    property int i_state: 0
    property bool wip: false; //work-in-process


    function goback()
    {
        page4.i_state = 1;
        btn_ref1.i_status = 1
        btn_ref2.i_status = 0;
        btn_back.enabled = true;
        btn_next.enabled = false;
        myheader.titleStr = "Choose Alignment Mode"

        var resultItem = stack.find(
                                     function(item){
                                                 console.log(item.objectName);
                                                return item.objectName === "Page_ModeSelection" ? true : false;
                                            }
                                    );

         if(resultItem !== null)
         {
             myheader.titleStr = "Choose Alignment Mode";
             stack.pop(resultItem);
         }

    }

    function popupOpen()
    {
        //setPopContent(pageModeSelection_Mode);
        popup_page4_alert.open();
    }

    Component.onCompleted:
    {
        page4.i_state = 1;
        btn_ref1.i_status = 1
        btn_ref1.getStart_confirmed = false;
        btn_ref1.getTake_confirmed = false;
        btn_ref1.getTake_completed = false;
        btn_ref1.getCancel_confirmed = false;

        btn_ref2.i_status = 0;
        btn_ref2.getStart_confirmed = false;
        btn_ref2.getTake_confirmed = false;
        btn_ref2.getTake_completed = false;
        btn_ref2.getCancel_confirmed = false;


        myheader.titleStr = pageTitle;
        btn_next.enabled = true;
        btn_next.enabled = false;
        btn_next.enabled = true;
        popup_page4_alert.open();
    }

    Connections
    {
        target: mySerialThread


        //////////////////     GET CONFIRM    ////////////////////////
        ////////////////////  Spade A ////////////////////////////////
        onSpadeA_start_confirmedChanged:
        {
            btn_ref1.getStart_confirmed = false;
            btn_ref1.getStart_confirmed = mySerialThread.spadeA_start_confirmed;
        }

        onSpadeA_take_confirmedChanged:
        {
            btn_ref1.getTake_confirmed = false;
            btn_ref1.getTake_confirmed = mySerialThread.spadeA_take_confirmed;
        }

        onSpadeA_cancel_confirmedChanged:
        {
            btn_ref1.getCancel_confirmed = false;
            btn_ref1.getCancel_confirmed = mySerialThread.spadeA_cancel_confirmed;
        }

        ////////////////////  Spade B ////////////////////////////////
        onSpadeB_start_confirmedChanged:
        {
            btn_ref2.getStart_confirmed = false;
            btn_ref2.getStart_confirmed =  mySerialThread.spadeB_start_confirmed;
        }

        onSpadeB_take_confirmedChanged:
        {
            btn_ref2.getTake_confirmed = false;
            btn_ref2.getTake_confirmed = mySerialThread.spadeB_take_confirmed
        }

        onSpadeB_cancel_confirmedChanged:
        {
            btn_ref2.getCancel_confirmed = false;
            btn_ref2.getCancel_confirmed = mySerialThread.spadeB_cancel_confirmed
        }

        onPivot_start_confirmedChanged:
        {
            if(pageModeSelection_Mode === 2)
            {
                btn_ref2.getStart_confirmed = false;
                btn_ref2.getStart_confirmed = mySerialThread.pivot_start_confirmed;
            }
        }

        onPivot_take_confirmedChanged:
        {
            if(pageModeSelection_Mode === 2)
            {
                btn_ref2.getTake_confirmed = false;
                btn_ref2.getTake_confirmed = mySerialThread.pivot_take_confirmed;
            }
        }

        onPivot_cancel_confirmedChanged:
        {
            if(pageModeSelection_Mode === 2)
            {
                btn_ref2.getCancel_confirmed = false;
                btn_ref2.getCancel_confirmed = mySerialThread.pivot_cancel_confirmed;
            }
        }

        //////////////////       GET COMPLETE      /////////////////////////
        ////////////////////     Spade A    ////////////////////////////////
        onSpadeA_take_completedChanged:
        {
            btn_ref1.getTake_completed = false;
            btn_ref1.getTake_completed = mySerialThread.spadeA_take_completed;
        }

        ////////////////////  Spade B ////////////////////////////////
        onSpadeB_take_completedChanged:
        {
            btn_ref2.getTake_completed = false;
            btn_ref2.getTake_completed = mySerialThread.spadeB_take_completed;
        }

        onBtn_start_completedChanged:
        {
            if(mySerialThread.btn_start_completed && btn_ref1.i_status === 2){

                btn_ref1.getStart_completed = false;
                btn_ref1.getStart_completed = mySerialThread.btn_start_completed ;
                btn_ref1.i_status = 3; // Solid Red
            }

            else if(mySerialThread.btn_start_completed && btn_ref2.i_status === 2){

                btn_ref2.getStart_completed = false;
                btn_ref2.getStart_completed = mySerialThread.btn_start_completed ;
                btn_ref2.i_status = 3; // Solid Red
            }
        }

        onPivot_take_completedChanged:
        {
            if(pageModeSelection_Mode === 2)
            {
                if(mySerialThread.btn_start_completed && btn_ref1.i_status === 2){

                    btn_ref1.getStart_completed = false;
                    btn_ref1.getStart_completed = mySerialThread.btn_start_completed ;
                    btn_ref1.i_status = 3; // Solid Red
                }

                else if(mySerialThread.btn_start_completed && btn_ref2.i_status === 2){

                    btn_ref2.getStart_completed = false;
                    btn_ref2.getStart_completed = mySerialThread.btn_start_completed ;
                    btn_ref2.i_status = 3; // Solid Red
                }
            }
        }
        ////////////////////////////END OF GET COMPLETE////////////////////////////////
    }

    onWipChanged:
    {
        global_wip = wip;
        if(wip)
        {
            btn_back.enabled = false;
        }
        else
            btn_back.enabled = true;
    }

    Popup_Main_V2
    {
        id:popup_page4_alert
        titleText: qsTr("Scan References")
        contentText1: qsTr("Aim laser pointer at reference points.")
        contentAlertMsg: qsTr("The tripod location cannot be moved after reference points are scanned.")
        lBtn_text: qsTr("OK")
        onLBtn_Clicked:
        {
            popup_page4_alert.close();
        }
    }

        Image {
            id: pic_ref
            anchors.top: page4.top
            anchors.bottom: col.top
            anchors.left: page4.left
            anchors.right: page4.right
            cache: false
            source:
            {
                switch (referenceMode)
                {
                case 1:
                     return Qt.resolvedUrl("qrc:/Images/mode123.png")

                case 2:
                    return Qt.resolvedUrl("qrc:/Images/mode45.png")
                }
            }
        }


    Column
    {
        id:col
        anchors.bottom: page4.bottom
        anchors.horizontalCenter: page4.horizontalCenter
        spacing: 1

        Btn_Dynamic
        {
            id:btn_ref1
            btn_name: "ref1"

            onGetStart_confirmedChanged:
            {
                if(getStart_confirmed)
                {
                    btn_ref1.i_status = 2; // Flashing Black
                }
            }

            onGetTake_confirmedChanged:
            {
                if(getTake_confirmed)
                {
                    btn_ref1.i_status = 4; // Flashing Red
                }
            }

            onGetTake_completedChanged:
            {
                if(getTake_completed)
                {
                    if(btn_ref2.i_status === 5)
                    {
                        btn_next.enabled = true;
                    }
                    else
                    {
                        btn_ref2.i_status = 1;
                        btn_next.enabled = false;
                    }
                    btn_ref1.i_status = 5; // Solid Green
                    wip = false;
                }
            }

            onGetCancel_confirmedChanged:
            {
                if(getCancel_confirmed)
                {
                    btn_ref1.i_status = 2; // Solid Black

                    if (btn_ref2.i_status !== 5 ) //reset B if B not DONE status
                    {
                        btn_ref2.i_status = 0;
                    }
                }
            }

            onBtn_click:
            {
                if(btn_ref2.i_status === 0 || btn_ref2.i_status === 5)
                {
                    if(btn_ref1.i_status === 1)
                    {
                        mySerialThread.setPkg("SpadeA","start");
                        console.log("ref1 start")
                    }
                    else if(btn_ref1.i_status === 3)
                    {
                        mySerialThread.setPkg("SpadeA","take");
                        console.log("ref1 take")
                    }
                    wip = true;
                }
            }


            onBtn_hold:
            {
                if(btn_ref1.i_status == 5 && (btn_ref2.i_status === 1 || btn_ref2.i_status === 5))
                {
                    //console.log("Send A Hold CMD \r\n");
                    mySerialThread.setPkg("SpadeA","cancel");
                    if(btn_ref2.i_status === 1)
                    {
                        btn_ref2.i_status = 0;
                    }
                    btn_next.enabled = false;
                    wip = true;
                    console.log("ref1 hold")
                }
            }
        }

       Btn_Dynamic
       {
           id:btn_ref2
           btn_name: "ref2"

           onGetStart_confirmedChanged:
           {
               if(getStart_confirmed)
               {
                   btn_ref2.i_status = 2; // Flashing Black
               }
           }

           onGetTake_confirmedChanged:
           {
               if(getTake_confirmed){
                   btn_ref2.i_status = 4; //Flashing RED
               }
           }

           onGetTake_completedChanged:
           {
               if(getTake_completed && btn_ref2.i_status === 4)
               {
                   btn_ref2.i_status = 5;
                   wip = false; // btn B process is DONE

                   if(btn_ref1.i_status === 5)
                   {
                       btn_next.enabled = true;
                   }
                   else
                   {
                       btn_next.enabled = false;
                   }
               }
           }

           onGetCancel_confirmedChanged:
           {
               if(getCancel_confirmed){
                   btn_ref2.i_status = 2; // flashing black
                   btn_next.enabled = false;
               }
           }

           onBtn_click:
           {
               if(btn_ref1.i_status === 5)
               {
                   if(btn_ref2.i_status === 1 )
                   {
                       if(pageModeSelection_Mode === 2)
                       {
                           mySerialThread.setPkg("Pivot","start");
                           console.log("Pivot start")
                       }
                       else
                       {
                           mySerialThread.setPkg("SpadeB","start");
                           console.log("ref2 start")
                       }
                       wip = true;

                   }
                   else if (btn_ref2.i_status === 3 )
                   {
                       if(getStart_completed)
                       {
                           if(pageModeSelection_Mode === 2)
                           {
                               mySerialThread.setPkg("Pivot","take");
                               console.log("Pivot take")
                           }
                           else
                           {
                               mySerialThread.setPkg("SpadeB","take");
                               console.log("ref2 take")
                           }
                       }
                   }
               }
           }

           onBtn_hold:
           {
               if(btn_ref2.i_status === 5 && (btn_ref2.i_status === 1 || btn_ref2.i_status === 5))
               {
                   //console.log("Send A Hold CMD \r\n");

                   if(pageModeSelection_Mode === 2)
                   {
                       mySerialThread.setPkg("Pivot","cancel");
                       console.log("Pivot cancel")
                   }
                   else
                   {
                       mySerialThread.setPkg("SpadeB","cancel");
                       console.log("ref2 cancel")
                   }

                   if(btn_ref2.i_status === 1)
                   {
                       btn_ref2.i_status = 0;
                   }
                   btn_next.enabled = false;
                   wip = true;

               }
           }
       }
        Row
        {
            Btn_Static
            {
                id:btn_back
                btn_name:"back"
                fontPtSize: fsize_large
                //color: btn_next.enabled ? clr_orange : clr_gray1

                onBtnClick:
                {
                    page4.goback();
                   // stack.pop();
                }
            }


            Btn_Static
            {
                id:btn_next
                btn_name:"next"
                fontPtSize: fsize_large
                color: btn_next.enabled ? clr_orange : clr_gray1

                onBtnClick:
                {
                    switch(referenceMode)
                    {
                        case 1:
                            switch (pageModeSelection_Mode)
                            {
                                case 2:
                                mySerialThread.setPkg("Scan","start");
                                console.log("Scan start")
                                break

                                 default:
                                 mySerialThread.setPkg("Scan","start");
                                 console.log("Scan start")
                                 //starttime here

                                 myStartTime = new Date();
                                 startTime = myStartTime.toTimeString();
                                 myDate = Qt.formatDateTime(myStartTime, "yyyy-MM-dd");
                                 second_elapsed = 0;
                                 timer_elapsed.start();

                                 break;
                            }
                            stack.push(Qt.resolvedUrl("qrc:/Pages/Page_6_Measuring.qml"));
                            //stack.currentItem.popupOpen();
                        break;

                     case 2:
                        stack.push(Qt.resolvedUrl("qrc:/Pages/Page_5_Pivot_Scan.qml"));
                     break;
                    }
                }
            }
        }
    }

}*/

import QtQuick 2.0
import QtQuick.Controls 2.0

import "../Widgets"
import "../Popup"
import "../JS/UnitConvert.js" as UC

Rectangle
{
    id:page4
    width: 480
    height: 615

    objectName: "Page_ReferenceScan"
    property string pageTitle: qsTr("Reference Scanning")

//    property bool start_on: false
//    property bool cancel_on: false
//    property bool take_on: false

//    property bool b_spadeA_done: false;
//    property bool b_spadeB_done: false;

//    property bool alreadySendCmd: false;

    property int i_state: 0
    property bool wip: false; //work-in-process


    function goback()
    {
        page4.i_state = 1;
        btn_ref1.i_status = 1
        btn_ref2.i_status = 0;

        btn_back.enabled = true;
        btn_next.enabled = false;


        myheader.titleStr = qsTr("Choose Alignment Mode")

        stack.pop();
    }

    function popupOpen()
    {
        popup_page4_alert.open();
    }

    function page4Ini()
    {
        pic_ref.source = Qt.resolvedUrl(switchPicSource(pageModeSelection_Mode));
        myheader.titleStr = qsTr("Reference Scanning")
        page4.i_state = 1;
        btn_ref1.i_status = 1
        btn_ref1.getStart_confirmed = false;
        btn_ref1.getTake_confirmed = false;
        btn_ref1.getTake_completed = false;
        btn_ref1.getCancel_confirmed = false;

        btn_ref2.i_status = 0;
        btn_ref2.getStart_confirmed = false;
        btn_ref2.getTake_confirmed = false;
        btn_ref2.getTake_completed = false;
        btn_ref2.getCancel_confirmed = false;

        btn_back.enabled = true;
        btn_next.enabled = false;
        btn_next.enabled = true;
    }

    function setUrl(referenceMode)
    {
        var myurl;
        switch (referenceMode)
        {
        case 1:
            myurl =  "qrc:/Images/mode123.png"
            break;

        case 2:
            myurl =  "qrc:/Images/mode45.png"
            break;
        }
        return myurl;
    }

    Component.onCompleted:
    {
        page4.i_state = 1;
        btn_ref1.i_status = 1
        btn_ref1.getStart_confirmed = false;
        btn_ref1.getTake_confirmed = false;
        btn_ref1.getTake_completed = false;
        btn_ref1.getCancel_confirmed = false;

        btn_ref2.i_status = 0;
        btn_ref2.getStart_confirmed = false;
        btn_ref2.getTake_confirmed = false;
        btn_ref2.getTake_completed = false;
        btn_ref2.getCancel_confirmed = false;


        myheader.titleStr = pageTitle;
        btn_back.enabled = true;
        btn_next.enabled = false;
       // btn_next.enabled = true;
    }

    Connections
    {
        target: window
        onIsSettingsChangedChanged:
        {
            if(isSettingsChanged)
            {
                //dlg_settingsTip.tipText = "Current Settings"
                //dlg_settingsTip.openMsg();

                popup_settingsTip.contentAlertMsg = popup_settingsTip.updateSettingsContent();
                popup_settingsTip.open();
            }
        }
    }

    Connections
    {
        target: mySerialThread


        //////////////////     GET CONFIRM    ////////////////////////
        ////////////////////  Spade A ////////////////////////////////
        onSpadeA_start_confirmedChanged:
        {
            btn_ref1.getStart_confirmed = false;
            btn_ref1.getStart_confirmed = mySerialThread.spadeA_start_confirmed;
        }

        onSpadeA_take_confirmedChanged:
        {
            btn_ref1.getTake_confirmed = false;
            btn_ref1.getTake_confirmed = mySerialThread.spadeA_take_confirmed;
        }

        onSpadeA_cancel_confirmedChanged:
        {
            btn_ref1.getCancel_confirmed = false;
            btn_ref1.getCancel_confirmed = mySerialThread.spadeA_cancel_confirmed;
        }

        ////////////////////  Spade B ////////////////////////////////
        onSpadeB_start_confirmedChanged:
        {
            btn_ref2.getStart_confirmed = false;
            btn_ref2.getStart_confirmed =  mySerialThread.spadeB_start_confirmed;
        }

        onSpadeB_take_confirmedChanged:
        {
            btn_ref2.getTake_confirmed = false;
            btn_ref2.getTake_confirmed = mySerialThread.spadeB_take_confirmed
        }

        onSpadeB_cancel_confirmedChanged:
        {
            btn_ref2.getCancel_confirmed = false;
            btn_ref2.getCancel_confirmed = mySerialThread.spadeB_cancel_confirmed
        }

        ////////////////////  Pivot ////////////////////////////////
//        onPivot_start_confirmedChanged:
//        {
//            if(pageModeSelection_Mode === 2)
//            {
//                btn_ref2.getStart_confirmed = false;
//                btn_ref2.getStart_confirmed = mySerialThread.pivot_start_confirmed;
//            }
//        }

//        onPivot_take_confirmedChanged:
//        {
//            if(pageModeSelection_Mode === 2)
//            {
//                btn_ref2.getTake_confirmed = false;
//                btn_ref2.getTake_confirmed = mySerialThread.pivot_take_confirmed;
//            }
//        }

//        onPivot_cancel_confirmedChanged:
//        {
//            if(pageModeSelection_Mode === 2)
//            {
//                btn_ref2.getCancel_confirmed = false;
//                btn_ref2.getCancel_confirmed = mySerialThread.pivot_cancel_confirmed;
//            }
//        }


        //////////////////       GET COMPLETE      /////////////////////////
        ////////////////////     Spade A    ////////////////////////////////
        onSpadeA_take_completedChanged:
        {
            btn_ref1.getTake_completed = false;
            btn_ref1.getTake_completed = mySerialThread.spadeA_take_completed;
        }

        ////////////////////  Spade B ////////////////////////////////
        onSpadeB_take_completedChanged:
        {
            btn_ref2.getTake_completed = false;
            btn_ref2.getTake_completed = mySerialThread.spadeB_take_completed;
        }

//        onPivot_take_completedChanged:
//        {
//            if(pageModeSelection_Mode === 2)
//            {
//                btn_ref2.getTake_completed = false;
//                btn_ref2.getTake_completed = mySerialThread.spadeB_take_completed;
//            }
//        }

        onBtn_start_completedChanged:
        {
            if(mySerialThread.btn_start_completed && btn_ref1.i_status === 2){

                btn_ref1.getStart_completed = false;
                btn_ref1.getStart_completed = mySerialThread.btn_start_completed ;
                btn_ref1.i_status = 3; // Solid Red
            }

            else if(mySerialThread.btn_start_completed && btn_ref2.i_status === 2){

                btn_ref2.getStart_completed = false;
                btn_ref2.getStart_completed = mySerialThread.btn_start_completed ;
                btn_ref2.i_status = 3; // Solid Red
            }
        }

        onIsAB_tooCloseChanged:
        {
            if(mySerialThread.isAB_tooClose)
            {
                if(btn_ref1.i_status === 5 && btn_ref2.i_status !== 5)
                {
                    //ref 2 not right
                    btn_ref2.i_status = 1;
                    btn_next.enabled = false;
                }
                else if(btn_ref1.i_status !== 5 && btn_ref2.i_status === 5)
                {
                    //ref 1 not right
                    btn_ref1.i_status = 1;
                    btn_next.enabled = false;
                }
                popup_page4_pts_2Close.open();
            }
        }
        ////////////////////////////END OF GET COMPLETE////////////////////////////////

//        onDipDistChanged:
//        {
//            console.log("dip dist = ",mySerialThread.dipDistance)
//        }

//        onDipAccuracyChanged:
//        {
//            console.log("dip acc = ",mySerialThread.dipAccuracy)
//        }

//        onDipAngleChanged:
//        {
//            console.log("dip ang = ",mySerialThread.dipAngle)
//        }


        onDttChanged:
        {
            if(pageModeSelection_Mode === 6)
            {
                dip_Accuracy = mySerialThread.dtt;

            }
        }

        onScan_angleChanged:
        {
            if(pageModeSelection_Mode === 6)
            {
                dip_Angle = mySerialThread.scan_angle;
            }
        }

        onDtrChanged:
        {
            if(pageModeSelection_Mode === 6)
            {
                dip_Distance = mySerialThread.dtr;
            }
        }
    }

    onWipChanged:
    {
        global_wip = wip;
        if(wip)
        {
            btn_back.enabled = false;
        }
        else
            btn_back.enabled = true;
    }

    Popup_Main_V2
    {
        id:popup_page4_pts_2Close
        titleText: qsTr("Points Pick Error")
        contentText1: qsTr("Ref1 and Ref2 are too close.")
        contentAlertMsg: qsTr("Ref1 and Ref2 are too close to each other.")
        lBtn_text: qsTr("OK")
        onLBtn_Clicked:
        {
            popup_page4_pts_2Close.close();
        }
    }

    Popup_Main_V2
    {
        id:popup_page4_dip_result
        titleText: qsTr("Dip Measurement Result")
        contentText1: qsTr("<b>Distance between two targets:</b><br>") + (is_Unit_Imperial ? UC.m2fractional_Ft_Inches_Style(dip_Distance) : (dip_Distance.toFixed(3) + qsTr(" m")))
        contentText2: qsTr("<br></br><b>Angle is:</b><br>") + dip_Angle.toFixed(2) + unit_swing + qsTr("</br>")
        //contentText3: qsTr("<br></br><b>Accuracy is:</b><br>") + (is_Unit_Imperial ? UC.m2fractional_Ft_Inches_Style(dip_Accuracy) : dip_Accuracy.toFixed(3)+qsTr(" m")) +  qsTr("</br>")
        contentText3: qsTr("<br></br><b>Accuracy is:</b><br>") + dip_Accuracy.toFixed(3)+ unit_swing +  qsTr("</br>")
        lBtn_text: qsTr("Measure Again?")
        rBtn_text: qsTr("Finished")
        lBtn_fontSize:fsize_2xs
        rBtn_fontSize: fsize_2xs

        function elapsedTime(seconds)
        {
            if(seconds>=0)
            {
                const diff = {};

                diff.days    = Math.floor(seconds / 86400);
                diff.hours   = Math.floor(seconds / 3600 % 24);
                diff.minutes = Math.floor(seconds / 60 % 60);
                diff.seconds = Math.floor(seconds % 60);

                if(diff.days !== 0)
                {
                    if(diff.days > 1)
                        return (diff.days.toString() + " days " + diff.minutes.toString() + " min " + diff.seconds.toString() + " sec");
                    else
                        return (diff.days.toString() + " day " + diff.minutes.toString() + " min " + diff.seconds.toString() + " sec");
                }
                else
                    return (diff.minutes.toString() + " min " + diff.seconds.toString() + " sec");
            }
            else
                return "time error"
        }

        onLBtn_Clicked:
        {
            dip_Distance = 0.0
            dip_Angle = 0.0
            dip_Accuracy = 0.0

            mySerialThread.setPkg("done");
            popup_page4_dip_result.close()
        }

        onRBtn_Clicked:
        {
            mySerialThread.setPkg("done");

            myEndTime = new Date();

            endTime = Qt.formatDateTime(myEndTime, "hh:mm:ss");
            timer_elapsed.stop();
            totalElapsedTime = elapsedTime(second_elapsed);

            arr_measuredDist[0] = 2;
            arr_measuredDist.push(dip_Distance);
            arr_measuredDist.push(dip_Angle);
            arr_measuredDist.push(dip_Accuracy);

            mylist_review.setProperty(0,"review_data",String(arr_measuredDist[0]));
            for(var i=1;i<arr_measuredDist.length;i++)
            {
                mylist_review.append({"review_data":qsTr(String(arr_measuredDist[i]))});
            }
            page4.page4Ini();
            page7.page7Ini();
            stack.push(page7)

            popup_page4_dip_result.close()
        }
    }

    Image {
        id: pic_ref
        anchors.top: page4.top
        anchors.bottom: col.top
        anchors.left: page4.left
        anchors.right: page4.right
        cache: false
        //source:pageModeSelection_Mode === 6 ? Qt.resolvedUrl("qrc:/Images/Dipmeasurement.png") : Qt.resolvedUrl(setUrl(referenceMode))
        source: Qt.resolvedUrl(switchPicSource(pageModeSelection_Mode));
    }

    function switchPicSource(mode)
    {
        var url;
        switch (mode)
        {
        case 6:
            url = "qrc:/Images/Dipmeasurement.png"
            break;

        case 7:
            url = "qrc:/Images/ground.png"
            break;

        default:
            url = setUrl(referenceMode)
            break;
        }

        return url
    }

    Column
    {
        id:col
        anchors.bottom: page4.bottom
        anchors.horizontalCenter: page4.horizontalCenter
        spacing: 1

        Btn_Dynamic
        {
            id:btn_ref1
            btn_name: "ref1"

            onGetStart_confirmedChanged:
            {
                if(getStart_confirmed)
                {
                    btn_ref1.i_status = 2; // Flashing Black
                }
            }

            onGetTake_confirmedChanged:
            {
                if(getTake_confirmed)
                {
                    btn_ref1.i_status = 4; // Flashing Red
                }
            }

            onGetTake_completedChanged:
            {
                if(getTake_completed)
                {
                    if(btn_ref2.i_status === 5)
                    {
                        btn_next.enabled = true;
                    }
                    else
                    {
                        btn_ref2.i_status = 1;
                        btn_next.enabled = false;
                        if(pageModeSelection_Mode === 6)
                        {
                            pic_ref.source = Qt.resolvedUrl("qrc:/Images/dip_2.png")
                        }
                        else if(pageModeSelection_Mode === 7)
                        {
                            pic_ref.source = Qt.resolvedUrl("qrc:/Images/wall.png")
                        }
                    }
                    btn_ref1.i_status = 5; // Solid Green
                    wip = false;
                }
            }

            onGetCancel_confirmedChanged:
            {
                if(getCancel_confirmed)
                {
                    btn_ref1.i_status = 2; // Solid Black

                    if (btn_ref2.i_status !== 5 ) //reset B if B not DONE status
                    {
                        btn_ref2.i_status = 0;
                    }
                }
            }

            onBtn_click:
            {
                if(btn_ref2.i_status === 0 || btn_ref2.i_status === 5)
                {
                    if(btn_ref1.i_status === 1)
                    {

                        mySerialThread.setPkg("SpadeA","start");
                        //console.log("ref1 start")
                    }
                    else if(btn_ref1.i_status === 3)
                    {
                        mySerialThread.setPkg("SpadeA","take");
                        //console.log("ref1 take")
                    }
                    wip = true;
                }
            }


            onBtn_hold:
            {
                if(btn_ref1.i_status == 5 && (btn_ref2.i_status === 1 || btn_ref2.i_status === 5))
                {
                    //console.log("Send A Hold CMD \r\n");
                    mySerialThread.setPkg("SpadeA","cancel");
                    if(btn_ref2.i_status === 1)
                    {
                        btn_ref2.i_status = 0;
                    }
                    else if(btn_ref2.i_status === 5)
                    {
                        if(pageModeSelection_Mode === 6)
                        {
                            pic_ref.source = Qt.resolvedUrl("qrc:/Images/dip_2.png")
                        }
                        else if(pageModeSelection_Mode === 7)
                        {
                            pic_ref.source = Qt.resolvedUrl("qrc:/Images/ground.png")
                        }
                    }
                    btn_next.enabled = false;
                    wip = true;
                   // console.log("ref1 hold")
                }
            }
        }

       Btn_Dynamic
       {
           id:btn_ref2
           btn_name: "ref2"

           onGetStart_confirmedChanged:
           {
               if(getStart_confirmed)
               {
                   btn_ref2.i_status = 2; // Flashing Black
               }
           }

           onGetTake_confirmedChanged:
           {
               if(getTake_confirmed){
                   btn_ref2.i_status = 4; //Flashing RED
               }
           }

           onGetTake_completedChanged:
           {
               if(getTake_completed && btn_ref2.i_status === 4)
               {
                   btn_ref2.i_status = 5;
                   wip = false; // btn B process is DONE

                   if(btn_ref1.i_status === 5)
                   {
                       btn_next.enabled = true;
                   }
                   else
                   {
                       btn_next.enabled = false;
                   }
               }
           }

           onGetCancel_confirmedChanged:
           {
               if(getCancel_confirmed){
                   btn_ref2.i_status = 2; // flashing black
                   btn_next.enabled = false;
               }
           }

           onBtn_click:
           {
               if(btn_ref1.i_status === 5)
               {
                   if(btn_ref2.i_status === 1 )
                   {
//                       if(pageModeSelection_Mode === 2)
//                       {
//                           mySerialThread.setPkg("Pivot","start");
//                           wip = true;
//                           console.log("ref2 Pivot start");
//                       }
//                       else
//                       {
//                           mySerialThread.setPkg("SpadeB","start");
//                           wip = true;
//                           console.log("ref2 start");
//                       }

                       if(pageModeSelection_Mode === 6)
                       {
                           pic_ref.source = Qt.resolvedUrl("qrc:/Images/dip_3.png")
                       }

                       mySerialThread.setPkg("SpadeB","start");
                       wip = true;
                       //console.log("ref2 start");
                   }
                   else if (btn_ref2.i_status === 3 )
                   {
                       if(getStart_completed)
                       {
//                           if(pageModeSelection_Mode === 2)
//                           {
//                               mySerialThread.setPkg("Pivot","take");
//                               console.log("ref2 Pivot take")
//                           }
//                           else
//                           {
//                               mySerialThread.setPkg("SpadeB","take");
//                               console.log("ref2 take")
//                           }

                           mySerialThread.setPkg("SpadeB","take");
                       }
                   }
               }
           }

           onBtn_hold:
           {
               if(btn_ref2.i_status === 5 && (btn_ref2.i_status === 1 || btn_ref2.i_status === 5))
               {
                   //console.log("Send A Hold CMD \r\n");
//                   if(pageModeSelection_Mode === 2)
//                   {
//                       mySerialThread.setPkg("Pivot","cancel");
//                       console.log("Pivot cancel")
//                   }
//                   else
//                   {
//                       mySerialThread.setPkg("SpadeB","cancel");
//                       console.log("ref2 cancel")
//                   }

                   mySerialThread.setPkg("SpadeB","cancel");

                   if(btn_ref2.i_status === 1)
                   {
                       btn_ref2.i_status = 0;
                   }
                   btn_next.enabled = false;
                   wip = true;
                   //console.log("ref2 hold")
               }
           }
       }
        Row
        {
            Btn_Static
            {
                id:btn_back
                btn_name:"back"
                fontPtSize: fsize_large
                visible: false;
                //color: btn_next.enabled ? clr_orange : clr_gray1

                enabled: (btn_ref1.i_status === 5 || btn_ref2.i_status === 5 || (btn_ref1.i_status === 5 && btn_ref2.i_status === 5)) ? false : true

                onBtnClick:
                {
                    page4.page4Ini();
                    myheader.titleStr = "Choose Alignment Mode"
                    stack.pop();

                }
            }


            Btn_Static
            {
                id:btn_next
                btn_name:"nextlong"
                fontPtSize: fsize_large
                color: btn_next.enabled ? clr_orange : clr_gray1

                onBtnClick:
                {
                    switch(referenceMode)
                    {
                        case 1:
                            switch (pageModeSelection_Mode)
                            {
                                case 2:
                                    //mySerialThread.setPkg("Scan","start");
                                    mySerialThread.setPkg("Scan","DISDETSTAR");
                                    //console.log("dtr start")
                                break;

                                case 6:
                                    mySerialThread.setPkg("Scan","DIP");
                                    myStartTime = new Date();
                                    startTime = myStartTime.toTimeString();
                                    myDate = Qt.formatDateTime(myStartTime, "yyyy-MM-dd");
                                    second_elapsed = 0;
                                    timer_elapsed.start();
                                break;

                                case 7:
                                    num_Measured = 0;
                                    arr_measuredDist = [];
                                    mySerialThread.setPkg("Scan","PLT");
                                    myStartTime = new Date();
                                    startTime = myStartTime.toTimeString();
                                    myDate = Qt.formatDateTime(myStartTime, "yyyy-MM-dd");
                                    second_elapsed = 0;
                                    timer_elapsed.start();
                                break;

                                 default:
                                 mySerialThread.setPkg("Scan","start");
                                 //console.log("Scan start")
                                 //starttime here

                                 myStartTime = new Date();
                                 startTime = myStartTime.toTimeString();
                                 myDate = Qt.formatDateTime(myStartTime, "yyyy-MM-dd");
                                 second_elapsed = 0;
                                 timer_elapsed.start();
                                 break;
                            }

                            //stack.push(Qt.resolvedUrl("qrc:/Pages/Page_6_Measuring.qml"));
                            if(!stack.busy )
                            {
                                if(pageModeSelection_Mode !== 6)
                                {
                                    stack.push(page6);
                                    page6.page6Ini();
                                    //myheader.titleStr = "Measuring"
                                    if(pageModeSelection_Mode !== 7)
                                    {
                                        page6.popupOpen();
                                    }
                                }
                                else
                                {
                                    popup_page4_dip_result.open();
                                }

                            }

                            //stack.currentItem.popupOpen();
                        break;

                     case 2:
                         switch (pageModeSelection_Mode)
                         {
                         case 4:
                             page5.imgSource = Qt.resolvedUrl("qrc:/Images/swing.png")
                             break;

                         case 5:
                             page5.imgSource = Qt.resolvedUrl("qrc:/Images/dist_swing.png")
                             break;
                         }
                         stack.push(page5);
                         myheader.titleStr = "Pivot Scan"
                        //stack.push(Qt.resolvedUrl("qrc:/Pages/Page_5_Pivot_Scan.qml"));
                     break;
                    }
                }
            }
        }
    }
}

