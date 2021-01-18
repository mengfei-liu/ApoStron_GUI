import QtQuick 2.0
//import MyLang 1.0
import "../JS/Database.js" as DB

Rectangle
{
    id:root
    width: parent.width
    height: 100
    //color:clr_gray2
    color:"black"

    property int btnSpacing: (width - 4*btn_1.width)/5

    Row
    {
        spacing: btnSpacing
        height: root.height
        anchors.verticalCenter: root.verticalCenter
        anchors.horizontalCenter: root.horizontalCenter
        Btn_Footer
        {
            id:btn_3
            btn_name: "home"
            onBtnClick:
            {
                console.log("Home Pressed")

                var resultItem = stack.find(
                                             function(item){
                                                         //console.log(item.objectName);
                                                        return item.objectName === "Page_ModeSelection" ? true : false;
                                                    }
                                            );
//                 if(resultItem.objectName !== stack.currentItem.objectName)
//                 {
//                   stack.pop("qrc:/Page_3_DrillPlan_Inputs.qml");
//                 }

//                if((stack.currentItem.objectName == "Page_MarkPoints" || stack.currentItem.objectName =="Page_DrillPlan_Inputs"))
//                {
//                    console.log("Current Page is ",stack.currentItem.objectName," can not go back home")
//                }
                if(stack.currentItem.objectName === "Page_Initialize" || stack.currentItem.objectName == "Page_PivoteScan" || stack.currentItem.objectName == "Page_Measuring")
                {
                    console.log("Current Page is ",stack.currentItem.objectName," can not go back home")
                }
                else
                {
                    if(resultItem !== stack.currentItem )
                    {
                        if(stack.currentItem.objectName == "Page_AlignmentReview")
                        {
                            mylist_review.clear();
                            mylist_review.set(0, {"review_data": qsTr("0")});
                        }

                        startTime = "";
                        footerPoped = false;

                        myheader.titleStr = "Choose Alignment Mode";
                        stack.pop(resultItem);
                    }
                    else
                    {
                        console.log("current is Home page")
                    }
                }
            }
        }


        Btn_Footer
        {
            id:btn_2
            btn_name: "settings"
            onBtnClick:
            {


                console.log("Settings Pressed")
                pageSettings.settings_dateText = Qt.formatDateTime(mySysTime, "yyyy-MM-dd");
                pageSettings.settings_timeText = Qt.formatDateTime(mySysTime, "hh:mm:ss");


               var resultItem = stack.find(
                                            function(item){
                                                        //console.log(item.objectName);
                                                       return item.objectName === "Page_Settings" ? true : false;
                                                   }
                                           );

                if(resultItem !== null)
                {
                      footerPoped = false;
                      myheader.titleStr = resultItem.page_container.pageTitle;
                      stack.pop(resultItem.page_container);
                }
                else
                {
                    //stack.push(Qt.resolvedUrl("qrc:/Page_Settings.qml"))
                    if(footerPoped)
                    {
                        var previousItem = stack.get(stack.depth -1);
                        stack.pop(previousItem.page_container);
                        footerPoped = false;
                        console.log("pop previousItem",previousItem.objectName);
                    }

                    //if((stack.currentItem.objectName !== "Page_MarkPoints" && stack.currentItem.objectName !== "Page_ConfirmCompletion" && stack.currentItem.objectName !=="Page_MeasureRefPts"))
                    //if((stack.currentItem.objectName !== "Page_MarkPoints" && stack.currentItem.objectName !== "Page_ConfirmCompletion" )) //&& stack.currentItem.objectName !=="Page_MeasureRefPts"
                    if(stack.currentItem.objectName !== "Page_Measuring")
                    {
                        footerPoped = true;
                        //stack.push(Qt.resolvedUrl("qrc:/Pages/Page_Settings.qml"),{page_container:stack.currentItem});
                        stack.push(pageSettings,{page_container:stack.currentItem});
                    }
                    else
                    {
                        //warning_dlg.tipText = "Sorry";
                        warning_dlg.tipText = "Settings can't be changed";
                        warning_dlg.openMsg();
                    }

                }
            }
        }

        Btn_Footer
        {
            id:btn_4
            visible: true
            btn_name: "auditlog"

            onBtnClick:
            {
                console.log("Auditlog Pressed")
               // mytrans.updateLanguage(MyLang.FR)

               var resultItem = stack.find(
                                            function(item){
                                                       //console.log(item.text);
                                                        console.log(item.objectName);
                                                       return item.objectName === "Page_AUDITLOGS" ? true : false;
                                                   }
                                           );

                if(resultItem !== null)
                {
                    //stack.pop();
                        footerPoped = false;
                      myheader.titleStr = resultItem.page_container.pageTitle;
                      mySerialThread.systemSync();
                      stack.pop(resultItem.page_container);
                }
                else
                {
                    //stack.push(Qt.resolvedUrl("qrc:/Page_Audit_Logs.qml"))
                    if(footerPoped)
                    {
                        mySerialThread.systemSync();
                        var previousItem = stack.get(stack.depth -1);
                        stack.pop(previousItem.page_container);
                        footerPoped = false;
                        console.log("pop previousItem",previousItem.objectName);
                    }
                    footerPoped = true;
                    mylist_Auditlog.clear();
                    DB.readAll(mylist_Auditlog);
                    stack.push(Qt.resolvedUrl("qrc:/Pages/Page_Audit_Logs.qml"),{page_container:stack.currentItem});
                }
            }
        }

        Btn_Footer
        {
            id:btn_1
            btn_name: "help"
            visible: false
            onBtnClick:
            {
                console.log("Help Pressed")



               /*var resultItem = stack.find(
                                            function(item){
                                                       //console.log(item.text);
                                                        console.log(item.objectName);
                                                       return item.objectName === "Page_Help" ? true : false;
                                                   }
                                           );
                if(resultItem !== null)
                {
                  //stack.pop();

                    footerPoped = false;
                    myheader.titleStr = resultItem.page_container.pageTitle;
                    stack.pop(resultItem.page_container);
               }
                else
                {
                   //stack.push(Qt.resolvedUrl("qrc:/Page_Help.qml"))

                    if(footerPoped)
                    {
                        var previousItem = stack.get(stack.depth -1);
                        if(previousItem.objectName === "Page_AUDITLOGS" || previousItem.objectName === "Page_Settings")
                        {

                        }
                        else
                        {
                            stack.pop(previousItem.page_container);
                            footerPoped = false;
                            console.log("pop previousItem",previousItem.objectName);
                        }

                    }

                    footerPoped = true;


                    //help v2
                    mylist_help_v2.clear();
                    mylist_help_v2.set(0,{"help_content":""});
                    //var text_title;
                    var text_content;
                    help_title = "";

                    switch (stack.currentItem.objectName)
                    {
                        case "Page_Initialize":
                        {
                            help_title = "Initialization Help"
                            text_content = "To perform the initialization, rotate the device until the yellow disc is centred inside the green circle. Adjust the tripod legs if necessary."
                            mylist_help_v2.insert(0,{"help_content":text_content})

                            text_content = "The disc will turn yellow once inside the circle.  Keep the device stationary for 3 seconds until the words “Device is Ready” is displayed.  Press “Start!” to continue.";
                            mylist_help_v2.insert(1,{"help_content":text_content})

                            text_content = "The numbers below the yellow disk indicate how far the device is away from the initialization zone. “X axis” indicates the flatness of the device in the roll direction. “Y axis” indicates the flatness of the device in the pitch direction.";
                            mylist_help_v2.insert(2,{"help_content":text_content})

                        }
                        break;

                        case "Page_DrillPlan_Inputs":
                        {
                            help_title = "Drill Plan Input Help"
                            text_content = "<b>Hole ID:</b> Enter a label for this measurement corresponding to the current hole id from the drill plan. You can enter up to 10 alphanumeric characters and a “-” symbol."
                            mylist_help_v2.insert(0,{"help_content":text_content})
                            text_content = "<b>Ref. Line Angle:</b> This is the angle made by the survey crew’s reference points available on the drilll plan in degrees. You can enter a numeric value between -359.99° and 359.99°.";
                            mylist_help_v2.insert(1,{"help_content":text_content})

                            text_content = "<b>Offset Angle:</b> This is the desired angle of offest from the reference line angle as specified on the drill plan.  enter the offset angle in degrees. You can enter a numeric value between -359.99° and 359.99° Counter clockwise rotation is positive.";
                            mylist_help_v2.insert(2,{"help_content":text_content})

                            text_content = "<b>Offset Dist.:</b> This is the desired linear distance of offset from the <b>Ref. Line Angle</b>. If no location movement from current position is required, the Offset Dist. should be toggled to the off position.  You can enter a numeric value between -25 and 25. Offset dist, relative to reference line, at the device side is positive. Offset dist., across the reference, at far side from device is negative.";
                            mylist_help_v2.insert(3,{"help_content":text_content})

                            text_content = "Once the entries are filled, press “Next” to continue.";
                            mylist_help_v2.insert(4,{"help_content":text_content})
                        }
                        break;

                        case "Page_MeasureRefPts":
                        {
                            help_title = "Reference Measurement Help"
                            text_content = "To measure Spade A, press the orange button labelled “Spade A”. The button will turn red and the laser has turned on."
                            mylist_help_v2.insert(0,{"help_content":text_content})

                            text_content = "Move the device to align the laser point to Spade A. Once the laser has reached the target, press the button again to take the measurement. The button will turn green once the measurement is complete.";
                            mylist_help_v2.insert(1,{"help_content":text_content})

                            text_content = "Repeat the process with buttons “Spade B” and the “Pivot Point” to their measurments.";
                            mylist_help_v2.insert(2,{"help_content":text_content})

                            text_content = "To repeat a measurement on any point, hold the button desired reference button for 2 seconds. The button will turn red and the laser will turn on. Press the same button again to complete the measurement.";
                            mylist_help_v2.insert(3,{"help_content":text_content})

                            text_content = "Once the measurements are complete, press “Next” to continue.";
                            mylist_help_v2.insert(4,{"help_content":text_content})

                            text_content = "Press “Cancel” will go back to the plan page.";
                            mylist_help_v2.insert(5,{"help_content":text_content})
                        }
                        break;

                        case "Page_MarkPoints":
                        {
                            help_title = "Scanning & Measurement Help"
                            text_content = "Move the red laser indicator to find the target line."
                            mylist_help_v2.insert(0,{"help_content":text_content})

                            text_content = "Once the red laser is within the tolerance range of the target line, a green laser indicator will turn on and the red dot at the centre of the screen will turn to green.";
                            mylist_help_v2.insert(1,{"help_content":text_content})

                            text_content = "Press “Mark” when the target is located. A number will appear indicating the number of points marked for auditing purposes.";
                            mylist_help_v2.insert(2,{"help_content":text_content})

                            text_content = "Once complete, press “Next” to continue.";
                            mylist_help_v2.insert(3,{"help_content":text_content})

                        }
                        break;

                        case "Page_ConfirmCompletion":
                        {
                            help_title = "Confirm Completion Help"
                            text_content = "A summary of the drill plan inputs are displayed here."
                            mylist_help_v2.insert(0,{"help_content":text_content})
                            text_content = "Press “Next” to continue.";
                            mylist_help_v2.insert(1,{"help_content":text_content})

                            text_content = "Press “Back” to mark more points.";
                            mylist_help_v2.insert(2,{"help_content":text_content})
                        }
                        break;

                        case "Page_MoveComplete":
                        {
                            help_title = "Move Complete Help"
                            text_content = "A summary of the measuring process is displayed here."
                            mylist_help_v2.insert(0,{"help_content":text_content})

                            text_content = "Press “Discard” to cancel and discard the current measurement process.";
                            mylist_help_v2.insert(1,{"help_content":text_content})

                            text_content = "Press “Done” to complete the job.";
                            mylist_help_v2.insert(2,{"help_content":text_content})
                        }
                        break;

                        case "Page_Settings":
                        {
                            help_title = "Settings Help"
                            text_content = "Select “Metric” or ”Imperial” to change distance units to metres (m) or feet  (ft), respectively."
                            mylist_help_v2.insert(0,{"help_content":text_content})
                            text_content = "In “Tolerance”, select the desired precision of the scanning process. A “Low” tolerance will allow an easier scanning process if high precision is not required.";
                            mylist_help_v2.insert(1,{"help_content":text_content})

                            text_content = "In “Local Time” and “Date”, the time and date can be set in the format “HH:MM:SS” and “YYYY-MM-DD”, respectively.";
                            mylist_help_v2.insert(2,{"help_content":text_content})

                            text_content = "Language has been set to English as the default.";
                            mylist_help_v2.insert(3,{"help_content":text_content})
                        }
                        break;

                        case "Page_AUDITLOGS":
                        {
                            help_title = "Audit Log Help"
                            text_content = "Display the results of the measuring labelled by their “Date” and “Hole ID”."
                            mylist_help_v2.insert(0,{"help_content":text_content})

                        }
                    }

                    stack.push(Qt.resolvedUrl("qrc:/Pages/Page_Help.qml"),{page_container:stack.currentItem});
                }*/
            }
        }


    }
}
