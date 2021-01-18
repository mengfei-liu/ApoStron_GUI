function buttonPressed(isImperial,mode,keybord_obj,btnText)
{
    //keybord_obj.input_value = btnText

    var vaildIntDigis;
    if(mode === 1 || mode === 3)    //distance
    {
//        if(Number(keybord_obj.input_value) >= 0)
//        {
//            //vaildIntDigis = isImperial ? 3 : 2;
//            vaildIntDigis = isImperial ? 3 : 3;
//        }
//        else
//        {
//            //vaildIntDigis = isImperial ? 4 : 3;
//            vaildIntDigis = isImperial ? 4 : 4;
//        }

        if(!isImperial)
        {
            if(Math.abs(Number(keybord_obj.input_value)) >= 0)
                vaildIntDigis = 2//3
            else
                vaildIntDigis = 3//4
        }

    }
    else                            //swing
    {
        vaildIntDigis = Number(keybord_obj.input_value) >= 0 ? 3 : 4;
    }

    inputCondition(isImperial,mode,keybord_obj,vaildIntDigis,btnText);

}

function inputCondition(isImperial,mode,keybord_obj,vaildIntDigis,btnText)
{
    //if(mode === 2 || mode === 4 || ((mode ===1 || mode === 3)&&(!isImperial)))      //不是分数英尺
    if(mode === 2 || mode === 4)      //swing
    {
        if(keybord_obj.input_value.indexOf(".") > 0 && keybord_obj.input_value.indexOf(".") <= vaildIntDigis)
        {
            if((keybord_obj.input_value.length - keybord_obj.input_value.indexOf(".")) <= 2)  //判断小数点后有几位
            {
                setText(keybord_obj,btnText)
            }
            else
            {
                if(btnText === "back" || btnText === "±" || btnText === ".")
                {
                    setText(keybord_obj,btnText)
                }
            }
        }
        else
        {
            if(keybord_obj.input_value.length < vaildIntDigis)
            {
                if(Math.abs(Number(keybord_obj.input_value)) <= 9 && btnText === "back")
                {
                   keybord_obj.input_value = "0" ;
                   keybord_obj.cursorPosition = keybord_obj.input_value.length;
                }
                else
                {
                    setText(keybord_obj,btnText)
                }
            }
            else
            {
                if(btnText === "back" || btnText === "±" || btnText === ".")
                {
                    setText(keybord_obj,btnText)
                }
            }
        }
    }
    else if((mode ===1 || mode === 3)&&(!isImperial))   //dist 不是分数英尺
    {
        if(keybord_obj.input_value.indexOf(".") > 0 && String(Math.abs(Number(keybord_obj.input_value))).indexOf(".") <= vaildIntDigis)
        {
            if((keybord_obj.input_value.length - (keybord_obj.input_value.indexOf(".")+1)) < vaildIntDigis)  //判断小数点后有几位
            {
                setText(keybord_obj,btnText)
            }
            else
            {
                if(btnText === "back" || btnText === "±" || btnText === ".")
                {
                    setText(keybord_obj,btnText)
                }
            }
        }
        else
        {
            //if(keybord_obj.input_value.length < vaildIntDigis-1) // input int for 3 digis
            if(String(Math.abs(Number(keybord_obj.input_value))).length < vaildIntDigis) // input int
            {
                if(Math.abs(Number(keybord_obj.input_value)) <= 9 && btnText === "back")
                {
                   keybord_obj.input_value = "0" ;
                   keybord_obj.cursorPosition = keybord_obj.input_value.length;
                }
                else
                {
                    setText(keybord_obj,btnText)
                }
            }
            else
            {
                if(btnText === "back" || btnText === "±" || btnText === ".")
                {
                    setText(keybord_obj,btnText)
                }
            }
        }
    }
    else        //分数英尺
    {
        var pos1 = keybord_obj.input_value.indexOf("f")
        var pos2 = keybord_obj.input_value.lastIndexOf("-")
        var pos3 = keybord_obj.input_value.indexOf("/")
        var pos4 = keybord_obj.input_value.indexOf("in");
        var lastpos;
        var currentCurPos = keybord_obj.cursorPosition;
        var currentValue;
        var tempStr;
        var tempBtn;
        switch (currentCurPos)
        {
        case pos1:
            lastpos = 0;
            currentValue = keybord_obj.input_value.substr(lastpos,currentCurPos);

            keybord_obj.input_value = setText_ft(keybord_obj.input_value,currentCurPos,currentValue,btnText) + keybord_obj.input_value.substr(currentCurPos);
            keybord_obj.cursorPosition = keybord_obj.input_value.indexOf("f");
            break;

        case pos2:
            lastpos = pos1+3;
            currentValue = keybord_obj.input_value.substr(lastpos,currentCurPos  - lastpos);

            tempStr = keybord_obj.input_value.substr(0,pos1+3)
            if(btnText === "±")
            {
                tempStr = setNegativeSignOnOff(tempStr)
            }

            keybord_obj.input_value = tempStr + setText_ft(keybord_obj.input_value,currentCurPos,currentValue,btnText)+ keybord_obj.input_value.substr(currentCurPos);

            keybord_obj.cursorPosition = keybord_obj.input_value.lastIndexOf("-");
            break;

        case pos3:
            lastpos = pos2+1;
            currentValue = keybord_obj.input_value.substr(lastpos,currentCurPos - lastpos);
            tempStr = keybord_obj.input_value.substr(0,pos2+1)
            if(btnText === "±")
            {
                tempStr = setNegativeSignOnOff(tempStr)
            }
            keybord_obj.input_value = tempStr + setText_ft(keybord_obj.input_value,currentCurPos,currentValue,btnText)+ keybord_obj.input_value.substr(currentCurPos);
            keybord_obj.cursorPosition = keybord_obj.input_value.indexOf("/");
            break;

        case pos4:
            lastpos = pos3+1;
            currentValue = keybord_obj.input_value.substr(lastpos,currentCurPos - lastpos);
            tempStr = keybord_obj.input_value.substr(0,pos3+1)
            if(btnText === "±")
            {
                tempStr = setNegativeSignOnOff(tempStr)
            }
            keybord_obj.input_value = tempStr + setText_ft(keybord_obj.input_value,currentCurPos,currentValue,btnText)+ keybord_obj.input_value.substr(currentCurPos);
            keybord_obj.cursorPosition = keybord_obj.input_value.indexOf("in");
            break;
        }
    }
}

