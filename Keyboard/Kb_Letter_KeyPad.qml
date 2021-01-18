import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle
{
    id:root
    width: 480
    height: 300
    color: clr_keybordBKG_gray

    property bool shiftPressed: false
    property int btnRowSpacing: 5
    property int btnColumnSpacing: 5
    signal buttonPressed(string btnText)
    signal btnBackHold

    property Item surface: parent

    y: surface.height

   // state: surface.activeFocus ? "active" : "inactive"

    states: [
        State {
            name: "active"
            PropertyChanges { target: root; y: (surface.height - root.height ); z:1}
        },
        State {
            name: "inactive"
            PropertyChanges { target: root; y: surface.height;z:0}
        }

    ]

    transitions: Transition {
        NumberAnimation {
            target: root
            property: "y"
            easing.type: "OutQuad"
            duration: 250
        }
    }

    Row
    {
        id:row_func
        anchors.left: root.left
        Kb_Num_Btn
        {
            text:"Previous";
            color: clr_keybordBKG_gray
            onBtnPressed: {color= Qt.darker(clr_keybordBKG_gray)}
            onBtnReleased: {color= clr_keybordBKG_gray}
            onBtnClick:{myListView.decrementCurrentIndex();}
        }
        Kb_Num_Btn
        {
            text:"Next";
            color: clr_keybordBKG_gray
            onBtnPressed: {color= Qt.darker(clr_keybordBKG_gray)}
            onBtnReleased: {color= clr_keybordBKG_gray}
            onBtnClick:{myListView.incrementCurrentIndex()}
        }
    }

    Kb_Num_Btn
    {
        anchors.top:row_func.top; anchors.right: root.right;
        text:"Done";
        color: clr_keybordBKG_gray
        onBtnPressed: {color= Qt.darker(clr_keybordBKG_gray)}
        onBtnReleased: {color= clr_keybordBKG_gray}
        onBtnClick: {root.state = "inactive";btn_cancel.enabled = true;btn_next.enabled = true;}
    }

    Rectangle
    {
        width: root.width
        height: 1
        color: "white"
        anchors.bottom: col.top
        anchors.bottomMargin: 10
    }

    ColumnLayout
    {
        id:col
        width: root.width
        anchors.horizontalCenter: root.horizontalCenter
        anchors.bottom: root.bottom
        anchors.bottomMargin: 5
        spacing: btnColumnSpacing
        RowLayout
        {
            id:row1
            Layout.alignment: Qt.AlignCenter
            spacing: btnRowSpacing
            //anchors.horizontalCenter: root.horizontalCenter
            Kb_Letter_Btn { text: shiftPressed?"Q":"q"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"W":"w"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"E":"e"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"R":"r"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"T":"t"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"Y":"y"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"U":"u"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"I":"i"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"O":"o"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"P":"p"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
        }

        RowLayout
        {
            id:row2
            Layout.alignment: Qt.AlignCenter
            spacing: btnRowSpacing
            //anchors.horizontalCenter: root.horizontalCenter
            Kb_Letter_Btn { text: shiftPressed?"A":"a"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"S":"s"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"D":"d"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"F":"f"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"G":"g"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"H":"h"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"J":"j"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"K":"k"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn { text: shiftPressed?"L":"l"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
        }

        RowLayout
        {
            Layout.alignment: Qt.AlignCenter
            spacing: btnRowSpacing+13
            Kb_Letter_Btn_Function {btn_name: "shift";onToggled: shiftPressed = !shiftPressed }

            RowLayout
            {
                id:row3
                Layout.alignment: Qt.AlignCenter
                spacing: btnRowSpacing
                //anchors.horizontalCenter: root.horizontalCenter
                Kb_Letter_Btn { text: shiftPressed?"Z":"z"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
                Kb_Letter_Btn { text: shiftPressed?"X":"x"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
                Kb_Letter_Btn { text: shiftPressed?"C":"c"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
                Kb_Letter_Btn { text: shiftPressed?"V":"v"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
                Kb_Letter_Btn { text: shiftPressed?"B":"b"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
                Kb_Letter_Btn { text: shiftPressed?"N":"n"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
                Kb_Letter_Btn { text: shiftPressed?"M":"m"; op: text;  Component.onCompleted: clicked.connect(buttonPressed)}
            }

            Kb_Letter_Btn_Function
            {
                btn_name: "back";
                op: btn_name;
                Component.onCompleted:
                {
                    btn_BackClick.connect(buttonPressed)

                    btn_BackHold.connect(btnBackHold)
                }
             }
         }

        Row
        {
            width: 480
            Layout.alignment: Qt.AlignLeft
            Layout.margins: 1
            spacing: btnRowSpacing
            Kb_Letter_Btn_Function {btn_name: "123"; text:"123";onBtnClick: {root.state = "inactive"; vk_num.state = "active"}}
            Kb_Letter_Btn{width:320;text: "-";op:"-";Component.onCompleted: clicked.connect(buttonPressed)}
            Kb_Letter_Btn_Function {width: 92; btn_name: "return"; text:"return";onBtnClick: {root.state = "inactive";btn_cancel.enabled = true;btn_next.enabled = true;}}
        }
    }

}
