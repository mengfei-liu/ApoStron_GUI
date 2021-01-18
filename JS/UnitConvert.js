function inch2M(inch)
{
    return inch * 0.0254
}

function m2Inch(m)
{
    return m * 39.37007874
}

function ft2m(ft)
{
    //return ft / 3.28084
    return ft * 0.3048
}

function m2ft(m)
{
    return m * 3.280839895
}

function m2ft_inches(m)
{
    var tempFt = m * 3.280839895 //m=8.5
    var feet = parseInt(tempFt) // ft = 27
    var tempIn = (tempFt - feet) * 12 // 10.64
    var inches = parseInt(tempIn) // in = 10

    var fraction = parseInt((tempIn - inches)*16)
    var denominator = 16;

    //return fraction === 0 ? feet + "' " + inches +"''" : feet + "' " + inches +" "+ fraction+"/16" + "''";

    while(fraction !== 0 && fraction % 2 === 0 && denominator != 2)
    {
        fraction /= 2;
        denominator /= 2;
    }

    //return fraction === 0 ? inches + "''" : inches +" "+ fraction+"/16" + "''";

    var displayOut = "";
    if(fraction ===0)
    {
        if(inches === 0 )
        {
            displayOut = (feet + " '")
        }
        else
        {
            displayOut = (feet + " ' " + Math.abs(inches) + "''")
        }

        return displayOut;
    }
    else
    {
        if(inches === 0 )
        {
           displayOut = (feet + " ' "  + Math.abs(fraction) + "/" + denominator + " ''")
        }
        else
        {
            displayOut = (feet + " ' " + Math.abs(inches) + " " + Math.abs(fraction) + "/" + denominator + " ''")
        }

        return displayOut;
    }

    //return fraction === 0 ? feet + "' " + inches +"''"  : inches +" "+ Math.abs(fraction) + "/" + denominator+ "''";
}

function m2fractionalInches(m)
{
	var tempIn =  m * 39.37007874
	var inches = parseInt(tempIn);

	var denominator = 16;

	var fraction = parseInt((tempIn - inches) * denominator)

    while(fraction !== 0 && fraction % 2 === 0 && denominator != 2)
	{
		fraction /= 2;
		denominator /= 2;
	}

	//return fraction === 0 ? inches + "''" : inches +" "+ fraction+"/16" + "''";

    if(fraction === 0)
    {
        return inches + "''"
    }
    else
    {
        if(inches === 0)
        {
            return fraction + "/" + denominator+ "''"
        }
        else
        {
            return inches +" "+ Math.abs(fraction) + "/" + denominator+ "''";
        }
    }

   // return fraction === 0 ? inches + "''" : inches +" "+ Math.abs(fraction) + "/" + denominator+ "''";
}

function m2fractional_Ft_Inches_old(m)
{
    var tempFt =  m * 3.2808399
    var isPositive = false;

    if( m < 0 )
    {
      isPositive = true;
    }

    var feet = Math.abs(parseInt(tempFt));
    var tempIn=  (Math.abs(tempFt) - feet) * 12;
    var inches = parseInt(tempIn)

    var temptFraction  = tempIn - inches;

    var denominator = 8;//64;
    //var fraction = Math.round(temptFraction * denominator)
    var fraction = Math.floor(temptFraction * denominator)

    while(fraction !== 0 && fraction % 2 === 0 && denominator != 1)
    {
        fraction /= 2;
        denominator /= 2;
    }
    var output = feet + "ft " + inches +"-"+ Math.abs(fraction) + "/" + denominator+ "in";
    if(isPositive)
      return "-" + output;
    else
      return output;
}

function m2fractional_Ft_Inches(m)
{
    var tempFt =  m * 3.2808399
    var isPositive = false;

    if( m < 0 )
    {
      isPositive = true;
    }

    var feet = Math.abs(parseInt(tempFt));
    var tempIn=  (Math.abs(tempFt) - feet) * 12;
    var inches = parseInt(tempIn)

    var temptFraction  = tempIn - inches;

    var denominator = 8;//64;
    //var fraction = Math.round(temptFraction * denominator)
    var fraction = Math.floor(temptFraction * denominator)

    while(fraction !== 0 && fraction % 2 === 0 && denominator != 1)
    {
        fraction /= 2;
        denominator /= 2;
    }
    //var output = feet + "ft " + inches +"-"+ Math.abs(fraction) + "/" + denominator+ "in";
    var output ;

    /*if(feet === 0 && inches === 0 && fraction === 0)
    {
        output = 0 + "in";
    }
    else if(feet === 0 && inches === 0 && fraction !== 0)
    {
        output = Math.abs(fraction) + "/" + denominator + "in";
    }
    else if(feet === 0 && inches !== 0 && fraction === 0)
    {
        output = inches + "in";
    }
    else if(feet === 0 && inches !== 0 && fraction !== 0)
    {
        output = inches +"-"+ Math.abs(fraction) + "/" + denominator + "in";
    }


    else if(feet !== 0 && inches === 0 && fraction === 0)
    {
        output = feet + "ft " + inches + "in";
    }
    else if(feet !== 0 && inches === 0 && fraction !== 0)
    {
        output = feet + "ft " + Math.abs(fraction) + "/" + denominator  + "in";
    }
    else if(feet !== 0 && inches !== 0 && fraction === 0)
    {
        output = feet + "ft " + inches  + "in";
    }
    else if(feet !== 0 && inches !== 0 && fraction !== 0)
    {
        output = feet + "ft " + inches +"-"+ Math.abs(fraction) + "/" + denominator+ "in";
    }*/
    //console.log("feet:",feet," inches:",inches, " fraction:",fraction, " denominator:",denominator)
    switch (feet)
    {
        case 0:
        {
            switch (inches)
            {
            case 0:
            {
                switch (fraction)
                {
                case 0:
                    output = 0 + "in";
                    break;

                default:
                    output = Math.abs(fraction) + "/" + denominator + "in";
                    break;
                }
            }
            break;

            default:
                switch (fraction)
                {
                case 0:
                    output = inches + "in";
                    break;

                default:
                    output = inches +"-"+ Math.abs(fraction) + "/" + denominator + "in";
                    break;
                }
                break;
            }

        }
        break;

    default:
        switch (inches)
        {
        case 0:
        {
            switch (fraction)
            {
            case 0:
                output = feet + "ft " + inches + "in";
                break;

            default:
                output = feet + "ft " + Math.abs(fraction) + "/" + denominator  + "in";
                break;
            }
        }
        break;

        default:
            switch (fraction)
            {
            case 0:
                output = feet + "ft " + inches  + "in";
                break;

            default:
                output = feet + "ft " + inches +"-"+ Math.abs(fraction) + "/" + denominator+ "in";
                break;
            }
            break;
        }
        break;
    }


    if(isPositive)
      return "-" + output;
    else
      return output;
}

