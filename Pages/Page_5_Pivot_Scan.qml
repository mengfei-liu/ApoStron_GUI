import QtQuick 2.0
import QtQuick.Controls 2.0

import "../Widgets"
import "../Popup"

Rectangle
{
    id:page5
    objectName: "Page_PivoteScan"
    width: 480
    height: 615

    property string pageTitle: qsTr("Reference Scanning")
    property bool wip: false; //work-in-process
    property alias imgSource: pic_pivot.source

    function page5Ini()
    {
        btn_Pivot.i_status = 1
        btn_Pivot.getStart_confirmed = false;
        btn_Pivot.getTake_confirmed = false;
        btn_Pivot.getTake_completed = false;
        btn_Pivot.getCancel_confirmed = false;
        btn_next.enabled = false;
        //btn_next.enabled = true;
    }

    Component.onCompleted:
    {
        myheader.titleStr = pageTitle;

        btn_Pivot.i_status = 1
        btn_Pivot.getStart_confirmed = false;
        btn_Pivot.getTake_confirmed = false;
        btn_Pivot.getTake_completed = false;
        btn_Pivot.getCancel_confirmed = false;

        btn_next.enabled = false;
        btn_next.enabled = true;
    }

    Connections
    {
        target: mySerialThread
        onPivot_start_confirmedChanged:
        {
            btn_Pivot.getStart_confirmed = false;
            btn_Pivot.getStart_confirmed = mySerialThread.pivot_start_confirmed;
        }

        onPivot_take_confirmedChanged:
        {
            btn_Pivot.getTake_confirmed = false;
            btn_Pivot.getTake_confirmed = mySerialThread.pivot_take_confirmed;
        }

        onPivot_cancel_confirmedChanged:
        {
            btn_Pivot.getCancel_confirmed = false;
            btn_Pivot.getCancel_confirmed = mySerialThread.pivot_cancel_confirmed;
        }

        onPivot_take_completedChanged:
        {
            btn_Pivot.getTake_completed = false;
            btn_Pivot.getTake_completed = mySerialThread.pivot_take_completed;
        }

        onBtn_start_completedChanged:
        {
            if(mySerialThread.btn_start_completed && btn_Pivot.i_status === 2)
            {

                btn_Pivot.getStart_completed = false;
                btn_Pivot.getStart_completed = mySerialThread.btn_start_completed ;
                btn_Pivot.i_status = 3; // RED color	and allow to take
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

    Image {
        id: pic_pivot
        anchors.top: page5.top
        anchors.bottom: col.top
        anchors.left: page5.left
        anchors.right: page5.right

        //source:Qt.resolvedUrl("qrc:/Images/pivot.png")


    }


    Column
    {

        id:col
        anchors.bottom: page5.bottom
        anchors.horizontalCenter: page5.horizontalCenter
        spacing: 1

        Btn_Dynamic
        {
            id:btn_Pivot
            btn_name: "pivot"
            btnText: pageModeSelection_Mode === 4 ? qsTr("Scan New Collar") : qsTr("Scan Current Collar")

            onGetStart_confirmedChanged:
            {
                if(getStart_confirmed)
                {
                    btn_Pivot.i_status = 2; // Flashing Black
                }
            }

            onGetTake_confirmedChanged:
            {
                if(getTake_confirmed)
                {
                    btn_Pivot.i_status = 4; // Flashing Red
                }
            }

            onGetTake_completedChanged:
            {
                if(getTake_completed)
                {
                    btn_next.enabled = true;
                    btn_Pivot.i_status = 5; // Solid Green
                    wip = false;
                }
            }

            onGetCancel_confirmedChanged:
            {
                if(getCancel_confirmed)
                {
                    btn_Pivot.i_status = 2; // Solid Black
                }
            }

            onBtn_click:
            {
                if(btn_Pivot.i_status === 1)
                {
                    mySerialThread.setPkg("Pivot","start");
                    console.log("Pivot start")
                }
                else if(btn_Pivot.i_status === 3)
                {
                    mySerialThread.setPkg("Pivot","take");
                    console.log("Pivot take")
                }
                wip = true;
            }


            onBtn_hold:
            {
                if(btn_Pivot.i_status == 5 )
                {
                    //console.log("Send A Hold CMD \r\n");
                    mySerialThread.setPkg("Pivot","cancel");
                    btn_next.enabled = false;
                    wip = true;
                    console.log("ref1 hold")
                }
            }
        }

        Row
        {
            Btn_Static
            {
                id:btn_back
                fontPtSize: fsize_large
                btn_name:"cancel"
                text: "Back"
                onBtnClick:
                {
                    page5.page5Ini();
                    stack.pop();

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
                    mySerialThread.setPkg("Scan","start");
                    console.log("Scan start")
                    //start time here
                    myStartTime = new Date();
                    startTime = myStartTime.toTimeString();
                    myDate = Qt.formatDateTime(myStartTime, "yyyy-MM-dd");
                    second_elapsed = 0;
                    timer_elapsed.start();


                    //stack.push(Qt.resolvedUrl("qrc:/Pages/Page_6_Measuring.qml"));
                    stack.push(page6);
                    page6.page6Ini();
                    //myheader.titleStr = "Measuring"
                    page6.popupOpen();
                    //stack.currentItem.popupOpen();
                }
            }
        }
    }
}
