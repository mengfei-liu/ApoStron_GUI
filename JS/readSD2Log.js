function readSD2Log(text,mylist_Auditlog)
{
    if(text === "")
    {
       return;
    }
    else
    {
        var arr=text.split("\n");

        for (var i=0;i<arr.length;i++)
        {
            if(arr[i] !== "")
            {
                var type = "";
                var subArr = arr[i].split(" ");
                var ElapsedTime = subArr[4] + " " + subArr[5]+ " " + subArr[6] + " " + subArr[7];

                if((subArr.length -9 >1))
                {
                    for(var j=9;j<subArr.length;j++)
                    {
                        type += subArr[j] + " ";
                    }
                }
                else
                {
                    type = subArr[9];
                }

                console.log("log_type",type)
                if(i==0)
                {
                    mylist_Auditlog.remove(0);
                    mylist_Auditlog.append({"log_date":subArr[0],"log_holeid":subArr[1],
                                           "log_startTime":subArr[2],"log_endTime":subArr[3],
                                           "log_totalElapsedTime":ElapsedTime,"log_markedPoints":subArr[8],"log_type":String(type)});
                }
                else
                {
                    if(arr[i].length > 1)
                    {

                        mylist_Auditlog.append({"log_date":subArr[0],"log_holeid":subArr[1],
                                               "log_startTime":subArr[2],"log_endTime":subArr[3],
                                               "log_totalElapsedTime":ElapsedTime,"log_markedPoints":subArr[8],"log_type":String(type)});
                    }
                }
            }

        }
    }
}
