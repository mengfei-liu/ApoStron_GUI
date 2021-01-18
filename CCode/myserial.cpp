#include "myserial.h"
#include <QString>
#include <QByteArray>
#include <QBitArray>
#include <QProcess>
#include <QString>
#include <QCoreApplication>
#include <QTimer>
#include <QHostAddress>
#include <QHostInfo>
#include <QNetworkInterface>

#define TIMER_TIMEOUT   (100)
#define TIMER_Data_TIMEOUT   (3000)

//QSerialPort mySerialPort;


//MySerial::MySerial()
MySerial::MySerial(QSerialPort *parent):QSerialPort (parent)
{

    f_DTT = 0.0;
    f_ScanAngle= 0.0;
    f_DTR = 0.0;

    myunit = false;
    mytolrance = 0;

    LevelNumberX = -180.0;
    LevelNumberY = -180.0;

    f_VirtualPoints_X = 0.0;
    f_VirtualPoints_Y = 0.0;

    batteryPercentage = 0;

    CMD_ID = 0x00;
    Last_CMD_ID = 0x10;

   // haveSentCmd = false;

    DTTArray.resize(2);
    ScanAngleArray.resize(2);
    ScanDTRArray.resize(2);
    DTRArray.resize(4);
    DataTimeBatteryArray.resize(7);
    DataArray.resize(3);
    TimeArray.resize(3);
    ArrayX.resize(4);
    ArrayY.resize(4);
    DataSending_A.resize(2);
    DataSending_B.resize(2);
    DataSending_C.resize(2);
    Dip_DistanceArray.resize(4);
    Dip_AccuracyArray.resize(4);
    Dip_AngleArray.resize(4);



    dataSendingTimer->setInterval(TIMER_Data_TIMEOUT);

   // getIPaddress();

   // cmdTimer->setInterval(TIMER_TIMEOUT);

    QObject::connect(this, SIGNAL(readyRead()),this, SLOT(receivefrom()));
    //QObject::connect(&mySerialPort, SIGNAL(readyRead()),this, SLOT(receivefrom()));
    //QObject::connect(this,static_cast<void (QSerialPort::*)(QSerialPort::SerialPortError)>(&QSerialPort::error),this,SLOT(portError()));
    QObject::connect(this,SIGNAL(error(QSerialPort::SerialPortError)),this,SLOT(portError(QSerialPort::SerialPortError)));


    QObject::connect(dataSendingTimer, SIGNAL(timeout()), this, SLOT(dataSendingTimeoutSlot()));

  //  QObject::connect(cmdTimer,SIGNAL(timeout()), this, SLOT(cmdTimerSlot()));
}


void MySerial::closePort()
{
    this->close();
    portOpen = false;
    //mySerialPort.close();
     emit portOpenChanged();
}

void MySerial::screenDark()
{
    system("gpio pwm 40 10");
}

void MySerial::screenLight()
{
    system("gpio pwm 40 600");
}

void MySerial::systemSync()
{
    system("sync");
}

void MySerial::systemRights(QString path)
{
    QString tempCmd = "sudo chgrp pi " + path;

    system(tempCmd.toStdString().c_str());

    tempCmd = "sudo chown pi "+path;
    system(tempCmd.toStdString().c_str());

    system("sync");
}

void MySerial::systemTime(QString sysTime)
{
    QString tempCmd = "sudo date -s '" + sysTime + "'";

    system(qPrintable(tempCmd));

    //qDebug()<<"Set Time To: "<<qPrintable(tempCmd);

//    QString sysCmd = "sudo date -s '" + sysTime + "'";
//    QProcess *proc = new QProcess;
//    proc->start(sysCmd);
//    qDebug()<<"sysCmd: "<<sysCmd;
}

void MySerial::shellUpdate()
{
    QFile file("//home//pi//startup2.sh");

    if(file.exists())
    {
        file.open(QIODevice::ReadWrite);

        QByteArray shellData = file.readAll();

        QString temp =  "gpio mode 40 pwm\r\ngpio pwm 40 600\r\nsleep 2\r\n";

        shellData.insert(0,temp);

        QFile fileTemp("//home//pi//tempShell.sh");
        fileTemp.open(QIODevice::ReadWrite);
        fileTemp.write(shellData);
        fileTemp.close();

        file.close();
        bool isRemoved = file.remove();
        system("sync");
        if(isRemoved)
        {
           fileTemp.close();
           fileTemp.rename("//home//pi//tempShell.sh","//home//pi//startup2.sh");
           fileTemp.close();
           system("chmod 755 //home//pi//startup2.sh");
           system("sync");

           system("sudo chgrp pi //home//pi//startup2.sh");
           system("sudo chown pi //home//pi//startup2.sh");
           system("sync");

        }

    }

}

QString MySerial::getIP()
{
    QList<QHostAddress> hostList = QNetworkInterface::allAddresses();
    QString myip = "ip not available";
    foreach (const QHostAddress& address, hostList)
    {

        if (address.protocol() == QAbstractSocket::IPv4Protocol && address.isLoopback() == false) {

             myip =  address.toString();
        }

    }
    return myip;
}


void MySerial::portSwitch()
{
    if(portOpen)
    {
        this->close();
        portOpen = false;
        //serialData = "Serial port  close";
        //emit serialDataChanged();
    }
    else {

        portOpen =  this->open(QIODevice::ReadWrite);
       // serialData = "Serial port  Opened";
       // emit serialDataChanged();
    }
     emit portOpenChanged();
}

void MySerial::openAndSetPort()
{
    //this->setPortName("COM4");
    // this->setPortName("COM23");
      this->setPortName("/dev/ttyAMA0");

       if(portOpen == false)
       {

           this->close();
           //qDebug()<<"close port";
           portOpen = this->open(QIODevice::ReadWrite);
           //qDebug()<<"port open = "<<portOpen;
           emit portOpenChanged();
       }


       if(portOpen)
       {
          // openPortTimesCnt = 0;

           this->setBaudRate(QSerialPort::Baud115200);
           this->setDataBits(QSerialPort::Data8);
           this->setParity(QSerialPort::NoParity);
           this->setStopBits(QSerialPort::OneStop);
           this->setFlowControl(QSerialPort::NoFlowControl);

           //this->clear(QSerialPort::AllDirections);
       }
}

int MySerial::sendCMD()
{
    if(this->isWritable())
    {
        if(isTimerExist == true)
        {
            return 1;
        }
        else
        {
           // qDebug()<<"/****** Send CMD: "<<mySendPKG.toHex()<<"  ******/\r\n";

            qint64 bytesWritten = this->write(mySendPKG);



            if(bytesWritten == -1)
            {
                qDebug()<<"Failed to write data to port";
            }
            else if(bytesWritten != mySendPKG.size()){
                qDebug()<<"Failed to write all the data to port";
            }
            else
            {
                //haveSentCmd = true;

                timerId = startTimer(TIMER_TIMEOUT);
                isTimerExist = true;
            }

            return 0;
        }

    }
    else
    {
        qDebug()<<"Serial Port Not Open";
        return 2;
    }
}

