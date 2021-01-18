import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle
{
    id:root
   // width: 60
   // height: 30

    color: "#00000000"
    antialiasing: true
    border.color:"white"
    border.width:1
    radius: 2

    property int iBatteryPercentage:100
    property double barSpacing: 1

    state: "5"

    Rectangle
    {
        height: root.height * 3 /5
        width: root.width / 15
        anchors.left: root.right
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
        antialiasing: true
    }

    onIBatteryPercentageChanged:
    {
        if(root.iBatteryPercentage > 80  &&  root.iBatteryPercentage<= 100)
        {
            root.state = "5"
        }
        else if(root.iBatteryPercentage > 60  &&  root.iBatteryPercentage<= 80)
        {
            root.state = "4"
        }
        else if(root.iBatteryPercentage > 40  &&  root.iBatteryPercentage<= 60)
        {
            root.state = "3"
        }
        else if(root.iBatteryPercentage > 20  &&  root.iBatteryPercentage<= 40)
        {
            root.state = "2"
        }
        else if(root.iBatteryPercentage >= 0  &&  root.iBatteryPercentage<= 20)
        {
            root.state = "1"
        }
        console.log(qsTr("Battery: "),iBatteryPercentage + "%");
    }


    states: [
        State {
            name: "5"
            PropertyChanges { target: cell_1; color:clr_batterygreen}
            PropertyChanges { target: cell_2; color:clr_batterygreen}
            PropertyChanges { target: cell_3; color:clr_batterygreen}
            PropertyChanges { target: cell_4; color:clr_batterygreen}
            PropertyChanges { target: cell_5; color:clr_batterygreen}
        },
        State {
            name: "4"
            PropertyChanges { target: cell_1; color:clr_batterygreen}
            PropertyChanges { target: cell_2; color:clr_batterygreen}
            PropertyChanges { target: cell_3; color:clr_batterygreen}
            PropertyChanges { target: cell_4; color:clr_batterygreen}
            PropertyChanges { target: cell_5; color:"#00000000"}
        },
        State {
            name: "3"
            PropertyChanges { target: cell_1; color:clr_batterygreen}
            PropertyChanges { target: cell_2; color:clr_batterygreen}
            PropertyChanges { target: cell_3; color:clr_batterygreen}
            PropertyChanges { target: cell_4; color:"#00000000"}
            PropertyChanges { target: cell_5; color:"#00000000"}
        },
        State {
            name: "2"
            PropertyChanges { target: cell_1; color:"yellow"}
            PropertyChanges { target: cell_2; color:"yellow"}
            PropertyChanges { target: cell_3; color:"#00000000"}
            PropertyChanges { target: cell_4; color:"#00000000"}
            PropertyChanges { target: cell_5; color:"#00000000"}
        },
        State {
            name: "1"
            PropertyChanges { target: cell_1; color:("red")}
            PropertyChanges { target: cell_2; color:"#00000000"}
            PropertyChanges { target: cell_3; color:"#00000000"}
            PropertyChanges { target: cell_4; color:"#00000000"}
            PropertyChanges { target: cell_5; color:"#00000000"}
        }
    ]


    transitions:
        Transition
        {
            ColorAnimation
            {
                duration: 1000
            }
        }

    Row
    {
        anchors.centerIn: root
        spacing: barSpacing

        Rectangle
        {
            id:cell_1
            width: (root.width - 4 * root.barSpacing) / 6  //(root.width - 4 * root.barSpacing) / 5
            height: root.height * 7 / 8

            border.color: "white"
            border.width: 0
            radius: 0
        }

        Rectangle
        {
            id:cell_2
            width: cell_1.width
            height: cell_1.height

            border.color: "white"
            border.width: cell_1.border.width
            radius: cell_1.radius
        }

        Rectangle
        {
            id:cell_3
            width: cell_1.width
            height: cell_1.height

            border.color: "white"
            border.width: cell_1.border.width
            radius: cell_1.radius
        }

        Rectangle
        {
            id:cell_4
            width: cell_1.width
            height: cell_1.height

            border.color: "white"
            border.width: cell_1.border.width
            radius: cell_1.radius
        }

        Rectangle
        {
            id:cell_5
            width: cell_1.width
            height: cell_1.height

            border.color: "white"
            border.width: cell_1.border.width
            radius: cell_1.radius
        }
    }
}
