import QtQuick 2.0

Rectangle {
    id: root;
    width: 480
    height: 300

    property alias hourModel: hourList.myModel; //24
    property alias minModel: minList.myModel;   //60
    property alias secModel: secList.myModel;   //60

    property alias hourValue: hourList.value;
    property alias minValue: minList.value;
    property alias secValue: secList.value;

    property alias hourZeroFlags: hourList.bZeroFlags;
    property alias minZeroFlags: minList.bZeroFlags;
    property alias secZeroFlags: secList.bZeroFlags;

    property alias hourTextFlags: hourList.bTextFlags;
    property alias minTextFlags: minList.bTextFlags;
    property alias secTextFlags: secList.bTextFlags;

    property alias timeText: currentTime.text;


    //SIGNAL
    signal sigHourValue(int index);
    signal sigMinValue(int index);
    signal sigSecValue(int index);
    signal sigConfirmOK();
    signal sigCancel();


    Rectangle
    {
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
                id: currentTime;
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                color: clr_orange;

                font.family: bodyFont.name;
                font.pointSize: fsize_small

                //text: hourList.value + ":" +  (minList.value) + ":"  + (secList.value  );

                text: myHour + ":" + myMin + ":" + mySec

//                onTextChanged:
//                {
//                    var h,m,s;
//                    if(hourList.value < 10)
//                    {
//                        h = "0" + hourList.value.toString();
//                    }
//                    else if(minList.value < 10)
//                    {
//                        m = "0" + minList.value.toString();
//                    }
//                    else if(secList.value < 10)
//                    {
//                        s = "0" + secList.value.toString();
//                    }
//                    else
//                    {
//                        h = hourList.value.toString();
//                        m = minList.value.toString();
//                        s = secList.value.toString();
//                    }

//                     currentTime.text = h + ":" + m + ":" + s
//                }
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

        //Hour
        Picker_DateTime
        {
            id: hourList;
            anchors
            {
                left: parent.left;
                top: line.bottom;
            }


            width: root.width / 3;
            height: parent.height - contentText.height -line.height - settingsButton_OK.height
            onValueChanged:
            {
                root.sigHourValue(value);
            }
        }

        //Minute
        Picker_DateTime
        {
            id: minList;

            anchors
            {
                left: hourList.right;
                top: line.bottom;
            }

            width: root.width / 3;
            height: parent.height - contentText.height -line.height - settingsButton_OK.height;
            onValueChanged:
            {
                root.sigMinValue(value);

            }
        }

        //sec
        Picker_DateTime
        {
            id: secList;
            anchors {
                left: minList.right;
                top: line.bottom;
            }
            width: root.width / 3;
            height: parent.height - contentText.height -line.height - settingsButton_OK.height;
            onValueChanged: {
                root.sigSecValue(value);
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

                    font.family: bodyFont.name;
                    font.pointSize: fsize_small

                    color: "white";
                    text: "OK"
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

                    font.family: bodyFont.name;
                    font.pointSize: fsize_small                    

                    color: "white";
                    text: "Cancel"
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

}