void MySerial::setSysTime(QByteArray date, QByteArray time)
{
    qDebug() << "New set time";
    QDate d1(int(date.at(0) + 2000), int(date.at(1)), int(date.at(2)));
    QString tempDate = d1.toString("yyyy-MM-dd");

    QTime t1(int(time.at(0)),int(time.at(1)),int(time.at(2)));
    QString tempTime = t1.toString("hh:mm:ss");

    QString sysCmd = "sudo date -s \"" + tempDate + " " + tempTime + "\"";
    system(qPrintable(sysCmd));
    qDebug()<<"Set Time To: "<<qPrintable(sysCmd);
}

void MySerial::setSysTime(QByteArray arr,bool isDate)
{
    QString temp = "";

    if(isDate)
    {
        QDate d1(int(DataArray.at(0) + 2000), int(DataArray.at(1)), int(DataArray.at(2)));
        temp = d1.toString("yyyy-MM-dd");

    }
    else
    {
        QTime t1(int(TimeArray.at(0)),int(TimeArray.at(1)),int(TimeArray.at(2)));
        temp = t1.toString("hh:mm:ss");

    }
    //QString sysCmd = "sudo date --s=" + temp;
    //QString sysCmd = "sudo date -s '" + temp + "'";
    QString sysCmd = "sudo date -s \"" + temp + "\"";

    //QProcess::execute(sysCmd);
    /*QProcess *proc = new QProcess;
    proc->start(sysCmd);
    qDebug()<<"sysCmd: "<<sysCmd;*/

    system(qPrintable(sysCmd));
    qDebug()<<"Sync Time To: "<<qPrintable(sysCmd);
}

void MySerial::timerEvent(QTimerEvent *event)
{
    if(event->timerId() == timerId)
    {

        if(isConfirmed == false)
        {
           isTimerExist = false;
           qDebug()<<"Process Confirm NOT Got, Resend CMD";
           sendCMD();
        }
        else
        {
            qDebug()<<"Process Confirm Got, Kill Timer, Increase ID";

            //idIncrease();

            //killTimer(timerId);
        }

    }
}

void MySerial::cmdTimerSlot()
{

}

void MySerial::dataSendingTimeoutSlot()
{
     qDebug()<<"Time out";
     int i = temp_data_Rcv.length();
    temp_data_Rcv.clear();
    if(dataSending_Send_DataPackage_Idx <= dataSending_Rcv_DataPackageNumber_Idx)
    {
        getDataCompletePkg(3, 1, shortToQByteArray(i), shortToQByteArray(dataSending_Send_DataPackage_Idx));

    }
    else if(dataSending_Send_DataPackage_Idx == dataSending_Rcv_DataPackageNumber_Idx + 1)
    {
        //getDataLastPkg(3, 1, shortToQByteArray(temp_data_Rcv.length()), shortToQByteArray(dataSending_Send_DataPackage_Idx), DataSending_C);
        getDataCompletePkg(3, 1, shortToQByteArray(i), shortToQByteArray(dataSending_Send_DataPackage_Idx));
    }

    dataSendingTimeout_counter += 1;

    if(dataSendingTimeout_counter == 2 && dataSendingTimeout_LastID == dataSendingTimeout_ID)
    {
        dataSendingTimeout_counter = 0;
        isRxMode = false;
    }


    dataSendingTimeout_LastID = dataSending_Send_DataPackage_Idx;
    //dataSendingTimeout_LastID = dataSendingTimeout_ID;
}

void MySerial::idIncrease()
{
    //if(CMD_ID <= 0x0f)
    if(CMD_ID < 0x0f)
    {
        CMD_ID += 0x01;
    }
    else
    {
        CMD_ID = 0x00;
    }
}

void MySerial::portError(QSerialPort::SerialPortError)
{
//    receivedCMD = "serial error :";
//    receivedCMD.append(this->errorString());
//    emit receivedCMDChanged();
}

void MySerial::receivefrom()
{

    int RcvLen = 0;
    unsigned char RcvID = 0x00;
    int RcvCMD = 0;

    if(!isRxMode)
    {
        QByteArray temparray = this->readAll();
        rxBUf.append(temparray);
        //qDebug()<<"Receive Data: "<<rxBUf.toHex().toUpper();
        // CMD mode
        while ( rxBUf.indexOf(0xf0) >= 0 )
        {
            int headerPos = rxBUf.indexOf(0xf0);

            if(headerPos+1 == rxBUf.length()) //0xf0 在最后一位
            {
                rxBUf.remove(0,headerPos);
                break;
            }
            else    //0xf0 不在最后一位
            {
                rxBUf.remove(0,headerPos);
                headerPos = rxBUf.indexOf(0xf0);
                if(rxBUf.at(headerPos+1) >= 4 && rxBUf.at(headerPos+1)<=12) //长度满足要求
                {
                    RcvLen = rxBUf.at(headerPos+1);

                    if((headerPos+1 + 1) == rxBUf.length()) //长度在最后一位
                    {
                        break;
                    }
                    else //长度不在最后一位
                    {
                        int n = rxBUf.at(headerPos+2);
                        //if((unsigned char)rxBUf.at(headerPos+2) >= (unsigned char)0x00 && (unsigned char)rxBUf.at(headerPos+2) <= (unsigned char)0x0f) //ID满足要求
                        if(n >= 0 && n<=15)
                        {
                            RcvID = (unsigned char)rxBUf.at(headerPos+2);

                            if((headerPos+2 + 1) == rxBUf.length()) //ID在最后一位
                            {
                                break;
                            }
                            else //ID不在最后一位
                            {
                                unsigned char cmd_type = (unsigned char)(rxBUf.at(headerPos+3) & 0x80);

                                if(cmd_type == 0x80)
                                {
                                    cmd_type = (unsigned char)(rxBUf.at(headerPos+3) & 0x7f);
                                }
                                else
                                {
                                   cmd_type = (unsigned char)rxBUf.at(headerPos+3);
                                }

                                int icmd_type = cmd_type;
                                //if(cmd_type>= (unsigned char)0x00 && cmd_type <= (unsigned char)0x15)   //cmd type满足要求
                                if(icmd_type >= 0 && icmd_type <= 21)
                                {
                                    RcvCMD = cmd_type;

                                    if((headerPos + 3 + 1) == rxBUf.length()) //cmd type 在最后一位
                                    {
                                        break;
                                    }
                                    else
                                    {
                                         if(rxBUf.length() < RcvLen+1)
                                         {
                                             break;
                                         }
                                         else
                                         {
                                             processBuf = rxBUf.mid(headerPos,RcvLen+1);
                                             //rxBUf.remove(headerPos,RcvLen+1);
                                             rxBUf.remove(0,headerPos+RcvLen+1);
                                             analyzePkg(processBuf);
                                         }
                                    }
                                }
                                else
                                {
                                    rxBUf.remove(0,headerPos+4); //cmd type不满足要求
                                }
                            }
                        }
                        else
                        {
                            qDebug()<<"ID not Valid "<<rxBUf.at(headerPos+2);
                            rxBUf.remove(0,headerPos+3);    //ID不满足要求
                        }
                    }
                }
                else //长度不满足要求
                {
                   rxBUf.remove(0,headerPos+1);
                }
            }
        }
    }
    else
    {
        temp_data_Rcv.append(this->readAll());
//        qDebug()<<"Receive DataSending: "<<temp_data_Rcv.toHex().toUpper();
       // qDebug()<<"Data Len: "<<temp_data_Rcv.length();

//        while (temp_data_Rcv.length() >= dataSending_Rcv_DataLen && (dataSending_Send_DataPackage_Idx <= dataSending_Rcv_DataPackageNumber_Idx))
//        {
//            if(dataSendingTimer->isActive())
//            {
//                dataSendingTimer->stop();
//                qDebug()<<"Timer Stopped";
//            }
//            dataBuf.append(temp_data_Rcv.mid(0,dataSending_Rcv_DataLen));
//            temp_data_Rcv.remove(0,dataSending_Rcv_DataLen);


//            //getDataCompletePkg(3, 0, shortToQByteArray(dataBuf.length()), shortToQByteArray(dataSending_Send_DataPackage_Idx));    //ok
//            getDataCompletePkg(3, 0, shortToQByteArray(4096), shortToQByteArray(dataSending_Send_DataPackage_Idx));    //ok

//            dataSending_Send_DataPackage_Idx += 1;
//        }

        if(temp_data_Rcv.length() == dataSending_Rcv_DataLen && (dataSending_Send_DataPackage_Idx <= dataSending_Rcv_DataPackageNumber_Idx))
        {
//            if(dataSendingTimer->isActive())
//            {
//                dataSendingTimer->stop();
//                qDebug()<<"Timer Stopped";
//            }
            dataBuf.append(temp_data_Rcv.mid(0,dataSending_Rcv_DataLen));
            temp_data_Rcv.remove(0,dataSending_Rcv_DataLen);


            //getDataCompletePkg(3, 0, shortToQByteArray(dataBuf.length()), shortToQByteArray(dataSending_Send_DataPackage_Idx));    //ok
            getDataCompletePkg(3, 0, shortToQByteArray(4096), shortToQByteArray(dataSending_Send_DataPackage_Idx));    //ok
            if(dataSendingTimer->isActive())
            {
                dataSendingTimer->stop();
                dataSendingTimer->start();
            }
            else
            {
                dataSendingTimer->start();
            }

            dataSending_Send_DataPackage_Idx += 1;
        }

        if( (dataSending_Send_DataPackage_Idx <= dataSending_Rcv_DataPackageNumber_Idx) && temp_data_Rcv.length() < dataSending_Rcv_DataLen )
        {
//           if(dataSendingTimer->isActive())
//           {
//               dataSendingTimer->stop();
//               dataSendingTimer->start();
//           }
//           else
//           {
//               dataSendingTimer->start();
//           }
        }

        if((dataSending_Send_DataPackage_Idx == dataSending_Rcv_DataPackageNumber_Idx + 1))
        {
            if(temp_data_Rcv.length() < dataSending_Rcv_LastPackageLen_CRC)
            {
//                if(dataSendingTimer->isActive())
//                {
//                    dataSendingTimer->stop();
//                    dataSendingTimer->start();
//                }
//                else
//                {
//                    dataSendingTimer->start();
//                }
            }
            else
            {
//                if(dataSendingTimer->isActive())
//                {
//                    dataSendingTimer->stop();
//                    qDebug()<<"Timer Stopped";
//                }
                //temp_data_Rcv =  temp_data_Rcv.mid(0,dataSending_Rcv_LastPackageLen_CRC);
                dataBuf.append(temp_data_Rcv.mid(0,dataSending_Rcv_LastPackageLen_CRC));
                dataSendingTimer->stop();

                uint32_t x = adler32(dataBuf);

                getDataLastPkg(3,0,shortToQByteArray(dataBuf.length()),shortToQByteArray((x >> 16)),shortToQByteArray(( x & 0x0000ffff)));
                isRxMode = false;


            }
        }
    }
}

