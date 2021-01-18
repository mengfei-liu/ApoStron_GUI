import QtQuick 2.0

Rectangle
{
    id:page1
    width: 480
    height: 800
    signal timeout();

    Image {
        id: name
        y: 0
        z:0
        width: page1.width
        height: page1.height
        anchors.top: page1.top
        anchors.left: page1.left
        anchors.right: page1.right
        anchors.bottom: page1.bottom
        cache: false
        source: Qt.resolvedUrl("../Images/titlescreen.png")
        fillMode: Image.PreserveAspectFit
    }

    Text
    {
        anchors.bottom: page1.bottom
        anchors.bottomMargin: 10
        anchors.right: page1.right
        anchors.rightMargin: 10
        font.family: bodyFont.name
        font.pixelSize: 13
        color: "white"
        text:"Beta Release: "+ myVer + " Date: " + myVerDate
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Timer {
        id: splashTimer
        interval: 2000

        onTriggered:
        {
            visible = false
            page1.timeout();
        }
    }

    Component.onCompleted: splashTimer.start()

}
