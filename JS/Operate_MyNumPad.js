var iDotCnt;
function buttonPressed(item_value,btnText)
{

    if(Number(item_value) === 0)
    {
             switch((btnText))
             {
                case "back":
                {
                    item_value = "0";
                }
                break;

                case "0":
                {
                    iDotCnt = item_value.indexOf(".");
                    if(iDotCnt < 0)
                    {
                       item_value = "0";
                    }
                    else
                    {
                        item_value += (btnText);
                    }

                }
                break;

                case ".":
                {
                    iDotCnt = item_value.indexOf(".");

                    if(iDotCnt < 0 )
                    {
                         item_value += (btnText);
                    }
                }
                break;

                case "±":
                {
                    if(item_value.indexOf(".")>=0)
                    {
                        if(item_value.indexOf("-") >=0)
                        {
                            item_value = "0.";
                        }
                        else
                            item_value = "-0.";
                    }
                    else
                    {
                        item_value = String(Number(item_value) * -1);
                    }

                }
                break;

                case "done":
                {

                }
                break;


                default:
                {
                    if(item_value.indexOf(".") > 0)
                    {
                        item_value += (btnText);
                    }
                    else
                        item_value = (btnText);
                }

             }
           }
           else if(Number(item_value) !== 0)
           {
               switch((btnText))
               {
                case "back":
                {
                    item_value = item_value.substr(0,(item_value.length-1));
                }
                break;


                case ".":
                {
                    iDotCnt = item_value.indexOf(".");
                    if(iDotCnt < 0 )
                    {
                         item_value += (btnText);
                    }
                }
                break;


                case "±":
                {
                    if(item_value.indexOf(".")>=0)
                    {
                        if(item_value.indexOf("-") >=0)
                        {
                            item_value = item_value.substring(1,item_value.length);
                        }
                        else
                            item_value = "-" + item_value;
                    }
                    else
                    {
                        item_value = String(Number(item_value) * -1);
                    }
                }
                break;

                case "done":
                {

                }
                break;

                default:
                    item_value += (btnText);
               }
            }
            else
            {
                switch((btnText))
                {
                 case "back":
                 {
                     item_value = item_value.substr(0,(item_value.length-1));
                 }
                 break;


                 case ".":
                 {
//                     iDotCnt = item_value.indexOf(".");
//                     if(iDotCnt < 0 )
//                     {
//                          str += (btnText);
//                     }
                 }
                 break;


                 case "±":
                 {
                    // str = String(Number(item_value) * -1);
                 }
                 break;

                 case "done":
                 {

                 }
                 break;

                 default:
                     item_value += (btnText);
                }
            }

            return item_value;
}