uint32_t MySerial::adler32(QByteArray data)
{
    for(int index=0;index<data.length();++index)
    {
        a = (a + (unsigned char)data[index]) % MOD_ADLER;
        b = (b + a) % MOD_ADLER;
    }
    return ((b<<16)|a);
}

void MySerial::clearPKG()
{
    mySendPKG.clear();
    isConfirmed = false;
}

unsigned char MySerial::calCRC(QByteArray arr)
{
    unsigned char crc =0x00;
    for(int i=1;i<arr.length()-1;i++)
    {
        crc += arr.at(i);
    }
    //qDebug("CRC Stored in Buffer: %#X",arr.at(arr.length()-1));
    //qDebug("CRC Calculated: %#X",crc);

    return crc;
}

bool MySerial::isCRCcorrect(QByteArray arr)
{
    if(calCRC(arr) == (unsigned char)arr.at(arr.length()-1))
    {
        //qDebug("CRC is RIGHT");
        return true;
    }
    else
    {
        //qDebug("CRC is WRONG");
        return false;
    }
}


/***************************         发送          *****************************/
void MySerial:: getDataLastPkg(int type, int state, QByteArray DataLen_Array, QByteArray DataPackageNumber_Idx_Array, QByteArray LastPackageLen_CRC_Array)
{
    clearPKG();
    mySendPKG[0] = 0xF0; //header
    mySendPKG[1] = 0x00; //Length
    mySendPKG[2] = CMD_ID; //CMD_ID
    //qDebug()<<"Command ID:"<<CMD_ID;
    mySendPKG[3] = 0x15;
    mySendPKG[4] = type;
    mySendPKG[5] = state;
    mySendPKG.append(DataLen_Array);
    mySendPKG.append(DataPackageNumber_Idx_Array);
    mySendPKG.append(LastPackageLen_CRC_Array);
    mySendPKG[1] = mySendPKG.length();

    unsigned char crc = 0x00;
    int len = mySendPKG.length() - 1;
    for(int i =1; i<=len;i++)
    {
        crc += mySendPKG[i];
    }
    mySendPKG.append(crc);

    //sendCMD();
    this->write(mySendPKG);
     idIncrease();
    //qDebug()<<"Type: "<< type <<" state: "<<state;

//    CMD_ID += 0x01;
//    if(state == 1)
//    {
//        dataSendingTimeout_ID = (int)CMD_ID;
//    }
}

void MySerial:: getDataCompletePkg(int type, int state, QByteArray DataLen_Array, QByteArray DataPackageNumber_Idx_Array)
{
    clearPKG();
    mySendPKG[0] = 0xF0; //header
    mySendPKG[1] = 0x00; //Length
    mySendPKG[2] = CMD_ID; //CMD_ID
    qDebug()<<"Data Sending Command ID:"<<CMD_ID;
    mySendPKG[3] = 0x15;
    mySendPKG[4] = type;
    mySendPKG[5] = state;
    mySendPKG.append(DataLen_Array);
    mySendPKG.append(DataPackageNumber_Idx_Array);
    mySendPKG[10] = 0x00;
    mySendPKG[11] = 0x00;
    mySendPKG[1] = mySendPKG.length();

    unsigned char crc = 0x00;
    int len = mySendPKG.length() - 1;
    for(int i =1; i<=len;i++)
    {
        crc += mySendPKG[i];
    }
    mySendPKG.append(crc);

    //sendCMD();
    this->write(mySendPKG);
    idIncrease();

    qDebug()<<"Send Type: "<< type <<" state: "<<state ;

//    CMD_ID += 0x01;
//    if(state == 1)
//    {
//        dataSendingTimeout_ID = (int)CMD_ID;
//    }
}

