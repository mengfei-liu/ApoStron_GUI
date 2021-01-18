import QtQuick 2.0

Item {
    anchors.verticalCenter: parent.verticalCenter
    width: 120
    height:  120
    Column
    {
        anchors.fill: parent
        Text {
            id: value
            width: parent.width
            height: parent.height * 2 / 3
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: bodyFont.name
            font.pointSize:fsize_med
            font.bold: true
            color: clr_gray2
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            textFormat: Text.RichText
            text: qsTr("-125ft 26-23/64in")
        }

        Text {

            id: title
            width: parent.width
            height: parent.height / 3
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: bodyFont.name
            font.pointSize:fsize_2xs
            color: clr_gray2
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            textFormat: Text.RichText
            text: qsTr("Measured Disance")
        }
    }
}
