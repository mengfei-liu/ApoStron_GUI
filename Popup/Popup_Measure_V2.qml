import QtQuick 2.0

Rectangle
{
    id:root

//    property string ftValue: "3"
//    property string inchValue: "2 - 1/8"
//    property alias d2t: value

    property alias d2t: text_distance.text
    property alias d2t_info: text_distance_info.text
    property alias d2t_color: text_distance.color
    property bool arrow_visable

    property alias url_arrow: image.source
    property alias url_arrow_rotation: image.rotation
    property alias infotext_fontSize: text_distance_info.font.pixelSize
    property alias d2t_fontSize: text_distance.font.pixelSize

    state: "false"

    onArrow_visableChanged:
    {
        if(arrow_visable)
        {
//            text_distance.width = root.width *3/4
//            text_distance.anchors.right = divider.left
//            text_distance.horizontalAlignment = Text.AlignLeft
//            text_direction_info.visible = true
//            text_distance_info.anchors.right = text_distance.anchors.right
//            text_distance_info.horizontalAlignment = Text.AlignLeft
//            rect_pic.visible = true
//            divider.visible = true
            state = "true"
        }
        else
        {

//            text_distance.width = root.width
//            text_distance.anchors.right = root.right
//            text_distance.horizontalAlignment = Text.AlignHCenter
//             text_distance_info.anchors.right = text_distance.anchors.right
//            text_distance_info.horizontalAlignment = Text.AlignHCenter
//            text_direction_info.visible = false
//            rect_pic.visible = false
//            divider.visible = false

            state = "false"
        }
    }

    states:
    [
        State
        {
            name:"true"
            PropertyChanges {
                target: text_distance;
                width:root.width * 3 / 4
                //anchors.right:  divider.left
                anchors.left: root.left
                //horizontalAlignment:Text.AlignLeft
                horizontalAlignment:Text.AlignHCenter
                font.pixelSize: fsize_med +  8
                minimumPixelSize: fsize_med - 5
                fontSizeMode: Text.Fit
            }
            PropertyChanges {
                target: text_distance_info
                width:root.width * 3 / 4
                text: qsTr("Distance to target line")
                visible:true;
                anchors.right : text_distance.right
                //horizontalAlignment : Text.AlignLeft
                horizontalAlignment:Text.AlignHCenter
            }
            PropertyChanges {
                target: text_direction_info
                text: qsTr("Direction to target")
                visible:true;
                anchors.top: text_distance_info.top
                anchors.left: divider.right
                anchors.leftMargin: 5
                anchors.right: root.right
                anchors.bottom: root.bottom
            }
            PropertyChanges {
                target: rect_pic;visible:true;

            }
            PropertyChanges {
                target: divider;visible:true;

            }
        },

        State
        {
            name:"false"
            PropertyChanges {
                target: text_distance;
                width:root.width
                anchors.right:  root.right
                horizontalAlignment:Text.AlignHCenter

                font.pixelSize: fsize_large
                minimumPixelSize: fsize_med - 5
                fontSizeMode: Text.Fit
            }
            PropertyChanges {
                target: text_distance_info
                width:text_distance.width
                visible:true;
                anchors.right : root.right
                horizontalAlignment : Text.AlignHCenter
            }
            PropertyChanges {
                target: text_direction_info
                visible:false;
            }
            PropertyChanges {
                target: rect_pic;visible:false;

            }
            PropertyChanges {
                target: divider;visible:false;

            }
        }

    ]

    Text {
        id: text_distance
        width:  root.state === "true" ? root.width * 3/ 4 : root.width
        height: parent.height *3/4

        anchors.top: root.top
        anchors.left: root.left
        anchors.right: divider.left
        anchors.rightMargin: 5

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter//Text.AlignHCenter

        textFormat: Text.RichText
        wrapMode: Text.NoWrap
        //fontSizeMode: Text.Fit
       // minimumPixelSize: 1
        //minimumPointSize: 1
        font.family: bodyFont.name
        font.bold: true
        text: "abc"

    }

    Text {
        id: text_distance_info
        height: root.height /4
        width: text_distance.width
        anchors.top: text_distance.bottom
        anchors.left: root.left
        //anchors.right: text_distance.right
        anchors.bottom: root.bottom
        //verticalAlignment: Text.AlignTop
        verticalAlignment: Text.AlignVCenter
        //horizontalAlignment: Text.AlignLeft

        fontSizeMode: Text.Fit
        //fontSizeMode: Text.HorizontalFit
        minimumPixelSize: 1
        minimumPointSize: 1

        //font.pixelSize: text_distance.font.pixelSize/2
        textFormat: Text.RichText
        font.family: bodyFont.name
        font.pixelSize: fsize_xs -2
        font.wordSpacing: 1
        text: qsTr("Distance to target line")
    }

    Rectangle {
        id: divider
        width: 1
        height: root.height
        x:root.width *4 / 7
        visible: true//image.visible
        color: "black"
    }

    Rectangle
    {
        id:rect_pic
        height: root.height *3/4
        anchors.top: root.top
        anchors.left: divider.right
        anchors.right: root.right
        anchors.bottom: text_direction_info.top

        Image {
            id: image
    //        width: parent.width/4
            height: 80
            width: 80
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: rect_pic.horizontalCenter
            source: Qt.resolvedUrl("qrc:/Icons/explosionMark.svg")
            visible: true

        }

    }


    Text {
        id: text_direction_info
        width: rect_pic.width/4
        height: root.height /4
        anchors.top: text_distance_info.top
        anchors.left: divider.right
        anchors.leftMargin: 5
        anchors.right: root.right
        anchors.bottom: root.bottom
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        textFormat: Text.RichText
        font.family: bodyFont.name
        font.pixelSize: fsize_xs -2
        fontSizeMode: Text.Fit
        //fontSizeMode: Text.HorizontalFit
        //font.pixelSize: text_distance_info.font.pixelSize
        font.wordSpacing: 1
        minimumPixelSize: 1
        minimumPointSize: 1
        visible: image.visible

        text: qsTr("Direction to target")
    }
}