void MySerial::setDataSendingPkg(int type, int state, QByteArray DataLen_Array, QByteArray DataPackageNumber_Idx_Array, QByteArray LastPackageLen_CRC_Array)
{
    clearPKG();
    mySendPKG[0] = 0xF0; //header
    mySendPKG[1] = 0x00; //Length
    mySendPKG[2] = CMD_ID; //CMD_ID
    qDebug()<<"Data Sending Command ID:"<<CMD_ID;
    mySendPKG[3] = 0x15;
    mySendPKG[4] = type;
    mySendPKG[5] = state;
    mySendPKG.append(DataLen_Array);
    mySendPKG.append(DataPackageNumber_Idx_Array);
    mySendPKG.append(LastPackageLen_CRC_Array);
    mySendPKG[1] = mySendPKG.length();

    unsigned char crc = 0x00;
    int len = mySendPKG.length() - 1;
    for(int i =1; i<=len;i++)
    {
        crc += mySendPKG[i];
    }
    mySendPKG.append(crc);

    //sendCMD();
    this->write(mySendPKG);
    idIncrease();
    qDebug()<<"Send Type: "<< type <<" state: "<<state;
}

void MySerial::uiSendConfirm()
{
    if(!processBuf.isEmpty())
    {
        sendConfirm(processBuf);
    }
    else
    {
        serialSendCMD = "NOT GET ANYDATA";
        emit serialSendCMDChanged();
    }

}

void MySerial::sendConfirm(QByteArray data)
{
    QByteArray confirmPKG;
    confirmPKG.clear();
    confirmPKG.append(0xf0); //header
    confirmPKG.append(0x04); //length
    confirmPKG.append(data.at(2)); //ID
    confirmPKG.append(0x08); //Command type

    unsigned char crc = 0x00;
    int len = confirmPKG.length() - 1;
    for(int i =1; i<=len;i++)
    {
        crc += confirmPKG[i];
    }

    confirmPKG.append(crc); //CRC

    qint64 bytesWritten = this->write(confirmPKG);

    if(bytesWritten == -1)
    {
        qDebug()<<"Failed to write data to port";
    }
    else if(bytesWritten != confirmPKG.size()){
        qDebug()<<"Failed to write all the data to port";
    }
    else
    {
        //qDebug()<<"Send Confirm !!!!";
    }
}

void MySerial::setPkg(int modeType,float angle,float distance)
{
    //myPKG.clear();
    clearPKG();
    mySendPKG[0] = 0xF0; //header
    mySendPKG[1] = 0x00; //Length
    mySendPKG[2] = CMD_ID; //CMD_ID
    //qDebug()<<"Command ID:"<<CMD_ID;

    unsigned char mode = 0x00;
    mode |= 0x80;

    mySendPKG[3] = mode;

    mySendPKG[4] = modeType;

    mySendPKG[5] = 0x00;

    angle = angle * 100 / 10;
    short myAngle = angle;

    QByteArray array_short(reinterpret_cast<const char*>(&myAngle), sizeof(myAngle));
    mySendPKG.append(array_short);

    QByteArray array_float(reinterpret_cast<const char*>(&distance), sizeof(distance));
    mySendPKG.append(array_float);

    mySendPKG[1] = mySendPKG.length();

    unsigned char crc = 0x00;
    int len = mySendPKG.length() - 1;
    for(int i =1; i<=len;i++)
    {
        crc += mySendPKG[i];
    }
    mySendPKG.append(crc);

    sendCMD();
}

void MySerial::setPkg(QString OperationCMD)
{
    clearPKG();
    QStringList OperationOptions;
    OperationOptions<<"measure"<<"done"<<"LevelAdjust"<<"LevelDone"<<"Dip";
    unsigned char CMD_Type;

    mySendPKG[0] = 0xF0; //header
    mySendPKG[1] = 0x00; //Length
    mySendPKG[2] = CMD_ID; //CMD_ID
  //  qDebug()<<"Command ID:"<<CMD_ID;

    switch (OperationOptions.indexOf(OperationCMD))
    {
        case 0:
        {
            CMD_Type = 0x01; // 0x01: measure
        }
        break;

        case 1:
        {
            CMD_Type = 0x06; // 0x06: DONE
        }
        break;

        case 2:
        {
            CMD_Type = 0x09; // 0x09: Level adjust
            qDebug()<<"Level Adjust !!!!";
        }
        break;

        case 3:
        {
            CMD_Type = 0x0b; //0x0b: Level Done
        }
        break;

        case 4:
            CMD_Type = 0x16; // 0x16 dip
        break;
    }
    CMD_Type |= 0x80;
    mySendPKG[3] = CMD_Type;

    mySendPKG[1] = mySendPKG.length(); // set length

    unsigned char crc = 0x00;   // set CRC
    int len = mySendPKG.length() - 1;
    for(int i =1; i<=len;i++)
    {
        crc += mySendPKG[i];
    }

    mySendPKG.append(crc);
    sendCMD();
}

void MySerial::setPkg(QString OperationCMD,QString Operate)
{
    clearPKG();
    unsigned char CMD_Type;
    QStringList OperationCMDOptions;
    OperationCMDOptions<<"SpadeA"<<"SpadeB"<<"Pivot"<<"Scan"<<"Complete";

    mySendPKG[0] = 0xF0; //header
    mySendPKG[1] = 0x00; //Length
    mySendPKG[2] = CMD_ID; //CMD_ID
  //  qDebug()<<"Command ID:"<<CMD_ID;

    switch (OperationCMDOptions.indexOf(OperationCMD))
    {
        case 0:
        {
            CMD_Type = 0x02; // 0x02: SpadeA
        }
        break;

        case 1:
        {
            CMD_Type = 0x03; // 0x03: SpadeB
        }
        break;

        case 2:
        {
            CMD_Type = 0x04; // 0x04: Pivot
        }
        break;

        case 3:
        {
            CMD_Type = 0x05; //0x05: Scan
        }
        break;

        case 4:
        {
            CMD_Type = 0x0c; //0x0c: Complete
        }
        break;
    }
    CMD_Type |= 0x80;
    mySendPKG[3] = CMD_Type;

    QStringList OperateOptions;
    OperateOptions<<"start"<<"take"<<"cancel"<<"mark"<<"spadeA"<<"spadeB"<<"pivot"<<"levelDone"<<"DISDETSTAR"<<"DISDETDONE"<<"DIP"<<"PLT"; //20190614
    //OperateOptions<<"start"<<"take"<<"cancel"<<"mark"<<"spadeA"<<"spadeB"<<"pivot"<<"levelDone";

    switch (OperateOptions.indexOf(Operate))
    {
        case 0:
        {
            CMD_Type = 0x00; // 0x00: start
        }
        break;

        case 1:
        {
            CMD_Type = 0x01; // 0x01: take
            qDebug()<<"Send Take Command\r\n";
        }
        break;

        case 2:
        {
            CMD_Type = 0x02; // 0x02: cancel
        }
        break;

        case 3:
        {
            CMD_Type = 0x01; //0x01: mark
        }
        break;

        case 4:
        {
            CMD_Type = 0x00; //0x00: spadeA
        }
        break;

        case 5:
        {
            CMD_Type = 0x01; //0x01: spadeB
        }
        break;

        case 6:
        {
            CMD_Type = 0x02; //0x02: pivot
        }
        break;

        case 7:
        {
            CMD_Type = 0x03; //0x03: levelDone
        }
        break;

        //20190614
        case 8:
        {
            CMD_Type = 0x02; //0x02: DISDETSTAR
        }
        break;

        case 9:
        {
            CMD_Type = 0x03; //0x03: DISDETDONE
        }
        break;

        case 10:
        {
            CMD_Type = 0x04; //0x04: DIP
        }
        break;

        case 11:
        {
            CMD_Type = 0x05; //0x05: PLT
        }
        break;
    }
    mySendPKG[4] = CMD_Type;

    mySendPKG[1] = mySendPKG.length(); // set length

    unsigned char crc = 0x00;   // set CRC
    int len = mySendPKG.length() - 1;
    for(int i =1; i<=len;i++)
    {
        crc += mySendPKG[i];
    }

    mySendPKG.append(crc);

    mySendPKG[1] = mySendPKG.length() - 1; // set length add crc
    sendCMD();
}

