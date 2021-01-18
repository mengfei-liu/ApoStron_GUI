import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Widgets"

Item {
    id: root
    anchors.centerIn: parent
    property int radius: 10
    //提示框内容
    property alias pic1_url: img1.source
    property alias pic2_url: img2.source
    property alias contentText1: contextMsg1.text
    property alias contentText2: contextMsg2.text
    property alias contentAlertMsg: text_alert.alertMsg

    property alias input_dist_title: input_Dist.input_TitleText
    property alias input_dist_value: input_Dist.input_ContentText
    property alias input_dist:input_Dist.input_Content
    property alias input_swing_title: input_Swing.input_TitleText
    property alias input_swing_value: input_Swing.input_ContentText
    property alias input_swing:input_Swing.input_Content

    property alias titleText: titleMsg.text
    property alias lBtn_text: btn_left.text
    property alias rBtn_text: btn_right.text

    signal input_dist_Clicked();
    signal input_swing_Clicked();
    signal lBtn_Clicked();
    signal rBtn_Clicked();
    //提示框颜色
    property string backGroundColor: "white"
    property Item parentItem : Rectangle {}

    /*  width: {
          if(contextMsg.implicitWidth < 100 || contextMsg.implicitWidth == 100)
              return 100;
          else
              return contextMsg.implicitWidth > 300 ? 300: contextMsg.implicitWidth;
      }*/

    /*  width: rect_measure.width + 100
      //height: contextMsg.implicitHeight + header.height + footer.height + 50
      height: rect_measure.height + contextMsg1.implicitHeight + header.height + footer.height + 50

      width: {
          if(contextMsg1.implicitWidth < 100 || contextMsg1.implicitWidth == 100)
          {
              console.log("contextMsg1.implicitWidth = ",contextMsg1.implicitWidth);
              return 100;
          }
          else
          {
              console.log("contextMsg1.implicitWidth = ",contextMsg1.implicitWidth);
              return contextMsg1.implicitWidth > 300 ? 300: contextMsg1.implicitWidth;
          }

      }
      //height: 800
      height: header.height + footer.height + 50+ contextMsg1.implicitHeight + contextMsg2.implicitHeight+contextMsg2.anchors.topMargin+ img1.height + img2.height + img1.anchors.topMargin + img2.anchors.topMargin+ divider1.height + divider2.height + divider1.anchors.topMargin + divider2.anchors.topMargin*/
    function open() {
        root.x = (parent.width - dialog.width) * 0.5
        root.y = (parent.height - dialog.height) * 0.5
        dialog.open();
    }

    function close()
    {
        dialog.close();
    }

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
               wider = shorter
               wider += 30
               if(wider > 480)
                   wider = 380
           }
        }
        else
        {
            wider += 30
        }

        return wider;
    }

    /*function setWidth()
    {
        if(contextMsg1.implicitWidth < 100 || contextMsg1.implicitWidth === 100)
        {
            return 100;
        }
        else
        {
            var width;
            if(contextMsg1.implicitWidth > 300)
            {
                width = 300;
            }
            else
            {
                width = contextMsg1.implicitWidth + 50;
            }
            console.log("set width to:",width)
            return width;
        }
    }*/

   /* function isStrEmpty(str)
    {
        if (str.length !== 0)
        {
          //alert("not empty");
          console.log("str",str);
          return false;
        }
        else
        {
         // alert("empty");
         console.log("str",str);
          return true;
        }
    }*/

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
            root.state = "measure"
        }
        else
        {
            if(!isStrEmpty(contentText1) && isStrEmpty(contentText2) && isStrEmpty(contentAlertMsg) && isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
                console.log("msg")
                 root.state = "msg"
            }
//            else if(!isStrEmpty(contentText1) && isStrEmpty(contentText2) && !isStrEmpty(contentAlertMsg) && isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
//            {
//                console.log("alert")
//                 root.state = "alert"
//            }
            else if(!isStrEmpty(contentText1)  && !isStrEmpty(contentAlertMsg) && isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
                console.log("alert")
                 root.state = "alert"
            }
            else if(!isStrEmpty(contentText1) && isStrEmpty(contentText2)  && isStrEmpty(contentAlertMsg) && !isStrEmpty(pic1_url.toString()) && !isStrEmpty(pic2_url.toString()))
            {
                console.log("input1")
                root.state = "input1"
            }
            else if(!isStrEmpty(contentText1) && !isStrEmpty(contentText2)  && isStrEmpty(contentAlertMsg) && !isStrEmpty(pic1_url.toString()) && !isStrEmpty(pic2_url.toString()))
            {
                 console.log("input2")
                root.state = "input2"
            }
            else if(!isStrEmpty(contentText1) && !isStrEmpty(contentText2) && isStrEmpty(input_dist_title) && isStrEmpty(input_swing_title) && isStrEmpty(contentAlertMsg) && !isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
                console.log("input3")
                root.state = "input3"
            }
            else if(!isStrEmpty(contentText1) && !isStrEmpty(input_dist_title) && !isStrEmpty(input_swing_title) && !isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
                console.log("input4")
                root.state = "input4"
            }
            else if(!isStrEmpty(contentText1) && !isStrEmpty(input_dist_title) && isStrEmpty(input_swing_title) && !isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
                console.log("input5")
                root.state = "input5"
            }
            else if(!isStrEmpty(contentText1) && isStrEmpty(input_dist_title) && !isStrEmpty(input_swing_title) && !isStrEmpty(pic1_url.toString()) && isStrEmpty(pic2_url.toString()))
            {
                console.log("input6")
                root.state = "input6"
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
                height:contextMsg1.implicitHeight + header.height + footer.height + 50;
                width: root.setWidth();
            }
            PropertyChanges{ target: rect_measure;visible:false;}
            PropertyChanges
            {
                target: text_info1;
                visible:true;
                anchors.top: content.top;
                anchors.left: content.left;
                anchors.right: content.right;
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
                //height:contextMsg1.implicitHeight + text_alert.height + header.height + footer.height + 50;
                height: isStrEmpty(contentText2) ? (contextMsg1.implicitHeight + text_alert.height + header.height + footer.height + 50):(contextMsg1.implicitHeight + contextMsg2.implicitHeight + text_info2.anchors.topMargin + text_alert.height + header.height + footer.height + 50);
               /* height:
                {
                    var height
                    if(isStrEmpty(contentText2))
                    {
                        console.log("no 2nd line")
                        height =  (contextMsg1.implicitHeight + text_alert.height + header.height + footer.height + 50);
                    }
                    else
                    {
                        height = (contextMsg1.implicitHeight + contextMsg2.implicitHeight + text_info2.anchors.topMargin + text_alert.height + header.height + footer.height + 50);
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
                anchors.top: content.top;
                anchors.left: content.left;
                anchors.right: content.right;
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
                anchors.horizontalCenter: content.horizontalCenter
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
                height: header.height + contextMsg1.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + divider2.height + divider2.anchors.topMargin + img2.height + img2.anchors.topMargin + footer.height + 30;
                width: root.setWidth();
            }
            PropertyChanges{ target: rect_measure;visible:false;}
            PropertyChanges
            {
                target: text_info1;
                visible:true;
                anchors.top: content.top;
                anchors.left: content.left;
                anchors.right: content.right;
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
                height: header.height + contextMsg1.implicitHeight + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + divider2.height + divider2.anchors.topMargin + img2.height + img2.anchors.topMargin  + footer.height + 30;
            }
            PropertyChanges{ target: rect_measure;visible:false;}
            PropertyChanges
            {
                target: text_info1;
                visible:true;
                anchors.top: content.top;
                anchors.left: content.left;
                anchors.right: content.right;
            }
            PropertyChanges
            {
                target: text_info2;
                visible:true;
                anchors.top: text_info1.bottom
                anchors.left: content.left;
                anchors.right: content.right;
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
                height: header.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + 30;
            }
            PropertyChanges{ target: rect_measure;visible:false;}
            PropertyChanges
            {
                target: text_info1;
                visible:true;
                anchors.top: content.top;
                anchors.left: content.left;
                anchors.right: content.right;
            }
            PropertyChanges
            {
                target: text_info2;
                visible:true;
                anchors.top: text_info1.bottom
                anchors.left: content.left;
                anchors.right: content.right;
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
                height: header.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + input_Dist.height + input_Dist.anchors.topMargin +input_Swing.height + input_Swing.anchors.topMargin + 30;
            }
            PropertyChanges{ target: rect_measure;visible:false;}
            PropertyChanges
            {
                target: text_info1;
                visible:true;
                anchors.top: content.top;
                anchors.left: content.left;
                anchors.right: content.right;
            }
            PropertyChanges
            {
                target: text_info2;
                visible:isStrEmpty(contentText2) ? false : true;
                anchors.top: text_info1.bottom
                anchors.left: content.left;
                anchors.right: content.right;
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
                height: header.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + input_Dist.height + input_Dist.anchors.topMargin + 30;
            }
            PropertyChanges{ target: rect_measure;visible:false;}
            PropertyChanges
            {
                target: text_info1;
                visible:true;
                anchors.top: content.top;
                anchors.left: content.left;
                anchors.right: content.right;
            }
            PropertyChanges
            {
                target: text_info2;
                visible:isStrEmpty(contentText2) ? false : true;
                anchors.top: text_info1.bottom
                anchors.left: content.left;
                anchors.right: content.right;
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
                height: header.height + footer.height + contextMsg1.implicitHeight + text_info2.anchors.topMargin + contextMsg2.implicitHeight + divider1.height + divider1.anchors.topMargin + img1.height + img1.anchors.topMargin + input_Swing.height + input_Swing.anchors.topMargin +30;
            }
            PropertyChanges{ target: rect_measure;visible:false;}
            PropertyChanges
            {
                target: text_info1;
                visible:true;
                anchors.top: content.top;
                anchors.left: content.left;
                anchors.right: content.right;
            }
            PropertyChanges
            {
                target: text_info2;
                visible:isStrEmpty(contentText2) ? false : true;
                anchors.top: text_info1.bottom
                anchors.left: content.left;
                anchors.right: content.right;
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
                height:rect_measure.height + contextMsg1.implicitHeight + header.height + footer.height + 50;
                width: rect_measure.width + 100;
            }
            PropertyChanges
            {
                target: rect_measure;
                visible:true;
                width: 200
                height: 100
                anchors.top: content.top
                anchors.horizontalCenter: content.horizontalCenter
            }
            PropertyChanges
            {
                target: text_info1;
                visible:true;
                anchors.top: rect_measure.bottom
                anchors.horizontalCenter: content.horizontalCenter
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



    Dialog {
        id: dialog
        width: root.width
        height: root.height
        modal: true

        background: Rectangle {
            color: backGroundColor
            //color:"transparent"
            border.width: 0
            anchors.fill: parent
            radius: root.radius + 20
            antialiasing: true
        }

        header: Rectangle
        {
            id:header
            height:50
            width:dialog.width
            radius:root.radius
            color: backGroundColor
            Text {
                anchors.centerIn: parent
                font.family: bodyFont.name
                font.pointSize:fsize_small
                font.bold: true
                color: clr_black
                text: titleText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

            }
        }

        contentItem: Rectangle
        {
            id:content
            border.color: backGroundColor
            color: backGroundColor
            width:dialog.width


            Popup_Measure
            {
               id:rect_measure
               width: 200
               height: 100
               anchors.top: content.top
               anchors.horizontalCenter: content.horizontalCenter
            }

           /* Text {
                id:text_info
                anchors.top: pop_measure.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.fill: parent
                //anchors.centerIn: parent
                font.family: "Microsoft Yahei"
                color: "gray"
                text: contentText
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }*/

            Text {
                id:text_info1
                //anchors.top: content.top
                //anchors.left: content.left
                //anchors.right: content.right
                font.family: bodyFont.name
                font.pointSize:fsize_2xs
                color: clr_black
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: contentText1
            }

            Text {
                id:text_info2
                anchors.topMargin: 10
               // anchors.top: text_info1.bottom
                anchors.left: content.left
                anchors.right: content.right
                font.family: bodyFont.name
                font.pointSize:fsize_2xs
                color: clr_black
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                text: contentText2
            }

            Popup_Alert
            {
                id:text_alert
                anchors.topMargin: 10
                width: dialog.width
            }

            Popup_ParaInput
            {
                id:input_Dist
                anchors.topMargin: 10
                anchors.horizontalCenter: content.horizontalCenter
                onTextInputClicked:
                {
                    root.input_dist_Clicked();
                }
            }

            Popup_ParaInput
            {
                id:input_Swing
                anchors.topMargin: 10
                anchors.horizontalCenter: content.horizontalCenter
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
                anchors.horizontalCenter: content.horizontalCenter
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
                //source: Qt.resolvedUrl("qrc:/1.png")
            }

            Rectangle
            {
                id:divider2
                width: text_info1.width
                height: 1
                anchors.topMargin: 10
                //anchors.top: img1.bottom
                anchors.horizontalCenter: content.horizontalCenter
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
                //anchors.horizontalCenter: content.horizontalCenter
                //source: Qt.resolvedUrl("qrc:/1.png")
            }
        }

        footer: Rectangle
        {
            id:footer
            height:divider_hor.height + btn_left.height
            width:dialog.width
            //border.color: backGroundColor
            //color: backGroundColor
            //color:btn_left.color
            color:"transparent"
            //border.color: btn_left.color
            border.color: "transparent"
            radius: root.radius
            antialiasing:true


            Rectangle
            {
                id:divider_hor
                width: dialog.width
                height: 1
                color: clr_black
                anchors.bottom: btn_left.top
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

                onClicked:
                {
                    root.lBtn_Clicked();
                }
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

                onClicked:
                {
                    root.rBtn_Clicked();
                }
            }
        }
    }
}