function setNegativeSignOnOff(text)
{
    if(text.indexOf("-") === 0)
    {
        text = text.substr(1,text.length-1)
    }
    else
    {
        text = "-"+text
    }
    return text
}

function setText_ft(currentText,currentpos,currentValue,btnText)
{
    var pos1 = currentText.indexOf("f")
    var pos2 = currentText.lastIndexOf("-")
    var pos3 = currentText.indexOf("/")
    var pos4 = currentText.indexOf("in");

    var vaildIntDigis;

    var temp = currentValue;

    switch (currentpos)
    {
    case pos1:
      if(currentValue.indexOf("-") === 0)
      {
        vaildIntDigis = 4;
      }
      else
        vaildIntDigis = 3;

       if(Number(currentValue) === 0)
       {
           if(currentValue === "0")
           {
               switch (btnText)
               {
                 case "±":
                   btnText = "-0";
                 break;

                 case "back":
                   btnText =  "0";
                 break;

                 default:
                   btnText =  btnText;
                 break;
               }
           }
           else if(currentValue === "-0")
           {
              if(btnText === "±" || btnText === "back")
              {
                btnText =  "0";
              }
              else
              {
                btnText =  "-" +btnText;
              }
           }
       }
       else
       {
           var currentLen = currentValue.length;
           switch (btnText)
           {
             case "±":
               btnText = String(Number(currentValue) * -1)
             break;

             case "back":
                if(Math.abs(Number(currentValue))<10)
                {
                    btnText  = "0"
                }
                else
                {
                    btnText = currentValue.substr(0,(currentValue.length-1));
                }
             break;

             default:
               if(currentLen < vaildIntDigis)
               {
                 btnText = currentValue + btnText;
               }
               else
               {
                 btnText = currentValue;
               }
             break;
           }
       }
       //return btnText;
       break;

    default:
        vaildIntDigis = 2;
        currentLen = currentValue.length;
        switch (btnText)
        {
            case "±":
            btnText = currentValue;
            break;

            case "back":
            if( Number(currentValue) <10)
            {
                btnText  = "0"
            }
            else
            {
                btnText = currentValue.substr(0,(currentValue.length-1));
            }
            break;

            default:
            if(currentLen < vaildIntDigis)
            {
                if(Number(currentValue) === 0)
                {
                    btnText =  btnText;
                }
                else
                    btnText = currentValue + btnText;
            }
            else
            {
                btnText = currentValue;
            }
            break;
        }
    break;
    }
    return btnText;
}


