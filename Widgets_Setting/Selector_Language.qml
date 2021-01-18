import QtQuick 2.0

Rectangle
{
    id: root;
    width: 480
    height: 300

    property alias languageModel: languageList.myModel

    signal sigLanguageIndex(int index);
    signal sigConfirmOK();
    signal sigCancel();

    Rectangle
    {
        id: mainUI;
        color: "#FEFEFE";
        anchors.centerIn: parent;
        width: 480
        height: root.height;

        Picker_Language
        {
            id: languageList;
            anchors.top: mainUI.top
            anchors.bottom: settingsButton_OK.top
            width: parent.width;

            onValueChanged:
            {
                root.sigLanguageIndex(value);
            }
        }

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
                }
            }
        }
    }
}
