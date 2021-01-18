import QtQuick 2.0

Rectangle
{
    id:root
//    width: 200
//    height: 100

//    property string ftValue: "3"
//    property string inchValue: "2 - 1/8"
//    property alias d2t: value

    property alias d2t: text_distance.text
    property alias d2t_color: text_distance.color
    property alias url_arrow: image.source
    property alias arrow_visable: image.visible
    property alias arrow_rotation: image.rotation
    property alias infotext_fontSize: text_distance_info.font.pixelSize
    property alias d2t_fontSize: text_distance.font.pixelSize

    Text {
        id: text_distance
        width: parent.width*3/4 -divider.anchors.leftMargin
        height: parent.height *3/4
        anchors.top: root.top
        anchors.left: root.left
        //anchors.right: divider.left
        anchors.bottom: image.bottom
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft//Text.AlignHCenter
        textFormat: Text.RichText
        fontSizeMode: Text.Fit
        minimumPixelSize: 1
        minimumPointSize: 1
        //font.pixelSize: 12
        font.bold: true
        //text: qsTr("<font size='6'>"+ ftValue + "</font>ft <font size='4'>"+ inchValue +"in</font>")

       /* text: qsTr("<html>
            <div style='font-size: 50px;'>3</div>ft 2-1/8in
        </html>")*/

        //text: qsTr("<html><div style='font-size: 20px;'>" + ftValue + "</div>ft <div style='font-size: 10px;'>" + inchValue + "</div>in</html>")

    }

    Text {
        id: text_distance_info
        width: parent.width*3/4 - divider.anchors.leftMargin
        height: parent.height *3/4
        anchors.top: text_distance.bottom
        anchors.left: text_distance.left
        //anchors.right: divider.left
        anchors.bottom: root.bottom
        //verticalAlignment: Text.AlignTop
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignLeft

        fontSizeMode: Text.Fit
        //fontSizeMode: Text.HorizontalFit
        minimumPixelSize: 1
        minimumPointSize: 1

        //font.pixelSize: text_distance.font.pixelSize/2
        textFormat: Text.RichText
        font.wordSpacing: 1
        text: qsTr("Distance to target line")
    }

    Rectangle {
        id: divider
        width: 1
        anchors.top: root.top
        anchors.bottom: root.bottom
        anchors.left: text_distance.right
        anchors.leftMargin: 5
        anchors.right: image.left
        anchors.rightMargin: 5
        visible: true//image.visible
        color: "black"
    }

    Image {
        id: image
        width: parent.width/4
        height: parent.height *3/4
        anchors.right: root.right
        anchors.top: root.top
        source: Qt.resolvedUrl("qrc:/Icons/explosionMark.svg")

        onSourceChanged:
        {
            if(image.source === "")
            {
                visible = false
            }
            else
                visible = true
        }

        onVisibleChanged:
        {
//            if(visible)
//            {
//                text_distance.anchors.right = divider.left
//                text_distance_info.anchors.right = divider.left
//            }
//            else
//            {
//                text_distance.anchors.right = root.right
//                text_distance_info.anchors.right = root.right
//            }
        }

    }

    Text {
        id: text_direction_info
        width: parent.width/4
        height: parent.height /4
        anchors.top: image.bottom
        anchors.left: image.left
        anchors.right: root.right

        anchors.bottom: root.bottom
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignLeft
        textFormat: Text.RichText

        fontSizeMode: Text.Fit
        //fontSizeMode: Text.HorizontalFit
        font.pixelSize: text_distance_info.font.pixelSize
        font.wordSpacing: 1
        minimumPixelSize: 1
        minimumPointSize: 1
        visible: image.visible

        text: qsTr("Direction to target")
    }
}
