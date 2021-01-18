import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "../Widgets"

//Component
//{
//    id:delegate_auditlogs

    Rectangle
    {
            id:root
            width: 480
            height: log_col.implicitHeight
            color: clr_gray3
            focus: false
            z: -1

            signal btnDelete(int index);
            signal btnCancel();

            property string oldState: ""
            property bool isFolded: false

            Component.onCompleted:
            {
                isFolded = true;
            }

            MouseArea
            {
                anchors.fill: root
                onClicked:
                {
                    isFolded = !isFolded;
                }
            }


            onIsFoldedChanged:
            {
                if(isFolded)
                {
                    log_grid2.visible = false;
                    row_dtt.visible = false;
                }
                else
                {
                    log_grid2.visible = true;
                    row_dtt.visible = true;
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

            Rectangle
            {
                id:list_info
                width: root.width
                height: log_col.implicitHeight
                anchors.left: root.left
                anchors.top: root.top
                color: "transparent"

                state:"Details"

                property int itemMargin: 15
                property int spaceMargin: 5
                property real detailsOpacity : 0
                property real deleteOpacity: 0

                Column
                {
                    id:log_col
                    anchors.horizontalCenter: list_info.horizontalCenter
                    spacing: log_grid1.rowSpacing

                    GridLayout
                    {
                        id:log_grid1
                        width: root.width
                        columns: 2

                        Log_Text {
                            id: date
                            font.pointSize: fsize_small
                            text: qsTr("Date: ") + log_date
                        }
                        Log_Text {
                            id: time
                            font.pointSize: fsize_small
                            text: qsTr("Time: ") + log_starttime
                        }
                    }

                    GridLayout
                    {
                        id:log_grid2
                        width: root.width
                        columns: 2

                        Log_Text {
                            id: starttime
                            text: qsTr("Start Time: ") + log_starttime
                        }
                        Log_Text {
                            id: endtime
                            text: qsTr("End Time: ") + log_endtime
                        }

                        Log_Text {
                            id: elapsedTime
                            text: qsTr("Elapsed Time: ") + log_ElapsedTime
                        }
                        Log_Text {
                            id: unit
                            text: qsTr("Unit: ") + log_unit
                        }

                        Log_Text {
                            id: accuracy
                            text: qsTr("Accuracy: ") + log_accuracy
                        }
                        Log_Text {
                            id: mode
                            text: qsTr("Mode: ") + log_mode
                        }

                        Log_Text {
                            id: dtr
                            text: qsTr("Dist. to Ref.: ") + log_dtr
                        }
                        Log_Text {
                            id: swing
                            text: qsTr("Swing Angle: ") + log_swing + unit_swing
                        }

                        Log_Text {
                            id: measuredPts
                            text: qsTr("Number of Measured Points: ") + log_measuredPts
                        }
                    }

                    Row
                    {
                        id:row_dtt
                        width: parent.width
                        Log_Text
                        {
                            id: dtt
                            wrapMode: Text.WordWrap
                            text:qsTr("Dist. to Target: ")+log_dtt
                            verticalAlignment: Text.AlignTop
                            horizontalAlignment: Text.AlignLeft
                        }
                    }

                }

               /* ColumnLayout
                {
                    id:log_grid
                    width: root.width
                    RowLayout
                    {
                        width: root.width
                        Log_Text {
                            id: date
                            anchors.left: parent.left
                            text: qsTr("Date: ") + log_date
                        }
                        Log_Text {
                            id: time
                            anchors.right: parent.right
                            text: qsTr("Time: ") + log_starttime
                        }
                    }

                    RowLayout
                    {
                        width: root.width
                        Log_Text {
                            id: starttime
                            anchors.left: parent.left
                            text: qsTr("Start Time: ") + log_starttime
                        }
                        Log_Text {
                            id: endtime
                            anchors.right: parent.right
                            text: qsTr("End Time: ") + log_endtime
                        }
                    }

                    RowLayout
                    {
                        width: root.width
                        Log_Text {
                            id: elapsedTime
                            anchors.left: parent.left
                            text: qsTr("Elapsed Time: ") + log_ElapsedTime
                        }
                        Log_Text {
                            id: unit
                            anchors.right: parent.right
                            text: qsTr("Unit: ") + log_unit
                        }
                    }

                    RowLayout
                    {
                        width: root.width
                        Log_Text {
                            id: accuracy
                            anchors.left: parent.left
                            text: qsTr("Accuracy: ") + log_accuracy
                        }
                        Log_Text {
                            id: mode
                            anchors.right: parent.right
                            text: qsTr("Mode: ") + log_mode
                        }
                    }

                    RowLayout
                    {
                        width: root.width
                        Log_Text {
                            id: dtr
                            anchors.left: parent.left
                            text: qsTr("Dist. to Ref.: ") + log_dtr
                        }
                        Log_Text {
                            id: swing
                            anchors.right: parent.right
                            text: qsTr("Swing Angle: ") + log_swing + unit_swing
                        }
                    }

                    RowLayout
                    {
                        width: root.width
                        Log_Text {
                            id: measuredPts
                            text: qsTr("Number of Measured Points: ") + log_measuredPts
                        }
                    }

                    RowLayout
                    {
                        width: root.width
                        Log_Text
                        {
                            id: dtt
                            text: qsTr("Dist. to Target: ") + log_dtt
                        }
                    }
                }*/
            }

            Rectangle
            {
                id:btn_delete
                height: root.height
                width: 50
                anchors.top: root.top
                anchors.left: list_info.right
                color: btn_delete_click.pressed ? clr_gray2 : "red"
                opacity: list_info.deleteOpacity

                Text {
                    id: text_delete
                    anchors.centerIn: parent
                    font.family: bodyFont.name
                    font.pointSize: fsize_3xs
                    color: "white"
                    text: qsTr("Delete")
                }

                MouseArea
                {
                    id:btn_delete_click
                    anchors.fill: parent

                    onClicked:
                    {
                        root.btnDelete(index);
                    }
                }

            }

            Rectangle
            {
                id:btn_cancel
                height: btn_delete.height
                width: btn_delete.width
                anchors.top: btn_delete.top
                anchors.left: btn_delete.right
                color: btn_cancel_click.pressed ? "white" : clr_gray2
                opacity: list_info.deleteOpacity

                Text {
                    id: text_cancel
                    anchors.centerIn: parent
                    font.family: bodyFont.name
                    font.pointSize: fsize_3xs
                    color: btn_cancel_click.pressed ?  clr_gray2 : "white"
                    text: qsTr("Cancel")
                }

                MouseArea
                {
                    id:btn_cancel_click
                    anchors.fill: parent

                    onClicked:
                    {
                        root.btnCancel();
                        list_info.state = root.oldState;
                    }
                }
            }
        }
//}