void MySerial::adminSetup(qint16 psw,int index,int content_1,int content_2,int content_3,int content_4,int content_5)
{
    clearPKG();
    mySendPKG[0] = 0xF0; //header
    mySendPKG[1] = 0x00; //Length
    mySendPKG[2] = CMD_ID; //CMD_ID
    qDebug()<<"Admin Command ID:"<<CMD_ID;
    mySendPKG[3] = (0x13 | 0x80);

    mySendPKG.append(shortToQByteArray(psw));
    mySendPKG.append(index);

    mySendPKG.append(content_1);
    mySendPKG.append(content_2);
    mySendPKG.append(content_3);
    mySendPKG.append(content_4);
    mySendPKG.append(content_5);

    mySendPKG[1] = mySendPKG.length();

    unsigned char crc = 0x00;
    int len = mySendPKG.length() - 1;
    for(int i =1; i<=len;i++)
    {
        crc += mySendPKG[i];
    }

    mySendPKG.append(crc);
    sendCMD();

    if(index == 5)
    {
        updateDone = 0;
        emit updateDoneChanged();
    }
}

void MySerial::superReset(int i)
{
   clearPKG();
   mySendPKG[0] = 0xF0; //header
   mySendPKG.append(0x05);
   mySendPKG.append(CMD_ID);
  // qDebug()<<"Command ID:"<<CMD_ID;
   mySendPKG.append((0x14 | 0x80));
   mySendPKG.append(i);

   unsigned char crc = 0x00;   // set CRC
   int len = mySendPKG.length() - 1;
   for(int n =1; n<=len;n++)
   {
       crc += mySendPKG[n];
   }
   mySendPKG.append(crc);
   sendCMD();
}

void MySerial::setParametersPkg(int iUnit,int iTolerance,int iYear,int iMonth,int iDate,int iHour,int iMinute,int iSecond)
{
    clearPKG();
    mySendPKG[0] = 0xF0; //header
    mySendPKG[1] = 0x0c; //Length
    mySendPKG[2] = CMD_ID; //CMD_ID
   // qDebug()<<"Command ID:"<<CMD_ID;
    mySendPKG[3] = (0x0f | 0x80);

    mySendPKG.append(iUnit);
    mySendPKG.append(iTolerance);
    mySendPKG.append(iYear);
    mySendPKG.append(iMonth);
    mySendPKG.append(iDate);
    mySendPKG.append(iHour);
    mySendPKG.append(iMinute);
    mySendPKG.append(iSecond);

    unsigned char crc = 0x00;   // set CRC
    int len = mySendPKG.length() - 1;
    for(int i =1; i<=len;i++)
    {
        crc += mySendPKG[i];
    }

    mySendPKG.append(crc);
    sendCMD();

    QDate d1(int(iYear + 2000), int(iMonth), int(iDate));
    QString tempDate = d1.toString("yyyy-MM-dd");

    QTime t1(iHour,iMinute,iSecond);
    QString tempTime = t1.toString("hh:mm:ss");

    QString sysCmd = "sudo date -s \"" + tempDate + " " + tempTime + "\"";
//    QString sysCmd = "sudo date -s \"" + temp + "\"";
//    system(qPrintable(sysCmd));
//    qDebug()<<"Set Date To: "<<qPrintable(sysCmd);

 //   sysCmd = "sudo date -s \"" + tempTime + "\"";
    system(qPrintable(sysCmd));
    qDebug()<<"Set Time To: "<<qPrintable(sysCmd);


}

/******************************************************************************/


