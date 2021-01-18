import QtQuick 2.0
import QtQuick.Controls 2.2



Rectangle
{
    id:root
    width: 480
    height: 300
    color: clr_gray2
    state: "inactive"


//    property string sHour
//    property string sMin
//    property string sSec

    property int iHour
    property int iMin
    property int iSec

    property Item surface: parent

    onIHourChanged:
    {
        timeSelector.hourValue =  iHour;
    }

    onIMinChanged:
    {
        timeSelector.minValue =  iMin;
    }

    onISecChanged:
    {
        timeSelector.secValue =  iSec;
    }

    function show()
    {
        root.state = "active";
    }

    function hide()
    {
        root.state = "inactive";
    }

    y: surface.height

    signal sigOKClicked();

    states: [
        State {
            name: "active"
            PropertyChanges { target: root; y: (surface.height - root.height ); z:1}
        },
        State {
            name: "inactive"
            PropertyChanges { target: root; y: surface.height;z:0}
        }

    ]

    transitions: Transition {
        NumberAnimation {
            target: root
            property: "y"
            easing.type: "OutQuad"
            duration: 250
        }
    }

    Selector_Time
    {
          id: timeSelector;
          anchors.fill: parent;

          visible: true;


          hourZeroFlags:true
          minZeroFlags: true
          secZeroFlags: true

          //hourModel: 24;
          hourModel:24
          minModel: 60;
          secModel: 60;

          onSigHourValue:
          {
              ("HourValue = " + index);
              if(index < 10)
              {
                 myHour = "0" +  index.toString();
              }
              else
              {
                  myHour = index.toString();
              }

          }

          onSigMinValue:
          {
             // console.log("minValue = " + index);

              if(index < 10)
              {
                 myMin = "0" +  index.toString();
              }
              else
              {
                  myMin = index.toString();
              }
          }

          onSigSecValue:
          {
             // console.log("secValue = " + index);
              if(index < 10)
              {
                 mySec = "0" +  index.toString();
              }
              else
              {
                  mySec = index.toString();
              }
          }

          onSigConfirmOK:
          {
             // console.log("TimeOK","time:" , myHour ,":",myMin,":",mySec);
              root.sigOKClicked();
              root.state = "inactive";
          }

          onSigCancel:
          {
              //console.log("cancel");
              root.state = "inactive";
          }

    }
}
