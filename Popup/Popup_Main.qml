import QtQuick 2.0
import QtQuick.Controls 2.2
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
    property alias arrow_visable: rect_measure.arrow_visable
    property alias arrow_roation: rect_measure.url_arrow_rotation
    property alias popmeasure_d2t: rect_measure.d2t

    property alias titleText: titleMsg.text
    property alias lBtn_text: btn_left.text
    property alias rBtn_text: btn_right.text
    property alias lBtn_fontSize: btn_left.fontSize
    property alias rBtn_fontSize: btn_right.fontSize

    signal input_dist_Clicked();
    signal input_swing_Clicked();
    signal lBtn_Clicked();
    signal rBtn_Clicked();


    function setWidth()
    {
        var wider,shorter;
        if(titleMsg.implicitWidth > contextMsg1.implicitWidth)
        {
            wider = titleMsg.implicitWidth;
            shorter = contextMsg1.implicitWidth
        }
        else
        {
            wider = contextMsg1.implicitWidth;
            shorter = titleMsg.implicitWidth
        }

        if(wider <= 100)
        {
            wider = 100
        }
        else if(wider > 300)
        {
           wider = 300
           if(wider<shorter)
           {
               console.log("shorter =",shorter)
               wider = shorter
               wider += 60
               if(wider > 480)
                   wider = 380
           }
        }
        else
        {
            wider += 30
        }
        rect_background.width = wider;
        return wider;
    }

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
            anchors.horizontalCenter: rect_background.horizontalCenter
            //anchors.topMargin: 30
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
//           width: 200
//           height: 100
           infotext_fontSize:fsize_xs - 3
           d2t_fontSize: fsize_med +5

           anchors.top: rect_background.top
           anchors.horizontalCenter: rect_background.horizontalCenter
        }


        Text {
            id:text_info1
            //anchors.top: content.top
            //anchors.left: content.left
            //anchors.right: content.right
            width: rect_background.width
            font.family: bodyFont.name
            font.pointSize:fsize_2xs
            color: clr_black
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            textFormat: Text.RichText
            text: contentText1
        }

        Text {
            id:text_info2
            anchors.topMargin: 10
           // anchors.top: text_info1.bottom
            //anchors.left: content.left
            //anchors.right: content.right
            width: text_info1.width
            font.family: bodyFont.name
            font.pointSize:fsize_2xs
            color: clr_black
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            textFormat: Text.RichText
            text: contentText2
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

        Rectangle
        {
            id:divider1
            width: text_info1.width
            height: 1
            anchors.topMargin: 10
            //anchors.top: text_info2.bottom
            anchors.horizontalCenter: rect_background.horizontalCenter
            color: clr_black
        }

        Image
        {
            id:img1
            fillMode: Image.PreserveAspectFit
            //anchors.top: divider1.bottom
            anchors.topMargin: 10
            anchors.left: text_info1.left
            anchors.right: text_info1.right
            cache: false
            //source: Qt.resolvedUrl("qrc:/1.png")
        }

        Rectangle
        {
            id:divider2
            width: text_info1.width
            height: 1
            anchors.topMargin: 10
            //anchors.top: img1.bottom
            anchors.horizontalCenter: rect_background.horizontalCenter
            color: clr_black
        }

        Image
        {
            id:img2
            fillMode: Image.PreserveAspectFit
            //anchors.top: divider2.bottom
            anchors.topMargin: 10
            anchors.left: text_info1.left
            anchors.right: text_info1.right
            cache: false
            //anchors.horizontalCenter: content.horizontalCenter
            //source: Qt.resolvedUrl("qrc:/1.png")
        }

        Rectangle
        {
            id:footer
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
               // anchors.bottom: parent.bottom
               // anchors.left: parent.left
               // anchors.right: divider_ver.left

               // topLeftCorner: false
               // topRightCorner: false
               // bottomLeftCorner: true
              //  bottomRightCorner: false

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
               // anchors.bottom: parent.bottom
               // anchors.right: parent.right
               // anchors.left: divider_ver.right

              //  topLeftCorner: false
              //  topRightCorner: false
              //  bottomLeftCorner: false
               // bottomRightCorner: true

//                onClicked:
//                {
//                    root.rBtn_Clicked();
//                }

                onMyBtnClicked:
                {
                    root.rBtn_Clicked();
                }
            }

    //        Rectangle
    //        {
    //            id:content
    //            anchors.horizontalCenter: rect_background.horizontalCenter
    //            anchors.top: title.bottom
    //            anchors.bottom: footer.top
    //            border.color: backGroundColor
    //            color: backGroundColor
    //            width:rect_background.width



    //        }
        }


        states:
        [
            State
            {
                name: "msg"
                PropertyChanges{
                    target: root;
                    height:contextMsg1.implicitHeight + title.height + footer.height + 50;
                    width: root.setWidth();
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                    anchors.top: title.bottom;
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges{ target: text_info2;visible:false;}
                PropertyChanges{ target: text_alert;visible:false;}
                PropertyChanges{ target: input_Dist;visible:false;}
                PropertyChanges{ target: input_Swing;visible:false;}
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
                name: "alert"
                PropertyChanges{
                    target: root;
                    //height:contextMsg1.implicitHeight + text_alert.height + title.height + footer.height + 50;
                    height: isStrEmpty(contentText2) ? (contextMsg1.implicitHeight + text_alert.height + title.height + footer.height + 50):(contextMsg1.implicitHeight + contextMsg2.implicitHeight + text_info2.anchors.topMargin + text_alert.height + title.height + footer.height + 50);
                   /* height:
                    {
                        var height
                        if(isStrEmpty(contentText2))
                        {
                            console.log("no 2nd line")
                            height =  (contextMsg1.implicitHeight + text_alert.height + title.height + footer.height + 50);
                        }
                        else
                        {
                            height = (contextMsg1.implicitHeight + contextMsg2.implicitHeight + text_info2.anchors.topMargin + text_alert.height + title.height + footer.height + 50);
                        }

                        return height
                    }*/

                    width: root.setWidth();
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                    anchors.top: title.bottom;
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                    wrapMode:Text.WordWrap
                }

                PropertyChanges
                {
                    target: text_info2;
                    //visible:false;
                    visible: isStrEmpty(contentText2) ? false :true
                    anchors.top: text_info1.bottom;
                }
                PropertyChanges
                {
                    target: text_alert;
                    visible:true;
                    anchors.top: text_info2.visible ? text_info2.bottom: text_info1.bottom;
                    anchors.topMargin: 15
                    anchors.horizontalCenter: rect_background.horizontalCenter
                }
                PropertyChanges{ target: input_Dist;visible:false;}
                PropertyChanges{ target: input_Swing;visible:false;}

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
                    height: title.height + contextMsg1.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + divider2.height + divider2.anchors.topMargin + img2.height + img2.anchors.topMargin + footer.height + 30;
                    width: root.setWidth();
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                    anchors.top: title.bottom;
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges{ target: text_info2;visible:false;}
                PropertyChanges {target: text_alert;visible:false;}
                PropertyChanges {target: input_Dist;visible:false;}
                PropertyChanges {target: input_Swing;visible:false;}

                PropertyChanges
                {
                    target: divider1;
                    visible:true;
                    anchors.top: text_info1.bottom
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
                    width: root.setWidth();
                    height: title.height + contextMsg1.implicitHeight + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + divider2.height + divider2.anchors.topMargin + img2.height + img2.anchors.topMargin  + footer.height + 30;
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                    anchors.top: title.bottom;
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges
                {
                    target: text_info2;
                    visible:true;
                    anchors.top: text_info1.bottom
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges{ target: text_alert;visible:false;}
                PropertyChanges{ target: input_Dist;visible:false;}
                PropertyChanges{ target: input_Swing;visible:false;}
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
                /*PropertyChanges{ target: divider_ver;visible:true;}
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
                }*/
            },

            State
            {
                name: "input3"
                PropertyChanges{
                    target: root;
                    width:root.setWidth()// 300//root.setWidth();
                    height: title.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + 30;
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                    anchors.top: title.bottom;
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges
                {
                    target: text_info2;
                    visible:true;
                    anchors.top: text_info1.bottom
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges{ target: text_alert;visible:false;}
                PropertyChanges{ target: input_Dist;visible:false;}
                PropertyChanges{ target: input_Swing;visible:false;}
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
                    visible:false;
                    //anchors.top: img1.bottom
                }
                PropertyChanges{
                    target: img2;
                    visible:false;
                   // anchors.top: divider2.bottom
                }

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

               /* PropertyChanges{ target: divider_ver;visible:true;}
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
                }*/
            },

            State
            {
                name: "input4"
                PropertyChanges{
                    target: root;
                    width:root.setWidth()// 300//root.setWidth();
                    height: title.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight+ img1.height + img1.anchors.topMargin + input_Dist.height + input_Dist.anchors.topMargin +input_Swing.height + input_Swing.anchors.topMargin + divider1.height + divider1.anchors.topMargin  + 30;
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                    anchors.top: title.bottom;
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges
                {
                    target: text_info2;
                    visible:isStrEmpty(contentText2) ? false : true;
                    anchors.top: text_info1.bottom
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges {
                    target: input_Dist;visible:true;
                    anchors.top: text_info2.visible ? text_info2.bottom : text_info1.bottom

                }

                PropertyChanges {
                    target: input_Swing;visible:true;
                    anchors.top: input_Dist.bottom
                }
                PropertyChanges {target: text_alert;visible:false;}
                PropertyChanges
                {
                    target: divider1;
                    visible:true;
                    anchors.top: input_Swing.bottom
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
                    visible:false;
                    //anchors.top: img1.bottom
                }
                PropertyChanges{
                    target: img2;
                    visible:false;
                   // anchors.top: divider2.bottom
                }

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
                    width:root.setWidth()// 300//root.setWidth();
                    height: title.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + input_Dist.height + input_Dist.anchors.topMargin + 30;
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                    anchors.top: title.bottom;
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges
                {
                    target: text_info2;
                    visible:isStrEmpty(contentText2) ? false : true;
                    anchors.top: text_info1.bottom
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges {
                    target: input_Dist;visible:true;
                    anchors.top: text_info2.visible ? text_info2.bottom : text_info1.bottom

                }

                PropertyChanges {
                    target: input_Swing;visible:false;
                }
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

                PropertyChanges
                {
                    target: divider2;
                    visible:false;
                    //anchors.top: img1.bottom
                }
                PropertyChanges{
                    target: img2;
                    visible:false;
                   // anchors.top: divider2.bottom
                }

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
                    width:root.setWidth()// 300//root.setWidth();
                    height: title.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + input_Swing.height + input_Swing.anchors.topMargin +30;
                }
                PropertyChanges{ target: rect_measure;visible:false;}
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                    anchors.top: title.bottom;
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges
                {
                    target: text_info2;
                    visible:isStrEmpty(contentText2) ? false : true;
                    anchors.top: text_info1.bottom
                    anchors.left: rect_background.left;
                    anchors.right: rect_background.right;
                }
                PropertyChanges {
                    target: input_Dist;visible:false;


                }

                PropertyChanges {
                    target: input_Swing;visible:true;
                    anchors.top: text_info2.visible ? text_info2.bottom : text_info1.bottom
                }

                PropertyChanges {target: text_alert;visible:false;}
                PropertyChanges
                {
                    target: divider1;
                    visible:true;
                    anchors.top: input_Swing.bottom
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
                    visible:false;
                    //anchors.top: img1.bottom
                }
                PropertyChanges{
                    target: img2;
                    visible:false;
                   // anchors.top: divider2.bottom
                }

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
                    height:rect_measure.height + contextMsg1.implicitHeight + title.height + footer.height + text_info1.anchors.topMargin;
                    width: 350// rect_measure.width + 100;
                }
                PropertyChanges
                {
                    target: rect_measure;
                    visible:true;
//                    width: 300
//                    height: 100
                    anchors.top: title.bottom
                    anchors.horizontalCenter: rect_background.horizontalCenter
                }
                PropertyChanges
                {
                    target: text_info1;
                    visible:true;
                    anchors.top: rect_measure.bottom
                    anchors.topMargin: 10
                    anchors.horizontalCenter: rect_background.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    minimumPointSize: 1
                }
                PropertyChanges {target: input_Dist;visible:false;}
                PropertyChanges {target: input_Swing;visible:false;}
                PropertyChanges {target: text_alert;visible:false;}
                PropertyChanges{ target: text_info2;visible:false;}
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
