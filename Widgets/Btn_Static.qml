import QtQuick 2.0

Rectangle
{
    id:root
    height: 100

    color:btn_mouseArea.pressed? Qt.darker(clr_orange) : clr_orange

    signal btnClick();

    property alias btn_name: root.state
    property alias text: btn_text.text
    property alias fontPtSize: btn_text.font.pointSize

    MouseArea
    {
        id:btn_mouseArea
        anchors.fill: root
        onClicked: root.btnClick();
    }

    Text {
        id: btn_text
        anchors.verticalCenter: root.verticalCenter
        anchors.horizontalCenter: root.horizontalCenter
        font.family: bodyFont.name
        //font.pointSize: fsize_large
        font.bold: true
        fontSizeMode: Text.Fit
        color:"white"
    }

    states:
    [
        State
        {
            name: "mode"
            PropertyChanges
            {
                target: root;width:480;height:modeBtnHeight
            }
        },

        State
        {
            name: "complete"
            PropertyChanges{target: root;width:480;}
            PropertyChanges{target: btn_text;text:qsTr("Complete!")}
        },


        State
        {
            name: "relevel2"
            PropertyChanges
            {
                target: root;width:480;height:modeBtnHeight;
                color:btn_mouseArea.pressed?  clr_gray2: Qt.darker(clr_gray2)//clr_gray2;  Qt.darker(clr_gray1)
            }
            //PropertyChanges{target: btn_text;text:qsTr("Re-Level")}
        },

        State
        {
            name: "start"
            PropertyChanges
            {
                target: root; width:480;
            }
            PropertyChanges{target: btn_text;text:qsTr("Start!")}

        },

        State
        {
            name: "cancel"
            PropertyChanges
            {
                target: root;width:240
                color:btn_mouseArea.pressed? Qt.lighter(clr_ltblack) :clr_black

                onEnabledChanged:
                {
                    if(enabled)
                    {
                      color = clr_black;

                    }
                    else
                        color = clr_gray1;
                }
            }
           // PropertyChanges{target: btn_text;text:qsTr("Cancel")}
        },

        State
        {
            name: "relevel"
            PropertyChanges
            {
                target: root;width:240
                color:btn_mouseArea.pressed? Qt.lighter(clr_ltblack) :clr_black
            }
            PropertyChanges{target: btn_text;text:qsTr("Re-Level")}
        },

        State
        {
            name: "back"
            PropertyChanges
            {
                target: root;width:240
                //color:btn_mouseArea.pressed? Qt.lighter(clr_ltblack) :clr_black
                color:root.enabled ? (btn_mouseArea.pressed? Qt.lighter(clr_ltblack) :clr_black) : clr_gray1
            }
            PropertyChanges{target: btn_text;text:qsTr("Back")}
        },

        State
        {
            name: "measure"
            PropertyChanges
            {
                target: root;width:240
                //color:btn_mouseArea.pressed? Qt.lighter(clr_ltblack) :clr_black
                color:root.enabled ? (btn_mouseArea.pressed? Qt.lighter(clr_ltblack) :clr_black) : clr_gray1
            }
            PropertyChanges{target: btn_text;text:qsTr("Measure")}
        },

        State
        {
            name: "backWide"
            PropertyChanges
            {
                target: root;width:480
                color:btn_mouseArea.pressed? Qt.lighter(clr_ltblack) :clr_black
            }
            PropertyChanges{target: btn_text;text:qsTr("Back")}
        },

        State
        {
            name: "next"
            PropertyChanges
            {
                target: root; width:240
                color:root.enabled ? (btn_mouseArea.pressed? Qt.lighter(clr_orange) :clr_orange) : clr_gray1
            }
            PropertyChanges{target: btn_text;text:qsTr("Next")}
        },

        State
        {
            name: "nextlong"
            PropertyChanges
            {
                target: root; width:480;
                color:root.enabled ? (btn_mouseArea.pressed? Qt.lighter(clr_orange) :clr_orange) : clr_gray1
            }
            PropertyChanges{target: btn_text;text:qsTr("Next")}
        },

        State
        {
            name: "deleteLog"
            PropertyChanges
            {
                target: root;width:240
                color:root.enabled ? (btn_mouseArea.pressed? Qt.lighter(clr_orange) :clr_orange) : clr_gray1
            }
            PropertyChanges{target: btn_text;text:qsTr("Delete")}
        },

        State
        {
            name: "done"
            PropertyChanges
            {
                target: root;width:480
                color:root.enabled ? (btn_mouseArea.pressed? Qt.lighter(clr_orange) :clr_orange) : clr_gray1
            }
            PropertyChanges{target: btn_text;text:qsTr("Done")}
        },

        State
        {
            name: "doneShort"
            PropertyChanges
            {
                target: root;width:240
                //color:btn_mouseArea.pressed? Qt.lighter(clr_ltblack) :clr_black
                color:root.enabled ? (btn_mouseArea.pressed? Qt.lighter(clr_orange) :clr_orange) : clr_gray1
            }
            PropertyChanges{target: btn_text;text:qsTr("Done")}
        },

        State
        {
            name: "discard"
            PropertyChanges
            {
                target: root;width:240
                color:btn_mouseArea.pressed? Qt.darker("red") : "red"
            }
            PropertyChanges{target: btn_text;text:qsTr("Discard")}
        },

        State
        {
            name: "close"
            PropertyChanges
            {
                target: root; width:480
                color:btn_mouseArea.pressed? Qt.lighter(clr_ltblack) : clr_black
            }
            PropertyChanges{target: btn_text;text:qsTr("Close");}
        },

        State
        {
            name: "Mark"
            PropertyChanges
            {
                target: root; width:240
                color:btn_mouseArea.pressed? Qt.lighter("green") : "red"
            }
            PropertyChanges
            {
                target: btn_text;
                text:qsTr("Mark")
            }
        }
    ]
}
