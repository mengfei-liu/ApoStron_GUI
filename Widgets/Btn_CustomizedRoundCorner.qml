import QtQuick 2.0

Rectangle {
    id:root
    z:0
    color: mouseArea.pressed ? clr_black : "white"
    antialiasing: true
    //radius: 10

    //signal clicked();
    signal myBtnClicked();

    property alias text: btn_text.text
    property alias fontSize: btn_text.font.pointSize
    property alias fontBold: btn_text.font.bold

    property bool topLeftCorner: false
    property bool topRightCorner: false
    property bool bottomRightCorner: false
    property bool bottomLeftCorner: false

    Text {
        z:1
        id: btn_text
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: bodyFont.name
//        fontSizeMode: Text.Fit
//        minimumPixelSize: 1
//        minimumPointSize: 1
        color: mouseArea.pressed ? "white" : clr_black
    }

    MouseArea
    {
        id:mouseArea
        anchors.fill: parent
        onClicked:
        {
            //root.clicked();
            myBtnClicked();
        }
    }

    onTopLeftCornerChanged:
    {
        if(topLeftCorner)
        {
            rect_tl.color = "transparent"
            rect_tl.radius = radius
        }
        else
        {
            rect_tl.color = parent.color
            rect_tl.radius = 0
        }
    }

    onTopRightCornerChanged:
    {
        if(topRightCorner)
        {
            rect_tr.color = "transparent"
            rect_tr.radius = radius
        }
        else
        {
            rect_tr.color = parent.color
            rect_tr.radius = 0
        }
    }

    onBottomLeftCornerChanged:
    {
        if(bottomLeftCorner)
        {
            rect_bl.color = "transparent"
            rect_bl.radius = radius
        }
        else
        {
            rect_bl.color = parent.color
            rect_bl.radius = 0
        }
    }

    onBottomRightCornerChanged:
    {
        if(bottomRightCorner)
        {
            rect_br.color = "transparent"
            rect_br.radius = radius
        }
        else
        {
            rect_br.color = parent.color
            rect_br.radius = 0
        }
    }

    Rectangle
    {
        id:rect_tl
        z:0
        color: parent.color
        height: parent.height/2
        width: parent.width/2
        anchors.top: parent.top
        anchors.left:parent.left
        antialiasing: true
    }

    Rectangle
    {
        id:rect_tr
        z:0
        color: parent.color
        height: parent.height/2
        width: parent.width/2
        anchors.top: parent.top
        anchors.right: parent.right
        antialiasing: true
    }

    Rectangle
    {
        id:rect_bl
        z:0
        color: parent.color//"transparent"
        height: parent.height/2
        width: parent.width/2
        anchors.bottom: parent.bottom
        anchors.left:parent.left
        antialiasing: true
        //radius: 10
    }

    Rectangle
    {
        id:rect_br
        z:0
        color: parent.color
        height: parent.height/2
        width: parent.width/2
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        antialiasing: true
    }
}
