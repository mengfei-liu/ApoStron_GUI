import QtQuick 2.0
import QtQuick.Controls 2.2

import "../Delegates"
import "../Widgets"

Rectangle
{
    id:page_help
    objectName: "Page_Help"
    width: 480
    height: 615
    color: clr_gray3

    property variant page_container: null
    property string pageTitle: qsTr("Help")

    Component.onCompleted:
    {
        myheader.titleStr = qsTr("Help");
    }

    Text
    {
        id:text_title
        anchors.top:page_help.top
        anchors.topMargin: 15
        anchors.horizontalCenter: page_help.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.family: bodyFont.name
        font.pointSize: fsize_med
        font.bold: true
        color: clr_gray2
        text: help_title
    }

    ListView
    {
        id: myListView_help
        width: page_help.width
        interactive: true
        anchors.top: text_title.bottom
        anchors.bottom: btn_close.top
        //anchors.top: page_help.top
        //anchors.topMargin: 10
        clip: true
        contentWidth: width
        flickableDirection: Flickable.AutoFlickDirection

        //model: mylist_help            // concrete model
        //delegate: Delegate_TextField_Help{} // provide delegate component.
        model:mylist_help_v2
        delegate: Delegate_Page_Help{} // provide delegate component.
        spacing: 10
    }


    Btn_Static
    {
        id:btn_close
        anchors.bottom: page_help.bottom
        btn_name:"close"

        onBtnClick:
        {
           var resultItem = stack.find(
                                        function(item){
                                                   // console.log(item.objectName);
                                                  // return item.objectName === "Page_Help" ? true : false;
                                                    return item.objectName === page_help.page_container.objectName ? true : false;
                                               }
                                       );
            if(resultItem !== null)
            {
              //stack.pop();
                footerPoped = false;
                myheader.titleStr = resultItem.pageTitle;
                stack.pop(resultItem);
           }
        }
    }
}
