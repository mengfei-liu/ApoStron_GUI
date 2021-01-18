import QtQuick 2.0
import QtQuick.Controls 2.0

import "../Widgets"
import "../Popup"

Rectangle
{
    id:page2
    objectName: "Page_Initialize"
    width: 480
    height: 615

    color: "black"

    property bool x_inTarget: false
    property bool y_inTarget: false

    property int defaultSeconds: 4
    property int seconds: defaultSeconds

    property double toleranceAngle: 3//20//5
    property double coord_ratioX: (display_area.width - object_area.width) / 360.0
    property double coord_ratioY: (display_area.height - object_area.height) / 360.0

    property string pageTitle: "INITIALIZE Laser Device"

    function page2ini()
    {
        myheader.titleStr = "INITIALIZE Laser Device";
        btn_start.visible = false;
        btn_start.enabled = false;
        //text1.visible = true;     //20190523
        text2.visible = false;
        x_inTarget = false;
        y_inTarget = false;
        target_area.x = 0;
        target_area.y = 0;
        x_animation.to = target_area.x;
        x_animation.start();
        y_animation.to = target_area.y;
        y_animation.start();

        popup_page2_alert.open();    //20190523
    }

    Component.onCompleted:
    {
        myheader.titleStr = "INITIALIZE Laser Device";

        btn_start.visible = false;
        btn_start.enabled = false;
        //text1.visible = true;              //20190523
        level_title.visible = false;        //20190523
        level_title_2nd.visible = false;    //20190523
        text2.visible = false;

    }

    Connections
    {
        target: mySerialThread

        onLevelXChanged:
        {
            var x_pos;
            x_pos =  (mySerialThread.levelX + 180) * page2.coord_ratioX;
            //console.log("Degree X = ",mySerialThread.levelX);
            x_animation.to = x_pos;
            x_animation.start();

        }

        onLevelYChanged:
        {
            var y_pos;
            y_pos =  (mySerialThread.levelY + 180) * page2.coord_ratioY
            //console.log("Degree Y = ",mySerialThread.levelY);
            y_animation.to = y_pos;
            y_animation.start();

        }
    }

    ///////////new
    onX_inTargetChanged:
    {
        if(page2.x_inTarget && page2.y_inTarget)
        {
            levelTimer.running = true;
            levelTimer.restart();
            //object_area.color = "yellow";     //20190523
            object_area.color = Qt.lighter("green");
        }
        else
        {
            levelTimer.stop();
            page2.seconds = defaultSeconds;
            //object_area.color = "white";      //20190523
            object_area.color = "red";
        }

    }

    onY_inTargetChanged:
    {
        if(page2.x_inTarget && page2.y_inTarget)
        {
            levelTimer.restart();
            levelTimer.running = true;
            text2.text = "";
            //object_area.color = "yellow";     //20190523
            object_area.color = Qt.lighter("green");
        }
        else
        {
            levelTimer.stop();
            levelTimer.running = false;
            page2.seconds = defaultSeconds;
            text2.text = page2.seconds;
           // object_area.color = "white"       //20190523
            object_area.color = "red";
        }
    }
    ////////////////

    Timer
    {
        id: levelTimer
        interval: 1000

        repeat: true

        onRunningChanged:
        {
//            if(running)
//            {
//                console.log("timer started")
//                //btn_start.visible = true;
//                //btn_start.enabled = true;
//                text1.visible = false;
//                text2.visible = true;
//            }
            text1.visible = false;
            text2.visible = true;

        }

        onTriggered:
        {
            page2.seconds--;

            if(page2.seconds == 0 )
            {
                running = false;
                page2.seconds = defaultSeconds;
                text2.text = "Device is Ready"

                btn_start.visible = true;
                btn_start.enabled = true;
            }
            else
            {
               text2.text = page2.seconds;
            }

        }
    }

    Rectangle
    {
        id:display_area
        anchors.top: page2.top
        width: 480
        height: page2.height - btn_start.height
        color: "black"

        Text
        {
            id: level_title
            text: qsTr("Rotate device and/or adjust tripod legs until yellow disk is centered within green zone")
            anchors.top: display_area.top
            anchors.topMargin: 20
            anchors.left: display_area.left
            anchors.right: display_area.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            font.family:bodyFont.name
            font.pointSize: fsize_xs
            font.bold: true
            color: "white"
        }

        Text
        {
            id: level_title_2nd
            text: qsTr("Maintaining level is not required but position must not change")
            anchors.top: level_title.bottom
            anchors.topMargin: 10
            anchors.left: display_area.left
            anchors.right: display_area.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            font.family:bodyFont.name
            font.pointSize: 11//fsize_3xs
            font.bold: true
            color: "white"
        }

        Rectangle
        {
            id:target_area
            anchors.centerIn: display_area
            width: 150
            height: 150


//            width:toleranceAngle * page2.coord_ratioX
//            height: width

            radius: width/2
            color: "transparent"
            //border.color: "green"     //20190523
            border.color: "white"       //20190523
            border.width: 7             //20190523
            x:(page2.width - object_area.width)/2
            y:(page2.height - object_area.height)/2

            property double center_coord_X: x + width/2
            property double center_coord_Y: y + height/2

        }


        Rectangle
        {
            id:object_area
            width: 130
            height: 130
            radius: width/2
            //color: "transparent"
            //color: (page2.x_inTarget && page2.y_inTarget) ? "yellow" : "white"

            //color:"white"             //20190523
            //border.color: "white"     //20190523
            //opacity: 0.8              //20190523
            color:"red"                 //20190523
            opacity: 1                  //20190523

//            property double center_coord_X: (object_area.width - object_area.x) / 2
//            property double center_coord_Y: (object_area.height - object_area.y) / 2

            property double center_coord_X: x + width/2
            property double center_coord_Y: y + height/2

            onCenter_coord_XChanged:
            {
                if(Math.abs(target_area.center_coord_X - center_coord_X) <= toleranceAngle * page2.coord_ratioX)
                {
                    page2.x_inTarget = true;
                }
                else
                {
                   page2.x_inTarget = false;

                   btn_start.visible = false;
                   btn_start.enabled = false;

                   //text1.visible = true;  //20190523
                   text2.visible = false;
                }
            }

            onCenter_coord_YChanged:
            {
                if(Math.abs(target_area.center_coord_Y - center_coord_Y) <= toleranceAngle * page2.coord_ratioY)
                {
                    page2.y_inTarget = true;
                }
                else
                {
                   page2.y_inTarget = false;

                    btn_start.visible = false;
                    btn_start.enabled = false;
                    //text1.visible = true;     //20190523
                    text2.visible = false;
                }
            }

            NumberAnimation on x
            {
                id:x_animation
                duration:17
            }

            NumberAnimation on y
            {
                id:y_animation
                duration:17

            }
        }
    }

    Btn_Static
    {
        id:btn_start
        anchors.bottom: page2.bottom
        btn_name: "start"
        fontPtSize: fsize_large
        visible: (page2.x_inTarget && page2.y_inTarget) ? true : false
        enabled: (page2.x_inTarget && page2.y_inTarget) ? true : false
        onBtnClick:
        {
            myupdatefile.createFile();
            mySerialThread.setPkg("LevelDone");
            //stack.push(Qt.resolvedUrl("qrc:/Pages/Page_3_Mode_Selection.qml"))
            stack.push(page3)
            myheader.titleStr = "Choose Alignment Mode"
            page3.popupOpen();
            //page3.popup_page3_alert.open();
            //stack.currentItem.popupOpen();
        }

    }

    Text {
        id: text1
        x: 65
        y: 404
        //visible: (page2.x_inTarget && page2.y_inTarget) ? false : true    //20190523
        visible: false
        width: 355
        height: 78
        text: "X axis: " + mySerialThread.levelX.toFixed(2) + "\xB0\r\nY axis: " + mySerialThread.levelY.toFixed(2) + "\xB0"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "red"
        font.family: bodyFont.name
        font.bold: true
        font.pointSize: fsize_large
        z:1
    }

    Text {
        id: text2
        x: 65
        y: 404
        visible: (page2.x_inTarget && page2.y_inTarget) ? true : false
        width: 355
        height: 78
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        font.family: bodyFont.name
        font.bold: true
        font.pointSize: fsize_large
        z:1
    }
}
