import QtQuick 2.0

//------------ v5 ~ ow 20180703 add color RED for start complete

Rectangle
{
    id:root
    height: 100
    width: 480
    enabled: true

    color:clr_gray1
    signal btn_click();
    signal btn_hold();

    property alias btn_name: root.state
    property alias btnText: btn_text.text
    property bool getStart_confirmed: false;
    property bool getTake_confirmed: false;
    property bool getCancel_confirmed: false;

    property bool getStart_completed: false;
    property bool getTake_completed: false;

    property int i_status: 0

    onI_statusChanged:
    {
        switch (i_status)
        {
            case 0: // grey
                root.enabled = false;
                root.color = clr_gray1;
                break;

//            case 1: //solid orange
//                root.enabled = true;
//                root.color = clr_orange;
//                break;

//            case 2: //flash orange
//                // MCU send start complete to change its status
//                root.enabled = false;
//                btn_orange_flash_animation.start();
//                // Orange flashing CALL allowed to Take
//                break;

            case 1: //solid black
                if(btn_red_flash_animation.running)
                {
                    btn_red_flash_animation.stop()
                }
                root.enabled = true;
                root.color = clr_black;
                break;

            case 2: //flash black
                // MCU send start complete to change its status
                root.enabled = false;
                btn_orange_flash_animation.start();
                // Orange flashing CALL allowed to Take
                break;

            //------------ow 20180703 add color RED for start complete
            case 3: //solid red
                btn_orange_flash_animation.stop();
                if(btn_red_flash_animation.running)
                {
                    btn_red_flash_animation.stop()
                }
                root.color = clr_red;
                root.enabled = true;
                break;

            case 4: //flash red
                btn_red_flash_animation.start();
                root.enabled = false; // automatcial to case 5
                break;

            case 5: // GREEN
                btn_red_flash_animation.stop();
                root.enabled = true; // allow for long hold
                root.color = "green";
                break;
            //------------ow 20180703 add color RED for start complete
        }
    }

    MouseArea
    {
        id:btn_mouseArea
        anchors.fill: root
        onClicked:
        {
            // disable it after click: prevent accident click btw clikc & status change
             // only ORANGE & normal FLASHING ORANGE allow to click
            if(i_status == 1 || i_status == 3)
            {
                root.btn_click();
                root.enabled = false;
            }
        }

        onPressAndHold:
        {
            // disable it after hold: prevent accident click btw clikc & status change
            // only solid RED allowed hold
            if(i_status == 5 && !wip)
            {
                root.btn_hold();
                root.enabled = false;
            }
        }
    }

    Rectangle
    {
        id:circle_num_area
        anchors.verticalCenter: root.verticalCenter
        anchors.left: root.left
        anchors.leftMargin: 30
        color: root.color
        width: root.height/2 + 7
        height: width
        radius: width/2
        border.width: 2
        border.color: "white"
        visible: false      //20190523 not show order number
        Text
        {
            id: text_circle_num
            anchors.verticalCenter: circle_num_area.verticalCenter
            anchors.horizontalCenter: circle_num_area.horizontalCenter
            font.family: titleFont.name
            font.pointSize: fsize_large
            color: "white"
        }
    }

    Text
    {
        id: btn_text
        anchors.verticalCenter: root.verticalCenter
        anchors.horizontalCenter: root.horizontalCenter
        font.family: bodyFont.name
        font.pointSize: fsize_large
        font.bold: true
        color: "white"
    }


    states:
    [
        State
        {
            name: "ref1"
            //PropertyChanges{target: btn_text;text:(qsTr("Spade A"))}  //20190523
            PropertyChanges{target: btn_text;text:pageModeSelection_Mode === 7 ? qsTr("Scan Ground Start") : (qsTr("Reference 1"))}
            PropertyChanges{target: text_circle_num;visible:false;text:("1")}
        },

        State
        {
            name: "ref2"
            //PropertyChanges{target: btn_text;text:(qsTr("Spade A"))}  //20190523
            PropertyChanges{target: btn_text;text:pageModeSelection_Mode === 7 ? qsTr("Scan Platform Height") :(qsTr("Reference 2"))}
            PropertyChanges{target: text_circle_num;visible:false;text:("2")}
        },

        State
        {
            name: "pivot"
            //PropertyChanges{target: btn_text;text:(qsTr("Spade A"))}  //20190523
            //PropertyChanges{target: btn_text;text:(qsTr("Pivot"))}
            PropertyChanges{target: text_circle_num;visible:false;text:("3")}
        },


        State
        {
            name: "Spade A"
            //PropertyChanges{target: btn_text;text:(qsTr("Spade A"))}  //20190523
            PropertyChanges{target: btn_text;text:(qsTr("Reference 1"))}
            PropertyChanges{target: text_circle_num;text:("1")}
        },

        State
        {
            name: "Spade B"
            //PropertyChanges{target: btn_text;text:(qsTr("Spade B"))}  //20190523
            PropertyChanges{target: btn_text;text:(qsTr("Reference 2"))}
            PropertyChanges{target: text_circle_num;text:("2")}
        },

        State
        {
            name: "Pivot Point"
            //PropertyChanges{target: btn_text;text:(qsTr("Pivot Point"))}
            PropertyChanges{target: btn_text;text:(qsTr("Pivot"))}
            PropertyChanges{target: text_circle_num;text:("3")}
        },

        State
        {
            name: "FRONT SITE"
            //PropertyChanges{target: btn_text;text:(qsTr("Spade A"))}
            PropertyChanges{target: btn_text;text:(qsTr("Front Sight"))}
            PropertyChanges{target: text_circle_num;text:("1")}
        },

        State
        {
            name: "BACK SITE"
            //PropertyChanges{target: btn_text;text:(qsTr("Spade B"))}
            PropertyChanges{target: btn_text;text:(qsTr("Back Sight"))}
            PropertyChanges{target: text_circle_num;text:("2")}
        }


    ]

    SequentialAnimation
    {
        id:btn_orange_flash_animation
        loops:Animation.Infinite
        running: false

        ColorAnimation
        {
            target:root;property: "color";  from: root.color; to: Qt.lighter(root.color); duration: 300
        }
        ColorAnimation
        {
            target:root;property: "color"; from: Qt.lighter(root.color); to: root.color;  duration: 300
        }
    }

    SequentialAnimation
    {
        id:btn_red_flash_animation
        loops:Animation.Infinite
        running: false

        ColorAnimation
        {
             target:root;property: "color";  from: root.color; to: Qt.lighter(root.color); duration: 100
        }
        ColorAnimation
        {
             target:root;property: "color"; from: Qt.lighter(root.color); to: root.color;  duration: 100
        }
    }
}
