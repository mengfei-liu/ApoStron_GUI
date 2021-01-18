import QtQuick 2.0
import QtQuick.Controls 2.0

import "../Widgets"
import "../Popup"
import "../JS/Database.js" as DB
import "../JS/UnitConvert.js" as Unit

Rectangle
{
    id:page7
    objectName: "Page_AlignmentReview"
    width: 480
    height: 615
    property string pageTitle: qsTr("Alignment Review")


    Component.onCompleted:
    {
        myheader.titleStr = page7.pageTitle;

    }

    function page7Ini()
    {
        myheader.titleStr = pageTitle;
    }

    function changeModeText(mode)
    {
        var text;
        switch (mode)
        {
        case 1:
            //text = qsTr("Align to Reference")
            text = qsTr("Put Drill on Line")
            break;

        case 2:
            //text = qsTr("Measure Line Offset")
            text = qsTr("Measure from Line")
            break;

        case 3:
            //text = qsTr("Enter Line Offset")
            text = qsTr("Offset Drill")
            break;

        case 4:
            text = qsTr("Swing Drill")
            break;

        case 5:
            text = qsTr("Offset & Swing Drill")
            break;

        case 6:
            text = qsTr("Dip Measurement")
            break;

        case 7:
            text = qsTr("Level Platform")
            break;
        }
        return String(text);
    }

    function changeAccurcyText(tolerance)
    {
        var text;
        switch (tolerance)
        {
        case 0:
            //text = qsTr("Low")
            text = is_Unit_Imperial ? Unit.m2fractional_Ft_Inches(tolerance_value) : String(tolerance_value)+"m"
            break;

        case 1:
            //text = qsTr("Medium")
            text = is_Unit_Imperial ? Unit.m2fractional_Ft_Inches(tolerance_value) : String(tolerance_value)+"m"
            break;

        case 2:
            //text = qsTr("High")
            text = is_Unit_Imperial ? Unit.m2fractional_Ft_Inches(tolerance_value) : String(tolerance_value)+"m"
            break;
        }
        return text;
    }


    ListView
    {
        id: myListView
//        width: page7.width *0.9
//        anchors.horizontalCenter: page7.horizontalCenter
        anchors.left: page7.left
        //anchors.right: page7.right
        anchors.right: page7.right //pic_arrow.visible ? pic_arrow.left :
        height: 125
        interactive: true
        clip: true
        anchors.top: page7.top
        anchors.topMargin: 10
        orientation:ListView.Horizontal
        model: mylist_review              // concrete model
        delegate: SwipeView_Alignment_Review{}  // provide delegate component.
        spacing: 20

        ScrollBar.horizontal:
            ScrollBar{
            orientation: Qt.Horizontal
            policy: mylist_review.count <= 3 ? ScrollBar.AlwaysOff : ScrollBar.AlwaysOn
        }
    }


    Rectangle
    {
        id:divider1
        height: 1
        width: page7.width
        color: clr_black
        anchors.top:myListView.bottom
    }

    Row
    {
        id:time
        height: 100
        anchors.top: divider1.bottom
        width: page7.width *0.9
        anchors.horizontalCenter: page7.horizontalCenter
        spacing: 30
        Column
        {
            anchors.verticalCenter: time.verticalCenter
            Text {
                id: totalTime

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.bold: true
                font.pixelSize: fsize_med+5
                minimumPixelSize: fsize_small
                fontSizeMode: Text.HorizontalFit
                color: clr_gray2

                text: totalElapsedTime
            }

            Text {
                id: timeToAlign

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.pixelSize: fsize_2xs
                //wrapMode: Text.WordWrap
                color: clr_gray2

                text: qsTr("Time to Align")
            }
        }

        Column
        {
            anchors.verticalCenter: time.verticalCenter
            Text {
                id: text_startTime

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.bold: true
                font.pixelSize: fsize_med+5
                minimumPixelSize: fsize_small
                fontSizeMode: Text.HorizontalFit
                color: clr_gray2

                text: startTime
            }

            Text {
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.pixelSize: fsize_2xs
                //wrapMode: Text.WordWrap
                color: clr_gray2

                text: qsTr("Start Time")
            }
        }

        Column
        {
            anchors.verticalCenter: time.verticalCenter
            Text {
                id: text_endTime

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.bold: true
                font.pixelSize: fsize_med+5
                minimumPixelSize: fsize_small
                fontSizeMode: Text.HorizontalFit
                color: clr_gray2

                text: endTime
            }

            Text {
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.pixelSize: fsize_2xs
                //wrapMode: Text.WordWrap
                color: clr_gray2

                text: qsTr("End Time")
            }
        }
    }
    Rectangle
    {
        id:divider2
        height: 1
        width: page7.width
        color: clr_black
        anchors.top:time.bottom
    }
    Rectangle
    {
        id:displayOPMode
        height: 100
        width: page7.width *0.9
        anchors.top: divider2.bottom
        anchors.horizontalCenter: page7.horizontalCenter
        Column
        {
            anchors.verticalCenter: displayOPMode.verticalCenter
            //anchors.horizontalCenter: displayOPMode.horizontalCenter
            anchors.left: displayOPMode.left
            Text {
                id: text_mode

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.bold: true
                font.pixelSize: fsize_med+5
                minimumPixelSize: fsize_small
                fontSizeMode: Text.HorizontalFit
                color: clr_gray2

                text:page7.changeModeText(pageModeSelection_Mode)
            }

            Text {
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.pixelSize: fsize_2xs
                //wrapMode: Text.WordWrap
                color: clr_gray2

                text: qsTr("Chosen workflow")
            }
        }
    }

    Rectangle
    {
        id:divider3
        height: 1
        width: page7.width
        color: clr_black
        anchors.top:displayOPMode.bottom
    }

    Rectangle
    {
        id:displayAccurcy
        anchors.top: divider3.bottom
        height: 100
        width: page7.width *0.9
        anchors.horizontalCenter: page7.horizontalCenter

        Column
        {
            anchors.verticalCenter: displayAccurcy.verticalCenter
            //anchors.horizontalCenter: displayAccurcy.horizontalCenter
            anchors.left: displayAccurcy.left
            Text {
                id: text_Accurcy

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.bold: true
                font.pixelSize: fsize_med+5
                minimumPixelSize: fsize_small
                fontSizeMode: Text.HorizontalFit
                color: clr_gray2

                text:page7.changeAccurcyText(tolerance)
            }

            Text {
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: bodyFont.name
                font.pixelSize: fsize_2xs
                //wrapMode: Text.WordWrap
                color: clr_gray2

                text: qsTr("Accuracy")
            }
        }
    }



    Btn_Static
    {
        id:btn_complete
        btn_name: "complete"
        fontPtSize: fsize_large
        anchors.bottom: page7.bottom

        onBtnClick:
        {
            if(pageModeSelection_Mode !== 6)
            {
                var array = []
                array.push(DB.getMaxID()+1);
                array.push(myDate);
                array.push(startTime);
                array.push(endTime);
                array.push(totalElapsedTime);
                array.push(text_mode.text);
                array.push(is_Unit_Imperial);
                array.push(text_Accurcy.text);
                array.push(arr_measuredDist[0]);
                array.push(dDistOffset);

                dSwingOffset = -1 * dSwingOffset;
                array.push(dSwingOffset);

                var dttarray = [];
                for(var i=1;i<arr_measuredDist.length;i++)
                {
                    dttarray.push(arr_measuredDist[i]);
                }


                array.push(dttarray);
            }

            var resultItem = stack.find(
                                         function(item){
                                                    // console.log(item.objectName);
                                                    return item.objectName === "Page_ModeSelection" ? true : false;
                                                }
                                        );

             if(resultItem !== null)
             {

                myheader.titleStr = "Choose Alignment Mode";

                stack.pop(resultItem);
                if(pageModeSelection_Mode !== 6)
                {
                    DB.insertLogData(array);
                }

                mylist_review.clear();
                mylist_review.set(0, {"review_data": qsTr("0")});
             }
        }
    }
}
