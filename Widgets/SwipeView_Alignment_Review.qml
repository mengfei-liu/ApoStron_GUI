import QtQuick 2.0

import QtQuick.Controls 2.0

import "../JS/UnitConvert.js" as UC

Item
{
    id:root
    width: index === 0 ? 150 * 0.8 : 150
    height: 100

    Rectangle
    {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: parent.height
        Text {
            id: text_up

            height: root.height * 0.8
            width: parent.width
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: bodyFont.name
            font.bold: true
            font.pixelSize: fsize_med+5
            minimumPixelSize: fsize_small
            fontSizeMode: Text.HorizontalFit
            color: clr_gray2
            //text: index === 0 ? Number(review_data) : (is_Unit_Imperial? UC.m2fractional_Ft_Inches(Number(review_data).toFixed(3)): (String(Number(review_data).toFixed(2))+"m"))
            //text: index === 0 ? Number(review_data) : (is_Unit_Imperial? UC.m2fractional_Ft_Inches(UC.toFixed(Number(review_data),3)): (String(UC.toFixed(Number(review_data),2))+"m"))
//            text:  pageModeSelection_Mode !==6 ? (index === 0 ? Number(review_data) : (index ===1 ? review_data : (is_Unit_Imperial? UC.m2fractional_Ft_Inches(UC.toFixed(Number(review_data),3)): (String(UC.toFixed(Number(review_data),2))+"m"))))
//                                               : switchNumText(index)

            text: switchText(pageModeSelection_Mode,index);

            function switchNumText(index)
            {
                var text
                switch (index)
                {
                    case 0:
                        text = Number(review_data)
                    break;

                    case 1:
                        if(is_Unit_Imperial)
                        {
                            text = UC.m2fractional_Ft_Inches(UC.toFixed(Number(review_data),3))
                        }
                        else
                        {
                            text = String(UC.toFixed(Number(review_data),3)) + "m"
                        }
                        break;

                    case 2:
                        text = UC.toFixed(Number(review_data),2) + unit_swing
                        break;

                    case 3:
                        text = String(UC.toFixed(Number(review_data),3)) + unit_swing
                        break;
                }
                return String(text);
            }

            function switchText(mode,index)
            {
                var text

                switch (mode)
                {
                case 6:
                    switch (index)
                    {
                    case 0:
                        text = Number(review_data)
                    break;

                    case 1:
                        if(is_Unit_Imperial)
                        {
                            text = UC.m2fractional_Ft_Inches(UC.toFixed(Number(review_data),3))
                        }
                        else
                        {
                            text = String(UC.toFixed(Number(review_data),3)) + "m"
                        }
                        break;

                    case 2:
                        text = UC.toFixed(Number(review_data),2) + unit_swing
                        break;

                    case 3:
                        text = String(UC.toFixed(Number(review_data),3)) + unit_swing
                        break;
                    }
                    break;

                default:
                    switch(index)
                    {
                    case 0:
                        text = Number(review_data);
                        break;

                    case 1:
                        text = review_data;
                        break;

                    default:
                        if(is_Unit_Imperial)
                        {
                            text = UC.m2fractional_Ft_Inches(UC.toFixed(Number(review_data),3))
                        }
                        else
                        {
                            text = String(UC.toFixed(Number(review_data),2))+"m"
                        }
                        break;
                    }
                    break;
                }
                return String(text);
            }
        }

        Text {
            id: text_low
            height: root.height  /4
            width: parent.width
            anchors.top: text_up.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: bodyFont.name
            font.pixelSize: fsize_2xs
            wrapMode: Text.WordWrap
            color: clr_gray2
            //text: index === 0 ? "Number of Points Measured" : "Measured Disance"
//            text: pageModeSelection_Mode !==6 ? (index === 0 ? "Number of Points Measured" : (index === 1 ? "Distance to Reference": "Measured Disance"))
//                                              : switchText(index)

            text:switchText(pageModeSelection_Mode,index);

//            function switchText(index)
//            {
//                var text
//                switch (index)
//                {
//                case 0:
//                    text = "Number of Points Measured"
//                    break;

//                case 1:
//                    text = "Distance"
//                    break;

//                case 2:
//                    text = "Angle"
//                    break;

//                case 3:
//                    text = "Accuracy"
//                    break;
//                }
//                return String(text);
//            }

            function switchText(mode,index)
            {
                var text

                switch (mode)
                {
                case 6:
                    switch (index)
                    {
                    case 0:
                        text = "Number of Points Measured"
                    break;

                    case 1:
                        text = "Distance"
                        break;

                    case 2:
                        text = "Angle"
                        break;

                    case 3:
                        text = "Accuracy"
                        break;
                    }
                    break;

                case 7:
                    switch (index)
                    {
                    case 0:
                        text = "Number of Points Measured"
                        break;

                    case 1:
                        text = "Platform Height"
                        break;

                    default:
                        text = "Distance to Platform"
                        break;
                    }
                break;

                default:
                    switch(index)
                    {
                    case 0:
                        text = "Number of Points Measured"
                        break;

                    case 1:
                        text = "Distance to Reference"
                        break;

                    default:
                        text = "Measured Disance"
                        break;
                    }
                    break;
                }
                return String(text);
            }

        }
    }



}