function m2fractional_Ft_Inches_Style(m)
{
    var tempFt =  m * 3.2808399
        var isPositive = false;

        if( m < 0 )
        {
          isPositive = true;
        }

        var feet = Math.abs(parseInt(tempFt));
        var tempIn=  (Math.abs(tempFt) - feet) * 12;
        var inches = parseInt(tempIn)

        var temptFraction  = tempIn - inches;

        var denominator = 8;//64;
        var fraction = Math.floor(temptFraction * denominator)

        while(fraction !== 0 && fraction % 2 === 0 && denominator != 1)
        {
            fraction /= 2;
            denominator /= 2;
        }

        //var output = "<font size='4'><b>"+feet+"</b></font>" + "<font size='1'>ft</font> " + "<font size='3'><b>"+inches +"</b>-<b>"+ Math.abs(fraction) + "</b>/<b>" + denominator+ "</b></font><font size='1'>in</font>";
        var output;

        switch (feet)
        {
            case 0:
            {
                switch (inches)
                {
                case 0:
                {
                    switch (fraction)
                    {
                    case 0:
                        output = "<font size='4'><b>" + 0 + "</b></font>" + "<font size='1'>in</font>";
                        break;

                    default:
                        output = "<font size='3'><b>" + Math.abs(fraction) + "</b>/<b>" + denominator + "</b></font><font size='1'>in</font>";
                        break;
                    }
                }
                break;

                default:
                    switch (fraction)
                    {
                    case 0:
                        output = "<font size='3'><b>" + inches + "</b></font><font size='1'>in</font>";
                        break;

                    default:
                        output = "<font size='3'><b>" + inches + "</b>-<b>" + Math.abs(fraction) + "</b>/<b>" + denominator + "</b></font><font size='1'>in</font>";
                        break;
                    }
                    break;
                }

            }
            break;

        default:
            switch (inches)
            {
            case 0:
            {
                switch (fraction)
                {
                case 0:
                    output = "<font size='4'><b>" + feet + "</b></font>" + "<font size='1'>ft</font> " + "<font size='3'><b>" + inches + "</b></font><font size='1'>in</font>";
                    break;

                default:
                    output = "<font size='4'><b>" + feet + "</b></font>" + "<font size='1'>ft</font> " + "<b>" + Math.abs(fraction) + "</b>/<b>" + denominator  + "</b></font><font size='1'>in</font>";
                    break;
                }
            }
            break;

            default:
                switch (fraction)
                {
                case 0:
                    output = "<font size='4'><b>" + feet +"</b></font>" + "<font size='1'>ft</font> " + "<font size='3'><b>" + inches  + "</b><font size='1'>in</font>";
                    break;

                default:
                    output = "<font size='4'><b>"+feet+"</b></font>" + "<font size='1'>ft</font> " + "<font size='3'><b>"+inches +"</b>-<b>"+ Math.abs(fraction) + "</b>/<b>" + denominator+ "</b></font><font size='1'>in</font>";
                    break;
                }
                break;
            }
            break;
        }


        if(isPositive)
          return "-" + output;
        else
          return output;
}

function toFixed(input,length)
{
    var carry = 0; //存放进位标志
    var num,multiple; //num为原浮点数放大multiple倍后的数，multiple为10的length次方
    //var str = this + ''; //将调用该方法的数字转为字符串
    var str = String(input)
    var dot = str.indexOf("."); //找到小数点的位置
    if(str.substr(dot+length+1,1)>=5) carry=1; //找到要进行舍入的数的位置，手动判断是否大于等于5，满足条件进位标志置为1
    multiple = Math.pow(10,length); //设置浮点数要扩大的倍数
    num = Math.floor(input * multiple) + carry; //去掉舍入位后的所有数，然后加上我们的手动进位数
    var result = num/multiple + ''; //将进位后的整数再缩小为原浮点数
    /*
    * 处理进位后无小数
    */
    dot = result.indexOf(".");
    if(dot < 0)
    {
        result += '.';
        dot = result.indexOf(".");
    }
    /*
    * 处理多次进位
    */
    var len = result.length - (dot+1);
    if(len < length)
    {
        for(var i = 0; i < length - len; i++)
        {
        result += 0;
        }
    }
    return Number(result);
}
