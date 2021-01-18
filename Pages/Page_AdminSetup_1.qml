import QtQuick 2.0
import QtQuick.Controls 2.2

import "../Widgets"
import "../Keyboard"
import "../JS/Operate_MyNumPad.js" as MyNumPad

Rectangle
{
    id:page_adminSetup_1
    objectName: "page_adminSetup_1_2"
    width: 480
    height: 615

    color: clr_gray3

    property variant page_container: null

    property bool isPasswordCorrect:false

    property string pageTitle: "Admin Setup"


    Connections
    {
        target: mySerialThread

        /*onIsAdminPSWCorrectChanged:
        {
            isPasswordCorrect = mySerialThread.isAdminPSWCorrect;

            if(isPasswordCorrect)
            {
                isPasswordCorrect = false;
                stack.push(Qt.resolvedUrl("qrc:/Page_AdminSetup_2.qml"),{page_container:page_adminSetup_1.page_container});
            }
            else
            {
                 vk_num.state = "inactive"
                 label_wrongPassword.opacity = 1;

            }
        }*/
    }


    Component.onCompleted:
    {
        myheader.titleStr = "Admin Setup";
    }

    MouseArea
    {
        anchors.fill: page_adminSetup_1

        onClicked:
        {
            text_input.focus = false;
        }

    }

//    onIsPasswordCorrectChanged:
//    {
//        if(isPasswordCorrect)
//        {
//            isPasswordCorrect = false;
//            stack.push(Qt.resolvedUrl("qrc:/Page_AdminSetup_2.qml"));
//        }
//        else
//        {
//             vk_num.state = "inactive"
//             label_wrongPassword.opacity = 1;

//        }
//    }





//    Label
//    {
//        id: label_wrongPassword
//        width: 200
//        height: 50
//        opacity: 0
//        anchors.horizontalCenter: page_adminSetup_1.horizontalCenter
//        anchors.verticalCenter: page_adminSetup_1.verticalCenter
//        verticalAlignment: Text.AlignVCenter
//        horizontalAlignment: Text.AlignHCenter

//        font.family:bodyFont.name
//        font.pointSize: 18
//        font.bold: true


//        color: "red"
//        text: "Password Incorrect !"

//        transitions: Transition {

//            NumberAnimation {
//                target: label_wrongPassword
//                property: "opacity"
//                duration: 10000
//                easing.type: Easing.InOutQuad
//            }
//        }

//    }


    Label
    {
        x: 32
        y: 131
        width: 120
        height: 50
        text: "Password: "
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family:bodyFont.name
        font.pointSize: fsize_small
        font.bold: true
    }


    TextField
    {
        id:text_input
        width: 240
        height: 50
        x: 165
        y: 131
        //passwordCharacter: qsTr("*")
        //echoMode: TextInput.Password
        horizontalAlignment: Text.AlignHCenter
        font.family:bodyFont.name
        font.pointSize: fsize_small
        font.bold: true
        focus: false
        text:password

        background: Rectangle {
                    id:text_rect_background
                   radius: 5
                   implicitWidth: 240
                   implicitHeight: 50
                   border.color: "black"
                   border.width: 1
               }

        onFocusChanged:
        {
            if(focus)
            {
                pswIncorrect_warning_text.visible = false;
                vk_num.state = "active"
                text_rect_background.border.color = "orange"
            }
            else
            {
                vk_num.state = "inactive"
                text_rect_background.border.color = "black"
            }
        }
    }

    Label
    {
        id:pswIncorrect_warning_text
        anchors.horizontalCenter: page_adminSetup_1.horizontalCenter
        anchors.top: text_input.bottom
        anchors.topMargin: 30
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family:bodyFont.name
        font.pointSize: fsize_small
        visible: false
        color: "red"
        text: "Password Incorrect!"
    }

    Btn_Static
    {
        id:btn_cancel
        anchors.bottom: page_adminSetup_1.bottom
        anchors.left: parent.left
        btn_name: "back"
        fontPtSize: fsize_large
        onBtnClick:
        {
            var resultItem = stack.find(
                                         function(item){
                                                     console.log("Item in stack: ",item.objectName);
                                                    return item.objectName === page_adminSetup_1.page_container.objectName ? true : false;
                                                }
                                        );

             if(resultItem !== null)
             {

               myheader.titleStr = resultItem.pageTitle;
               stack.pop(resultItem);
              // page_container.goback();
             }

        }
    }

    Btn_Static
    {
        id:btn_next
        anchors.bottom: page_adminSetup_1.bottom
        anchors.right: parent.right
        btn_name: "next"
        fontPtSize: fsize_large
        onBtnClick:
        {
            myIPaddress = mySerialThread.getIP();
            //mySerialThread.adminSetup(Number(password),0,0,0,0,0,0);
            //stack.push(Qt.resolvedUrl("qrc:/Pages/Page_AdminSetup_2.qml"),{page_container:page_adminSetup_1.page_container})
            if(Number(password) === 5918)
            {
               stack.push(Qt.resolvedUrl("qrc:/Pages/Page_AdminSetup_2.qml"),{page_container:page_adminSetup_1.page_container})
            }
            else
            {
                pswIncorrect_warning_text.visible = true;
            }
        }
    }


    Kb_Num_KeyPad_v2_Admin
    {
        id:vk_num
        btn_func_visible:false;

        onButtonPressed:
        {
            if( btnText != "±" && btnText != ".")
            {
                password = MyNumPad.buttonPressed(text_input.text ,btnText);
            }
        }

        onStateChanged:
        {
            switch (vk_num.state)
            {
                case "inactive":
                {
                   btn_cancel.visible = true;
                   btn_next.visible = true;
                   text_input.focus = false;
                }
                break;

                case "active":
                {
                    btn_cancel.visible = false;
                    btn_next.visible = false;
                    text_input.focus = true;
                }
                break;
            }
        }
    }

}
