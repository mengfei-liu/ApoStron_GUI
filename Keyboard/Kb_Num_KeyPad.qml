import QtQuick 2.0
import QtQuick.Layouts 1.3


Rectangle
{
    id:root
    width: 480
    height: 301//row_func.height + divider.height + col.height
    color: clr_keybordNum_gray
    objectName: "Num_KeyPad"

    signal buttonPressed(string btnText)
    signal btnBackHold
    signal btn_switch2LetterPressed
    state: "inactive"

    property var surface :page3//stack
    property var container:page3

    parent: root.state === "active" ? container.contentItem : surface
    //property Item surface :parent//stack

    //property Item surface: parent.parent
    property alias btn_switch2Letter: btn_switch2letter
    property alias btn_func_visible: row_func.visible

    //y: surface.height + myfooter.height
   // y : surface.height
   anchors.horizontalCenter: parent.horizontalCenter
   //  anchors.horizontalCenter: parent.horizontalCenter

   // state: surface.activeFocus ? "active" : "inactive"


    function show(obj)
    {
        root.state = "active"
    }

    function hide()
    {
       root.state = "inactive"
    }


    onStateChanged:
    {
        console.log("container = ",container.objectName)
        console.log("surface = ",surface.objectName)
        console.log("container.height = ",container.height)
        console.log("y = ",root.y)

        console.log("input_distance.y = ",container.y)
    }


    states: [
        State {
            name: "active"
           // PropertyChanges { target: root; y: (window.height-myfooter.height - root.height ); z:1}

           // PropertyChanges { target: root; y: (container.height- root.height); z:1;}
            PropertyChanges { target: root; y: (surface.height- root.height - (surface.height - container.y - container.height)); z:1;}


        },
        State {
            name: "inactive"
            PropertyChanges { target: root; z:0;y:surface.height }

        }

    ]

//    states: [
//        State {
//            name: "active"
//            PropertyChanges { target: root; y: (surface.height - root.height ); z:1}
//        },
//        State {
//            name: "inactive"
//            PropertyChanges { target: root; y: surface.height;z:0}
//        }

//    ]

    transitions: Transition {
        id:keypad_animation
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
        visible: true
        Kb_Num_Btn
        {
            text:"Previous";
            onBtnClick:
            {
                myListView.decrementCurrentIndex()
            }
        }
        Kb_Num_Btn
        {
            text:"Next";
            onBtnClick:
            {
               if(myListView.currentIndex == 2 && myListView.contentItem.children[3].switch_mode_result == false)
               {
                   console.log("mode switch not enabled")
               }
               else
               {
                   myListView.incrementCurrentIndex()
               }
            }
        }
    }

    Kb_Num_Btn{anchors.top:row_func.top; anchors.right: root.right;text:"Done";onBtnClick: {root.state = "inactive";}}//btn_cancel.enabled = true;btn_next.enabled = true;}}


    Rectangle
    {
        id:divider
        width: root.width
        height: 1
        color: "white"
        visible: row_func.visible
        anchors.bottom: col.top
    }


    ColumnLayout
    {
        id:col
        width: root.width
        anchors.horizontalCenter: root.horizontalCenter
        anchors.bottom: root.bottom
        spacing: 0
        Row
        {
            Kb_Num_Btn{text:"1";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:"2";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:"3";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn
            {
                text:"back";btnOperator:text;
                Component.onCompleted:
                {   btnClick.connect(buttonPressed)
                    btnHold.connect(btnBackHold);
                }
            }
        }

        Row
        {
            Kb_Num_Btn{text:"4";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:"5";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:"6";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:".";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
        }

        Row
        {
            Kb_Num_Btn{text:"7";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:"8";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:"9";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:"±";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
        }

        Row
        {

            Kb_Num_Btn{width:360;text:"0";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            //Kb_Num_Btn{width:120;text:"abc";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{id:btn_switch2letter;width:120;text:"abc";Component.onCompleted:btnClick.connect(btn_switch2LetterPressed) ; }
        }
    }
}



