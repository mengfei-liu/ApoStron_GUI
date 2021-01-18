import QtQuick 2.0
import QtQuick.Controls 2.0

import "../Widgets"
import "../Popup"
import "../Keyboard"
import "../Pages"
import "../JS/UnitConvert.js" as UC
import "../JS/UnitConvert_toFt.js" as M2ft
import "../JS/MyNumPad.js" as MyNumPad
import "../JS/InputValidation.js" as ValidateInput

Rectangle
{
    id:page6
    objectName: "Page_Measuring"
    width: 480
    height: 615

    property string pageTitle: qsTr("Measuring")

    property double dtt: 0.0
    property double dtr: 0.0
    property double scanAngle: 0.0
    property int inputMode: 1
    //property bool isDTRCorrect: false
    property alias btn_doneEnabled: btn_done.enabled
    property alias area_d2rNum: area_d2r.mynum
    property alias area_lmNum: area_lm.mynum
    property alias area_d2tNum:area_d2t.mynum



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

    function popupOpen()
    {
        setPopContent(pageModeSelection_Mode)
    }

    function setPopContent(mode)
    {
        var text1,text2;
        var pic1,pic2
        switch (mode)
        {
        case 1:
            pic1 = Qt.resolvedUrl("qrc:/Images/mode1_1.png");
            pic2 = Qt.resolvedUrl("qrc:/Images/mode1_2.png");
            text1 = qsTr("Aim the laser at a rig reference point to measure a distance to the scanned reference.");
            text2 = qsTr("A green laser indicator will appear when the measured position is aligned with the scanned reference line.");
            break;

        case 2:
            pic1 = Qt.resolvedUrl("qrc:/Images/mode2_1.png");
            pic2 = Qt.resolvedUrl("qrc:/Images/mode2_2.png");
            text1 = qsTr("Aim the laser at a rig reference point to measure a distance to the scanned reference. Press the measure button to record a distance ( <img width=\"25\" height=\"25\" align=\"middle\" src=\"qrc:/Icons/D4text.svg\" > ) into the audit log.");
            text2 = qsTr("");
            break;

        case 3:
            pic1 = Qt.resolvedUrl("qrc:/Images/mode3_1.png");
            pic2 = Qt.resolvedUrl("qrc:/Images/mode3_2.png");
            text1 = qsTr("Aim the laser at a rig reference point to measure a distance to the scanned reference line. Press the measure button to record a distance ( <img width=\"25\" height=\"25\" align=\"center\" src=\"qrc:/Icons/D4text.svg\" > ) into the audit log.");
            text2 = qsTr("A green laser indicator will appear when the measured position is in line with the offset reference line.");
            break;

        case 4:
            pic1 = Qt.resolvedUrl("qrc:/Images/mode4_1.png");
            pic2 = Qt.resolvedUrl("qrc:/Images/mode4_2.png");
            text1 = qsTr("Aim the laser at a rig reference point to measure a distance to the scanned reference line. Press the measure button to record a distance ( <img width=\"25\" height=\"25\" align=\"center\" src=\"qrc:/Icons/D4text.svg\" > ) into the audit log.");
            text2 = qsTr("A green laser indicator will appear when the measured position is aligned with the offset reference line.");
            break;

        case 5:
            pic1 = Qt.resolvedUrl("qrc:/Images/mode5_1.png");
            pic2 = Qt.resolvedUrl("qrc:/Images/mode5_2.png");
            text1 = qsTr("Aim the laser at a rig reference point once it is near the desired location. Press the measure button to record a distance (<img width=\"25\" height=\"25\" align=\"center\" src=\"qrc:/Icons/D4text.svg\" >) into the audit log");
            text2 = qsTr("A green laser indicator will appear when the measured position is in line the new target line.");
            break;
        }
        popup_page6_alert.contentText1 = String(text1);
        popup_page6_alert.contentText2 = String(text2);
        popup_page6_alert.pic1_url = pic1;
        popup_page6_alert.pic2_url = pic2;
        popup_page6_alert.open();
    }

  function page6Ini()
  {
      myheader.titleStr = qsTr("Measuring");
      vk_num.state = "inactive";
      btn_done.enabled = false;
      dtt = 0.0
      dtr = 0.0
      scanAngle = 0.0
  }

    Component.onCompleted:
    {
        myheader.titleStr = pageTitle;
        vk_num.state = "inactive";
        btn_done.enabled = false;
        //popup_page6_alert.open();
    }

    Connections
    {
        target: mySerialThread

        onDttChanged:
        {
            if(pageModeSelection_Mode !== 2 || (pageModeSelection_Mode === 2 && isDTRCorrect))
            {
                rect_scan.dtt = mySerialThread.dtt;
                page6.dtt = mySerialThread.dtt;

                //2019OCT21 fake data
//                if(pageModeSelection_Mode === 1)
//                {
//                    rect_scan.dtt = -1 * mySerialThread.dtt;
//                    page6.dtt = -1 * mySerialThread.dtt;
//                }


                if(is_Unit_Imperial)
                {
                    //area_d2t.mynum =  UC.m2fractional_Ft_Inches(rect_scan.dtt);
                    area_d2t.mynum =  UC.m2fractional_Ft_Inches_Style(rect_scan.dtt);
                }
                else
                {
                    //area_d2t.mynum  = String(rect_scan.dtt.toFixed(2)) + "m"
                    area_d2t.mynum  = String(UC.toFixed(rect_scan.dtt,2)) + "m"
                }

                if(rect_scan.isDotInTorle)
                {
                    popup_page6_measure.popmeasure_d2t = area_d2t.mynum;
                    popup_page6_measure.popmeasure_d2t_color = "green"
                    popup_page6_measure.contentText1 = qsTr("Measured distance is aligned to target line.")
                    popup_page6_measure.url_arrow = Qt.resolvedUrl("qrc:/Icons/green_arrow.svg")
                    popup_page6_measure.pic3_url = Qt.resolvedUrl("qrc:/Icons/measure_check.png")
                }
                else
                {
                    popup_page6_measure.popmeasure_d2t = area_d2t.mynum;
                    popup_page6_measure.popmeasure_d2t_color = "red"
                    popup_page6_measure.contentText1 = qsTr("Measured distance is NOT aligned to target line.")
                    popup_page6_measure.url_arrow = Qt.resolvedUrl("qrc:/Icons/red_arrow.svg")
                    popup_page6_measure.pic3_url = Qt.resolvedUrl("qrc:/Icons/red_cross.svg")
                }

            }
        }

        onScan_angleChanged:
        {
            rect_scan.scan_angle = mySerialThread.scan_angle;
        }

        onDtrChanged:
        {
            if(pageModeSelection_Mode === 1)
            {
                page6.dtr = mySerialThread.dtt;
                rect_scan.dtr = mySerialThread.dtt;
            }
            else
            {
                //oringal
                page6.dtr = mySerialThread.dtr;
                rect_scan.dtr = mySerialThread.dtr;

                //20190924
//                if(pageModeSelection_Mode === 2 && !isDTRCorrect)
//                {
//                    if(mySerialThread.dtt <0)
//                    {
//                        page6.dtr = mySerialThread.dtr * -1;
//                        rect_scan.dtr = mySerialThread.dtr * -1;
//                    }
//                    else
//                    {
//                        page6.dtr = mySerialThread.dtr ;
//                        rect_scan.dtr = mySerialThread.dtr ;
//                    }

//                }
//                else
//                {
//                    page6.dtr = mySerialThread.dtr ;
//                    rect_scan.dtr = mySerialThread.dtr ;
//                }
            }

            if(!isDTRCorrect)
            {
                if(is_Unit_Imperial )
                {
                    page6.area_d2rNum =  UC.m2fractional_Ft_Inches_Style(page6.dtr)

                }
                else
                {
                    //page6.area_d2rNum  =  String(page6.dtr.toFixed(3))+"m";
                    //page6.area_d2rNum  =  String(page6.dtr.toFixed(2))+"m";
                    page6.area_d2rNum = String(UC.toFixed(page6.dtr,2)) + "m";
                }
            }

            if(pageModeSelection_Mode === 2 && !isDTRCorrect)
            {
                if(is_Unit_Imperial)
                {
                    popup_page6_measure.popmeasure_d2t = UC.m2fractional_Ft_Inches_Style(page6.dtr)
                }
                else
                {
                   //popup_page6_measure.popmeasure_d2t = String(page6.dtr.toFixed(3))+"m";
                   // popup_page6_measure.popmeasure_d2t = String(page6.dtr.toFixed(2))+"m";
                    popup_page6_measure.popmeasure_d2t = String(UC.toFixed(page6.dtr,2)) + "m";
                }

            }
        }
    }

    Row
    {
        id:row_displayInfo
        anchors.top: page6.top
        width: parent.width
        Rect_Page_Measuring_DisplayInfo
        {
            id:area_d2t

            clr_background: Qt.lighter(clr_orange)
            clr_dashline: Qt.lighter(clr_green)
            clr_text:clr_black
            mytext: pageModeSelection_Mode !== 7 ? qsTr("Distance to Target") : qsTr("Distance to Platform")
            mynum: is_Unit_Imperial ? "0ft 0-0/8in" : "0m"
        }

        Rect_Page_Measuring_DisplayInfo
        {
            id:area_lm

            clr_background: clr_gray2
            clr_dashline: "transparent"
            clr_text:"white"
            mytext: qsTr("Last Measurement")
            mynum: is_Unit_Imperial ? "0ft 0-0/8in" : "0m"

        }

        Rect_Page_Measuring_DisplayInfo
        {
            id:area_d2r

            clr_background: clr_gray3
            clr_dashline: clr_orange
            clr_text:clr_black
            mytext: pageModeSelection_Mode !== 7 ? qsTr("Distance from Reference") : qsTr("Platform Height")
            mynum: is_Unit_Imperial ? "0ft 0-0/8in" : "0m"
        }
    }

    Rectangle
    {
        id:divider
        anchors.top: row_displayInfo.bottom
        height: 1
        width: page6.width
        color: "black"
    }

    Rect_Page_Measuring_Scan
    {
        id:rect_scan
        width: page6.width
        anchors.top: divider.bottom
        anchors.bottom: row_btn.top
        clr_targetLine: Qt.lighter(clr_green)
        clr_toleranceZone: Qt.lighter(clr_orange)

        onArrow_rotationChanged:
        {
            popup_page6_measure.arrow_rotation = rect_scan.arrow_rotation
        }
    }

    Row
    {
        id:row_btn
        anchors.bottom: page6.bottom
        Btn_Static
        {
            id:btn_measure
            btn_name: pageModeSelection_Mode !== 7 ? "measure" : "Mark"
            fontPtSize: fsize_large

            onBtnClick:
            {
                if(pageModeSelection_Mode !== 7)
                {
                    if(pageModeSelection_Mode === 2 && !isDTRCorrect )
                    {
                        popup_page6_measure.titleText = qsTr("Distance Measured!")
                        popup_page6_measure.img3_visable = false;
                        popup_page6_measure.arrow_visable = false
                        if(is_Unit_Imperial)
                        {
                          //popup_page6_measure.popmeasure_d2t = UC.m2fractional_Ft_Inches(page6.dtr);
                          popup_page6_measure.popmeasure_d2t =  UC.m2fractional_Ft_Inches_Style(page6.dtr);
                        }
                        else
                        {
                            //popup_page6_measure.popmeasure_d2t = String(page6.dtr.toFixed(2))+"m";
                            popup_page6_measure.popmeasure_d2t = String(UC.toFixed(page6.dtr,2)) + "m";
                        }


                        popup_page6_measure.popmeasure_d2t_color = "red"
                        popup_page6_measure.popmeasure_d2t_info = qsTr("Distance from Scanned Reference")
                        popup_page6_measure.contentText1 = qsTr("Use this measurement for line offset to establish parallel target line?")
                        popup_page6_measure.rBtn_text = qsTr("Yes")
                    }
                    else
                    {
                        popup_page6_measure.titleText = qsTr("Distance Measured!")
                        popup_page6_measure.img3_visable = true;
                        //popup_page6_measure.url_arrow = Qt.resolvedUrl("qrc:/Icons/green_arrow.png")
                        popup_page6_measure.arrow_visable = true

                        if(rect_scan.isDotInTorle)
                        {
                            popup_page6_measure.popmeasure_d2t_color = "green"
                            popup_page6_measure.contentText1 = qsTr("Measured distance is aligned to target line.")
                            popup_page6_measure.url_arrow = Qt.resolvedUrl("qrc:/Icons/green_arrow.svg")
                            //popup_page6_measure.pic3_url = Qt.resolvedUrl("qrc:/Icons/measure_check.svg")
                            popup_page6_measure.pic3_url = Qt.resolvedUrl("qrc:/Icons/measure_check.png")
                        }
                        else
                        {
                            popup_page6_measure.popmeasure_d2t_color = "red"
                            popup_page6_measure.contentText1 = qsTr("Measured distance is NOT aligned to target line.")
                            popup_page6_measure.url_arrow = Qt.resolvedUrl("qrc:/Icons/red_arrow.svg")
                            popup_page6_measure.pic3_url = Qt.resolvedUrl("qrc:/Icons/red_cross.svg")
                        }


                        if(is_Unit_Imperial)
                        {
                          //popup_page6_measure.popmeasure_d2t = UC.m2fractional_Ft_Inches(rect_scan.dtt);
                            popup_page6_measure.popmeasure_d2t = UC.m2fractional_Ft_Inches_Style(rect_scan.dtt);
                        }
                        else
                        {
                           //popup_page6_measure.popmeasure_d2t = String(rect_scan.dtt.toFixed(2))+"m";
                            popup_page6_measure.popmeasure_d2t = String(UC.toFixed(rect_scan.dtt,2)) + "m";
                        }

                        popup_page6_measure.rBtn_text = qsTr("OK")
                    }
                    popup_page6_measure.open();
                }
                else
                {
                    num_Measured += 1;
                    console.log("num_Measured = ",num_Measured)
                    mySerialThread.setPkg("Scan","mark");

                    btn_doneEnabled = true;

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
                }
            }
        }

        Btn_Static
        {
            id:btn_done
            btn_name:"doneShort"
            fontPtSize: fsize_large
            enabled: isDTRCorrect

            onBtnClick:
            {
                mySerialThread.setPkg("done");

                //end time here
                myEndTime = new Date();

                endTime = Qt.formatDateTime(myEndTime, "hh:mm:ss");
                timer_elapsed.stop();
                totalElapsedTime = elapsedTime(second_elapsed);


                mylist_review.setProperty(0,"review_data",String(arr_measuredDist[0]));
                mylist_review.append({"review_data":page6.area_d2rNum});
                for(var i=1;i<arr_measuredDist.length;i++)
                {
                    mylist_review.append({"review_data":qsTr(String(arr_measuredDist[i]))});
                }

                page4.page4Ini();
                page5.page5Ini();
                page7.page7Ini();
                stack.push(page7)
                //stack.push(Qt.resolvedUrl("qrc:/Pages/Page_7_Alignment_Review.qml"))
            }
        }
    }


}
