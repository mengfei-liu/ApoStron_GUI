import QtQuick 2.0
import QtQuick.Controls 2.2

import "../Delegates"
import "../Widgets"
import "../JS/Database.js" as DB

Rectangle
{
    id:page_Auditlog

    objectName: "Page_AUDITLOGS"
    width: 480
    height: 615

    color: "white"

    property string pageTitle: qsTr("AUDIT LOGS")

    property variant page_container: null

    property bool isLogChanged: false;

    signal listDeleteTriggered(int index);
    signal listCancelTriggered();

    onListCancelTriggered:
    {
        isLogChanged = false;

    }

    onListDeleteTriggered:
    {
        console.log("myAuditLogListView currentItem : ",myAuditLogListView.currentIndex);
        mylist_Auditlog.remove(index);
        isLogChanged = true;
    }

    Component.onCompleted:
    {
        myheader.titleStr = qsTr("AUDIT LOGS");
    }

    ListView
    {
        id: myAuditLogListView
        width: page_Auditlog.width
        height: 515
        anchors.top: page_Auditlog.top
        clip: true
        model: mylist_Auditlog

        delegate: Delegate_Page_AuditLogs
        {
            Component.onCompleted:
            {
            }
        }
        spacing: 20
        interactive: true
        flickableDirection: Flickable.AutoFlickDirection

        ScrollBar.vertical:
            ScrollBar{
            orientation: Qt.Vertical
            policy: ScrollBar.AsNeeded
        }
    }
    Btn_Static
    {
        id:btn_delete
        btn_name: "deleteLog"
        fontPtSize: fsize_large
        anchors.bottom: page_Auditlog.bottom
        enabled: mylist_Auditlog.count > 0 ? true :false
        onBtnClick:
        {

          DB.deleteAll(mylist_Auditlog);
        }
    }


    Btn_Static
    {
        id:btn_back
        btn_name: "back"
        fontPtSize: fsize_large
        anchors.bottom: page_Auditlog.bottom
        anchors.right: page_Auditlog.right
        onBtnClick:
        {

            var resultItem = stack.find(
                function(item)
                {
                //console.log(item.objectName);
                return item.objectName === page_Auditlog.page_container.objectName ? true : false;
                }
            );

            if(resultItem !== null)
            {
                footerPoped = false;
                myheader.titleStr = resultItem.pageTitle;
                stack.pop(resultItem);
            }
        }
    }

//    Btn_Static
//    {
//        id:btn_back
//        btn_name: "backWide"
//        fontPtSize: fsize_large
//        anchors.bottom: page_Auditlog.bottom

//        onBtnClick:
//        {

//            var resultItem = stack.find(
//                function(item)
//                {
//                //console.log(item.objectName);
//                return item.objectName === page_Auditlog.page_container.objectName ? true : false;
//                }
//            );

//            if(resultItem !== null)
//            {
//                footerPoped = false;
//                myheader.titleStr = resultItem.pageTitle;
//                stack.pop(resultItem);
//            }
//        }
//    }
}
