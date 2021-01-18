import QtQuick 2.0
import "../JS/UnitConvert_toM.js" as Ft2m
import "../JS/UnitConvert_toFt.js" as M2ft
import "../JS/UnitConvert.js" as Unit



Rectangle
{
    id:root
    //width: 480
    //height: 550
    border.color: "black"
    border.width: 2
    color: Qt.lighter("gray")
    clip: true
    antialiasing: true

    property alias target_height: target.height

    property double dtt: 0.0
    property double dtt_cal: 0.0
    property double scan_angle: 0.0
    property double dtr: 0.0

    property double dist_limit: 60 //-30 ~ 30
    property double angle_limit: 180 // -90 ~ 90

    property double object_radius: object_laser.radius

    property double dir_x_ratio: (root.width - root.object_radius * 2) / angle_limit
    property double dir_y_ratio: (root.height- root.object_radius * 2) / dist_limit

    property bool is_dtt_display_bottom: false
    property bool is_dtt_display_left: false

    property double yPosition: 0.0

    width: 480
    height: 450

//    Component.onCompleted:
//    {
//        dtt = 12.5;
//    }

    onIs_dtt_display_bottomChanged:
    {
        if(is_dtt_display_bottom && is_dtt_display_left)
        {
            dtt_display.state = "bottom_left"
        }
        else if(is_dtt_display_bottom && !is_dtt_display_left)
        {
            dtt_display.state = "bottom_right"
        }
        else if(!is_dtt_display_bottom && is_dtt_display_left)
        {
            dtt_display.state = "top_left"
        }
        else if(!is_dtt_display_bottom && !is_dtt_display_left)
        {
            dtt_display.state = "top_right"
        }
    }

    onIs_dtt_display_leftChanged:
    {
        if(is_dtt_display_bottom && is_dtt_display_left)
        {
            dtt_display.state = "bottom_left"
        }
        else if(is_dtt_display_bottom && !is_dtt_display_left)
        {
            dtt_display.state = "bottom_right"
        }
        else if(!is_dtt_display_bottom && is_dtt_display_left)
        {
            dtt_display.state = "top_left"
        }
        else if(!is_dtt_display_bottom && !is_dtt_display_left)
        {
            dtt_display.state = "top_right"
        }
    }

    onDttChanged:
    {
        if(Math.abs(root.dtt) > 30 * tolerance_value)
        {
            if(root.dtt > 0 )
            {
                root.dtt_cal = 30 * tolerance_value * (1 + (1.4 / Math.log(60.0)) * Math.log((Math.abs(root.dtt) / (30 * tolerance_value))) )

            }

            if(root.dtt < 0)
            {
                root.dtt_cal = -30 * tolerance_value * (1 + (1.4 / Math.log(60.0)) * Math.log((Math.abs(root.dtt) / (30 * tolerance_value))) )

            }
        }
        else
        {
            root.dtt_cal = root.dtt;
        }


        var y_pos;

        //y_pos = -90 / (30 * tolerance_value) * root.dtt_cal + root.height / 2 - object_radius ;

        y_pos = root.height / 2  - 90 / (30 * tolerance_value) * root.dtt_cal  - object_radius ;

        if(Math.abs(root.dtt) <= tolerance_value)
        {
            object_laser.color = Qt.lighter("green")
           // canvas_arrow.changeColor("green")
            arrow_r_animation.stop();
            arrow_r.opacity = 0;
            arrow_g_animation.start();
        }
        else
        {
            object_laser.color = "red"
           // canvas_arrow.changeColor("red")
            arrow_g_animation.stop();
            arrow_g.opacity = 0;
            arrow_r_animation.start();

        }

        if(y_pos<object_radius)
        {
            y_pos = 0;
        }
        else if(y_pos > (root.height-object_radius))
        {
            y_pos = root.height-object_radius
        }

        y_animation.to = y_pos;

        y_animation.start();


        if(root.dtt < 0 )
        {
            is_dtt_display_bottom = true;
          //  canvas_arrow.downArrow();

            arrow_r.rotation = 180;
            arrow_g.rotation = arrow_r.rotation
        }
        else
        {
            is_dtt_display_bottom = false;
         //   canvas_arrow.upArrow();

            arrow_r.rotation = 0;
            arrow_g.rotation = arrow_r.rotation
        }
    }

    onScan_angleChanged:
    {
        var x_pos;

        if(Math.abs(root.scan_angle) <= 90)
        {
            x_pos =  (root.scan_angle + 90) * root.dir_x_ratio - object_radius;


        }
        else
        {
            if(root.scan_angle > 90)
                x_pos = root.width - object_radius*2
            else if(root.scan_angle < -90)
                x_pos = 0
        }


        x_animation.to = x_pos;
        x_animation.start();


        if(root.scan_angle < 0 )
        {
            is_dtt_display_left = true;
        }
        else
        {
            is_dtt_display_left = false;
        }

        text_angle.text = "Rotation: " + scan_angle.toFixed(2).toString() + " \xB0"
    }

    onDtrChanged:
    {
//        dtr = mySerialThread.dtr.toFixed(2);

//        if(is_Unit_Imperial)
//        {
//            text_DTR.text = "Pivot to Ref.: "+ Number(M2ft.m2ft(dtr)).toFixed(2).toString() +" "+  unit_dist;
//        }
//        else
//        {
//            text_DTR.text = "Pivot to Ref.: "+ dtr.toFixed(2).toString() +" "+  unit_dist;
//        }

    }

    Text
    {
        id:text_angle
        anchors.left: canvas_triangle.right
        anchors.leftMargin: 20
        anchors.bottom: canvas_triangle.bottom
        font.family: bodyFont.name
        font.pointSize:12
        font.bold: true

        color: "white"

        text:"Rotation: " + scan_angle.toFixed(2).toString() + " \xB0"
    }

    Text {
        anchors.verticalCenter: rect_arrow.verticalCenter
        anchors.right: rect_arrow.left
        font.family: bodyFont.name
        font.pointSize:12
        font.bold: true
        color:"white"
        //text: qsTr("Move Rig To: ")
        text: qsTr("Rig move direction: ")
    }

    Rectangle
    {
        id:rect_arrow
        anchors.top: root.top
        anchors.topMargin: 3
        anchors.right: root.right
        anchors.rightMargin: 3
        height: 50
        width: 50
        color: "transparent"       

        Image {
            id: arrow_r
            anchors.right: parent.right
            anchors.top: parent.top
            width: 50
            height:50
            cache: false
            antialiasing: true
            source: Qt.resolvedUrl("qrc:/Icons/arrow_r.png")
            fillMode: Image.PreserveAspectFit
            opacity: 0
        }

        Image {
            id: arrow_g
            anchors.right: parent.right
            anchors.top: parent.top
            width: 50
            height: 50
            cache: false
            antialiasing: true
            source: Qt.resolvedUrl("qrc:/Icons/arrow_g.png")
            fillMode: Image.PreserveAspectFit
            opacity: 0
        }

        NumberAnimation
        {
            id:arrow_r_animation
            target: arrow_r
            properties: "opacity"
            duration: 1500
            running: false
            loops: Animation.Infinite
            from: 1
            to:0
            easing.type: Easing.InOutQuad


        }

        NumberAnimation
        {
            id:arrow_g_animation
            target: arrow_g
            properties: "opacity"
            duration: 1500
            running: false
            loops: Animation.Infinite
            from: 1
            to:0
            easing.type: Easing.InOutQuad


        }

/*        SequentialAnimation
        {
                id:arrow_r_show
                running: false

                onRunningChanged:
                {

                }
                NumberAnimation
                {
                    target: arrow_g;
                    property: "opacity";
                    from:1
                    to: 0;
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation
                {
                    target: arrow_r;
                    property: "opacity";
                    from:0
                    to: 1;
                    duration: 1000
                    loops: Animation.Infinite
                    easing.type: Easing.InOutQuad
                }
         }

        SequentialAnimation
        {
                id:arrow_g_show
                running: false
                NumberAnimation
                {
                    target: arrow_r;
                    property: "opacity";
                    from:1
                    to: 0;
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation
                {
                    target: arrow_g;
                    property: "opacity";
                    from:0
                    to: 1;
                    duration: 1000
                    loops: Animation.Infinite
                    easing.type: Easing.InOutQuad
                }
         }*/

    }
    Canvas
    {
        id:canvas_triangle
        width: 30
        height: 30
        anchors.horizontalCenter: root.horizontalCenter
        anchors.bottom: root.bottom
        anchors.bottomMargin: 10
        antialiasing: true
        transformOrigin: Item.Center
        renderTarget:Canvas.Image

        rotation: root.scan_angle /2

        onPaint:
        {
            var ctx = getContext("2d");

            ctx.lineWidth = 1;

            ctx.fillStyle =  Qt.rgba(0, 0, 0, 1);
            ctx.strokeStyle = Qt.rgba(0, 0, 0, 1);

            ctx.beginPath();
            ctx.moveTo(15,0);
            ctx.lineTo(0,30);
            ctx.lineTo(30,30)
            ctx.lineTo(15,0);
            ctx.closePath();
            ctx.stroke();
            ctx.fill();

            ctx.lineWidth = 1;
            ctx.strokeStyle = Qt.rgba(1,0,0,1);
            ctx.fillStyle = Qt.rgba(1,0,0,1);
            ctx.beginPath();
            ctx.moveTo(15,0);
            ctx.lineTo(10,10);//a
            ctx.lineTo(20,10);//b
            ctx.lineTo(15,0);
            ctx.closePath();
            ctx.stroke();
            ctx.fill();

         }
    }

  /*  Canvas
    {
        id:canvas_arrow
        x: 346
        y: 45
        width: 60
        height: 60
        antialiasing: true
        transformOrigin: Item.Center


        onPaint:
        {

        }
        function changeColor(color)
        {
            var ctx = getContext("2d");
            ctx.fillStyle =  color
            ctx.strokeStyle = color
            ctx.stroke();
            ctx.fill();
            canvas_arrow.requestPaint();
        }

        function clear_canvas()
        {
            var ctx = getContext("2d");
            ctx.reset();
            canvas_arrow.requestPaint();
        }

        function upArrow()
        {
            clear_canvas();
            var ctx = getContext("2d");
            ctx.lineWidth = 1;
//            ctx.fillStyle =  Qt.rgba(0, 0, 0, 1);
//            ctx.strokeStyle = Qt.rgba(0, 0, 0, 1);
            ctx.fillStyle =  "green"
            ctx.strokeStyle = "green"
            ctx.beginPath();
            ctx.moveTo(canvas_arrow.width/2,0);
            ctx.lineTo(0,canvas_arrow.height);
            ctx.lineTo(canvas_arrow.width/2,2 * canvas_arrow.height / 3)
            ctx.lineTo(canvas_arrow.width,canvas_arrow.height);
            ctx.lineTo(canvas_arrow.width/2,0);
            ctx.closePath();
            ctx.stroke();
            ctx.fill();
            canvas_arrow.requestPaint();
        }

        function downArrow()
        {
            clear_canvas();
            var ctx = getContext("2d");

            ctx.lineWidth = 1;

//            ctx.fillStyle =  Qt.rgba(0, 0, 0, 1);
//            ctx.strokeStyle = Qt.rgba(0, 0, 0, 1);
            ctx.fillStyle =  "red"
            ctx.strokeStyle = "red"

            ctx.beginPath();
            ctx.moveTo(canvas_arrow.width/2,canvas_arrow.height);
            ctx.lineTo(canvas_arrow.width,0);
            ctx.lineTo(canvas_arrow.width/2,canvas_arrow.height / 3)
            ctx.lineTo(0,0);
            ctx.lineTo(canvas_arrow.width/2,canvas_arrow.height);
            ctx.closePath();
            ctx.stroke();
            ctx.fill();
            canvas_arrow.requestPaint();
        }
    }*/


//    Text {
//        id: text_DTR

//        anchors.horizontalCenter: root.horizontalCenter

////        anchors.top: root.top
////        anchors.topMargin: 5
//        anchors.bottom: root.top

//        font.family: bodyFont.name
//        font.pointSize:12
//        font.bold: true

//        color:"red"
//        /*anchors.top:root.top
//        anchors.topMargin: 5
//        anchors.left: root.left
//        anchors.leftMargin: 5*/
//        verticalAlignment: Text.AlignVCenter
//        horizontalAlignment: Text.AlignHCenter
//        text: is_Unit_Imperial ? "Pivot to Ref.: "+ Number(M2ft.m2ft(dtr)).toFixed(2).toString() +" "+  unit_dist : "Pivot to Ref.: "+ dtr.toFixed(2).toString() + " " + unit_dist
//        //text: is_Unit_Imperial ? "DTR: "+ Number(M2ft.m2ft(dtr)).toFixed(2).toString() +" "+  unit_dist : "DTR: "+ dtr.toFixed(2).toString() + " " + unit_dist

//    }



    Rectangle
    {
        id:target
        width: root.width - 4
        height: 180
        color: "orange"
        anchors.verticalCenter: root.verticalCenter
        anchors.horizontalCenter: root.horizontalCenter
        border.color: "white"
        border.width: 1

        Rectangle
        {
            y: 0
            width: target.width
            height: 6
            color: "green"
            anchors.verticalCenter: target.verticalCenter
            anchors.horizontalCenter: target.horizontalCenter
        }


/*
        Text {
            id: angle_zero
            //text: yPosition.toString();
            font.family: bodyFont.name
            font.pointSize:12
            font.bold: true
            color:Qt.lighter("white")
            anchors.verticalCenter: target.verticalCenter
            anchors.horizontalCenter: target.horizontalCenter
        }

       Text {
            id: angle_90_negtive
            text: qsTr("-90\xB0")
            font.family: bodyFont.name
            font.pointSize:12
            font.bold: true
            color:Qt.lighter("white")
            anchors.verticalCenter: target.verticalCenter
            anchors.left: target.left
            anchors.leftMargin: 5
        }

        Text {
            id: angle_90
            text: qsTr("90\xB0")
            font.family: bodyFont.name
            font.pointSize:12
            font.bold: true
            color:Qt.lighter("white")
            anchors.verticalCenter: target.verticalCenter
            anchors.right:target.right
        }*/
    }

    Text
    {
        id: dtt_display

        font.family: bodyFont.name
        font.pointSize:12
        font.bold: true

        color:Qt.lighter("white")

     //   anchors.left: object_laser.right
      //  anchors.leftMargin: 10
        state:"top_left"

       // text: is_Unit_Imperial ? "DTT: "+ Number(M2ft.m2ft(dtt)).toFixed(2).toString() +" "+  unit_dist : "DTT: "+ dtt.toFixed(2).toString() + " " + unit_dist
        text:
        {
            if(is_Unit_Imperial)
            {
                if(Math.abs(Number(Unit.m2ft(dtt)))>1)
                {
                   //"DTT: "+ Number(Unit.m2ft(dtt)).toFixed(2).toString() +" "+  unit_dist;
                    "DTT: " + Unit.m2ft_inches(dtt);
                }
                else
                {
                   //"DTT: "+ Number(Unit.m2Inch(dtt)).toFixed(2).toString() +" in"
                    "DTT: " + Unit.m2fractionalInches(dtt);
                }

            }
            else
            {
                if(Math.abs(dtt)>1)
                {
                    "DTT: "+ dtt.toFixed(2).toString() + " " + unit_dist
                }
                else
                {
                    "DTT: "+ (dtt * 100).toFixed(2).toString() + " cm"
                }
            }
        }




        states:
        [
            State
            {
                name:"top_left"
                AnchorChanges
                {
                    target: dtt_display
                    anchors.left:  object_laser.right
                    anchors.top: object_laser.top
                }
                PropertyChanges
                {
                    target: dtt_display;
                    anchors.leftMargin: 10
                    anchors.topMargin: 5
                }
            },

            State
            {
                name:"top_right"
                AnchorChanges
                {
                    target: dtt_display
                    anchors.right:  object_laser.left
                    anchors.top: object_laser.top
                }
                PropertyChanges
                {
                    target: dtt_display;
                    anchors.rightMargin: 10
                    anchors.topMargin: 5
                }
            },

            State
            {
                name:"bottom_left"
                AnchorChanges
                {
                    target: dtt_display
                    anchors.left:  object_laser.right
                    anchors.top: object_laser.top
                }
                PropertyChanges
                {
                    target: dtt_display;
                    anchors.leftMargin: 10
                    anchors.topMargin: -5
                }
            },

            State
            {
                name:"bottom_right"
                AnchorChanges
                {
                    target: dtt_display
                    anchors.right:  object_laser.left
                    anchors.top: object_laser.top
                }
                PropertyChanges
                {
                    target: dtt_display;
                    anchors.rightMargin: 10
                    anchors.topMargin: -5
                }

            }
        ]

        transitions: Transition {
                // smoothly reanchor myRect and move into new position
                AnchorAnimation { duration: 80 }
            }
    }

    Rectangle
    {
        id:object_laser
        width: 15
        height: 15
        color: "red"
        border.color: "white"
        border.width: 2

        radius:height/2

        property double center_coord_X: x + width/2
        property double center_coord_Y: y + height/2

        NumberAnimation on x
        {
            id:x_animation
            duration:17
        }

        NumberAnimation on y
        {
            id:y_animation
            duration:17

        }
    }
}
