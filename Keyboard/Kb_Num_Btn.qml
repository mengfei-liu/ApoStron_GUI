import QtQuick 2.0

Rectangle
{
    id:root
    width: 120//parent.width/3
    height: 60//parent.height/5

    property string btnOperator: ""

    signal btnClick(string btnOperator);
    signal btnPressed();
    signal btnReleased();
    signal btnHold();


    property alias text: buttonText.text

    color: btn_mouseArea.pressed ? clr_keybordNum_grayDark :clr_keybordNum_gray

    MouseArea
    {
        id:btn_mouseArea
        anchors.fill: parent
        onClicked: root.btnClick(btnOperator);
        onPressed: root.btnPressed();
        onReleased: root.btnReleased();
        onPressAndHold: root.btnHold();
    }


    Text {
        id: buttonText
        anchors.centerIn: root
        font.family: bodyFont.name
        font.pixelSize: root.width > root.height ? root.height * 0.6 : root.width * 0.6

        color: "white"
        visible: buttonText.text == "back" ? false : true
    }

    Image {
        id: btn_pic
        anchors.fill: root
        fillMode: Image.PreserveAspectFit
        visible: buttonText.text == "back" ? true : false
        source: btn_mouseArea.pressed ? Qt.resolvedUrl("qrc:/Icons/btn_back_pressed.png") : Qt.resolvedUrl("qrc:/Icons/btn_back_released.png")
    }

    states:
   [
        //  20190530
//        State
//        {
//            when:buttonText.text == "back" ||buttonText.text == "." || buttonText.text == "±" || buttonText.text == "abc"
//            PropertyChanges
//            {
//                target: root
//                color:btn_mouseArea.pressed ? clr_keybordNum_gray:clr_keybordNum_grayDark
//            }
//        },

//        State
//        {
//            when:root.text === "Previous" ||  root.text === "Next" || buttonText.text === "Done"
//            PropertyChanges
//           {
//               target: buttonText
//               font.pixelSize: 22
//           }
//        }

                State
                {
                    when:buttonText.text == "back" ||buttonText.text == "." || buttonText.text == "±" || buttonText.text == "abc" || buttonText.text === "Done"
                    PropertyChanges
                    {
                        target: root
                        color:btn_mouseArea.pressed ? clr_keybordNum_gray:clr_keybordNum_grayDark
                    }
                },

                State
                {
                    when:buttonText.text == ""
                    PropertyChanges
                    {
                        target: root
                        color:clr_keybordNum_grayDark
                    }
                },

                State
                {
                    when:root.text === "Previous" ||  root.text === "Next"
                    PropertyChanges
                   {
                       target: buttonText
                       font.pixelSize: 22
                   }
                }

    ]
}
