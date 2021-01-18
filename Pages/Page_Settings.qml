import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import "../JS/UnitConvert_toFt.js" as M2ft
import "../JS/UnitConvert_toM.js" as Ft2m
import "../JS/UnitConvert.js" as Unit
import "../Widgets"
import "../Widgets_Setting"

Rectangle
{
    objectName: "Page_Settings"

    id:page_settings
    width: 480
    height: 615

    property string pageTitle: qsTr("Settings")

    property variant page_container: null

    property bool old_Unit
    property int old_tolerance

    property alias radio_l_text: radio_l.text
    property alias radio_m_text: radio_m.text
    property alias radio_h_text: radio_h.text

    property alias settings_dateText: text_date.text
    property alias settings_timeText: text_time.text

    Component.onCompleted:
    {

        myheader.titleStr = qsTr("Settings");

        old_Unit = is_Unit_Imperial;

        old_tolerance = tolerance;

        unit_switch.checked = is_Unit_Imperial;

        mySysTime = new Date();
        text_date.text = Qt.formatDateTime(mySysTime, "yyyy-MM-dd");
        text_time.text = Qt.formatDateTime(mySysTime, "hh:mm:ss");

        rect_time.iHour = mySysTime.getHours();
        rect_time.iMin = mySysTime.getMinutes();
        rect_time.iSec = mySysTime.getSeconds();

        rect_date.sYear = mySysTime.getFullYear();
        rect_date.sMonth = mySysTime.getMonth()+1;
        rect_date.sDay = mySysTime.getDate();

        //rect_date.sDay = mySysTime.getDay()+1; //getday ges monday tuesday etc..

        myYear = mySysTime.getFullYear();
        myMonth = Qt.formatDateTime(mySysTime,"MM");
        myDay = Qt.formatDateTime(mySysTime,"dd");

        switch (tolerance)
        {
            case 0:
            {
                radio_l.checked = true;
                radio_m.checked = false;
                radio_h.checked = false;
            }
            break;

            case 1:
            {
                radio_m.checked = true;
                radio_l.checked = false;
                radio_h.checked = false;
            }
            break;

            case 2:
            {
                radio_h.checked = true;
                radio_m.checked = false;
                radio_l.checked = false;
            }
            break;
        }
    }


    Text
    {
        id: text1
        anchors.top: page_settings.top
        anchors.topMargin: 10
        anchors.horizontalCenter: page_settings.horizontalCenter

        font.family:bodyFont.name
        font.pointSize: 19
        font.bold: true
        color: clr_gray2
        text: qsTr("Choose Device Settings")
    }


    Column
    {
        anchors.top:text1.bottom
        anchors.topMargin: 10
        spacing: 20

        Rect_Settings
        {
            titleText:qsTr("Units")
            z:1
            Btn_UnitSwitch
            {
                id:unit_switch
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                z:1
                onPressed:
                {
                    is_Unit_Imperial = !is_Unit_Imperial;
                }
            }

            MouseArea
            {
                anchors.fill: parent

                onClicked:
                {
                     if(rect_date.state == "active" || rect_lang.state == "active" || rect_time.state == "active")
                     {
                         rect_date.state = "inactive"
                         rect_time.state = "inactive"
                         rect_lang.state = "inactive"
                     }
                }
            }
        }

        Rect_Settings
        {
            id:radio
            //titleText:qsTr("Tolerance")
            titleText:qsTr("Accuracy")
            z:1
            Row
            {
                anchors.verticalCenter: radio.verticalCenter
                anchors.right: radio.right
                spacing: 3
                z:1
                Btn_RadioBtn
                {
                    id:radio_h
                    //text: "High"
                    text:  is_Unit_Imperial ? Unit.m2fractional_Ft_Inches(0.01) : "0.01m"
                    onCheckedChanged:
                    {
                        tolerance = 2;
                        //tolerance_value = 0.02
                        tolerance_value = 0.01      //project version 3
                    }
                }

                Btn_RadioBtn
                {
                    id:radio_m
                    //text: "Medium"
                     text:  is_Unit_Imperial ? Unit.m2fractional_Ft_Inches(0.02) : "0.02m"
                    onCheckedChanged:
                    {
                        tolerance = 1;
                        //tolerance_value = 0.05
                        tolerance_value = 0.02      //project version 3
                    }
                }

                Btn_RadioBtn
                {
                    id:radio_l
                    //text: "Low"
                    text:  is_Unit_Imperial ? Unit.m2fractional_Ft_Inches(0.04) : "0.04m"
                    onCheckedChanged:
                    {
                        tolerance = 0;
                        //tolerance_value = 0.1;
                        tolerance_value = 0.04      //project version 3
                    }
                }
            }

            MouseArea
            {
                anchors.fill: radio

                onClicked:
                {
                     if(rect_date.state == "active" || rect_lang.state == "active" || rect_time.state == "active")
                     {
                         rect_date.state = "inactive"
                         rect_time.state = "inactive"
                         rect_lang.state = "inactive"
                     }
                }
            }
        }

        Rect_Settings
        {
            id:local_time
            titleText:qsTr("Local Time")

            Rectangle
            {
                width: 200
                height: 30
                color: "white"
                border.color: clr_gray2
                border.width: 1
                radius: 5

                anchors.right: local_time.right
                anchors.rightMargin: 20
                anchors.verticalCenter: local_time.verticalCenter

                Text
                {
                    id:text_time
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: bodyFont.name
                    font.pointSize: fsize_small
                    color: clr_gray2
                }
            }

            MouseArea
            {
                anchors.fill: local_time
                onClicked:
                {
                    if(rect_time.state == "inactive")
                    {
                        rect_time.state = "active"

                        if(rect_date.state == "active" || rect_lang.state == "active")
                        {
                            rect_date.state = "inactive"
                            rect_lang.state == "inactive"
                        }
                    }
                    else
                    {
                        rect_time.state = "inactive"
                    }
                }
            }

        }

        Rect_Settings
        {
            id:local_date
            titleText:qsTr("Date")

            Rectangle
            {
                width: 200
                height: 30
                color: "white"
                border.color: clr_gray2
                border.width: 1
                radius: 5

                anchors.right: local_date.right
                anchors.rightMargin: 20
                anchors.verticalCenter: local_date.verticalCenter

                Text
                {
                    id:text_date
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: bodyFont.name
                    font.pointSize: fsize_small
                    color: clr_gray2
                }
            }

            MouseArea
            {
                anchors.fill: local_date
                onClicked:
                {
                    if(rect_date.state == "inactive")
                    {
                        rect_date.show();

                        if(rect_time.state == "active" || rect_lang.state == "active")
                        {
                            rect_time.state = "inactive"
                            rect_lang.state == "inactive"
                        }
                    }
                    else
                    {
                        rect_date.hide();
                    }
                }
            }

        }

        Rect_Settings
        {
            id:language
            titleText:qsTr("Language")

            Rectangle
            {
                width: 200
                height: 30
                color: clr_gray3
                border.color: clr_gray2
                border.width: 1
                radius: 5

                anchors.right: language.right
                anchors.rightMargin: 20
                anchors.verticalCenter: language.verticalCenter

                Text
                {
                    id:text_language
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    font.family: bodyFont.name
                    font.pointSize: fsize_small
                    color: clr_gray2
                    text:myLanguage
                }
            }

            MouseArea
            {
                anchors.fill: language
                onClicked:
                {
                    if(rect_lang.state == "inactive")
                    {
                        rect_lang.state = "active"

                        if(rect_date.state == "active"||  rect_time.state == "active")
                        {
                            rect_date.state = "inactive"
                            rect_time.state = "inactive"
                        }
                    }
                    else
                    {
                        rect_lang.state = "inactive"
                    }
                }
            }
        }
    }

    Rect_Date
    {
        id:rect_date

        state: "inactive"

        onStateChanged:
        {
            switch (rect_date.state)
            {
                case "inactive":
                {
                   btn_done.visible = true;
                }
                break;

                case "active":
                {
                    btn_done.visible = false;
                }
                break;
            }
        }

        onSigOKClicked:
        {
            text_date.text = myYear + "-" + myMonth + "-" + myDay;
        }
    }

    Rect_Time
    {
        id:rect_time
        state: "inactive"

        onStateChanged:
        {
            switch (rect_time.state)
            {
                case "inactive":
                {
                   btn_done.visible = true;
                }
                break;

                case "active":
                {
                    btn_done.visible = false;
                }
                break;
            }
        }

        onSigOKClicked:
        {
            text_time.text = myHour + ":" + myMin + ":" + mySec;
        }
    }

    Rect_Language
    {
        id:rect_lang
        state: "inactive"

        onStateChanged:
        {
            switch (rect_lang.state)
            {
                case "inactive":
                {
                   btn_done.visible = true;
                }
                break;

                case "active":
                {
                    btn_done.visible = false;
                }
                break;
            }
        }

        onSigOKClicked:
        {
            text_language.text = myLang;
        }

    }

    Btn_Static
    {
        id:btn_done
        anchors.bottom: page_settings.bottom
        btn_name:"done"
        fontPtSize: fsize_large

        onBtnClick:
        {
            mySerialThread.setParametersPkg(unit_switch.checked,tolerance,(Number(myYear)-2000),Number(myMonth),Number(myDay),Number(myHour),Number(myMin),Number(mySec));

            myheader.dateString  = text_date.text;
            myheader.timeString = text_time.text;

            mySerialThread.systemTime(myheader.dateString + " " + myheader.timeString);


            if(old_tolerance != tolerance || old_Unit != is_Unit_Imperial)
            {
                isSettingsChanged = true;
            }
            else
                isSettingsChanged = false;

            var resultItem = stack.find(
                                         function(item)
                                         {
                                             //console.log(item.objectName);
                                             return item.objectName === page_settings.page_container.objectName ? true : false;
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
}
