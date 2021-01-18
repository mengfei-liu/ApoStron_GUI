.import QtQuick.LocalStorage 2.0 as Sql
.import "UnitConvert.js" as UC


function getDatabase()
{
    var db = Sql.LocalStorage.openDatabaseSync("MyDatabase","","MyDatabase",100000);
    return db;
}

function initialize()
{
    var db = getDatabase();

    db.transaction(

           function(tx)
           {
               tx.executeSql('PRAGMA foreign_keys = ON;');
               tx.executeSql('create table if not exists dttData (id int,dtt float)');
               tx.executeSql('create table if not exists logData (id int primary key,date date, startTime time, endTime time, eclipsedTime varchar(15), mode varchar(15),unit int, accuracy varchar(8),measuredPts int, dtr float,swing float,foreign key(id) references dttData(id))');
           }
   );
}

function getMaxID()
{
    var db = getDatabase();
    var maxid=0;

    db.transaction
    (
        function(tx)
        {
            var  results = tx.executeSql('SELECT MAX(id) AS id from logData')

            maxid = results.rows.item(0).id;
            console.log("maxid= ",maxid)
        }
    );

    return maxid;
}

function insertLogData(logArray)
{
    var db = getDatabase();
    var logData =[];
    var dttData;
    for(var i = 0; i < logArray.length-1; i++)
    {
        logData.push(logArray[i]);
    }
    dttData = logArray[logArray.length-1];

    db.transaction
    (
        function(tx)
        {
            // tx.executeSql('INSERT INTO logData VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)',[1,"2019-06-02","12:30:21","12:32:21","2 min 0 sec","mode2",false,"low",2,1.2,2.2],function () { console.log('添加数据成功'); },function (tx, error) { console.log('添加数据失败: ' + error.message);})
            tx.executeSql('INSERT INTO logData VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)',[logData[0],logData[1],logData[2],logData[3],logData[4],logData[5],logData[6],logData[7],logData[8],logData[9],logData[10]],function () { console.log('添加数据成功'); },function (tx, error) { console.log('添加数据失败: ' + error.message);})
            for(var i=0;i<dttData.length;i++)
            {
                tx.executeSql('INSERT INTO dttData VALUES (?, ?)',[logArray[0],dttData[i]],function () { console.log('添加数据成功'); },function (tx, error) { console.log('添加数据失败: ' + error.message);})
            }
        }
    );
}


function readAll()
{
    var db = getDatabase();
//    db.transaction(
//                function(tx)
//                {

////                    var result = tx.executeSql('SELECT * from dttData INNER JOIN logData ON logData.id=dttData.id;',[],function () { console.log('添加数据成功'); },function (tx, error) { console.log('添加数据失败: ' + error.message);});
////                    console.log(result.rows);

////                    var result2 = tx.executeSql('SELECT * from logData INNER JOIN dttData ON logData.id=dttData.id;',[],function () { console.log('添加数据成功'); },function (tx, error) { console.log('添加数据失败: ' + error.message);});
////                    console.log(result2.rows);

////                    var result3 = tx.executeSql('SELECT * FROM dttData where id = 2');
////                    var len = result3.rows.length;
////                    console.log(result3.rows);
////                    console.log(result3.rows.item(0));


//                }
//             )
    var output =new Array();
    db.transaction(
                function (tx)
                {
//            var results = tx.executeSql(
//                        'SELECT * FROM logData')

//             var results = tx.executeSql('SELECT * from dttData INNER JOIN logData ON logData.id=dttData.id;')

//            for (var i = 0; i < results.rows.length; i++)
//            {
//                console.log(results.rows.item(i).id)
//            }

           var  results = tx.executeSql('select * from logData;')

            for (var j = 0; j < results.rows.length; j++)
            {
                output[j]=new Array();

                var arr1 = [results.rows.item(j).id,results.rows.item(j).date,results.rows.item(j).startTime,
                        results.rows.item(j).endTime,results.rows.item(j).eclipsedTime,results.rows.item(j).mode,
                        results.rows.item(j).unit,results.rows.item(j).accuracy,results.rows.item(j).measuredPts,
                        results.rows.item(j).dtr,results.rows.item(j).swing];

                var results2 = tx.executeSql('SELECT * from dttData INNER JOIN logData ON logData.id='+ results.rows.item(j).id + ' and logData.id=dttData.id;')
                for (var i = 0; i < results2.rows.length; i++)
                {
                   // output.push(results2.rows.item(i).dtt);
                    arr1.push(results2.rows.item(i).dtt);
                }

                for (var k=0;k<arr1.length;k++)
                {
                  output[j][k] = arr1[k]
                }


            }
        }
                )


        return output;
}

