import QtQuick 2.0
import QtQuick.Controls 2.0
import "../Widgets"

Popup
{
    id: root
    x: parent.width/2 - root.width/2
    y: parent.height/2 - root.height/2
    objectName: "Popup_Main"

    modal: true
    focus: true
    //设置窗口关闭方式为按“Esc”键关闭
    closePolicy: Popup.NoAutoClose
    dim:true
    //设置窗口的背景控件，不设置的话Popup的边框会显示出来
    background: rect_background

    property int radius: 10
    property string backGroundColor: "white"
    property alias pic1_url: img1.source
    property alias pic2_url: img2.source
    property alias contentText1: contextMsg1.text
    property alias contentText2: contextMsg2.text
    property alias contentText3: contextMsg3.text
    property alias contentAlertMsg: text_alert.alertMsg

    property alias input_dist:input_Dist.input_Content
    property alias input_dist_title: input_Dist.input_TitleText
   // property alias input_dist_value: input_Dist.input_ContentText
    property string input_dist_unit

    property alias input_swing:input_Swing.input_Content
    property alias input_swing_title: input_Swing.input_TitleText
   // property alias input_swing_value: input_Swing.input_ContentText
    property string input_swing_unit


    property alias url_arrow: rect_measure.url_arrow
    property alias arrow_rotation:rect_measure.url_arrow_rotation
    property alias arrow_visable: rect_measure.arrow_visable
    property alias img3_visable: img3.visible
    property alias pic3_url: img3.source
    property alias popmeasure_d2t: rect_measure.d2t
    property alias popmeasure_d2t_font: rect_measure.d2t_fontSize
    property alias popmeasure_d2t_info: rect_measure.d2t_info
    property alias popmeasure_d2t_color: rect_measure.d2t_color

    property alias titleText: titleMsg.text
    property alias lBtn_text: btn_left.text
    property alias lBtn: btn_left
    property alias hor_devider: divider_hor
    property alias rBtn_text: btn_right.text
    property alias lBtn_fontSize: btn_left.fontSize
    property alias rBtn_fontSize: btn_right.fontSize

    signal input_dist_Clicked();
    signal input_swing_Clicked();
    signal lBtn_Clicked();
    signal rBtn_Clicked();

    function isStrEmpty(obj)
    {
        if(typeof obj == "undefined" || obj === null || obj === "")
        {
            return true;
        }else{
            return false;
        }

    }

    Component.onCompleted:
    {

        if(titleText === "Distance Measured!")
        {
            rect_background.state = "measure"
        }
        else if(titleText === "Install Targets")
        {
            rect_background.state = "dip"
        }
        else if(titleText === "Dip Measurement Result")
        {
            rect_background.state = "dip_result"
        }
        else
        {
            if(!isStrEmpty(contentText1) && isStrEmpty(contentText2) && isStrEmpty(contentAlertMsg) && isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
                //console.log("msg")
                 rect_background.state = "msg"
            }
//            else if(!isStrEmpty(contentText1) && isStrEmpty(contentText2) && !isStrEmpty(contentAlertMsg) && isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
//            {
//                console.log("alert")
//                 root.state = "alert"
//            }
            else if(!isStrEmpty(contentText1)  && !isStrEmpty(contentAlertMsg) && isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
                //console.log("alert")
                 rect_background.state = "alert"
            }
            else if(!isStrEmpty(contentText1) && isStrEmpty(contentText2)  && isStrEmpty(contentAlertMsg) && !isStrEmpty(pic1_url.toString()) && !isStrEmpty(pic2_url.toString()))
            {
                //console.log("input1")
                rect_background.state = "input1"
            }
            else if(!isStrEmpty(contentText1) && !isStrEmpty(contentText2)  && isStrEmpty(contentAlertMsg) && !isStrEmpty(pic1_url.toString()) && !isStrEmpty(pic2_url.toString()))
            {
                 //console.log("input2")
                rect_background.state = "input2"
            }
            else if(!isStrEmpty(contentText1) && !isStrEmpty(contentText2) && isStrEmpty(input_dist_title) && isStrEmpty(input_swing_title) && isStrEmpty(contentAlertMsg) && !isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
               // console.log("input3")
                rect_background.state = "input3"
            }
            else if(!isStrEmpty(contentText1) && !isStrEmpty(input_dist_title) && !isStrEmpty(input_swing_title) && !isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
               // console.log("input4")

                rect_background.state = "input4"
            }
            else if(!isStrEmpty(contentText1) && !isStrEmpty(input_dist_title) && isStrEmpty(input_swing_title) && !isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
                //console.log("input5")
                rect_background.state = "input5"
            }
            else if(!isStrEmpty(contentText1) && isStrEmpty(input_dist_title) && !isStrEmpty(input_swing_title) && !isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
                //console.log("input6")
                rect_background.state = "input6"
            }
        }

        switch (pageModeSelection_Mode)
        {
        case 4:
            toggle_dir.checked = !inputIsCW_ModeSwing;
            break;

        case 5:
            toggle_dir.checked = !inputIsCW_ModeDistSwing;
            console.log("toggle_dir.checked =",toggle_dir.checked )
            break;
        }
    }


    //利用Text 的implicitWidth属性来调节提示框的大小
    //该Text的字体格式需要与contentItem中的字体一模一样
    Text {
        id: titleMsg
        visible: false
        width: 300
        wrapMode: Text.WordWrap
        font.family: bodyFont.name
        font.bold: true
        font.pointSize: fsize_small
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: contextMsg1
        visible: false
        width: 300
        wrapMode: Text.WordWrap
        font.family: bodyFont.name
        font.pointSize:fsize_2xs
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: contextMsg2
        visible: false
        width: 300
        wrapMode: Text.WordWrap
        font.family: bodyFont.name
        font.pointSize:fsize_2xs
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: contextMsg3
        visible: false
        width: 300
        wrapMode: Text.WordWrap
        font.family: bodyFont.name
        font.pointSize:fsize_2xs
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }



    Rectangle {
        id: rect_background
        anchors.fill: parent

        color: "white"
        border.width: 0
        radius: root.radius //+ 20
        antialiasing: true

        MouseArea
        {
            anchors.fill: rect_background
            onClicked:
            {
                input_Dist.input_Content.focus = false;
                input_Swing.input_Content.focus = false;
            }
        }

        Text {
            id: title
            height:50
            anchors.top: rect_background.top
            anchors.topMargin: 15
            anchors.horizontalCenter: rect_background.horizontalCenter

            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: bodyFont.name
            font.pointSize:fsize_small
            font.bold: true
            color: clr_black

            text: titleText
        }

        //Popup_Measure
        Popup_Measure_V2
        {
           id:rect_measure
           //infotext_fontSize:fsize_xs - 3
           //d2t_fontSize: fsize_med +20

           anchors.top: title.bottom
           anchors.horizontalCenter: rect_background.horizontalCenter
        }



        Rectangle
        {
            id:text_info1_row
            anchors.top: title.bottom
            anchors.topMargin: 15
            width: rect_background.width * 0.8
            height:  img3.visible ? (img3.height > text_info1.implicitHeight ? img3.height : text_info1.implicitHeight) : text_info1.implicitHeight
            anchors.horizontalCenter: rect_background.horizontalCenter
            Image {
                id: img3
                height: 50
                width: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: text_info1_row.left
                //source: Qt.resolvedUrl("qrc:/Icons/measure_check.svg")
                source: Qt.resolvedUrl("qrc:/Icons/measure_check.png")
                visible: true
            }

            Text {
                id:text_info1
                width: img3.visible ? (text_info1_row.width - img3.width) : text_info1_row.width
                anchors.left: img3.visible ? img3.right : text_info1_row.left
                anchors.verticalCenter: parent.verticalCenter
                font.family: bodyFont.name
                font.pointSize:fsize_2xs
                fontSizeMode: Text.Fit
                color: clr_black
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                textFormat: Text.RichText
                text: contentText1
            }
        }

        Text {
            id:text_info2
            anchors.topMargin: 10
            width: text_info1_row.width
            font.family: bodyFont.name
            font.pointSize:fsize_2xs
            color: clr_black
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            textFormat: Text.RichText
            text: contentText2
        }

        Text {
            id:text_info3
            anchors.topMargin: 10
            width: text_info1_row.width
            font.family: bodyFont.name
            font.pointSize:fsize_2xs
            color: clr_black
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            textFormat: Text.RichText
            text: contentText3
        }

        Popup_Alert
        {
            id:text_alert
            anchors.topMargin: 10
            width: rect_background.width
            anchors.horizontalCenter: rect_background.horizontalCenter
        }

        Popup_ParaInput
        {
            id:input_Dist
            anchors.topMargin: 10
            anchors.horizontalCenter: rect_background.horizontalCenter
            input_value:  is_Unit_Imperial ? "0ft 0-0/8in" :  "0"
            input_unit: is_Unit_Imperial? "" : input_dist_unit

            onTextInputClicked:
            {
                root.input_dist_Clicked();
            }
        }



        Popup_ParaInput
        {
            id:input_Swing
            anchors.topMargin: 10
            anchors.horizontalCenter: rect_background.horizontalCenter
            input_value: "0"
            input_unit: input_swing_unit
            onTextInputClicked:
            {
                root.input_swing_Clicked();
            }
        }

        Row
        {
            id:row_swing_direction
            height: 60
            anchors.topMargin: 10
            anchors.horizontalCenter: rect_background.horizontalCenter
            spacing: 20

            Btn_RadioBtn
            {
                id:dir_CW
                //text: "High"
                text: "CW"

                checked:
                {
                    var isEnable = false;
                    switch (pageModeSelection_Mode)
                    {
                    case 4:
                        isEnable = inputIsCW_ModeSwing;
                        break;

                    case 5:
                        isEnable = inputIsCW_ModeDistSwing;
                        break;
                    }
                    return isEnable;
                }

                onCheckedChanged:
                {
                    if(checked)
                    {
                        dir_CCW.checked = false;
                        switch (pageModeSelection_Mode)
                        {
                        case 4:
                            inputIsCW_ModeSwing = true;
                            break;

                        case 5:
                            inputIsCW_ModeDistSwing = true;
                            break;
                        }
                    }
                }
            }

            Btn_RadioBtn
            {
                id:dir_CCW
                //text: "High"
                text: "CCW"
                checked:
                {
                    var isEnable = false;
                    switch (pageModeSelection_Mode)
                    {
                    case 4:
                        isEnable = !inputIsCW_ModeSwing;
                        break;

                    case 5:
                        isEnable = !inputIsCW_ModeDistSwing;
                        break;
                    }
                    return isEnable;
                }
                onCheckedChanged:
                {
                    if(checked)
                    {
                        dir_CW.checked = false;
                        switch (pageModeSelection_Mode)
                        {
                        case 4:
                            inputIsCW_ModeSwing = false;
                            break;

                        case 5:
                            inputIsCW_ModeDistSwing = false;
                            break;
                        }
                    }
                }
            }

            /*Rectangle
            {
                id:btn_cw
                height: 60
                width: height
                radius: 5
                enabled:
                {
                    var isEnable = false;
                    switch (pageModeSelection_Mode)
                    {
                    case 4:
                        isEnable = !inputIsCW_ModeSwing;
                        break;

                    case 5:
                        isEnable = !inputIsCW_ModeDistSwing;
                        break;
                    }
                    return isEnable;
                }

                border.color: enabled ? clr_orange : Qt.lighter("green")
                border.width: 4
                color: enabled ? clr_orange : clr_gray1
                Text {
                    font.family: bodyFont.name
                    font.bold: true
                    font.pointSize: fsize_xs
                    text: qsTr("CW")
                    anchors.centerIn: parent
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        if(enabled)
                        {
                            btn_cw.enabled = false;
                            btn_ccw.enabled = true;
                            switch (pageModeSelection_Mode)
                            {
                            case 4:
                                inputIsCW_ModeSwing = true;
                                console.log("inputIsCW_ModeSwing = ",inputIsCW_ModeSwing)
                                break;

                            case 5:
                                inputIsCW_ModeDistSwing = true;
                                console.log("inputIsCW_ModeDistSwing = ",inputIsCW_ModeDistSwing)
                                break;
                            }
                        }

                    }
                }
            }

            Rectangle
            {
                id:btn_ccw
                height: btn_cw.height
                width: height
                radius: 5
                enabled:
                {
                    var isEnable = false;
                    switch (pageModeSelection_Mode)
                    {
                    case 4:
                        isEnable = inputIsCW_ModeSwing;
                        break;

                    case 5:
                        isEnable = inputIsCW_ModeDistSwing;
                        break;
                    }
                    return isEnable;
                }
                color: enabled ? clr_orange  : clr_gray1
                border.color: enabled ? clr_orange : Qt.lighter("green")
                border.width: btn_cw.border.width
                Text {
                    font.family: bodyFont.name
                    font.bold: true
                    font.pointSize: fsize_xs
                    text: qsTr("CCW")
                    anchors.centerIn: parent
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        if(enabled)
                        {
                            btn_cw.enabled = true;
                            btn_ccw.enabled = false;
                            switch (pageModeSelection_Mode)
                            {
                            case 4:
                                inputIsCW_ModeSwing = false;
                                console.log("inputIsCW_ModeSwing = ",inputIsCW_ModeSwing)
                                break;

                            case 5:
                                inputIsCW_ModeDistSwing = false;
                                console.log("inputIsCW_ModeDistSwing = ",inputIsCW_ModeDistSwing)
                                break;
                            }
                        }
                    }
                }
            }*/
        }

        Rectangle
        {
            id:divider1
            width: text_info1_row.width
            height: 1
            anchors.topMargin: 10
            anchors.horizontalCenter: rect_background.horizontalCenter
            color: clr_black
        }

        Image
        {
            id:img1
            fillMode: Image.PreserveAspectFit
            anchors.topMargin: 10
            anchors.left: text_info1_row.left
            anchors.right: text_info1_row.right
        }

        Rectangle
        {
            id:divider2
            width: text_info1_row.width
            height: 1
            anchors.topMargin: 10
            anchors.horizontalCenter: rect_background.horizontalCenter
            color: clr_black
        }

        Image
        {
            id:img2
            fillMode: Image.PreserveAspectFit
            //anchors.top: divider2.bottom
            anchors.topMargin: 10
            anchors.left: text_info1_row.left
            anchors.right: text_info1_row.right
        }

        Rectangle
        {
            id:footer
            anchors.topMargin: 10
            anchors.bottom: rect_background.bottom
            anchors.horizontalCenter: rect_background.horizontalCenter
            height:divider_hor.height + btn_left.height
            width:rect_background.width
            border.color: "transparent"
            radius: root.radius
            antialiasing:true

            Rectangle
            {
                id:divider_hor
                width: root.width
                height: 1
                color: clr_black
                anchors.bottom: btn_left.top
            }

            Rectangle
            {
                id:divider_ver
                width: 1
                height: btn_right.height + divider_hor.height
                color: clr_black
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
            }

            Btn_CustomizedRoundCorner
            {
                id:btn_left
                height: 50
                radius: root.radius
                fontSize: fsize_small
                fontBold: true

//                onClicked:
//                {
//                    root.lBtn_Clicked();
//                }

                onMyBtnClicked:
                {
                    root.lBtn_Clicked();
                }
            }

            Btn_CustomizedRoundCorner
            {
                id:btn_right
                height: 50
                radius: root.radius
                fontSize: fsize_small
                fontBold: true

//                onClicked:
//                {
//                    root.rBtn_Clicked();
//                }

                onMyBtnClicked:
                {
                    root.rBtn_Clicked();
                }
            }
        }

        states:
        [
            State
            {
                name: "msg"
                PropertyChanges{
                    target: root;
                    //height:contextMsg1.implicitHeight + title.height + footer.height + 50;
                    height: title.anchors.topMargin + title.height + text_info1_row.height + text_info1_row.anchors.topMargin  + footer.height + 20 ;
                    width: 330
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges{ target: img3;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                   // anchors.top: title.bottom;
                   // anchors.left: rect_background.left;
                   // anchors.right: rect_background.right;
                }
                PropertyChanges{ target: text_info2;visible:false;}
                PropertyChanges{ target: text_info3;visible:false;}
                PropertyChanges{ target: text_alert;visible:false;}
                PropertyChanges{ target: input_Dist;visible:false;}
                PropertyChanges{ target: input_Swing;visible:false;}
                PropertyChanges {target: row_swing_direction;visible:false;}
                PropertyChanges{ target: divider1;visible:false;}
                PropertyChanges{ target: img1;visible:false;}

                PropertyChanges{ target: divider2;visible:false;}
                PropertyChanges{ target: img2;visible:false;}

                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: false;

                    anchors.bottom: footer.bottom;
                    //anchors.right: footer.right;
                    anchors.right: divider_ver.left;        //20190523
                    anchors.left: footer.left;

                }
                //PropertyChanges{ target: btn_right;visible:false;}
               // PropertyChanges{ target: divider_ver;visible:false;}
                PropertyChanges{ target: divider_ver;visible:true;}     //20190523
                PropertyChanges{
                    target: btn_right;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: false;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom;
                    anchors.right: footer.right;
                    //anchors.left: footer.left;
                    anchors.left: divider_ver.right;        //20190523

                }
            },

            State
            {
                name: "dip"
                PropertyChanges{
                    target: root;
                    //height:contextMsg1.implicitHeight + title.height + footer.height + 50;
                    height: title.anchors.topMargin + title.height + text_info1_row.height + text_info1_row.anchors.topMargin + img1.height + img1.anchors.topMargin + footer.height + 20 ;
                    width: 330
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges{ target: img3;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                   // anchors.top: title.bottom;
                   // anchors.left: rect_background.left;
                   // anchors.right: rect_background.right;
                }
                PropertyChanges{ target: text_info2;visible:false;}
                PropertyChanges{ target: text_info3;visible:false;}
                PropertyChanges{ target: text_alert;visible:false;}
                PropertyChanges{ target: input_Dist;visible:false;}
                PropertyChanges{ target: input_Swing;visible:false;}
                PropertyChanges{target: row_swing_direction;visible:false;}
                PropertyChanges{ target: divider1;visible:false;}
                PropertyChanges{
                    target: img1;visible:true;
                    anchors.top: text_info1_row.bottom
                }

                PropertyChanges{ target: divider2;visible:false;}
                PropertyChanges{ target: img2;visible:false;}

                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: false;

                    anchors.bottom: footer.bottom;
                    //anchors.right: footer.right;
                    anchors.right: divider_ver.left;        //20190523
                    anchors.left: footer.left;

                }
                //PropertyChanges{ target: btn_right;visible:false;}
               // PropertyChanges{ target: divider_ver;visible:false;}
                PropertyChanges{ target: divider_ver;visible:true;}     //20190523
                PropertyChanges{
                    target: btn_right;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: false;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom;
                    anchors.right: footer.right;
                    //anchors.left: footer.left;
                    anchors.left: divider_ver.right;        //20190523

                }
            },

            State
            {
                name: "dip_result"
                PropertyChanges{
                    target: root;
                    height: title.anchors.topMargin + title.height + text_info1_row.height + text_info1_row.anchors.topMargin + text_info2.height + text_info2.anchors.topMargin + text_info3.height + text_info3.anchors.topMargin+ footer.height + 20 ;
                    width: 370
                }
                PropertyChanges{ target: text_info1;font.pointSize:fsize_xs;visible:true;}
                PropertyChanges{
                    target: text_info2;
                    visible:true;
                    font.pointSize:fsize_xs
                    anchors.top: text_info1_row.bottom
                    anchors.horizontalCenter: text_info1_row.horizontalCenter
                }
                PropertyChanges{
                    target: text_info3;
                    visible:true;
                    font.pointSize:fsize_xs
                    anchors.top: text_info2.bottom
                    anchors.horizontalCenter: text_info1_row.horizontalCenter
                }

                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges{ target: img3;visible:false;}
                PropertyChanges{ target: text_alert;visible:false;}
                PropertyChanges{ target: input_Dist;visible:false;}
                PropertyChanges{ target: input_Swing;visible:false;}
                PropertyChanges{ target: row_swing_direction;visible:false;}
                PropertyChanges{ target: divider1;visible:false;}
                PropertyChanges{ target: img1;visible:false;}
                PropertyChanges{ target: divider2;visible:false;}
                PropertyChanges{ target: img2;visible:false;}

                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: false;

                    anchors.bottom: footer.bottom;
                    //anchors.right: footer.right;
                    anchors.right: divider_ver.left;        //20190523
                    anchors.left: footer.left;

                }
                PropertyChanges{ target: divider_ver;visible:true;}     //20190523
                PropertyChanges{
                    target: btn_right;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: false;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom;
                    anchors.right: footer.right;
                    //anchors.left: footer.left;
                    anchors.left: divider_ver.right;        //20190523

                }
            },

            State
            {
                name: "alert"
                PropertyChanges{
                    target: root;
                    //height: isStrEmpty(contentText2) ? (contextMsg1.implicitHeight + text_alert.height + title.height + footer.height + 50):(contextMsg1.implicitHeight + contextMsg2.implicitHeight + text_info2.anchors.topMargin + text_alert.height + title.height + footer.height + 50);
                    //height: isStrEmpty(contentText2) ? (text_info1_row.height + text_alert.height + title.height + footer.height + 30):(text_info1_row.height + contextMsg2.implicitHeight + text_info2.anchors.topMargin + text_alert.height + title.height + footer.height + 30 );
                    height: isStrEmpty(contentText2) ? (title.height + text_info1_row.height + text_info1_row.anchors.topMargin + text_alert.height + text_alert.anchors.topMargin + footer.height):
                                                       (title.height + text_info1_row.height + text_info1_row.anchors.topMargin + text_info2.implicitHeight + text_info2.anchors.topMargin + text_alert.height + text_alert.anchors.topMargin + footer.height);
                    width: 330
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges{ target: img3;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
//                    anchors.top: title.bottom;
//                    anchors.left: rect_background.left;
//                    anchors.right: rect_background.right;
                    wrapMode:Text.WordWrap
                }

                PropertyChanges
                {
                    target: text_info2;
                    //visible:false;
                    visible: isStrEmpty(contentText2) ? false :true
                    anchors.top: text_info1_row.bottom;
                    //anchors.horizontalCenter: rect_background.horizontalCenter
                    anchors.left: text_info1_row.left//rect_background.left;
                    anchors.right: text_info1_row.right//ect_background.right;
                }
                PropertyChanges{ target: text_info3;visible:false;}
                PropertyChanges
                {
                    target: text_alert;
                    visible:true;
                    anchors.top: text_info2.visible ? text_info2.bottom: text_info1_row.bottom;
                    anchors.topMargin: 15
                    anchors.horizontalCenter: rect_background.horizontalCenter
                }
                PropertyChanges{ target: input_Dist;visible:false;}
                PropertyChanges{ target: input_Swing;visible:false;}
                PropertyChanges {target: row_swing_direction;visible:false;}

                PropertyChanges{ target: divider1;visible:false;}
                PropertyChanges{ target: img1;visible:false;}

                PropertyChanges{ target: divider2;visible:false;}
                PropertyChanges{ target: img2;visible:false;}

                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom;
                    anchors.right: footer.right;
                    anchors.left: footer.left;

                }
                PropertyChanges{ target: btn_right;visible:false;}
                PropertyChanges{ target: divider_ver;visible:false;}


            },

            State
            {
                name: "input1"
                PropertyChanges{
                    target: root;
                    //height: title.height + contextMsg1.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + divider2.height + divider2.anchors.topMargin + img2.height + img2.anchors.topMargin + footer.height + 30;
                    height: title.anchors.topMargin + title.implicitHeight + text_info1_row.height + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + divider2.height + divider2.anchors.topMargin + img2.height + img2.anchors.topMargin + footer.height + 20 ;
                    width: 400
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges{ target: img3;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
//                    anchors.top: title.bottom;
//                    anchors.left: rect_background.left;
//                    anchors.right: rect_background.right;
                }
                PropertyChanges{ target: text_info2;visible:false;}
                PropertyChanges{ target: text_info3;visible:false;}
                PropertyChanges {target: text_alert;visible:false;}
                PropertyChanges {target: input_Dist;visible:false;}
                PropertyChanges {target: input_Swing;visible:false;}
                PropertyChanges {target: row_swing_direction;visible:false;}

                PropertyChanges
                {
                    target: divider1;
                    visible:true;
                    anchors.top: text_info1_row.bottom
                }
                PropertyChanges
                {
                    target: img1;
                    visible:true;
                    anchors.top: text_info1_row.bottom
                }

                PropertyChanges
                {
                    target: divider2;
                    visible:true;
                    anchors.top: img1.bottom
                }
                PropertyChanges{
                    target: img2;
                    visible:true;
                    anchors.top: divider2.bottom
                }

                //PropertyChanges{ target: divider_ver;visible:true;}
                PropertyChanges{ target: divider_ver;visible:false;}
                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom;
                    anchors.left: footer.left;
                    anchors.right: footer.right;

                }
                PropertyChanges{ target: btn_right;visible:false;}
                /*PropertyChanges{
                    target: btn_right;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: false;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom
                    anchors.right: footer.right
                    anchors.left: divider_ver.right
                }*/
            },

            State
            {
                name: "input2"
                PropertyChanges{
                    target: root;
                    width: 400
                    //height: title.height + contextMsg1.implicitHeight + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + divider2.height + divider2.anchors.topMargin + img2.height + img2.anchors.topMargin  + footer.height + 30;
                    height: title.anchors.topMargin + title.implicitHeight + text_info1_row.height + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + divider2.height + divider2.anchors.topMargin + img2.height + img2.anchors.topMargin  + footer.height + 30 ;
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges{ target: img3;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
//                    anchors.top: title.bottom;
//                    anchors.left: rect_background.left;
//                    anchors.right: rect_background.right;
                }
                PropertyChanges
                {
                    target: text_info2;
                    visible:true;
                    anchors.top: text_info1_row.bottom
                    anchors.left: text_info1_row.left//rect_background.left;
                    anchors.right: text_info1_row.right//ect_background.right;
                }
                PropertyChanges{ target: text_info3;visible:false;}
                PropertyChanges{ target: text_alert;visible:false;}
                PropertyChanges{ target: input_Dist;visible:false;}
                PropertyChanges{ target: input_Swing;visible:false;}
                PropertyChanges {target: row_swing_direction;visible:false;}
                PropertyChanges
                {
                    target: divider1;
                    visible:true;
                    anchors.top: text_info2.bottom
                }
                PropertyChanges
                {
                    target: img1;
                    visible:true;
                    anchors.top: divider1.bottom
                }

                PropertyChanges
                {
                    target: divider2;
                    visible:true;
                    anchors.top: img1.bottom
                }
                PropertyChanges{
                    target: img2;
                    visible:true;
                    anchors.top: divider2.bottom
                }
                PropertyChanges{ target: divider_ver;visible:false;}
                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom;
                    anchors.left: footer.left;
                    anchors.right: footer.right;

                }
                PropertyChanges{ target: btn_right;visible:false;}
            },

            State
            {
                name: "input3"
                PropertyChanges{
                    target: root;
                    width:400
                    //height: title.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + 30;
                    height: title.anchors.topMargin + title.implicitHeight + footer.height + text_info1_row.height + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + 30 ;
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges{ target: img3;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
//                    anchors.top: title.bottom;
//                    anchors.left: rect_background.left;
//                    anchors.right: rect_background.right;
                }
                PropertyChanges
                {
                    target: text_info2;
                    visible:true;
                    anchors.top: text_info1_row.bottom
                    anchors.left: text_info1_row.left//rect_background.left;
                    anchors.right: text_info1_row.right//ect_background.right;
                }
                PropertyChanges{ target: text_info3;visible:false;}
                PropertyChanges{ target: text_alert;visible:false;}
                PropertyChanges{ target: input_Dist;visible:false;}
                PropertyChanges{ target: input_Swing;visible:false;}
                PropertyChanges {target: row_swing_direction;visible:false;}
                PropertyChanges
                {
                    target: divider1;
                    visible:true;
                    anchors.top: text_info2.bottom
                }
                PropertyChanges
                {
                    target: img1;
                    visible:true;
                    anchors.top: divider1.bottom
                }

                PropertyChanges{ target: divider2;visible:false;}
                PropertyChanges{ target: img2;visible:false;}
                PropertyChanges{ target: divider_ver;visible:false;}
                PropertyChanges{ target: btn_right;visible:false;}
                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom;
                    anchors.left: footer.left;
                    anchors.right: footer.right;

                }
            },

            State
            {
                name: "input4"
                PropertyChanges{
                    target: root;
                    width:400// 300//root.setWidth();
                    //height: title.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight+ img1.height + img1.anchors.topMargin + input_Dist.height + input_Dist.anchors.topMargin +input_Swing.height + input_Swing.anchors.topMargin + divider1.height + divider1.anchors.topMargin  + 30;
                    height: title.anchors.topMargin + title.implicitHeight + footer.height + text_info1_row.anchors.topMargin+ text_info1_row.implicitHeight + text_info2.anchors.topMargin  + contextMsg2.implicitHeight+ img1.height + img1.anchors.topMargin + input_Dist.height + input_Dist.anchors.topMargin +input_Swing.height + input_Swing.anchors.topMargin + row_swing_direction.height + row_swing_direction.anchors.topMargin + divider1.height + divider1.anchors.topMargin  + 20 ;
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges{ target: img3;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
//                    anchors.top: title.bottom;
//                    anchors.left: rect_background.left;
//                    anchors.right: rect_background.right;
                }
                PropertyChanges
                {
                    target: text_info2;
                    visible:isStrEmpty(contentText2) ? false : true;
                    anchors.top: text_info1_row.bottom
                    anchors.left: text_info1_row.left//rect_background.left;
                    anchors.right: text_info1_row.right//ect_background.right;
                }
                PropertyChanges{ target: text_info3;visible:false;}
                PropertyChanges {
                    target: input_Dist;visible:true;
                    anchors.top: text_info2.visible ? text_info2.bottom : text_info1_row.bottom
                }

                PropertyChanges {
                    target: input_Swing;visible:true;
                    anchors.top: input_Dist.bottom
                }
                PropertyChanges
                {
                    target: row_swing_direction;visible:true;
                    anchors.top: input_Swing.bottom
                }
                PropertyChanges {target: text_alert;visible:false;}
                PropertyChanges
                {
                    target: divider1;
                    visible:true;
                    anchors.top: row_swing_direction.bottom
                }
//                PropertyChanges
//                {
//                    target: divider1;
//                    visible:true;
//                    anchors.top: input_Swing.bottom
//                }
                PropertyChanges
                {
                    target: img1;
                    visible:true;
                    anchors.top: divider1.bottom
                }

                PropertyChanges{ target: divider2;visible:false;}
                PropertyChanges{ target: img2;visible:false;}
                PropertyChanges{ target: divider_ver;visible:true;}
                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: false;

                    anchors.bottom: footer.bottom;
                    anchors.left: footer.left;
                    anchors.right: divider_ver.left;

                }
                PropertyChanges{
                    target: btn_right;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: false;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom
                    anchors.right: footer.right
                    anchors.left: divider_ver.right
                }
            },

            State
            {
                name: "input5"
                PropertyChanges{
                    target: root;
                    width:400
                    //height: title.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + input_Dist.height + input_Dist.anchors.topMargin + 30;
                    height: title.anchors.topMargin + title.implicitHeight + footer.height + text_info1_row.height + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + input_Dist.height + input_Dist.anchors.topMargin + 30 ;
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges{ target: img3;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
//                    anchors.top: title.bottom;
//                    anchors.left: rect_background.left;
//                    anchors.right: rect_background.right;
                }
                PropertyChanges
                {
                    target: text_info2;
                    visible:isStrEmpty(contentText2) ? false : true;
                    anchors.top: text_info1_row.bottom
                    anchors.left: text_info1_row.left//rect_background.left;
                    anchors.right: text_info1_row.right//ect_background.right;
                }
                PropertyChanges{ target: text_info3;visible:false;}
                PropertyChanges {
                    target: input_Dist;visible:true;
                    anchors.top: text_info2.visible ? text_info2.bottom : text_info1_row.bottom

                }

                PropertyChanges {target: input_Swing;visible:false;}
                PropertyChanges {target: row_swing_direction;visible:false;}
                PropertyChanges {target: text_alert;visible:false;}
                PropertyChanges
                {
                    target: divider1;
                    visible:true;
                    anchors.top: input_Dist.bottom
                }
                PropertyChanges
                {
                    target: img1;
                    visible:true;
                    anchors.top: divider1.bottom
                }

                PropertyChanges{ target: divider2;visible:false;}
                PropertyChanges{ target: img2;visible:false;}
                PropertyChanges{ target: divider_ver;visible:true;}
                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: false;

                    anchors.bottom: footer.bottom;
                    anchors.left: footer.left;
                    anchors.right: divider_ver.left;

                }
                PropertyChanges{
                    target: btn_right;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: false;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom
                    anchors.right: footer.right
                    anchors.left: divider_ver.right
                }
            },

            State
            {
                name: "input6"
                PropertyChanges{
                    target: root;
                    width:400
                    //height: title.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + input_Swing.height + input_Swing.anchors.topMargin +30;
                    height: title.anchors.topMargin + title.implicitHeight + footer.height + text_info1_row.height + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + input_Swing.height + input_Swing.anchors.topMargin + row_swing_direction.height + row_swing_direction.anchors.topMargin +30 ;
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges{ target: img3;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
//                    anchors.top: title.bottom;
//                    anchors.left: rect_background.left;
//                    anchors.right: rect_background.right;
                }
                PropertyChanges
                {
                    target: text_info2;
                    visible:isStrEmpty(contentText2) ? false : true;
                    anchors.top: text_info1_row.bottom
                    anchors.left: text_info1_row.left//rect_background.left;
                    anchors.right: text_info1_row.right//ect_background.right;
                }
                PropertyChanges{ target: text_info3;visible:false;}
                PropertyChanges {target: input_Dist;visible:false;}

                PropertyChanges {
                    target: input_Swing;visible:true;
                    anchors.top: text_info2.visible ? text_info2.bottom : text_info1_row.bottom
                }
                PropertyChanges {
                    target: row_swing_direction;visible:true;
                    anchors.top: input_Swing.bottom
                }
                PropertyChanges {target: text_alert;visible:false;}
                PropertyChanges
                {
                    target: divider1;
                    visible:true;
                    anchors.top: row_swing_direction.bottom
                }
//                PropertyChanges
//                {
//                    target: divider1;
//                    visible:true;
//                    anchors.top: input_Swing.bottom
//                }
                PropertyChanges
                {
                    target: img1;
                    visible:true;
                    anchors.top: divider1.bottom
                }

                PropertyChanges{ target: divider2;visible:false;}
                PropertyChanges{ target: img2;visible:false;}
                PropertyChanges{ target: divider_ver;visible:true;}
                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: false;

                    anchors.bottom: footer.bottom;
                    anchors.left: footer.left;
                    anchors.right: divider_ver.left;

                }
                PropertyChanges{
                    target: btn_right;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: false;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom
                    anchors.right: footer.right
                    anchors.left: divider_ver.right
                }
            },

            State
            {
                name: "measure"
                PropertyChanges{
                    target: root;
                    //height:rect_measure.height + contextMsg1.implicitHeight + title.height + footer.height + text_info1.anchors.topMargin;
                    //height:rect_measure.height + text_info1_row.height + title.anchors.topMargin + title.implicitHeight + footer.height + text_info1.anchors.topMargin ;

                    height: title.anchors.topMargin + title.implicitHeight + rect_measure.height+ text_info1.implicitHeight + footer.height + footer.anchors.topMargin + 80
                    width: 350// rect_measure.width + 100;
                }
                PropertyChanges {target: img3;visible:true;}
                PropertyChanges
                {
                    target: rect_measure;
                    visible:true;
                    width: 350
                    height: 100
                    anchors.top: title.bottom
                    anchors.horizontalCenter: rect_background.horizontalCenter
                }
                PropertyChanges {
                    target: text_info1_row;
                    visible:true;
                    anchors.top: rect_measure.bottom
                }
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                    //anchors.top: rect_measure.bottom
                   // anchors.topMargin: 10
                   // anchors.horizontalCenter: rect_background.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
//                    fontSizeMode: Text.Fit
//                    minimumPixelSize: 1
//                    minimumPointSize: 1
                }
                PropertyChanges {target: input_Dist;visible:false;}
                PropertyChanges {target: input_Swing;visible:false;}
                PropertyChanges {target: row_swing_direction;visible:false;}
                PropertyChanges {target: text_alert;visible:false;}
                PropertyChanges{ target: text_info2;visible:false;}
                PropertyChanges{ target: text_info3;visible:false;}
                PropertyChanges{ target: divider1;visible:false;}
                PropertyChanges{ target: img1;visible:false;}

                PropertyChanges{ target: divider2;visible:false;}
                PropertyChanges{ target: img2;visible:false;}

                PropertyChanges{ target: divider_ver;visible:true;}
                PropertyChanges{
                    target: btn_left;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: true;
                    bottomRightCorner: false;



                    anchors.bottom: footer.bottom;
                    anchors.left: footer.left;
                    anchors.right: divider_ver.left;

                }
                PropertyChanges{
                    target: btn_right;
                    visible:true;
                    topLeftCorner: false;
                    topRightCorner: false;
                    bottomLeftCorner: false;
                    bottomRightCorner: true;

                    anchors.bottom: footer.bottom
                    anchors.right: footer.right
                    anchors.left: divider_ver.right
                }
            }
        ]

    }


}
