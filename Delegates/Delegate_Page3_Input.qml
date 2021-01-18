import QtQuick 2.0
import QtQuick.Controls 2.0

import "../Widgets"
import "../Keyboard"

Component
{
    id:delegate

    Rectangle
    {
        id:root
        width: parent.width
        height: 50
        //color: clr_gray3
        //color: btn_mouseArea.enabled ? clr_gray3 : clr_gray1//Qt.darker(clr_gray3)
        color: clr_gray3
        focus: false
        z: -1
        property int itemMargin: 15
        property string displayedText: item_value
        property bool switch_mode_result: switch_mode.checked

       MouseArea
       {
           id:btn_mouseArea
           anchors.fill: parent
           z:0
           enabled: index == 3 ? (switch_mode.checked ? true : false) : true

           function click()
           {
               btn_next.visible = false;
               btn_next.enabled = false;
               btn_cancel.visible = false;
               btn_cancel.enabled = false;

               myListView.currentIndex = index;
               myListView.currentItem.focus = true;

               if(index == 0)
               {

                   vk_letter.state = "active";
                   vk_num.state = "inactive";
                   vk_num.btn_switch2Letter.enabled = true;
               }
               else
               {
                   vk_letter.state = "inactive";
                   vk_num.state = "active";
                   vk_num.btn_switch2Letter.enabled = false;
               }
           }

           onClicked:
           {
               btn_next.visible = false;
               btn_next.enabled = false;
               btn_cancel.visible = false;
               btn_cancel.enabled = false;

               myListView.currentIndex = index;
               myListView.currentItem.focus = true;

               if(index == 0)
               {

                   vk_letter.state = "active";
                   vk_num.state = "inactive";
                   vk_num.btn_switch2Letter.enabled = true;
               }
               else
               {
                   vk_letter.state = "inactive";
                   vk_num.state = "active";
                   vk_num.btn_switch2Letter.enabled = false;
               }
           }
       }

       Border_Custom
       {
           commonBorder: false
           lBorderwidth: 0
           rBorderwidth: 0
           tBorderwidth: 1
           bBorderwidth: 1
           borderColor: clr_gray2
       }



       Switch
       {
           id:switch_mode
           anchors.left: root.left
           anchors.leftMargin:root.itemMargin
           anchors.verticalCenter: root.verticalCenter
           checked: false
           width: 60
           height: 30
           visible: index == 3 ? true : false;

           onCheckedChanged:
           {
//               if(myListView.currentIndex == 3 && checked == false)
//               {
//                   myListView.currentItem.focus = false;
//                   myListView.currentIndex = myListView.currentIndex -1;
//                   myListView.currentItem.focus = true;
//               }

               if(checked == false)
               {
//                   item_value = "0"
                   item_value = "NA"

//                   if(myListView.currentIndex == 3)
//                   {
//                       myListView.currentItem.focus = false;
//                       myListView.currentIndex = myListView.currentIndex -1;
//                       myListView.currentItem.focus = true;
//                   }
                   value_area.color = clr_gray3;
                   myListView.currentItem.focus = false;
                   myListView.currentIndex = 2;
                   myListView.currentItem.focus = true;

               }
               else
               {
                   value_area.color = "white";
                   item_value = "0"
                   myListView.currentItem.focus = false;
                   myListView.currentIndex = 3;
                   myListView.currentItem.focus = true;
               }
           }

           indicator: Rectangle {
               implicitWidth: 48
               implicitHeight: 26
               x: switch_mode.leftPadding
               y: parent.height / 2 - height / 2
               radius: 13
               color: switch_mode.checked ? clr_gray2 : "#ffffff"
               border.color: switch_mode.checked ? clr_gray2 : "#ffffff"

               Rectangle {
                   x: switch_mode.checked ? parent.width - width : 0
                   width: 26
                   height: 26
                   radius: 13
                   color: switch_mode.checked ?   clr_orange : (switch_mode.down ? Qt.lighter(clr_gray2) : clr_gray2)
                   border.color: switch_mode.checked ?   clr_orange : (switch_mode.down ? Qt.lighter(clr_gray2) : clr_gray2)
               }
           }

//           contentItem: Text {
//               text: switch_mode.text
//               font: switch_mode.font
//               opacity: enabled ? 1.0 : 0.3
//               color: switch_mode.down ? "#17a81a" : "#21be2b"
//               horizontalAlignment: Text.AlignHCenter
//               verticalAlignment: Text.AlignVCenter
//           }
       }

       Text
       {
           id: text_item_name
           anchors.left: root.left
           anchors.leftMargin: index == 3 ? (root.itemMargin + switch_mode.width + 15): root.itemMargin
           anchors.verticalCenter: root.verticalCenter
           color: clr_gray2
           font.family: bodyFont.name
           font.pointSize: fsize_med

           text: mylist_title + mytrans.emptyString

       }

       Rectangle
       {
           id:value_area
           width: 200 //index == 3 ? 200 : 245
           height: 30
           //color: "white"
           color:
           {
               if(index == 3)
               {
                   if(switch_mode.checked)
                   {
                       color = "white"
                   }
                   else
                   {
                       color = clr_gray3
                   }
               }
               else
               {
                   color = "white"
               }
           }
           radius: 5
           border.width: 1
           border.color: clr_gray2

           anchors.right: root.right
           anchors.rightMargin: root.itemMargin
           anchors.verticalCenter: root.verticalCenter

           TextInput
           {
               id: text_item_value

               anchors.fill: parent
               anchors.rightMargin: item_unit == "" ? 0 : 10

               font.family: bodyFont.name
               font.pointSize: fsize_small
               font.wordSpacing: 0
               z:0

               verticalAlignment: Text.AlignVCenter
               horizontalAlignment: Text.AlignRight

               activeFocusOnPress:false
               color: clr_gray2

               text: item_value + " " + item_unit

               //readOnly: true

               MouseArea
               {
                   anchors.fill: text_item_value
                   onClicked:
                   {
                       if(index == 3)
                       {
                           if(switch_mode.checked)
                           {
                               btn_mouseArea.click();
                           }
                       }
                       else
                          btn_mouseArea.click();
                   }
               }


               onTextChanged:
               {
                   text_item_value.cursorPosition = item_value.length;
               }
           }
       }

      onFocusChanged:
      {
          if(root.focus)
          {

              text_item_value.cursorVisible = true;
              text_item_value.cursorPosition = item_value.length;
          }
          else
          {
              text_item_value.cursorVisible = false;
          }
      }
    }
}