function deleteAll(mylist_Auditlog)
{
    var db = getDatabase();
    var maxid=0;

    db.transaction
    (
        function(tx)
        {
            var  results = tx.executeSql('delete from dttData')
        }
    );

    db.transaction
    (
        function(tx)
        {
            var  results = tx.executeSql('delete from logData')
        }
    );

    mylist_Auditlog.clear();

}

function readAll(mylist_Auditlog)
{
    var db = getDatabase();
    var output =new Array();
    db.transaction(
                    function (tx)
                    {

                        var  results = tx.executeSql('select * from logData;')

                        for (var j = 0; j < results.rows.length; j++)
                        {
                            output[j]=new Array();

                            var arr1 = [results.rows.item(j).id,results.rows.item(j).date,results.rows.item(j).startTime,
                                    results.rows.item(j).endTime,results.rows.item(j).eclipsedTime,results.rows.item(j).mode,
                                    results.rows.item(j).unit,results.rows.item(j).accuracy,results.rows.item(j).measuredPts,
                                    results.rows.item(j).dtr,results.rows.item(j).swing];

                            var results2 = tx.executeSql('SELECT * from dttData INNER JOIN logData ON logData.id='+ results.rows.item(j).id + ' and logData.id=dttData.id;')
//                            for (var i = 0; i < results2.rows.length; i++)
//                            {
//                               // output.push(results2.rows.item(i).dtt);
//                                arr1.push(results2.rows.item(i).dtt);
//                            }

                            var dtt_Imperial
                            var dtt_output = "";
                            for (var i = 0; i < results2.rows.length; i++)
                            {
                                arr1.push(results2.rows.item(i).dtt);
                                dtt_Imperial = results2.rows.item(i).dtt;
                                if(results.rows.item(j).unit)
                                {
                                    dtt_Imperial = UC.m2fractional_Ft_Inches(dtt_Imperial)
                                }
                                else
                                {
                                    dtt_Imperial = dtt_Imperial.toFixed(2) + "m"
                                }
                                if(i < results2.rows.length-1)
                                    dtt_output += (dtt_Imperial + " ")
                                else
                                    dtt_output += (dtt_Imperial)
                            }

                            var dtr_Imperial = results.rows.item(j).dtr;

                            var myunit = "Metric"
                            if(results.rows.item(j).unit)
                            {
                                dtr_Imperial = UC.m2fractional_Ft_Inches(dtr_Imperial)
                                myunit = "Imperial"
                            }
                            else
                            {
                                dtr_Imperial = String(dtr_Imperial) + "m"
                            }

                            if(mylist_Auditlog.count >0)
                            {
                                if(mylist_Auditlog.get(0).log_date === "")
                                {
                                    mylist_Auditlog.remove(0);
                                }
                            }

                           /* mylist_Auditlog.append({
                                                   "log_date": results.rows.item(j).date,
                                                       "log_starttime": results.rows.item(j).startTime,
                                                       "log_endtime": results.rows.item(j).endTime,
                                                       "log_ElapsedTime": results.rows.item(j).eclipsedTime,
                                                       "log_unit": myunit,
                                                       "log_accuracy": results.rows.item(j).accuracy,
                                                       "log_mode": results.rows.item(j).mode,
                                                       "log_dtr": dtr_Imperial,
                                                       "log_swing": String(results.rows.item(j).swing),
                                                       "log_measuredPts": String(results.rows.item(j).measuredPts),
                                                       "log_dtt": dtt_output,
                                                   });*/
                            mylist_Auditlog.insert(0,{ "log_date": results.rows.item(j).date,
                                                       "log_starttime": results.rows.item(j).startTime,
                                                       "log_endtime": results.rows.item(j).endTime,
                                                       "log_ElapsedTime": results.rows.item(j).eclipsedTime,
                                                       "log_unit": myunit,
                                                       "log_accuracy": results.rows.item(j).accuracy,
                                                       "log_mode": results.rows.item(j).mode,
                                                       "log_dtr": dtr_Imperial,
                                                       "log_swing": String(results.rows.item(j).swing),
                                                       "log_measuredPts": String(results.rows.item(j).measuredPts),
                                                       "log_dtt": dtt_output
                                                   });

                            for (var k=0;k<arr1.length;k++)
                            {
                              output[j][k] = arr1[k]
                            }
                        }
                    }
                )
}


