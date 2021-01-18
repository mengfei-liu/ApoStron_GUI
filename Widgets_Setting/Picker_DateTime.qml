import QtQuick 2.0
import "../Widgets"


Rectangle
{
    id:root
    property alias value: list.currentIndex;
    property alias myModel: list.model;

    property bool bZeroFlags: false;
    property bool bTextFlags: false;

    property int currentFontSize: 22;
    property int normalFontSize: 18;

    //width: 160

    color: "#36393b";
    //border.color: "white";

    Border_Custom
    {
        commonBorder: false
        lBorderwidth: 1
        rBorderwidth: 1
        tBorderwidth: 0
        bBorderwidth: 0
        borderColor: clr_gray2
    }

    Rectangle
    {
        id:btn_add
        width: root.width
        height: root.height/5

        anchors
        {
            top: parent.top;
            left: parent.left;
        }

        color: mouserArea_plus.pressed ? clr_orange :clr_gray3;

        Text
        {
            anchors.centerIn: parent
            font.family: bodyFont.name
            font.pointSize: fsize_small
            text: "+"
        }

        MouseArea
        {
            id:mouserArea_plus
            anchors.fill: parent
            onClicked:
            {
                list.incrementCurrentIndex();
            }
        }
    }

    Rectangle
    {
        id:btn_minus

        width: root.width
        height: root.height/5

        anchors
        {
            bottom: parent.bottom;
            left: parent.left;
        }

        color:  mouseArea_minus.pressed ? clr_orange :clr_gray3;

        Text
        {
            anchors.centerIn: parent
            font.family: bodyFont.name
            font.pointSize: fsize_small
            text: "-"
        }


        MouseArea
        {
            id:mouseArea_minus
            anchors.fill: parent
            onClicked:
            {
                list.decrementCurrentIndex();
            }
        }
    }

    Rectangle
    {
        id: wheelList;

        anchors.top: btn_add.bottom
        anchors.left: btn_add.left

        color: clr_gray3;
        width: root.width;
        height: root.height/5 * 3

        Border_Custom
        {
            commonBorder: false
            lBorderwidth: 0
            rBorderwidth: 0
            tBorderwidth: 1
            bBorderwidth: 1
            borderColor: clr_gray2
        }

        ListView
        {
            id: list;

            width: wheelList.width;
            height: wheelList.height;

            anchors.verticalCenter: wheelList.verticalCenter
            anchors.horizontalCenter: wheelList.horizontalCenter

            highlightRangeMode: ListView.StrictlyEnforceRange;

            preferredHighlightBegin: height / 3;
            preferredHighlightEnd: height / 3;
            clip: true;

            delegate:Rectangle
              {
                id: modelRect;

                color: clr_gray3;
                width: root.width;
                height: ListView.isCurrentItem ? list.height/3 : list.height/3;
                Text
                {
                    id: modelText;
                    anchors.centerIn: parent;
                    font.family: bodyFont.name
                    font.pointSize: modelRect.ListView.isCurrentItem ? fsize_med : fsize_small;
                    color: modelRect.ListView.isCurrentItem ? clr_orange : clr_gray2;
                    text:
                    {
                        if(bTextFlags)
                        {
                            return ( numberText);
                        }
                        else
                        {
                            if(bZeroFlags)
                            {
                                //return (index);

                                if(index<10)
                                {
                                    return("0" + String(index));
                                }
                                else
                                {
                                    return index;
                                }
                            }
                            else
                            {
//                                return ((index + 1));
                                //console.log("bZeroFlag == false")
                                if(index<9)
                                {
                                    return("0" + String(index+1));
                                }
                                else
                                {
                                    return (index+1);
                                }
                            }
                        }
                    }
                }
                MouseArea
                {
                    anchors.fill: parent;
                    onClicked:
                    {
                        list.currentIndex = index;
                    }
                }
            }
        }
    }
}

