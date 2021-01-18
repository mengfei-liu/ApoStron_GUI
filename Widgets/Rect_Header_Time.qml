import QtQuick 2.0
import QtQml 2.2

Rectangle
{
    id:root
    color: "transparent"
    width: parent.width/2
    height: parent.height/2

    property var locale: Qt.locale()
    property date currentTime: new Date()
    property string timeString
    property string dateString

    Component.onCompleted:
    {
//        timeString = currentTime.toLocaleTimeString(locale, "h:m A");
//        dateString = currentTime.toLocaleDateString(locale,"dd/MM/yyyy ddd");


        //dateString = myYear + "-" + myMonth + "-" + myDay + " " + currentTime.toLocaleDateString(locale,"ddd");
        //print(Date.fromLocaleTimeString(locale, timeString, Locale.ShortFormat));


        timeString = mycurrentTime.toTimeString("h:m A");
        dateString = mycurrentTime.toDateString("dd/MM/yyyy ddd");

        //dateString  = Qt.formatDateTime(mySysTime, "yyyy-MM-dd");
        //timeString = Qt.formatDateTime(mySysTime, "hh:mm:ss");
    }

    Text {
        id: text_date
        anchors.verticalCenter: root.verticalCenter
        anchors.right: root.horizontalCenter
        anchors.rightMargin: 10
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.bold: false
        font.family: bodyFont.name
        font.pointSize:14
        lineHeightMode:Text.FixedHeight
        lineHeight: 20

        color: "white"

        text: dateString
    }

    Text {
        id: text_time
        anchors.verticalCenter: root.verticalCenter
        anchors.left: root.horizontalCenter
        anchors.leftMargin: 10
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.bold: false
        font.family: bodyFont.name
        font.pointSize:14
        lineHeightMode:Text.FixedHeight
        lineHeight: 20

        color: "white"

        text: timeString
    }

}
