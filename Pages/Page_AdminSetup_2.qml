import QtQuick 2.0
import QtQuick.Controls 2.2
import FileIO 1.0
import "../Widgets"

Rectangle
{
    id:page_adminSetup_2
    objectName: "Page_AdminSetup_2"
    width: 480
    height: 615

    color: clr_gray3

    property variant page_container: null
    property string pageTitle: "Admin Setup"
    property bool isPasswordCorrect:false
    property bool isTempExist: false

    Component.onCompleted:
    {
        myheader.titleStr = "Admin Setup";
        state =  "Idle";
    }

    Connections
    {
        target: mySerialThread

        onIsAdminPSWCorrectChanged:
        {
            isPasswordCorrect = mySerialThread.isAdminPSWCorrect;

            if(isPasswordCorrect)
            {
                isPasswordCorrect = false;
                label_wrongPassword.opacity = 0;
            }
            else
            {
                label_wrongPassword.opacity = 1;
            }
        }

        onProgressLevelChanged:
        {
            if(mySerialThread.progressLevel  >= 200)
            {
                label_ProgressLevel.text =  "Parameter Received was Wrong"
            }
            else
            {
                label_ProgressLevel.text = "Progress Level: " + mySerialThread.progressLevel + "%"
            }
        }

        onUpdateDoneChanged:
        {
            //            if(mySerialThread.updateDone === "Update Finished")
            //            {
            //                label_ProgressLevel.text = "Progress Level: 100% Update Finished"
            //            }
            if(mySerialThread.updateDone == 0)
            {
                label_updateState.visible = true;
                label_updateState.text = "Start Update"
            }
            else if(mySerialThread.updateDone == 1)
            {
                label_updateState.visible = true;
                label_updateState.text = "Updating..."
            }
            else if(mySerialThread.updateDone == 2)
            {
                label_updateState.visible = true;
                label_updateState.text = "Update Finshed"
            }
            else if(mySerialThread.updateDone == 3)
            {
                label_updateState.visible = false;
                label_updateState.text = "File Error"
            }
            else
            {
                label_updateState.visible = true;
                label_updateState.text = "Start Update"
            }
        }
    }

   /* FileIO
    {
        id:tempfile
        source: "//home//pi//updatefile.txt"
    }*/

    Label {
        id: label_updateState
        visible: false;
        anchors.horizontalCenter: page_adminSetup_2.horizontalCenter
        anchors.bottom: label_ProgressLevel.top
        font.family:bodyFont.name
        font.pointSize: fsize_xs
        font.bold: true
        color: "black"
    }

    Label
    {
        id: label_wrongPassword
        width: 200
        height: 50
        opacity: 0
        anchors.horizontalCenter: page_adminSetup_2.horizontalCenter
        anchors.verticalCenter: page_adminSetup_2.verticalCenter
        anchors.verticalCenterOffset: 138
        anchors.horizontalCenterOffset: 0
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.family:bodyFont.name
        font.pointSize: fsize_xs
        font.bold: true


        color: "red"
        text: "Password Incorrect !"

        transitions: Transition {

            NumberAnimation {
                target: label_wrongPassword
                property: "opacity"
                duration: 10000
                easing.type: Easing.InOutQuad
            }
        }

    }

    Label
    {
        id: label_ProgressLevel
        height: 50
        opacity: label_wrongPassword.opacity==1 ? 0 : 1;
        anchors.horizontalCenter: page_adminSetup_2.horizontalCenter
        anchors.verticalCenter: page_adminSetup_2.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        font.family:bodyFont.name
        font.pointSize: fsize_xs
        font.bold: true

        color: "black"
        anchors.verticalCenterOffset: 138
        anchors.horizontalCenterOffset: 0

        transitions:
            Transition
            {
                NumberAnimation
                {
                    target: label_ProgressLevel
                    property: "opacity"
                    duration: 10000
                    easing.type: Easing.InOutQuad
                }
            }
    }

    Label {
        id: label_ver
        x: 200
        y: 482
        width: 80
        height: 25
        text: myVer
        horizontalAlignment: Text.AlignHCenter
    }

    Label {
        id: label_ip
        anchors.top: label_ver.top
        anchors.right: page_adminSetup_2.right
        anchors.rightMargin: 20

        text: myIPaddress
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea
    {
        anchors.fill: page_adminSetup_2
        onClicked:
        {
            page_adminSetup_2.state = "Idle";
        }
    }

    Row
    {
        id:row_btn
        anchors.horizontalCenter: page_adminSetup_2.horizontalCenter
        y:50
        spacing: 20

        Btn_Static {
            id: btn_log
            width: 140
            height: 80
            text:"Log"
            fontPtSize:12

            onBtnClick:
            {
                if(page_adminSetup_2.state !== "Log")
                {
                    page_adminSetup_2.state = "Log"
                }
                else
                {
                    page_adminSetup_2.state = "Idle"
                }
            }
        }

        Btn_Static {
            id: btn_firmware
            width: 140
            height: 80
            text:"Firmware"
            fontPtSize:12

            onBtnClick:
            {
                if(page_adminSetup_2.state !== "Firmware")
                {
                    page_adminSetup_2.state = "Firmware"
                }
                else if(page_adminSetup_2.state === "Firmware")
                {
                    page_adminSetup_2.state = "Idle"
                }
            }
        }

        Btn_Static {
            id: btn_recovery
            width: 140
            height: 80
            text:"Factory Recovery"
            fontPtSize:12

            onBtnClick:
            {
                if(page_adminSetup_2.state !== "Factory Recovery")
                {
                    page_adminSetup_2.state = "Factory Recovery"
                }
                else if(page_adminSetup_2.state === "Factory Recovery")
                {
                    page_adminSetup_2.state = "Idle"
                }
            }
        }
    }


    Btn_Static {
        id: btn_1
        width: 140
        height: 80
        fontPtSize:12
    }

    Btn_Static {
        id: btn_2
        width: 140
        height: 80
        fontPtSize:12
    }

    Btn_Static {
        id: btn_3
        width: 140
        height: 80
        fontPtSize:12
    }

    Btn_Static {
        id: btn_4
        width: 140
        height: 80
        fontPtSize:12
    }

    Btn_Static {
        id: btn_5
        width: 140
        height: 80
        fontPtSize:12
    }

    Btn_Static {
            id: btn_6
            width: 140
            height: 80
            fontPtSize:12
        }

    Btn_Static {
        id: btn_TspUpdate
        x: 8
        y: 146
        width: 140
        height: 80
        fontPtSize:12

        text:"TSP Update"

        onBtnClick:
        {
            if(page_adminSetup_2.state !== "Tspupdate")
            {
                page_adminSetup_2.state = "Tspupdate"
            }
            else if(page_adminSetup_2.state === "Tspupdate")
            {
                page_adminSetup_2.state = "Idle"
            }
        }
    }


    Btn_Static {
        id: btn_deleteTemp
        x: 170
        y: 146
        width: 140
        height: 80
        fontPtSize:12

        text:"Delete Temp"

        onBtnClick:
        {
            if(page_adminSetup_2.state !== "DeleteTemp")
            {
                page_adminSetup_2.isTempExist = false;

                page_adminSetup_2.state = "DeleteTemp"

                page_adminSetup_2.isTempExist = myupdatefile.isExists();

            }
            else if(page_adminSetup_2.state === "DeleteTemp")
            {
                page_adminSetup_2.state = "Idle"
            }
        }
    }

//    Btn_Static {
//        id: btn_updateShell
//        x: 8
//        y: 468
//        width: 77
//        height: 40
//        fontPtSize:5

//        text:"Shell Update"

//        onBtnClick:
//        {
//            mySerialThread.shellUpdate();
//        }

//    }

    Btn_Static {
        id: btn_EPRom
        x: 330
        y: 146
        width: 140
        height: 80
        fontPtSize:12

        text:"EPROM Update"

        onBtnClick:
        {
            if(page_adminSetup_2.state !== "EPROM")
            {
                page_adminSetup_2.state = "EPROM"
            }
            else  if(page_adminSetup_2.state === "EPROM")
            {
                page_adminSetup_2.state = "Idle"
            }
        }
    }

    Btn_Static
    {

        anchors.bottom: page_adminSetup_2.bottom
        btn_name: "done"
        fontPtSize: fsize_large
        onBtnClick:
        {
            var resultItem = stack.find(
                        function(item){
                            console.log("Item in stack: ",item.objectName);
                            return item.objectName === page_adminSetup_2.page_container.objectName ? true : false;
                        }
                        );

            if(resultItem !== null)
            {

                myheader.titleStr = resultItem.pageTitle;
                stack.pop(resultItem);
                // page_container.goback();
            }
        }
    }
    states:
    [
        State
        {
            name: "Idle"
            //PropertyChanges{ target: btn_pic; source: Qt.resolvedUrl("qrc:/icons/auditlogButton.png")}
            PropertyChanges{ target: btn_1;enabled:true;visible:false;opacity: 0.0;}
            PropertyChanges{ target: btn_2;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_3;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_4;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_5;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_6;visible:false;opacity: 0.0}

            PropertyChanges{ target: btn_log;visible:true;opacity: 1.0}
            PropertyChanges{ target: btn_firmware;visible:true;opacity: 1.0}
            PropertyChanges{ target: btn_recovery;visible:true;opacity: 1.0}
            PropertyChanges{ target: btn_TspUpdate;visible:true;opacity: 1.0;y:146}
            PropertyChanges{ target: btn_EPRom; x: 330;visible:true;opacity: 1.0;y:146}
            PropertyChanges{ target: btn_deleteTemp;visible:true;opacity: 1.0;y:146}
            PropertyChanges{ target: label_updateState;visible:false}

        },

        State
        {
            name: "Log"
            //PropertyChanges{ target: btn_pic; source: Qt.resolvedUrl("qrc:/icons/auditlogButton.png")}
            PropertyChanges{ target: btn_log;visible:true;opacity: 1.0;}

            PropertyChanges{ target: btn_firmware;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_recovery;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_TspUpdate;visible:true;opacity: 0.6;y:330}
            PropertyChanges{ target: btn_EPRom; x: 330;visible:true;opacity: 0.6;y:330}
            PropertyChanges{ target: btn_deleteTemp;visible:true;opacity: 0.6;y:330}

            PropertyChanges{ target: btn_1; x: 74; y: 146;enabled:true;visible:true;text:"Dump Log";opacity: 1.0;onBtnClick:{mySerialThread.adminSetup(Number(password),0,0,0,0,0,0);console.log("Log --- Dump Log")}}
            PropertyChanges{ target: btn_2; x: 276; y: 146;visible:true;text:"Dump & \r\nDelete Log";opacity: 1.0;onBtnClick:{mySerialThread.adminSetup(Number(password),0,1,0,0,0,0);console.log("Dump & Delete Log")}}
            PropertyChanges{ target: btn_3; x: 74; y: 239;visible:true;text:"Delete Log";opacity: 1.0;onBtnClick:{mySerialThread.adminSetup(Number(password),0,2,0,0,0,0);console.log("Delete Log")}}
            PropertyChanges{ target: btn_4; x: 276; y: 239;visible:true;text:"Delete All";opacity: 1.0;onBtnClick:{mySerialThread.adminSetup(Number(password),0,3,0,0,0,0);console.log("Delete All")}}
            PropertyChanges{ target: btn_5;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_6;visible:false;opacity: 0.0}
            PropertyChanges{ target: label_updateState;visible:false}

        },

        State {
            name: "Firmware"
            PropertyChanges{ target: btn_firmware;visible:true;opacity: 1.0;}
            PropertyChanges{ target: btn_log;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_recovery;visible:true;opacity: 0.6}

            PropertyChanges{ target: btn_TspUpdate; x: 8;visible:true;opacity: 0.6;y:240}
            PropertyChanges{ target: btn_EPRom; x: 330;visible:true;opacity: 0.6;y:240}
            PropertyChanges{ target: btn_deleteTemp;visible:true;opacity: 0.6;y:240}

            PropertyChanges{ target: btn_1; x: 75; y: 146;enabled:true;visible:true;text:"Normal Update";opacity: 1.0;onBtnClick:{mySerialThread.adminSetup(Number(password),1,0,0,0,0,0);console.log("Normal Update")}}
            PropertyChanges{ target: btn_2; x: 276; y: 146;visible:true;text:"Update Boot Ver.";opacity: 1.0;onBtnClick:{mySerialThread.adminSetup(Number(password),1,1,0,0,0,0);console.log("Update Boot Ver.")}}
            PropertyChanges{ target: btn_3;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_4;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_5;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_6;visible:false;opacity: 0.0}
            PropertyChanges{ target: label_updateState;visible:false}
        },

        State {
            name: "Factory Recovery"

            PropertyChanges{ target: btn_firmware;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_log;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_recovery;visible:true;opacity: 1.0;}

            PropertyChanges{ target: btn_TspUpdate; x: 8;visible:true;opacity: 0.6;y:240}
            PropertyChanges{ target: btn_EPRom; x: 330;visible:true;opacity: 0.6;y:240}
            PropertyChanges{ target: btn_deleteTemp;visible:true;opacity: 0.6;y:240}

            //            PropertyChanges{ target: btn_1;visible:false;opacity: 0.0}
            //            PropertyChanges{ target: btn_2;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_1; x: 74; y: 146;enabled:true;text:"Recovery";visible:true;opacity: 1.0;onBtnClick:{mySerialThread.adminSetup(Number(password),2,0,0,0,0,0);}}
            PropertyChanges{ target: btn_2; x: 276; y: 146;text:"Cancel";visible:true;opacity: 1.0;onBtnClick:{page_adminSetup_2.state = "Idle";}}
            PropertyChanges{ target: btn_3;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_4;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_5;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_6;visible:false;opacity: 0.0}
            PropertyChanges{ target: label_updateState;visible:false}
        },
        State {
            name: "Tspupdate"
            PropertyChanges{ target: btn_recovery;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_firmware;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_log;visible:true;opacity: 0.6}

            PropertyChanges{ target: btn_TspUpdate; x: 8;visible:true;opacity: 1.0;y:146}
            PropertyChanges{ target: btn_EPRom; x: 330;visible:true;opacity: 0.6;y:146}
            PropertyChanges{ target: btn_deleteTemp;visible:true;opacity: 0.6;y:146}
            PropertyChanges{ target: label_updateState;visible:true}

            PropertyChanges{ target: btn_1; x: 11;y:262;enabled:true;text:"Update";visible:true;opacity: 1.0;onBtnClick:{mySerialThread.adminSetup(Number(password),5,0,0,0,0,0);}}
            PropertyChanges{ target: btn_2; x: 170;y:262;text:"Cancel";visible:true;opacity: 1.0;onBtnClick:{page_adminSetup_2.state = "Idle";}}
            PropertyChanges{ target: btn_3; x: 330; y: 262;text:"Backup Update";visible:true;opacity: 1.0;onBtnClick:{myupdatefile.replaceBackupUI()}}
            PropertyChanges{ target: btn_4; x: 11; y: 362;text:"Backup Remove";visible:true;opacity: 1.0;onBtnClick:{myupdatefile.removeBackupUI()}}
            PropertyChanges{ target: btn_5;x: 170; y: 362;text:"sh1 Update";visible:true;opacity: 1.0;onBtnClick:{myupdatefile.updateSH1()}}
            PropertyChanges{ target: btn_6;x: 330; y: 362;text:"sh2 Update";visible:true;opacity: 1.0;onBtnClick:{myupdatefile.updateSH2()}}
        },

        State {
            name: "EPROM"
            PropertyChanges{ target: btn_recovery;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_firmware;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_log;visible:true;opacity: 0.6}

            PropertyChanges{ target: btn_TspUpdate;visible:true;opacity: 0.6;y:146}
            PropertyChanges{ target: btn_EPRom; x: 330;visible:true;opacity: 1.0;y:146}
            PropertyChanges{ target: btn_deleteTemp;visible:true;opacity: 0.6;y:146}

            PropertyChanges{ target: btn_1; x: 74;y:262;enabled:true;text:"Update";visible:true;opacity: 1.0;onBtnClick:{mySerialThread.adminSetup(Number(password),6,0,0,0,0,0);}}
            PropertyChanges{ target: btn_2; x: 276;y:262;text:"Cancel";visible:true;opacity: 1.0;onBtnClick:{page_adminSetup_2.state = "Idle";}}
            PropertyChanges{ target: btn_3;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_4;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_5;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_6;visible:false;opacity: 0.0}
            PropertyChanges{ target: label_updateState;visible:false}
        },

        State{
            name: "DeleteTemp"
            PropertyChanges{ target: btn_recovery;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_firmware;visible:true;opacity: 0.6}
            PropertyChanges{ target: btn_log;visible:true;opacity: 0.6}

            PropertyChanges{ target: btn_TspUpdate;visible:true;opacity: 0.6;y:146}
            PropertyChanges{ target: btn_EPRom; x: 330;visible:true;opacity: 0.6;y:146}
            PropertyChanges{ target: btn_deleteTemp;visible:true;opacity: 1.0;y:146}
            PropertyChanges{ target: label_updateState;visible:false }

            PropertyChanges
            {
                target: btn_1; x: 74;y:262;text:"Delete";visible:true;opacity: 1.0;
                onBtnClick:
                {
                    myupdatefile.deleteFile();
                }
            }

            PropertyChanges
            {
                target: btn_2;
                x: 276;y:262;
                text:"Cancel";
                visible:true;opacity: 1.0;
                onBtnClick:
                {
                    page_adminSetup_2.state = "Idle";
                    if(myupdatefile.isExists())
                    {
                        btn_1.enabled = true;
                    }
                    else
                        btn_1.enabled = false;
                }
            }
            PropertyChanges{ target: btn_3;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_4;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_5;visible:false;opacity: 0.0}
            PropertyChanges{ target: btn_6;visible:false;opacity: 0.0}
        }

    ]

    transitions:
        Transition
        {
            NumberAnimation { property: "opacity"; duration: 500}
            NumberAnimation { property: "y"; duration: 500}
        }
}
