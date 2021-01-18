import QtQuick 2.0

Rectangle
{
    id:root
    width: 55
    height: 50
    radius: 5

    property alias btn_name: root.state
    property alias text: buttonText.text
    property bool active: false

    property string op: ""

    signal toggled();
    signal btnClick();
    signal btn_BackClick(string op);
    signal btn_BackHold();


    Image {
        id: btn_pic
        visible: false;
        anchors.fill: root
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: buttonText
        anchors.centerIn: root
        visible: false
        font.family: bodyFont.name
        font.pixelSize: root.width > root.height ? root.height * 0.6 : root.width * 0.6
    }

    MouseArea
    {
        id:btn_mouseArea
        anchors.fill: root

    }

    states:
    [
        State
        {
            name: "shift"
            //PropertyChanges{ target: btn_pic; source: Qt.resolvedUrl("qrc:/icons/auditlogButton.png")}
            PropertyChanges{ target: btn_mouseArea;onClicked:{active = !active; root.toggled()}}
            PropertyChanges{ target: root;color:active ? clr_keybord_grayDark : clr_keybord_gray}
            PropertyChanges{ target: btn_pic;visible:true;source:root.active ? Qt.resolvedUrl("qrc:/Icons/btn_shift_pressed.png") : Qt.resolvedUrl("qrc:/Icons/btn_shift_released.png")}
        },

        State {
            name: "back"
            PropertyChanges{ target: btn_mouseArea;onClicked:{root.btn_BackClick(op)}}
            PropertyChanges{ target: btn_mouseArea;onPressAndHold:{root.btn_BackHold()}}
            PropertyChanges{ target: root;color:btn_mouseArea.pressed ? clr_keybord_grayDark : clr_keybord_gray}
            PropertyChanges{ target: btn_pic;visible:true;source:btn_mouseArea.pressed ? Qt.resolvedUrl("qrc:/Icons/btn_back_pressed.png") : Qt.resolvedUrl("qrc:/Icons/btn_back_released.png")}
        },

        State {
            name: "123"
            PropertyChanges{ target: btn_mouseArea;onClicked:{root.btnClick();}}
            PropertyChanges {target: root;color:btn_mouseArea.pressed ? clr_keybord_grayDark : clr_keybord_gray}
            PropertyChanges{ target: btn_pic;visible:false}
            PropertyChanges{ target: buttonText;visible:true;font.pixelSize:25}
        },

        State {
            name: "return"
            PropertyChanges{ target: btn_mouseArea;onClicked:{root.btnClick();}}
            PropertyChanges {target: root;color:btn_mouseArea.pressed ? clr_keybord_grayDark : clr_keybord_gray}
            PropertyChanges{ target: btn_pic;visible:false}
            PropertyChanges{ target: buttonText;visible:true;font.pixelSize:25}
        }
    ]
}
