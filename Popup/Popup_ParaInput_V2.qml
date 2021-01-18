import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item
{
    id:root
    width: 200
    height: area_input.height + text_title.implicitHeight + text_title.anchors.topMargin

    property alias input_TitleText: text_title.text

    //property alias input_ContentText: text_content.text
    property alias input_Content: text_content
    property alias input_value: text_content.input_value
    //property alias input_unit: text_content.input_unit
    property alias input_unit: unit.text
    property string lastDigit



    signal textInputClicked();
    Rectangle
    {
       id:area_input
       width: 200
       height: width/4
       anchors.top: parent.top
       anchors.horizontalCenter: parent.horizontalCenter
       color: clr_gray3
       border.color: text_content.focus ? clr_orange: clr_gray2
       border.width: 2
       radius: 6

       RowLayout
       {
           id:row
           anchors.fill: parent
           TextInput//TextEdit
           {
               id:text_content
               Layout.fillWidth:true
               //width:is_Unit_Imperial ? parent.width * 2 /3 : parent.width
               width:is_Unit_Imperial ? parent.width - dropdown.width - unit.implicitWidth : parent.width
               anchors.verticalCenter: row.verticalCenter
               //anchors.fill: parent
               //anchors.rightMargin:10
               color: clr_gray2//area_input.border.color //text color
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: is_Unit_Imperial ? Text.AlignLeft : Text.AlignRight
               font.family: bodyFont.name
               font.pointSize:fsize_small
               font.bold: true
               activeFocusOnPress: false
               property string input_value//"0"
               property string input_unit//is_Unit_Imperial ? " m" : ""
               //property string input_unit: is_Unit_Imperial ? "in" : ""
               //textFormat: Text.RichText
               text: input_value //+ input_unit

               onTextChanged:
               {
                  // if(!is_Unit_Imperial)
                   // text_content.cursorPosition = input_value.length
               }

    //           onInput_valueChanged:
    //           {
    //               text_content.cursorPosition = input_value.length
    //           }

               onFocusChanged:
               {
                   if(text_content.focus)
                   {
                       text_content.cursorVisible = true;


                       if(is_Unit_Imperial && input_unit === "")
                       {
                           text_content.cursorPosition = input_value.indexOf("f")
                       }
                       else
                           text_content.cursorPosition = input_value.length;
                   }
                   else
                       text_content.cursorVisible = false;
               }

               MouseArea
               {
                   anchors.fill: parent

                   onClicked:
                   {
                       text_content.focus = true;
                       root.textInputClicked();
                   }
               }
           }

           ComboBox
           {
               id:dropdown
               Layout.fillWidth:true
               anchors.verticalCenter: row.verticalCenter
               visible: is_Unit_Imperial
               currentIndex:0
               displayText : currentText
               font.family: bodyFont.name
               font.pointSize:fsize_small
               font.bold: true

               background: Rectangle {
                   color: area_input.color
               }

               contentItem: Text
               {
                   id:content_text
                   verticalAlignment: Text.AlignVCenter
                   horizontalAlignment: Text.AlignHCenter
                   color: text_content.color
               }

               model: ListModel {
                   id: cbItems
                   ListElement { text: "2"; }
                   ListElement { text: "4"; }
                   ListElement { text: "8"; }
                   ListElement { text: "16"; }
                   ListElement { text: "32"; }
                   ListElement { text: "64"; }
               }

               onCurrentIndexChanged:
               {
                   root.lastDigit = cbItems.get(currentIndex).text
                   displayText = cbItems.get(currentIndex).text
               }
           }

           Text {
               id:unit
               Layout.fillWidth:true
               anchors.verticalCenter: row.verticalCenter
               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignRight
               font.family: bodyFont.name
               font.pointSize:fsize_small
               font.bold: true
               color: text_content.color
               text: is_Unit_Imperial ? "in" : "m"
           }

       }
    }

    Text
    {
        id: text_title
        anchors.top: area_input.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: bodyFont.name
        font.pointSize:fsize_small
        font.bold: true
        color: clr_black
    }
}
