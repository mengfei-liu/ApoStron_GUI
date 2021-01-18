import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle
{
    id:root
    width: 480
    height: 300
    color: clr_gray2
    state: "inactive"

    property string sYear
    property string sMonth
    property string sDay

    property Item surface: parent

    y: surface.height

    function show()
    {
        root.state = "active";
    }

    function hide()
    {
        root.state = "inactive";
    }

    function isLeapYear (Year)
    {
        if (((Year % 4)==0) && ((Year % 100)!=0) || ((Year % 400)==0))
        {
            return (true);
        }
        else
        {
            return (false);
        }
    }

    onSYearChanged:
    {
       // yearModel.get(index).numberText;

        for(var i = 0; i < myyearModel.count; i++)
        {
          var currentYear = myyearModel.get(i).numberText;
          if(sYear === currentYear)
          {
            //console.log("Found it at index : ", i);
            dateSelector.yearList.value = i;
            break;
          }
        }

  /*      if(Number(root.sMonth) === 2 && root.isLeapYear(Number(root.sYear)))
        {
            dateSelector.dayModel = 29;
        }
        else if(Number(root.sMonth) === 2 && !root.isLeapYear(Number(root.sYear)))
        {
            dateSelector.dayModel = 28;
        }
        else if(Number(root.sMonth) === 4 || Number(root.sMonth) === 6 || Number(root.sMonth) === 9 || Number(root.sMonth) === 11 )
        {
            dateSelector.dayModel = 30;
        }
        else
        {
            dateSelector.dayModel = 31;
        }*/


    }

    onSMonthChanged:
    {
        dateSelector.monthValue = Number(sMonth)-1;
    }

    onSDayChanged:
    {
        dateSelector.dayValue = Number(sDay)-1;
    }

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

    Selector_Date {
          id: dateSelector;
          anchors.fill: parent;

          visible: true;
          yearTextFlags: true;

          monthZeroFlags: false;
          dayZeroFlags: false;

          yearModel: myyearModel;

          monthModel: 12;
          dayModel: 31;



          onSigYearValue:
          {
             // console.log("yearValue = " + yearModel.get(index).numberText);

              root.sYear = yearModel.get(index).numberText;
              myYear = yearModel.get(index).numberText;

              if(Number(root.sMonth) === 2 && root.isLeapYear(Number(root.sYear)))
              {
                  dayModel = 29;
              }
              else if(Number(root.sMonth) === 2 && !root.isLeapYear(Number(root.sYear)))
              {
                  dayModel = 28;
              }
              else if(Number(root.sMonth) === 4 || Number(root.sMonth) === 6 || Number(root.sMonth) === 9 || Number(root.sMonth) === 11 )
              {
                  dayModel = 30;
              }
              else
              {
                  dayModel = 31;
              }



          }

          onSigMonthValue:
          {
              //console.log("monthValue = " + (index+1));



              if(index+1 == 2 && root.isLeapYear(Number(yearModel.get(index).numberText)))
              {
                  dayModel = 29;
              }
              else if(index+1 == 2 && !root.isLeapYear(Number(yearModel.get(index).numberText)))
              {
                  dayModel = 28;
              }
              else if(index+1 === 4 || index+1 === 6 || index+1 === 9 || index+1 === 11 )
              {
                  dayModel = 30;
              }
              else
              {
                  dayModel = 31;
              }


              //choseMonth = index + 1;
              if(index < 9)
              {
                 // root.sMonth = "0" +  (index+1).toString();
                  myMonth = "0" +  (index+1).toString();
              }
              else
              {
                   //root.sMonth = (index+1).toString();
                 myMonth = (index+1).toString();
              }
                root.sMonth = myMonth;
            //  myMonth = root.sMonth;
              //root.sMonth = String(index + 1);
          }

          onSigDayValue:
          {
              //console.log("dayValue = " + (index+1));
              if(index < 9)
              {
                 // root.sDay = "0" +  (index+1).toString();
                  myDay = "0" +  (index+1).toString();
              }
              else
              {
                  //root.sDay = (index+1).toString();
                  myDay = (index+1).toString();
              }

             // myDay = root.sDay;
              //root.sDay = String(index + 1);
          }

          onSigConfirmOK: {

//              myYear = root.sYear;
//              myMonth = root.sMonth;
//              myDay = root.sDay;

              root.sYear =  myYear;
              root.sMonth = myMonth;
              root.sDay = myDay;

              //console.log("DateOK","year:",myYear," month:",myMonth," day:", myDay);
              root.sigOKClicked();
              root.state = "inactive";
          }

          onSigCancel:
          {
             // console.log("cancel");
              root.state = "inactive";
          }
      }
}