/***************************         解析          *****************************/
void MySerial::analyzePkg(QByteArray data) //from lower
{

    unsigned char chr = 0x00;

    if(isCRCcorrect(data))
    {

        chr = data.at(3);

        if((data.at(3) & 0x80) == 0x80)
        {
            sendConfirm(data);    //move to test page
            chr &=0x7f;
        }

        switch (int(chr))
        {

            case 0:
            { qDebug()<<"get mode cmd";}
            break;

            case 1:
            {qDebug()<<"get measure cmd";}
            break;

            case 2:
            {qDebug()<<"get SpatzA cmd";}
            break;

            case 3:
            {qDebug()<<"get SpatzB cmd";}
            break;

            case 4:
            {qDebug()<<"get Pivot cmd";}
            break;

            case 5:
            {qDebug()<<"get Scan cmd";}
            break;

            case 6:
            {qDebug()<<"get DONE cmd";}
            break;

            case 7:
            {
                DTTArray.clear();
                DTTArray= data.mid(4,2);
                f_DTT = float(QByteArrayToShort(DTTArray) / 100.0f);
                emit dttChanged();
                qDebug()<<"DTT:"<<f_DTT;    //dip tolerance

                ScanAngleArray = data.mid(6,2);

                //ScanDTRArray = data.mid(8,2);
                ScanDTRArray = data.mid(8,4);   //20190615

                f_ScanAngle = QByteArrayToShort(ScanAngleArray) / 100.0f;
                emit scan_angleChanged();   //dip angle
                qDebug()<<"Angle:"<<f_ScanAngle;

                //f_DTR = QByteArrayToShort(ScanDTRArray) / 100.0f;
                f_DTR = QByteArrayToFloat(ScanDTRArray);    //20190615
                emit dtrChanged();      //dip ab dist
                qDebug()<<"DTR:"<<f_DTR;

//                receivedCMD = "DTT_Angle_DTR CMD:";
//                receivedCMD += data.toHex();
//                emit receivedCMDChanged();
            }
            break;

            case 8:
            {
                unsigned char chr_PkgID = data.at(2);

               // receivedCMD = "Get Confirm CMD:";
              //  receivedCMD.append( data.toHex());

                if(!mySendPKG.isEmpty())
                {
                    if(chr_PkgID == (unsigned char)mySendPKG.at(2))
                    {
                        if(isConfirmed == false)
                        {
                            isConfirmed = true;
                            emit isConfirmedChanged();

                            killTimer(timerId);
                            isTimerExist = false;

                            this->idIncrease();

                          //  receivedCMD.append("\r\nID Correct, Confirmed");

                            sendConfirmSig(mySendPKG); // confirm button press


                        }

                    }
                    else
                    {
                        isConfirmed = false;
                        emit isConfirmedChanged();

                      //  receivedCMD.append("\r\nID Not Correct, Not Confirmed");
                    }
                }
                else
                {
                    isConfirmed = false;
                    qDebug("Send Package is Empty");
                  //  receivedCMD.append("\r\nhave not sent anything, Not Confirmed");
                }
                //emit receivedCMDChanged();
            }
            break;

            case 9:
            {qDebug()<<"get LevelAdjust";}
            break;

            case 10:
            {
                ArrayX.clear();
                ArrayY.clear();

                ArrayY= data.mid(4,4);
                ArrayX= data.mid(8,4);

                //ArrayX= data.mid(4,4);
                //ArrayY= data.mid(8,4);

                LevelNumberX = QByteArrayToFloat(ArrayX);
                LevelNumberY = QByteArrayToFloat(ArrayY);

//                LevelNumberX += 10;
//                LevelNumberY += 10;

                if(LevelNumberX < -180)
                {
                    LevelNumberX = -180;
                }
                else if(LevelNumberX > 180)
                {
                    LevelNumberX = 180;
                }


                if(LevelNumberY < -180)
                {
                    LevelNumberY = -180;
                }
                else if(LevelNumberY > 180)
                {
                    LevelNumberY = 180;
                }
                emit levelXChanged();
                emit levelYChanged();

                //qDebug()<<"LevelNumber_X:"<<LevelNumberX;
                //qDebug()<<"LevelNumber_Y:"<<LevelNumberY;

//                receivedCMD = "Get Level Number CMD:";
//                receivedCMD.append( data.toHex());
//                receivedCMD.append(" Level X = "+ QString::number(LevelNumberX));
//                receivedCMD.append(" Level Y = " + QString::number(LevelNumberY));
//                emit receivedCMDChanged();
            }
            break;

            case 11:
            {qDebug()<<"get Level Done cmd";}
            break;

            case 12:  //////////////complete cmd////////////////
            {
                //qDebug()<<"get complete cmd";
                sendCompleteSig(data); // get button complete state
            }
            break;

            case 13:
            {


                //myunit = int(data.at(4));
                //emit unitChanged();
//                if(myunit != int(data.at(4)))
//                {
//                    myunit = int(data.at(4));
//                    emit unitChanged();
//                }
                 qDebug()<<"Receive Data: "<<data.toHex().toUpper();
                if(data.at(4) == 0x00)
                {
                    myunit = false;
                    qDebug()<<"myunit = Metric";
                }
                else
                {
                    myunit = true;
                    qDebug()<<"myunit = Imperial";
                }
                emit unitChanged();



                mytolrance = int(data.at(5));
                emit toleranceChanged();

//                receivedCMD = "Get Boot UP CMD:";
//                receivedCMD += data.toHex();
//                emit receivedCMDChanged();
            }
            break;

            case 14:
            {
                qDebug()<<"get date time battery cmd";


                DataArray.clear();
                TimeArray.clear();
                batteryPercentage = 0;

                DataArray = data.mid(4,3);
                TimeArray = data.mid(7,3);

//                setSysTime(DataArray,true);
//                setSysTime(TimeArray,false);

                setSysTime(DataArray,TimeArray);
                batteryPercentage = int(data.at(10));
                emit batteryChanged();

//                receivedCMD = "Get Date Time Battery CMD:";
//                receivedCMD += data.toHex();
//                emit receivedCMDChanged();
            }
            break;

            case 15:
            {qDebug()<<"get Set Parameters cmd";}
            break;

            case 16:
            {
//                qDebug()<<"get DTR cmd";

//                DTRArray = data.mid(4,4);
//                f_DTR = QByteArrayToFloat(DTRArray);
//                qDebug()<<"DTR: "<<f_DTR;
                //TargetAngleArray = data.mid(8,2);
            }
            break;

            case 17:
            {
                qDebug()<<"get Error Happened cmd";
                emit showErrorPage();
            }
            break;

            case 18:
            {
                qDebug()<<"get Level Adj Requirement cmd";

                setPkg("LevelAdjust");

//                receivedCMD = "Get Level Adj Req CMD:";
//                receivedCMD += data.toHex();
//                emit receivedCMDChanged();
            }
            break;

            case 19:
            {
                qDebug()<<"get AdminSetup cmd";
                progressLevel = 0;
                if(data.at(6) == 0x03)
                {
                    qDebug()<<"Password Error";
                    isAdminPSWCorrect = false;
                    emit isAdminPSWCorrectChanged();
                }
                else
                {
                    qDebug()<<"Password Correct";

                    isAdminPSWCorrect = true;
                    emit isAdminPSWCorrectChanged();

                    if(data.at(6) == 0x04)
                    {
                         progressLevel = (int)((unsigned char)data.at(7));
                         emit progressLevelChanged();
                    }
                }
            }
            break;

            case 20:
            {
                qDebug()<<"SuperReset cmd";
            }
            break;

            case 21:
            {
                qDebug()<<"DataSending cmd";
                DataSending_A.clear();
                DataSending_B.clear();
                DataSending_C.clear();


                switch (data.at(4))
                {
                    case 0:
                    {
                       // progressLevel = (int)((unsigned char)data.at(5));
                       // emit progressLevelChanged();
                    }
                    break;

                    case 1:
                    {
                        //dataSending_Rcv_State = (unsigned char)data.at(5);

                        DataSending_A = data.mid(6,2);
                        DataSending_B = data.mid(8,2);
                        DataSending_C = data.mid(10,2);

                        dataSending_Rcv_DataLen = QByteArrayToShort(DataSending_A);
                        dataSending_Rcv_DataPackageNumber_Idx = QByteArrayToShort(DataSending_B);
                        dataSending_Rcv_LastPackageLen_CRC = QByteArrayToShort(DataSending_C);


                        for(int i=6;i<(data.length()-1);i++)
                        {
                            dataSending_Rcv_State += (unsigned char)data.at(i);
                        }


                        if(dataSending_Rcv_State == (unsigned char)data.at(5))
                        {
                          //send ok
                            dataBuf.clear();
                            dataBuf.resize(0);
                            temp_data_Rcv.clear();
                            updateDone = 1;
                            emit updateDoneChanged();
                            isRxMode = true;
                            setDataSendingPkg(2, 0, DataSending_A, DataSending_B, DataSending_C);

                        }
                        else
                        {
                           // send bad
                            setDataSendingPkg(2, 1, DataSending_A, DataSending_B, DataSending_C);
                            //isRxMode = false;
                        }

                    }
                    break;

                    case 4:
                    {
                        if(data.at(5) == 0)
                        {

                            qDebug()<<"Data Sending: Success";
                            QString sysCmd = "sync";
                            int writeLen = 0;
                            QFile *file = new QFile;
                            file->setFileName(filePath+"Adam_UI_New");

                            if(file->exists())
                            {

                                file->close();
                                file->flush();
                                QDate qdate;
                                QTime qtime;
                                bool isRenamed = file->rename(filePath+"Adam_UI_New",filePath+"Adam_UI_"+qdate.currentDate().toString("yyyy_MM_dd_")+qtime.currentTime().toString("hh_mm_ss"));
                                file->close();
                                file->flush();
                                system("sync");
                                //QProcess::execute(sysCmd);
                            }

                            file->open(QIODevice::WriteOnly);
                            writeLen = file->write(dataBuf);
                            file->close();
                            bool isFlush = file->flush();
                            if(isFlush)
                            {
                                if(writeLen == dataBuf.length())
                                {
                                    dataBuf.clear();
                                    system("sync");
                                    //QProcess::execute(sysCmd);
                                    updateDone = 2;
                                    emit updateDoneChanged();
                                }
                                else {
                                    updateDone = 3;
                                    emit updateDoneChanged();
                                }

                            }


                            //QDataStream out(file);
                            //writeLen = out.writeRawData(dataBuf,dataBuf.length());

//                            if(out.atEnd())
//                            {
//                                file->flush();
//                                file->close();
//                                delete file;
//                                updateDone = 2;
//                                emit updateDoneChanged();
//                            }



                            //QString sysCmd = "sudo chmod 777 //home//pi//Adam_UI_New";
                           // QString sysCmd = "sudo chmod +x //home//pi//Adam_UI_New";
                            //QProcess::execute(sysCmd);
                           // QProcess *proc = new QProcess;
                           // proc->start(sysCmd);
                           // delete proc;
//                            updateDone = 2;
//                            emit updateDoneChanged();

                            //QFile file(filePath+"Adam_UI_New");

//                            QFile file("//home//pi//Adam_UI");

//                            if(file.exists())
//                            {
//                                file.close();
//                                QDate qdate;
//                                QTime qtime;

//                                bool isRenamed=QFile::rename(filePath+"Adam_UI_New",
//                                                             filePath+"Adam_UI_"
//                                                             +qdate.currentDate().toString("yyyy_MM_dd_")
//                                                             +qtime.currentTime().toString("hh_mm_ss"));
//                                qDebug()<<"rename: "<<isRenamed;
//                                file.close();
//                            }

//                            file.open(QIODevice::WriteOnly);
//                            writeLen = file.write(dataBuf);
//                            file.close();

//                            file.open(QIODevice::WriteOnly);
//                            QDataStream out(&file);
//                            writeLen = out.writeRawData(dataBuf,dataBuf.length());
//                            file.close();

//                            //QString sysCmd = "sudo chmod 777 //home//pi//Adam_UI_New";
//                            QString sysCmd = "sudo chmod +x //home//pi//Adam_UI_New";
//                            //QProcess::execute(sysCmd);
//                            QProcess *proc = new QProcess;
//                            proc->start(sysCmd);

//                            //if(writeLen == dataBuf.length()) //added next day
//                            if(writeLen == dataBuf.length())
//                            {
//                                dataBuf.clear();
//                                file.close();
//                                file.setFileName("//home//pi//updatefile.txt");
//                                if(file.exists())
//                                {
//                                    file.close();
//                                    file.remove();
//                                    file.open(QIODevice::ReadWrite);
//                                    file.remove();
//                                    file.close();
//                                }
//                                else
//                                {
//                                    file.open(QIODevice::ReadWrite);
//                                    file.remove();
//                                    file.close();
//                                }

//                                updateDone = 2;
//                                emit updateDoneChanged();
//                            }

                        }
                        else if(data.at(5) == 1)
                        {
                            qDebug()<<"Data Sending: CRC Fail";
                        }

                    }
                    break;
                }

            }
            break;

            case 22:
                Dip_DistanceArray.clear();
                Dip_AccuracyArray.clear();
                Dip_AngleArray.clear();

                Dip_DistanceArray = data.mid(4,4);   //20191024
                Dip_AccuracyArray = data.mid(8,4);   //20191024
                Dip_AngleArray = data.mid(12,4);

                f_Dip_Distance = QByteArrayToFloat(Dip_DistanceArray);    //20191024
                emit dipDistChanged();
                qDebug()<<"Dip_Distance:"<<f_Dip_Distance;

                f_Dip_Accuracy = QByteArrayToFloat(Dip_AccuracyArray);    //20191024
                emit dipAccuracyChanged();
                qDebug()<<"Dip_Accuracy:"<<f_Dip_Accuracy;

                f_Dip_Angle = QByteArrayToFloat(Dip_AngleArray);    //20191024
                emit dipAngleChanged();
                qDebug()<<"Dip_Angle:"<<f_Dip_Angle;

            break;
        }
    }
}
/******************************************************************************/

