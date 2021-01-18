import QtQuick 2.0
import QtQuick.Layouts 1.3


Rectangle
{
    id:root
    width: 480
    height: row_func.visible ? row_func.height + divider.height + col.height : col.height//row_func.height + divider.height + col.height
    color: clr_keybordNum_gray
    objectName: "Num_KeyPad"

    signal buttonPressed(string btnText)
    signal btnBackHold
    signal btn_switch2LetterPressed


    //property int movePos: container.objectName === "input_both" ? -45 : -33
    property int movePos: container.objectName === "input_both" ? -45 : 25 //input simple
    property alias btn_func_visible: row_func.visible
    //property var surface :page6//stack
    property var container:page6
    property bool haveDot:!row_func.visible

    parent: root.state === "active" ? container.contentItem : surface
    anchors.horizontalCenter: parent.horizontalCenter

    property Item surface: parent
    y: surface.height + myfooter.height


    state : "inactive"


   states: [
       State {
           name: "active"
           PropertyChanges { target: root; y: (surface.height- root.height - movePos + myfooter.height); z:1;}


       },
       State {
           name: "inactive"
           PropertyChanges { target: root; z:0;y:surface.height + myfooter.height}
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
       NumberAnimation {
           target: root
           property: "y"
           easing.type: "OutQuad"
           duration: 250
          }
   }


    function show(obj)
    {
        root.setFuncBtnVisible();
        root.state = "active"
    }

    function hide()
    {
       if(container.input_dist.focus)
           container.input_dist.focus = false;

       if(container.input_swing.focus)
           container.input_swing.focus = false;

       root.state = "inactive"
    }

    function setFuncBtnVisible()
    {
        var pos1 = container.input_dist.input_value.indexOf("f")
        var pos2 = container.input_dist.input_value.lastIndexOf("-")
        var pos3 = container.input_dist.input_value.indexOf("/")
        var pos4 = container.input_dist.input_value.indexOf("in");

        switch (container.input_dist.cursorPosition)
        {
        case pos1:
            btn_pre.opacity = 0;
            btn_nex.opacity = 1;
            break;

        case pos2:
            btn_pre.opacity = 1;
            btn_nex.opacity = 1;
            break;

        case pos3:
            btn_pre.opacity = 1;
            btn_nex.opacity = 1;
            break;

        case pos4:
            btn_pre.opacity = 1;
            btn_nex.opacity = 0;
            break;
        }
    }

    Row
    {
        id:row_func
        anchors.left: root.left
        visible: true
        Kb_Num_Btn
        {
            id:btn_pre
            text:"Previous";
            opacity: 0
            onBtnClick:
            {
                //myListView.decrementCurrentIndex()
                //console.log("container",container.input_dist.input_value)
                //console.log("current cursor",container.input_dist.cursorPosition)

                var pos1 = container.input_dist.input_value.indexOf("f")
                var pos2 = container.input_dist.input_value.lastIndexOf("-")
                var pos3 = container.input_dist.input_value.indexOf("/")
                var pos4 = container.input_dist.input_value.indexOf("in");

                switch (container.input_dist.cursorPosition)
                {
                case pos1:
                    btn_pre.opacity = 0;
                    btn_nex.opacity = 1;
                    break;

                case pos2:
                    container.input_dist.cursorPosition = pos1;
                    btn_pre.opacity = 0;
                    btn_nex.opacity = 1;
                    break;

                case pos3:
                    container.input_dist.cursorPosition = pos2;
                    btn_pre.opacity = 1;
                    btn_nex.opacity = 1;
                    break;

                case pos4:
                    container.input_dist.cursorPosition = pos3;
                    btn_pre.opacity = 1;
                    btn_nex.opacity = 1;
                    break;
                }
            }
        }
        Kb_Num_Btn
        {
            id:btn_nex
            text:"Next";
            //opacity: container.input_dist.cursorPosition === 9 ? 0 : 1
            onBtnClick:
            {
                var pos1 = container.input_dist.input_value.indexOf("f")
                var pos2 = container.input_dist.input_value.lastIndexOf("-")
                var pos3 = container.input_dist.input_value.indexOf("/")
                var pos4 = container.input_dist.input_value.indexOf("in");
                switch (container.input_dist.cursorPosition)
                {
                case pos1:
                    container.input_dist.cursorPosition = pos2;
                    btn_pre.opacity = 1;
                    btn_nex.opacity = 1;
                    break;

                case pos2:
                    container.input_dist.cursorPosition = pos3;
                    btn_pre.opacity = 1;
                    btn_nex.opacity = 1;
                    break;

                case pos3:
                    container.input_dist.cursorPosition = pos4;
                    btn_pre.opacity = 1;
                    btn_nex.opacity = 0;
                    break;

                case pos4:
                    btn_pre.opacity = 1;
                    btn_nex.opacity = 0;
                    break;
                }
            }
        }
    }

   // Kb_Num_Btn{anchors.top:row_func.top; anchors.right: root.right;text:"Done";onBtnClick: {root.state = "inactive";}}//btn_cancel.enabled = true;btn_next.enabled = true;}}


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
            Kb_Num_Btn{text:"±";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}

        }

        Row
        {
            Kb_Num_Btn{text:"7";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:"8";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:"9";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            //Kb_Num_Btn{text:".";visible:root.haveDot;btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            Kb_Num_Btn{text:root.haveDot?".":"";enabled: root.haveDot;btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
        }

        Row
        {

            Kb_Num_Btn{width:360;text:"0";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            //Kb_Num_Btn{width:120;text:"abc";btnOperator:text; Component.onCompleted: btnClick.connect(buttonPressed)}
            //Kb_Num_Btn{id:btn_switch2letter;width:120;text:"abc";Component.onCompleted:btnClick.connect(btn_switch2LetterPressed) ; }
            //Kb_Num_Btn{id:btn_switch2letter;visible: false;width:120;text:"abc";Component.onCompleted:btnClick.connect(btn_switch2LetterPressed) ; }  //20190530
            Kb_Num_Btn{width:120;text:"Done";onBtnClick:root.hide();}//btn_cancel.enabled = true;btn_next.enabled = true;}}
        }
    }
}



