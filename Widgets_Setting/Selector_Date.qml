import QtQuick 2.0

Rectangle {
    id: root;
    width: 480
    height: 300

    property alias yearList: yearList
    property alias monthList: monthList
    property alias dayList: dayList

    property alias yearModel: yearList.myModel;
    property alias monthModel: monthList.myModel;
    property alias dayModel: dayList.myModel;

    property alias yearValue: yearList.value;
    property alias monthValue: monthList.value;
    property alias dayValue: dayList.value;

    property alias yearZeroFlags: yearList.bZeroFlags;
    property alias monthZeroFlags: monthList.bZeroFlags;
    property alias dayZeroFlags: dayList.bZeroFlags;

    property alias yearTextFlags: yearList.bTextFlags;
    property alias monthTextFlags: monthList.bTextFlags;
    property alias dayTextFlags: dayList.bTextFlags;

    property alias dateText: currentDate.text;

    //SIGNAL
    signal sigYearValue(int index);
    signal sigMonthValue(int index);
    signal sigDayValue(int index);
    signal sigConfirmOK();
    signal sigCancel();

    Rectangle {
        id: mainUI;
        color: "#FEFEFE";
        anchors.centerIn: parent;
        width: 480
        height: root.height;

        //titleText
        Rectangle
        {
            id: contentText;
            anchors
            {
                left: parent.left;
                top: parent.top;
            }

            width: parent.width;
            height: root.height/9;
            color: clr_gray3

            Text {
                id: currentDate;
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                color: clr_orange;
                //text:"2014-23-23";
                //text: yearModel.get(yearList.value).numberText + "-" +  (monthList.value+1) + "-"  + (dayList.value+1);
                text:myYear + "-" + myMonth + "-" + myDay
                font.family: bodyFont.name;
                font.pointSize: fsize_small
            }
        }

        //横线
        Rectangle {
            id: line;
            anchors {
                left: parent.left;
                right: parent.right;
                top: contentText.bottom;
            }
            height: 2
            color: clr_gray2
        }

        //年
        Picker_DateTime {
            id: yearList;
            anchors
            {
                left: parent.left;
                top: line.bottom;
            }

            width: parent.width / 3;
            height: parent.height - contentText.height -line.height - settingsButton_OK.height
            //currentFontSize: 22;
            //normalFontSize: 18;
            onValueChanged:
            {
                root.sigYearValue(value);
            }
        }

        //月
        Picker_DateTime {
            id: monthList;
            anchors
            {
                left: yearList.right;
                top: line.bottom;
            }

            width: parent.width / 3;
            height: parent.height - contentText.height -line.height - settingsButton_OK.height;
            //currentFontSize: 34;
            //normalFontSize: 28;


            onValueChanged:
            {
                root.sigMonthValue(value);
                //console.log("current index = ",value)
            }
        }

        //日
        Picker_DateTime
        {
            id: dayList;
            anchors {
                left: monthList.right;
                top: line.bottom;
            }
            width: parent.width / 3;
            height: parent.height - contentText.height -line.height - settingsButton_OK.height;
            //currentFontSize: 34;
            //normalFontSize: 28;
            onValueChanged: {
                root.sigDayValue(value);
            }
        }


        //设置按钮


            Rectangle
            {
                id: settingsButton_OK;

                height: 50;
                width: parent.width/2
                color: btn_ok.pressed ? Qt.lighter(clr_gray2) : clr_gray2;
                anchors.bottom: mainUI.bottom

                Text {
                    id: confirmText;
                    anchors.centerIn: parent;
                    color: "white";
                    text: "OK"
                    font.family: bodyFont.name;
                    font.pointSize: fsize_small
                }

                MouseArea
                {
                    id:btn_ok
                    anchors.fill: parent;
                    onClicked:
                    {
                        root.sigConfirmOK();
                        //root.visible = false;

                    }
                }
            }

            Rectangle
            {
                id: settingsButton_cancel;
                anchors.bottom: mainUI.bottom
                anchors.left: settingsButton_OK.right
                height: 50;
                width: parent.width/2
                color:btn_cancel.pressed ? Qt.lighter(clr_gray2) : clr_gray2;

                Text {
                    id: text_cancel;
                    anchors.centerIn: parent;
                    color: "white";
                    text: "Cancel"
                    font.family: bodyFont.name;
                    font.pointSize: fsize_small
                }

                MouseArea
                {
                    id:btn_cancel
                    anchors.fill: parent;
                    onClicked: {
                        root.sigCancel();
                        //root.visible = true;
                    }
                }
            }
        }



//    //左边透明
//    Rectangle {
//        id :leftRect;
//        anchors {
//            left: parent.left;
//            right: mainUI.left;
//            top: topRect.bottom;
//            bottom: bottomRect.top;
//        }
//        color:"#989898";
//        opacity: 0.6;

//        MouseArea{
//            anchors.fill: parent;
//            onClicked: {
//                root.visible = false;
//            }
//        }
//    }

//    //右边透明
//    Rectangle {
//        id :rightRect;
//        anchors {
//            left: mainUI.right;
//            right: parent.right;
//            top: topRect.bottom;
//            bottom: bottomRect.top;
//        }
//        color:"#989898";
//        opacity: 0.6;
//        MouseArea{
//            anchors.fill: parent;
//            onClicked: {
//                root.visible = false;
//            }
//        }
//    }

//    //下方透明
//    Rectangle {
//        id: bottomRect;
//        anchors {
//            left: parent.left;
//            top: mainUI.bottom;
//            bottom: parent.bottom;
//        }
//        width: parent.width;
//        opacity: 0.6;
//        color:"#989898";

//        MouseArea{
//            anchors.fill: parent;
//            onClicked: {
//                root.visible = false;
//            }
//        }
//    }
}