/***************************         格式转换          *****************************/
float MySerial::QByteArrayToFloat(QByteArray arr)
{
    QByteArray tempArray;
    tempArray.resize(4);
    tempArray[0] =  arr.at(3);
    tempArray[1] = arr.at(2);
    tempArray[2] = arr.at(1);
    tempArray[3] = arr.at(0);

    float temp;
    QDataStream stream(tempArray);
    stream.setFloatingPointPrecision(QDataStream::SinglePrecision);
    stream >> temp;
    return temp;
}


int MySerial::QByteArrayToInt(QByteArray arr)
{
//    int x;
//    bool ok;
//    x = arr.toHex().toInt(&ok, 16);
//    return x;

    QByteArray tempArray;
    tempArray.resize(4);
    tempArray[0] = arr.at(3);
    tempArray[1] = arr.at(2);
    tempArray[2] = arr.at(1);
    tempArray[3] = arr.at(0);
    int temp;
    QDataStream stream(tempArray);
    stream >> temp;
    return temp;
}

short MySerial::QByteArrayToShort(QByteArray arr)
{
//    bool ok;
//    short x;
//    x = arr.toHex().toShort(&ok,16);
//    return x;

    QByteArray tempArray;
    tempArray.resize(2);
    tempArray[0] = arr.at(1);
    tempArray[1] = arr.at(0);
    short temp;
    QDataStream stream(tempArray);
    stream >> temp;
    return temp;
}

QByteArray MySerial::intToQByteArray(int i)
{
   QByteArray temp(reinterpret_cast<const char*>(&i), sizeof(i));
   return temp;
}

QByteArray MySerial::shortToQByteArray(short i)
{
  QByteArray temp(reinterpret_cast<const char*>(&i), sizeof(i));
  return temp;
}

QByteArray MySerial::floatToQByteArray(float i)
{
   QByteArray temp(reinterpret_cast<const char*>(&i), sizeof(i));
   return temp;
}

QByteArray MySerial::doubleToQByteArray(double i)
{
   QByteArray temp(reinterpret_cast<const char*>(&i), sizeof(i));
   return temp;
}
/******************************************************************************/


/***************************        信号          *****************************/


bool MySerial::getPortOpen()
{
    return portOpen;
}

QByteArray MySerial::getReceivedCMD()
{
    return receivedCMD;
}

QByteArray MySerial::getSerialData()
{
    return serialData;
}

QByteArray MySerial::getSerialSendCMD()
{
    return serialSendCMD;
}

int MySerial::getProgressLevel()
{
    return progressLevel;
}

int MySerial::getUpdateDone()
{
    return updateDone;
}

bool MySerial::getErrorPage()
{
    isErrorPage = true;
    return isErrorPage;
}

bool MySerial::getUnit()
{
   unit = myunit;
   return unit;
}

int MySerial::getTolerance()
{
    tolerance = mytolrance;
    return tolerance;
}

float MySerial::getDipDist()
{
    dipDistance = f_Dip_Distance;
    return dipDistance;
}

float MySerial::getDipAccuracy()
{
    dipAccuracy = f_Dip_Accuracy;
    return dipAccuracy;
}

float MySerial::getDipAngle()
{
    dipAngle = f_Dip_Angle;
    return dipAngle;
}

float MySerial::getdtt()
{
    dtt = f_DTT;
    return dtt;
}

float MySerial::getdtr()
{
    dtr = f_DTR;
    return dtr;
}

float MySerial::getScan_angle()
{
    scan_angle = f_ScanAngle;
    return scan_angle;
}

float MySerial::getLevelX()
{
    levelX = LevelNumberX;
    return levelX;
}

float MySerial::getLevelY()
{
    levelY = LevelNumberY;
    return levelY;
}

int MySerial::getBattery()
{
    iBattery = batteryPercentage;
    return iBattery;
}

