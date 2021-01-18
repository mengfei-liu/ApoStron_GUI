Qt.include("UnitConvert.js")

function validateInput(inputRange,is_Unit_Imperial,inputMode,input)
{

    if(inputMode === 1 || inputMode === 3)  //distance
    {
        if(is_Unit_Imperial)
        {
            var pos1 = input.indexOf("f")
            var pos2 = input.lastIndexOf("-")
            var pos3 = input.indexOf("/")
            var pos4 = input.indexOf("in");

            var lastpos = 0;
            var input1 = Number(input.substr(lastpos,pos1 - lastpos));
            var temp = input.substr(lastpos,pos1 - lastpos);
            var isPositive = false;
            if(temp.indexOf("-") === 0)
            {
                isPositive = false;
            }
            else
            {
                isPositive = true;
            }

            lastpos = pos1+3;

            var input2 = Number(input.substr(lastpos,pos2 - lastpos));
            lastpos = pos2+1;

            var input3_1 = Number(input.substr(lastpos,pos3 - lastpos));
            lastpos = pos3+1;

            var input3_2 = Number(input.substr(lastpos,pos4 - lastpos));

            var range = inputRange * 3.2808399;
            var result ;
            var output;

            if(input3_2 !== 0)
            {
                result = input2 / 12 + input3_1/input3_2/12;
            }
            else
            {
                result = input2 / 12;
            }

            //if(input1>= 0)
            if(isPositive)
            {
               output = Math.abs(input1) + result
            }
            else
            {
               output=  -1 * (Math.abs(input1) + result)
            }

            if(Math.abs(input1) > Math.round(range))
            {
                output = m2fractional_Ft_Inches_old(ft2m(output));
                return [false,input, output ,  m2fractional_Ft_Inches_old(inputRange)]
            }
            else if(Math.abs(input1) <= Math.round(range))
            {
                if(Math.abs(input1) === Math.round(range))
                {
                    if(result <= range - Math.round(range))
                    {
                        output = ft2m(output);
                        return [true,output,"",""]
                    }
                    else
                    {
                        output = m2fractional_Ft_Inches_old(ft2m(output));
                        return [false,input, output ,  m2fractional_Ft_Inches_old(inputRange)]
                    }
                }
                else if(Math.abs(input1) < Math.round(range))
                {
                    output = ft2m(output);
                    return [true,output,"",""]
                }
            }
        }
        else        // m
        {
            if(Math.abs(input) > inputRange)
            {
                return [false,input, input ,  inputRange]
            }
            else
            {
                return [true,input, "" ,  ""]
            }
        }
    }
    else                          //swing
    {
        if(Math.abs(input) > 360)
        {
            return [false,input, input ,  360]
        }
        else
        {
            return [true,input, "" ,  ""]
        }
    }
}
