import QtQuick 2.0
//import QtGraphicalEffects 1.0


Rectangle
{
    id:root
    height: 75
    width: 75

    anchors.verticalCenter: parent.verticalCenter

    signal btnClick();
    signal btnHold();

    property alias btn_name: root.state
    property string pageUrl
    color: "transparent"

    Image {
        id: btn_pic
        width: parent.width
        height: parent.height
        anchors.fill: root
        cache: false
        fillMode: Image.PreserveAspectFit
        source: Qt.resolvedUrl("qrc:/Icons/btn_audit.png");
        opacity: 1
    }

    MouseArea
    {
        id:btn_mouseArea
        anchors.fill: parent

        onClicked:
        {
            root.btnClick();

        }

        onPressAndHold:
        {
            root.btnHold();
        }
    }

    Rectangle
    {
        id:btn_led
        width: root.width
        height: 2
        anchors.top: root.bottom
        anchors.topMargin: 1

       // color: btn_mouseArea.pressed? clr_orange : clr_gray2
        color: btn_mouseArea.pressed? clr_orange : "black"
    }

    states:
    [
        State
        {
            name: "auditlog"
            PropertyChanges { target: btn_pic; source: Qt.resolvedUrl("qrc:/Icons/btn_audit.svg");}
            //PropertyChanges { target: btn_pic; source: Qt.resolvedUrl("qrc:/Icons/btn_audit.png");}
            PropertyChanges { target: root;pageUrl: Qt.resolvedUrl("qrc:/")}
        },

        State
        {
            name: "help"
            PropertyChanges { target: btn_pic; source: Qt.resolvedUrl("qrc:/Icons/btn_help.svg");}
            //PropertyChanges { target: btn_pic; source: Qt.resolvedUrl("qrc:/Icons/btn_help.png")}
            PropertyChanges { target: root;pageUrl: Qt.resolvedUrl("qrc:/Pages/Page_Help.qml")}
        },

        State
        {
            name: "home"
            PropertyChanges { target: btn_pic; source: Qt.resolvedUrl("qrc:/Icons/btn_home.svg");}
            //PropertyChanges { target: btn_pic; source: Qt.resolvedUrl("qrc:/Icons/btn_home.png")}
            PropertyChanges { target: root;pageUrl: Qt.resolvedUrl("qrc:/Pages/Page_3_DrillPlan_Inputs.qml")}
        },

        State
        {
            name: "power"
            PropertyChanges { target: btn_pic; source: Qt.resolvedUrl("qrc:/Icons/btn_pwr.svg");}
            //PropertyChanges { target: btn_pic; source: Qt.resolvedUrl("qrc:/Icons/btn_pwr.png")}
        },

        State
        {
            name: "settings"
            PropertyChanges { target: btn_pic; source: Qt.resolvedUrl("qrc:/Icons/btn_settings.svg");}
            //PropertyChanges { target: btn_pic; source: Qt.resolvedUrl("qrc:/Icons/btn_settings.png")}
            PropertyChanges { target: root;pageUrl: Qt.resolvedUrl("qrc:/Pages/Page_Settings.qml")}
        }
    ]
}
