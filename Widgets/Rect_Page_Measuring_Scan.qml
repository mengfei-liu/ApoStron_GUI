import QtQuick 2.9
import "../JS/UnitConvert.js" as UC

Rectangle
{
    id:root
    color: "white"

    width: 480
    height: 415

    property alias clr_toleranceZone: zone_tolerance.color
    property alias arrow_rotation: pic_arrow.rotation
    property bool isDotInTorle: false
    property color clr_targetLine

    property double dtt: 0.0
    property double dtt_cal: 0.0
    property double scan_angle: 0.0
    property double dtr: 0.0

    property double dist_limit: 60 //-30 ~ 30
    property double angle_limit: 180 // -90 ~ 90

    property double object_radius: laser_dot.radius

    property double dir_x_ratio: (root.width - root.object_radius * 2) / angle_limit
    property double dir_y_ratio: (root.height- root.object_radius * 2) / dist_limit

    property bool is_dtt_display_bottom: false
    property bool is_dtt_display_left: false

    property double yPosition: 0.0

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
        if(pageModeSelection_Mode !== 2 || isDTRCorrect)
        {
            if(Math.abs(root.dtt) > 30 * tolerance_value)
            {
                root.dtt_cal = 30 * tolerance_value * (1 + (1.4 / Math.log(60.0)) * Math.log((Math.abs(root.dtt) / (30 * tolerance_value))) )

                if(root.dtt <0)
                    root.dtt_cal *= -1;
            }
            else
            {
                root.dtt_cal = root.dtt;
            }

            var y_pos;

            //y_pos = root.height / 2  + 90 / (30 * tolerance_value) * root.dtt_cal  - object_radius ; //20190615

           if(pageModeSelection_Mode === 7)
           {
               y_pos = root.height / 2  + 90 / (30 * tolerance_value) * -1 * root.dtt_cal  - object_radius ; //20190615
           }
           else
               y_pos = root.height / 2  + 90 / (30 * tolerance_value) * root.dtt_cal  - object_radius ; //20190615

            if(Math.abs(root.dtt) <= tolerance_value)
            {
                laser_dot.color = Qt.lighter("green")
                pic_arrow.source = Qt.resolvedUrl("qrc:/Icons/green_arrow.svg");
               // canvas_arrow.changeColor("green")
                isDotInTorle = 1;
                arrow_animation.stop();
                arrow_animation.start();
            }
            else
            {
                laser_dot.color = "red"
                pic_arrow.source = Qt.resolvedUrl("qrc:/Icons/red_arrow.svg");
                isDotInTorle = 0
               // canvas_arrow.changeColor("red")
                arrow_animation.stop();
                arrow_animation.start();

            }

            if(pageModeSelection_Mode === 7)
            {
                if(y_pos<object_radius)
                {
                    y_pos = root.height-object_radius;
                }
                else if(y_pos > (root.height-object_radius))
                {
                    y_pos = 0
                }
            }
            else
            {
                if(y_pos<object_radius)
                {
                    y_pos = 0;
                }
                else if(y_pos > (root.height-object_radius))
                {
                    y_pos = root.height-object_radius
                }
            }


            y_animation.to = y_pos;

            y_animation.start();


            if(root.dtt < 0 )
            {
                is_dtt_display_bottom = true;
              //  canvas_arrow.downArrow();

                pic_arrow.rotation = 180;
                pic_arrow.rotation = pic_arrow.rotation
            }
            else
            {
                is_dtt_display_bottom = false;
             //   canvas_arrow.upArrow();

                pic_arrow.rotation = 0;
                pic_arrow.rotation = pic_arrow.rotation
            }
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

        //text_angle.text = "Rotation: " + scan_angle.toFixed(2).toString() + " \xB0"
        text_angle.text = "Rotation: " + String(UC.toFixed(scan_angle,2))+ " \xB0"
    }

    onDtrChanged:
    {
        if(pageModeSelection_Mode === 2 && !isDTRCorrect)
        {
            if(Math.abs(root.dtr) > 30 * tolerance_value)
            {
                root.dtt_cal = 30 * tolerance_value * (1 + (1.4 / Math.log(60.0)) * Math.log((Math.abs(root.dtr) / (30 * tolerance_value))) )

                if(root.dtr <0)
                    root.dtt_cal *= -1;
            }
            else
            {
                root.dtt_cal = root.dtr;
            }

            var y_pos;

            y_pos = root.height / 2  + 90 / (30 * tolerance_value) * root.dtt_cal  - object_radius ; //20190615

            if(Math.abs(root.dtr) <= tolerance_value)
            {
                laser_dot.color = Qt.lighter("green")
               // canvas_arrow.changeColor("green")
                isDotInTorle = 1;
                arrow_animation.stop();
                pic_arrow.opacity = 0;
                arrow_animation.start();
            }
            else
            {
                laser_dot.color = "red"
                isDotInTorle = 0
               // canvas_arrow.changeColor("red")
                arrow_animation.stop();
                pic_arrow.opacity = 0;
                arrow_animation.start();

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


            if(root.dtr < 0 )
            {
                is_dtt_display_bottom = true;
              //  canvas_arrow.downArrow();

                pic_arrow.rotation = 180;
                pic_arrow.rotation = pic_arrow.rotation
            }
            else
            {
                is_dtt_display_bottom = false;
             //   canvas_arrow.upArrow();

                pic_arrow.rotation = 0;
                pic_arrow.rotation = pic_arrow.rotation
            }
        }

    }


    Rectangle
    {
        id:zone_tolerance
        width: root.width
        height: 100
        anchors.verticalCenter: root.verticalCenter

        Text {
            anchors.top: zone_tolerance.top
            anchors.topMargin: 10
            anchors.right: zone_tolerance.right
            anchors.rightMargin: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.Fit
            minimumPixelSize: 1
            minimumPointSize: 1
            font.family: bodyFont.name
            font.pointSize: fsize_3xs
            font.bold: false
            textFormat: Text.RichText
            color: clr_gray2
            text: qsTr("Tolerance Zone")
        }

        Row {
            id:targetLine
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: (root.width - 20*15) / 19
            Repeater {
                id:dash
                model: 20
                Rectangle {
                    width: 15; height: 8
                    color: clr_targetLine
                }
            }
        }

        Text {
            anchors.top: targetLine.top
            anchors.topMargin: 10
            anchors.left: targetLine.left
            anchors.leftMargin: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            fontSizeMode: Text.Fit
            minimumPixelSize: 1
            minimumPointSize: 1
            font.family: bodyFont.name
            font.pointSize: fsize_3xs
            font.bold: false
            textFormat: Text.RichText
            color: clr_gray2
            text: qsTr("Target Line")
        }
    }

    Image {
        id: pic_tripod
        width: 60
        height: width
        anchors.bottom: root.bottom
        anchors.bottomMargin: 5
        anchors.horizontalCenter: root.horizontalCenter
       // fillMode: Image.PreserveAspectFit
        source: Qt.resolvedUrl("qrc:/Icons/tripod.png")
    }



    Text
    {
        id:text_angle
        anchors.left: pic_tripod.right
        anchors.leftMargin: 5
        anchors.verticalCenter: pic_tripod.verticalCenter
        font.family: bodyFont.name
        font.pointSize:12
        font.bold: true

        color: "black"

        text:"Rotation: " + String(UC.toFixed(scan_angle,2)) + " \xB0"
        //text:"Rotation: " + scan_angle.toFixed(2).toString() + " \xB0"

    }

    Image
    {
        id:pic_arrow
        width: 60
        height: width
        anchors.right: root.right
        anchors.rightMargin: 15
        anchors.bottom: text_arrow.top
        anchors.topMargin: 5
        source: laser_dot.color === "red" ? Qt.resolvedUrl("qrc:/Icons/red_arrow.svg") : Qt.resolvedUrl("qrc:/Icons/green_arrow.svg")
    }

    NumberAnimation
    {
        id:arrow_animation
        target: pic_arrow
        properties: "opacity"
        duration: 1500
        running: false
        loops: Animation.Infinite
        from: 1
        to:0
        easing.type: Easing.InOutQuad
    }

    Text {
        id: text_arrow
        text: qsTr("Direction")
        anchors.horizontalCenter: pic_arrow.horizontalCenter
        anchors.bottom: root.bottom
        anchors.bottomMargin: 10
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: bodyFont.name
        font.pointSize: fsize_3xs
        font.bold: false
    }

    Rectangle
    {
        id:laser_dot
        width: 15
        height: 15
        color: "red"
        border.color: "white"
        border.width: 2
        x:100
        y:300
        radius:height/2

        property double center_coord_X: x + width/2
        property double center_coord_Y: y + height/2

        NumberAnimation on x
        {
            id:x_animation
            duration:1
            easing.type:Easing.Linear
        }

        NumberAnimation on y
        {
            id:y_animation
            duration:1
            easing.type:Easing.Linear
        }

        onXChanged: canvas.requestPaint()
        onYChanged: canvas.requestPaint()
    }


    Canvas {
           id: canvas
           anchors.fill: parent
           antialiasing: true
           smooth: true

           property real start_x: pic_tripod.x + pic_tripod.width/2
           property real start_y: pic_tripod.y
           property real end_x: laser_dot.center_coord_X
           property real end_y: laser_dot.center_coord_Y
           property bool dashed: true
           property real dash_length: 3
           property real dash_space: 3
           property real line_width: 2
           property real stipple_length: (dash_length + dash_space) > 0 ? (dash_length + dash_space) : 16
           property color draw_color: laser_dot.color


           onPaint:
           {
               var ctx = canvas.getContext('2d')
                    ctx.clearRect(0, 0, canvas.width, canvas.height)
                   // set line color
                   ctx.strokeStyle = draw_color;
                   ctx.lineWidth = line_width;
                   ctx.beginPath();

                   if (!dashed)
                   {
                       ctx.moveTo(start_x,start_y);
                       ctx.lineTo(end_x,end_y);
                   }
                   else
                   {
                       var dashLen = stipple_length;
                       var dX = end_x - start_x;
                       var dY = end_y - start_y;
                       var dashes = Math.floor(Math.sqrt(dX * dX + dY * dY) / dashLen);
                       if (dashes == 0)
                       {
                           dashes = 1;
                       }
                       var dash_to_length = dash_length/dashLen
                       var space_to_length = 1 - dash_to_length
                       var dashX = dX / dashes;
                       var dashY = dY / dashes;
                       var x1 = start_x;
                       var y1 = start_y;

                       ctx.moveTo(x1,y1);

                       var q = 0;
                       while (q++ < dashes) {
                           x1 += dashX*dash_to_length;
                           y1 += dashY*dash_to_length;
                           ctx.lineTo(x1, y1);
                           x1 += dashX*space_to_length;
                           y1 += dashY*space_to_length;
                           ctx.moveTo(x1, y1);

                       }

                   }
                   ctx.stroke();
           }
    }

    Text
    {
        id: dtt_display

        font.family: bodyFont.name
        font.pointSize:12
        font.bold: true

        color:clr_black
        state:"top_left"

        text:
        {

            if(pageModeSelection_Mode === 2 && !isDTRCorrect)
            {
                if(is_Unit_Imperial)
                {
                    "DTR: " + UC.m2fractional_Ft_Inches(dtr);
                }
                else
                {
//                    if(Math.abs(dtt)>1)
//                    {
//                        //"DTR: "+ dtr.toFixed(2).toString() + " m"
//                        "DTR: "+ String(UC.toFixed(dtr,2))+ " m"
//                    }
//                    else
//                    {
//                        //"DTR: "+ (dtr * 100).toFixed(2).toString() + " cm"
//                        "DTR: "+ String(UC.toFixed(dtr*100,2))+ " cm"
//                    }
                    "DTR: "+ String(UC.toFixed(dtr,3))+ " m"
                }
            }
            else
            {
                if(is_Unit_Imperial)
                {
//                    if(pageModeSelection_Mode === 1)
//                    {
//                        "DTT: " + UC.m2fractional_Ft_Inches(-1 * dtt);
//                    }
//                    else
//                    {
//                       "DTT: " + UC.m2fractional_Ft_Inches(dtt);
//                    }
                    "DTT: " + UC.m2fractional_Ft_Inches(dtt);
                }
                else
                {
//                    if(pageModeSelection_Mode === 1)
//                    {
//                       "DTT: "+ String(UC.toFixed(-1 * dtt,2)) + " " + unit_dist
//                    }
//                    else
//                    {
//                       "DTT: "+ String(UC.toFixed(dtt,2)) + " " + unit_dist
//                    }
                    "DTT: "+ String(UC.toFixed(dtt,2)) + " " + unit_dist
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
                    anchors.left:  laser_dot.right
                    anchors.top: laser_dot.top
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
                    anchors.right:  laser_dot.left
                    anchors.top: laser_dot.top
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
                    anchors.left:  laser_dot.right
                    anchors.top: laser_dot.top
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
                    anchors.right:  laser_dot.left
                    anchors.top: laser_dot.top
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



//    MouseArea
//    {
//        anchors.fill: parent
//        onClicked:
//        {
//            laser_dot.x += 5
//            laser_dot.y += 3

//            canvas.requestPaint();
//        }
//    }

}