bool MySerial::getIsAdminPSWCorrect()
{
    return isAdminPSWCorrect;
}

bool MySerial::getConfirmed()
{
    return isConfirmed;
}

/////////////////////Button A////////////////////
bool MySerial::getSpadeA_start_confirmed()
{
    return spadeA_start_confirmed;
}

bool MySerial::getSpadeA_take_confirmed()
{
    return spadeA_take_confirmed;
}

bool MySerial::getSpadeA_cancel_confirmed()
{
    return spadeA_cancel_confirmed;
}

bool MySerial::getSpadeA_take_completed()
{
    return spadeA_take_completed;
}
///////////////////////////////////////////////////

/////////////////////Button B////////////////////
bool MySerial::getSpadeB_start_confirmed()
{
    return spadeB_start_confirmed;
}

bool MySerial::getSpadeB_take_confirmed()
{
    return spadeB_take_confirmed;
}

bool MySerial::getSpadeB_cancel_confirmed()
{
    return spadeB_cancel_confirmed;
}

bool MySerial::getSpadeB_take_completed()
{
    return spadeB_take_completed;
}
///////////////////////////////////////////////////

/////////////////////Button Pivot////////////////////
bool MySerial::getPivot_start_confirmed()
{
    return pivot_start_confirmed;
}

bool MySerial::getPivot_take_confirmed()
{
    return pivot_take_confirmed;
}

bool MySerial::getPivot_cancel_confirmed()
{
    return pivot_cancel_confirmed;
}

bool MySerial::getPivot_take_completed()
{
    return pivot_take_completed;
}

bool MySerial::getBtn_start_completed()
{
    return btn_start_completed;
}

bool MySerial::getLevel_done()
{
    //level_done = true;
    return level_done;
}

bool MySerial::getScanDISDETDONE_confirmed()
{
    return isScanDISDETDONE_confirmed;
}

bool MySerial::getMode22ndModeCMD_confirmed()
{
    return isMode2_2ndModeCMD_confirmed;
}

bool MySerial::getScanDISDETDONE_completed()
{
    return isScanDISDETDONE_completed;
}

bool MySerial::getAB2Closed()
{
    return isAB_tooClose;
}
//////////////////////////////////////////////////////////////////////

void MySerial::sendCompleteSig(QByteArray arr)
{
    // set false
    spadeA_take_completed = false;
    spadeB_take_completed = false;
    pivot_take_completed = false;
    level_done = false;
    btn_start_completed = false;
    isScanDISDETDONE_completed = false;
    isAB_tooClose = false;

    switch (arr.at(4))
    {
        case 0x00:
        {
            qDebug()<<"SpadeA_take Complete";
            spadeA_take_completed = true;
            emit spadeA_take_completedChanged();
        }
        break;

        case 0x01:
        {
            //qDebug()<<"SpadeB_take Complete";
            spadeB_take_completed = true;
            emit spadeB_take_completedChanged();
        }
        break;

        case 0x02:
        {
            //qDebug()<<"Pivot_take Complete";
            pivot_take_completed = true;
            emit pivot_take_completedChanged();
        }
        break;

        case 0x03:
        {
            //qDebug()<<"Level_Done Complete";
            level_done = true;
            emit level_doneChanged();
        }
        break;

        case 0x04:
        {

            btn_start_completed = true;
            //qDebug()<<"Get btn_start_cancel Complete, Send to Qml";
            emit btn_start_completedChanged();
        }
        break;


        case 0x05:
        {
            //SuperRest 1 success
        }
        break;

        case 0x06:
        {
            //SuperReset 1 fail
        }
        break;

        case 0x07:
        {
            //get dtr complete
            isScanDISDETDONE_completed = true;
            emit isScanDISDETDONE_completeChanged();
        }
        break;

        case 0x08:  //Spade points too close
        {
            qDebug()<<"Serial get AB 2 close";
            isAB_tooClose = true;
            emit isAB_tooCloseChanged();
        }
        break;

        default:
        {
            //btn_start_completed = false;
        }
        break;
    }
}

void MySerial::sendConfirmSig(QByteArray arr)
{

     switch (arr[3] & 0x7f)
     {
         case 0x02:
         {
             //qDebug()<<"SpadeA CMD";
             spadeA_start_confirmed = false;
             spadeA_take_confirmed = false;
             spadeA_cancel_confirmed = false;
             switch (arr[4])
             {
                 case 0x00:
                 {
                     //qDebug()<<"confirm A start";
                     spadeA_start_confirmed = true;
                     emit spadeA_start_confirmedChanged();
                 }
                 break;

                 case 0x01:
                 {
                     //qDebug()<<"confirm A take";
                     spadeA_take_confirmed = true;
                     emit spadeA_take_confirmedChanged();
                 }
                 break;

                 case 0x02:
                 {
                     //qDebug()<<"confirm A cancel";
                     spadeA_cancel_confirmed = true;
                     emit spadeA_cancel_confirmedChanged();
                 }
                 break;
             }
         }
         break;

         case 0x03:
         {
             //qDebug()<<"SpadeB CMD";
             spadeB_start_confirmed = false;
             spadeB_take_confirmed = false;
             spadeB_cancel_confirmed = false;
             switch (arr[4])
             {
                 case 0x00:
                 {
                     //qDebug()<<"confirm B start";
                     spadeB_start_confirmed = true;
                     emit spadeB_start_confirmedChanged();
                 }
                 break;

                 case 0x01:
                 {
                     //qDebug()<<"confirm B take";
                     spadeB_take_confirmed = true;
                     emit spadeB_take_confirmedChanged();
                 }
                 break;

                 case 0x02:
                 {
                     //qDebug()<<"confirm B cancel";
                     spadeB_cancel_confirmed = true;
                     emit spadeB_cancel_confirmedChanged();
                 }
                 break;
             }

         }
         break;

         case 0x04:
         {
             //qDebug()<<"Pivot CMD";
             pivot_start_confirmed = false;
             pivot_take_confirmed = false;
             pivot_cancel_confirmed = false;
             switch (arr[4])
             {
                 case 0x00:
                 {
                     //qDebug()<<"confirm P start";
                     pivot_start_confirmed = true;
                     emit pivot_start_confirmedChanged();
                 }
                 break;

                 case 0x01:
                 {
                     //qDebug()<<"confirm P take";
                     pivot_take_confirmed = true;
                     emit pivot_take_confirmedChanged();
                 }
                 break;

                 case 0x02:
                 {
                     //qDebug()<<"confirm P cancel";
                     pivot_cancel_confirmed = true;
                     emit pivot_cancel_confirmedChanged();
                 }
                 break;
             }
         }
         break;

         case 0x05:
        {
            isScanDISDETDONE_confirmed = false;
            switch (arr[4])
            {
                case 0x03:
                {
                    isScanDISDETDONE_confirmed = true;
                    emit isScanDISDETDONE_confirmedChanged();
                }
                break;
            }
        }
         break;

        case 0x00:
        {
            isMode2_2ndModeCMD_confirmed = false;
            switch (arr[4])
            {
                case 0x02:
                {
                    if(isScanDISDETDONE_confirmed)
                    {
                        isMode2_2ndModeCMD_confirmed = true;
                        emit isMode22ndModeCMD_confirmedChanged();
                    }
                }
                break;
            }
        }
        break;
     }
}

/******************************************************************************/
