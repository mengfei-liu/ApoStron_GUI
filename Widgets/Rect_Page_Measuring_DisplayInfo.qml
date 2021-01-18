import QtQuick 2.0
import "../JS/UnitConvert.js" as UC

Rectangle
{
    id:root
    height: 100
    width: parent.width/3

    property alias clr_background: root.color
    property color clr_dashline
    property alias clr_text: num.color
    property alias mynum: num.text
    property alias mytext: lower_text.text

    property double inputData

    onInputDataChanged:
    {

    }

    function toDisplay()
    {

    }

    Text {
        id: num
        anchors.verticalCenter: root.verticalCenter
        anchors.horizontalCenter: root.horizontalCenter
        width: root.width
        //verticalAlignment: Text.AlignVCenter
        verticalAlignment: Text.AlignTop
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.Fit
        font.family: bodyFont.name
        font.pixelSize: fsize_med - 2
        minimumPixelSize: fsize_2xs
        font.bold: true
        textFormat: Text.RichText
        text: "3ft 2-1/8in"//qsTr("<span style='font-size:40px;'>3</span>ft <span style='font-size:28px;font-weight:bold'>2-</span><span style='font-size:28px;'>1</span>/<span style='font-size:28px;'>8</span>in")
    }

    Text {
        id: lower_text
        width: root.width
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.top: num.bottom
        anchors.horizontalCenter: num.horizontalCenter
        fontSizeMode: Text.Fit
        minimumPixelSize: 1
        minimumPointSize: 1
        font.family: bodyFont.name
        font.pointSize: fsize_2xs
        font.bold: false
        color:num.color
    }

    Row {
        anchors.top: lower_text.bottom
        anchors.topMargin: 3
        anchors.horizontalCenter: root.horizontalCenter
        spacing: 10
        Repeater {
            model: 4
            Rectangle {
                width: 20; height: 8
                color: clr_dashline
            }
        }
    }
}