function setText(keybord_obj,btnText)
{
    var iDotCnt = keybord_obj.input_value.indexOf(".");
    var displayedNum = Number(keybord_obj.input_value);

    if(displayedNum === 0)
    {
             switch((btnText))
             {
                case "back":
                    if(iDotCnt < 0)
                        keybord_obj.input_value = "0";
                    else
                    {
                        keybord_obj.input_value = keybord_obj.input_value.substr(0,keybord_obj.input_value.length -1)
                    }
                break;

                case "0":
                    if(iDotCnt < 0)
                    {
                       keybord_obj.input_value = "0";
                    }
                    else
                    {
                        keybord_obj.input_value += (btnText);
                    }
                break;

                case ".":
                    if(iDotCnt < 0 )
                    {
                         keybord_obj.input_value += (btnText);
                    }
                break;

                case "±":
                    if(iDotCnt >= 0)
                    {
                        if(keybord_obj.input_value.indexOf("-") >=0)
                        {
                            keybord_obj.input_value = "0.";
                        }
                        else
                            keybord_obj.input_value = "-0.";
                    }
                    else
                    {
                        keybord_obj.input_value = String(Number(displayedNum) * -1);
                    }
                break;

                default:
                    if(iDotCnt > 0)
                    {
                        keybord_obj.input_value += (btnText);
                    }
                    else
                        keybord_obj.input_value = (btnText);
             }
           }
           else if(displayedNum !== 0)
           {
               switch((btnText))
               {
                case "back":
                    if(Math.abs(displayedNum)<=9 && keybord_obj.input_value.indexOf(".")<0)
                        keybord_obj.input_value = "0"
                    else
                        keybord_obj.input_value = keybord_obj.input_value.substr(0,(keybord_obj.input_value.length-1));
                break;


                case ".":
                    if(iDotCnt < 0 )
                    {
                         keybord_obj.input_value += (btnText);
                    }
                break;


                case "±":
                    if(iDotCnt >= 0)
                    {
                        if(keybord_obj.input_value.indexOf("-") >=0)
                        {
                            keybord_obj.input_value = keybord_obj.input_value.substring(1,keybord_obj.input_value.length);
                        }
                        else
                        {
                            //keybord_obj.input_value = "-" + displayedNum;
                            keybord_obj.input_value = "-" + keybord_obj.input_value;
                        }

                    }
                    else
                    {
                        keybord_obj.input_value = String(displayedNum * -1);//String(Number(displayedNum) * -1);
                    }
                break;

                default:
                    keybord_obj.input_value += (btnText);
               }
            }

    keybord_obj.cursorPosition = keybord_obj.input_value.length;
}
