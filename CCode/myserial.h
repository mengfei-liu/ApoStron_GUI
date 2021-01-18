#ifndef MYSERIAL_H
#define MYSERIAL_H

#include <QObject>
#include <QtCore>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QDebug>


class MySerial : public QSerialPort
{
    Q_OBJECT
        Q_PROPERTY(QByteArray serialData READ getSerialData NOTIFY serialDataChanged)
        Q_PROPERTY(QByteArray receivedCMD READ getReceivedCMD  NOTIFY receivedCMDChanged)
        Q_PROPERTY(QByteArray serialSendCMD READ getSerialSendCMD  NOTIFY serialSendCMDChanged)
        Q_PROPERTY(bool portOpen READ getPortOpen NOTIFY portOpenChanged)


        Q_PROPERTY(int updateDone READ getUpdateDone  NOTIFY updateDoneChanged)
        Q_PROPERTY(int progressLevel READ getProgressLevel NOTIFY progressLevelChanged)
        Q_PROPERTY(float dtt READ getdtt NOTIFY dttChanged)
        Q_PROPERTY(float dtr READ getdtr NOTIFY dtrChanged)
        Q_PROPERTY(float scan_angle READ getScan_angle NOTIFY scan_angleChanged)
        Q_PROPERTY(bool unit READ getUnit NOTIFY unitChanged)
        Q_PROPERTY(int tolerance READ getTolerance NOTIFY toleranceChanged)

        Q_PROPERTY(float dipDistance READ getDipDist NOTIFY dipDistChanged)
        Q_PROPERTY(float dipAccuracy READ getDipAccuracy NOTIFY dipAccuracyChanged)
        Q_PROPERTY(float dipAngle READ getDipAngle NOTIFY dipAngleChanged)

        Q_PROPERTY(float levelX READ getLevelX NOTIFY levelXChanged)
        Q_PROPERTY(float levelY READ getLevelY NOTIFY levelYChanged)
        Q_PROPERTY(int iBattery READ getBattery NOTIFY batteryChanged)

       /************************************      Buttons     **********************************************/
        Q_PROPERTY(bool spadeA_start_confirmed READ getSpadeA_start_confirmed NOTIFY spadeA_start_confirmedChanged)
        Q_PROPERTY(bool spadeA_take_confirmed READ getSpadeA_take_confirmed NOTIFY spadeA_take_confirmedChanged)
        Q_PROPERTY(bool spadeA_cancel_confirmed READ getSpadeA_cancel_confirmed NOTIFY spadeA_cancel_confirmedChanged)
        Q_PROPERTY(bool spadeA_take_completed READ getSpadeA_take_completed NOTIFY spadeA_take_completedChanged)


        Q_PROPERTY(bool spadeB_start_confirmed  READ getSpadeB_start_confirmed NOTIFY spadeB_start_confirmedChanged)
        Q_PROPERTY(bool spadeB_take_confirmed  READ getSpadeB_take_confirmed NOTIFY spadeB_take_confirmedChanged)
        Q_PROPERTY(bool spadeB_cancel_confirmed  READ getSpadeB_cancel_confirmed NOTIFY spadeB_cancel_confirmedChanged)
        Q_PROPERTY(bool spadeB_take_completed READ getSpadeB_take_completed NOTIFY spadeB_take_completedChanged)

        Q_PROPERTY(bool pivot_start_confirmed READ getPivot_start_confirmed NOTIFY pivot_start_confirmedChanged)
        Q_PROPERTY(bool pivot_take_confirmed READ getPivot_take_confirmed NOTIFY pivot_take_confirmedChanged)
        Q_PROPERTY(bool pivot_cancel_confirmed READ getPivot_cancel_confirmed NOTIFY pivot_cancel_confirmedChanged)

        Q_PROPERTY(bool pivot_take_completed READ getPivot_take_completed NOTIFY pivot_take_completedChanged)

        Q_PROPERTY(bool btn_start_completed READ getBtn_start_completed  NOTIFY btn_start_completedChanged)

        Q_PROPERTY(bool isScanDISDETDONE_confirmed READ getScanDISDETDONE_confirmed  NOTIFY isScanDISDETDONE_confirmedChanged)
        Q_PROPERTY(bool isScanDISDETDONE_completed READ getScanDISDETDONE_completed  NOTIFY isScanDISDETDONE_completeChanged)
        Q_PROPERTY(bool isMode2_2ndModeCMD_confirmed READ getMode22ndModeCMD_confirmed  NOTIFY isMode22ndModeCMD_confirmedChanged)

        Q_PROPERTY(bool isAB_tooClose READ getAB2Closed NOTIFY isAB_tooCloseChanged)
        /***********************************************************************************************************************/

        Q_PROPERTY(bool level_done READ getLevel_done NOTIFY level_doneChanged)

        Q_PROPERTY(bool isConfirmed READ getConfirmed NOTIFY isConfirmedChanged)
        Q_PROPERTY(bool isAdminPSWCorrect READ getIsAdminPSWCorrect NOTIFY isAdminPSWCorrectChanged)


        Q_PROPERTY(bool isErrorPage READ getErrorPage NOTIFY showErrorPage)

    public:
        //MySerial();
        MySerial(QSerialPort *parent = 0);
        QTimer *dataSendingTimer = new QTimer(this);
        QByteArray mySendPKG,DTTArray,DTRArray,ScanDTRArray,ScanAngleArray,DataTimeBatteryArray,DataArray,TimeArray,Dip_DistanceArray,Dip_AccuracyArray,Dip_AngleArray;
        QByteArray ArrayX,ArrayY;
        QByteArray rxBUf,processBuf,dataBuf;
        //QString filePath = "C:\\Users\\Mengfei\\Desktop\\";
        QString filePath = "//home//pi//";
        int iPackageIndex = 0;
        int iLast_iPackageIndex = 0;
        int iByteNumRevd = 0;
        QByteArray DataSending_A,DataSending_B,DataSending_C;
        QByteArray temp_data_Rcv, temp_data_buf,temp_data_buf2;

        const uint32_t MOD_ADLER = 65521;
        uint32_t a=1,b=0;

        uint32_t adler32(QByteArray data);

        int dataSendingTimeout_ID = 0;
        int dataSendingTimeout_LastID = 0;
        int dataSendingTimeout_counter = 0;
        bool isDataBufFull = false;
        bool isDataFinished = false;

        bool isRxMode = false;
        bool dataEnough = false;
        bool isIDtrue = false;

        bool haveSentCmd;
        bool myunit = false;

        bool isTimerExist = false;
        int mytolrance = 0;

        int mySendPKGcount = 0;
        int timerId;
        int openPortTimerId;
        int openPortTimesCnt = 0;
        int batteryPercentage;

        float f_DTT,f_DTR,LevelNumberX,LevelNumberY,f_VirtualPoints_X,f_VirtualPoints_Y,f_ScanAngle,f_Dip_Distance,f_Dip_Accuracy,f_Dip_Angle;


        unsigned char dataSending_Rcv_Type;
        unsigned char dataSending_Rcv_State = 0x00;

        qint16 dataSending_Rcv_DataLen = 0;
        qint16 dataSending_Rcv_DataPackageNumber_Idx = 0;
        qint16 dataSending_Rcv_LastPackageLen_CRC = 0;

        qint16 dataSending_Send_DataPackage_Idx = 1;
        qint16 dataSending_Send_DataLenRcved = 0;
        int totalDataLen = 0;

        Q_INVOKABLE void systemTime(QString sysTime);
        Q_INVOKABLE void systemRights(QString path);
        Q_INVOKABLE void systemSync();
        Q_INVOKABLE void shellUpdate();
        Q_INVOKABLE void screenDark();
        Q_INVOKABLE void screenLight();
        Q_INVOKABLE QString getIP();
        Q_INVOKABLE void uiSendConfirm();
        Q_INVOKABLE void openAndSetPort();//打开并设定端口;
        Q_INVOKABLE void closePort();//关闭端口;
        Q_INVOKABLE void clearPKG();
        Q_INVOKABLE void setPkg(int modeType,float angle,float distance);
        Q_INVOKABLE void setPkg(QString OperationCMD);
        Q_INVOKABLE void setPkg(QString OperationCMD,QString Operate);
        Q_INVOKABLE void setParametersPkg(int iUnit,int iTolerance,int iYear,int iMonth,int iDate,int iHour,int iMinute,int iSecond);
        Q_INVOKABLE void analyzePkg(QByteArray data);
        Q_INVOKABLE void superReset(int i);
        Q_INVOKABLE void adminSetup(qint16 psw,int index,int content_1,int content_2,int content_3,int content_4,int content_5);
        Q_INVOKABLE void portSwitch();
        Q_INVOKABLE void setDataSendingPkg(int type, int state, QByteArray DataLen_Array, QByteArray DataPackageNumber_Idx_Array, QByteArray LastPackageLen_CRC_Array);
        Q_INVOKABLE void getDataCompletePkg(int type, int state, QByteArray DataLen_Array, QByteArray DataPackageNumber_Idx_Array);
        Q_INVOKABLE void getDataLastPkg(int type, int state, QByteArray DataLen_Array, QByteArray DataPackageNumber_Idx_Array, QByteArray LastPackageLen_CRC_Array);
       QByteArray getSerialData(void);
       QByteArray getReceivedCMD(void);
       QByteArray getSerialSendCMD(void);
       bool getPortOpen(void);


       int getProgressLevel(void);
       float getDipDist(void);
       float getDipAccuracy(void);
       float getDipAngle(void);
       float getdtt(void);
       float getdtr(void);
       float getScan_angle(void);
       float getLevelX(void);
       float getLevelY(void);
       int getUpdateDone(void);

       int getTolerance(void);
       int getBattery(void);

       bool getErrorPage(void);

       bool getConfirmed(void);
       bool getIsAdminPSWCorrect(void);
       bool getUnit(void);
       bool getLevel_done(void);

       Q_INVOKABLE void sendConfirm(QByteArray data);
       void resend();

       float QByteArrayToFloat(QByteArray arr);
       int QByteArrayToInt(QByteArray arr);
       short QByteArrayToShort(QByteArray arr);

       unsigned char calCRC(QByteArray arr);
       bool isCRCcorrect(QByteArray arr);

       QByteArray intToQByteArray(int i);
       QByteArray shortToQByteArray(short i);
       QByteArray floatToQByteArray(float i);
       QByteArray doubleToQByteArray(double i);
       QString QByteArray2HexQString(QByteArray data);

       void setSysTime(QByteArray arr,bool isDate);
       void setSysTime(QByteArray date,QByteArray time);
       void idIncrease();
       void timerEvent(QTimerEvent *event);
       //void sendCMD();
       int sendCMD();
       void sendCompleteSig(QByteArray arr);
       void sendConfirmSig(QByteArray arr);


       /*********************************/

      //          Spade A
      bool getSpadeA_start_confirmed(void);
      bool getSpadeA_take_confirmed(void);
      bool getSpadeA_cancel_confirmed(void);

      bool getSpadeA_take_completed(void);
      //...............................//


      //          Spade B
      bool getSpadeB_start_confirmed(void);
      bool getSpadeB_take_confirmed(void);
      bool getSpadeB_cancel_confirmed(void);

      bool getSpadeB_take_completed(void);
      //...............................//

      //          Pivot
      bool getPivot_start_confirmed(void);
      bool getPivot_take_confirmed(void);
      bool getPivot_cancel_confirmed(void);

      bool getPivot_take_completed(void);
      //...............................//

      //          start_completed
      bool getBtn_start_completed(void);
      //...............................//
      /*********************************/

      bool getScanDISDETDONE_confirmed(void);
      bool getScanDISDETDONE_completed(void);
      bool getMode22ndModeCMD_confirmed(void);

      bool getAB2Closed(void);

    signals:

              void updateDoneChanged();
              void portOpenChanged();
              void serialDataChanged();
              void receivedCMDChanged();
              void serialSendCMDChanged();
              void progressLevelChanged();
              void caldttChanged();
              void dttChanged();
              void dtrChanged();
              void dipDistChanged();
              void dipAccuracyChanged();
              void dipAngleChanged();
              void scan_angleChanged();
              void levelXChanged();
              void levelYChanged();
              void isConfirmedChanged();
              void isAdminPSWCorrectChanged();
              void unitChanged();
              void toleranceChanged();
              void batteryChanged();

             /*********************************/
             //          Spade A
             void spadeA_start_confirmedChanged();
             void spadeA_take_confirmedChanged();
             void spadeA_cancel_confirmedChanged();
             void spadeA_take_completedChanged();
             //............................//

             //          Spade B
             void spadeB_start_confirmedChanged();
             void spadeB_take_confirmedChanged();
             void spadeB_cancel_confirmedChanged();
             void spadeB_take_completedChanged();
             //............................//

             //          pivot
             void pivot_start_confirmedChanged();
             void pivot_take_confirmedChanged();
             void pivot_cancel_confirmedChanged();
             void pivot_take_completedChanged();

             // start complete
             void btn_start_completedChanged();

             void isScanDISDETDONE_confirmedChanged();
             void isScanDISDETDONE_completeChanged();
             void isMode22ndModeCMD_confirmedChanged();

             void level_doneChanged();
             void showErrorPage();

             void isAB_tooCloseChanged();

    private:

             QTimer *cmdTimer = new QTimer(this);
             QByteArray serialData;
             QByteArray receivedCMD;
             QByteArray serialSendCMD;
             bool portOpen = false;
             float dtt = 0.0;
             float dtr = 0.0;
             float cal_dtt = 0.0;
             float scan_angle = 0.0;
             float levelX = 0.0;
             float levelY = 0.0;
             float dipDistance = 0.0;
             float dipAccuracy = 0.0;
             float dipAngle = 0.0;
             int progressLevel = 0;
             int updateDone = 0;

             int tolerance = 0;
             int iBattery = 0;

             unsigned char CMD_ID;
             unsigned char Last_CMD_ID;


             bool unit = false;
             bool isConfirmed = false;
             bool isAdminPSWCorrect = false;

             bool spadeA_start_confirmed = false;
             bool spadeA_take_confirmed = false;
             bool spadeA_cancel_confirmed = false;
             bool spadeA_take_completed = false;

             bool spadeB_start_confirmed = false;
             bool spadeB_take_confirmed = false;
             bool spadeB_cancel_confirmed = false;
             bool spadeB_take_completed = false;

             bool pivot_start_confirmed  = false;
             bool pivot_take_confirmed  = false;
             bool pivot_cancel_confirmed  = false;
             bool pivot_take_completed = false;
             bool btn_start_completed = false;
             bool level_done = false;
             bool isErrorPage = false;
             bool isScanDISDETDONE_confirmed = false;
             bool isMode2_2ndModeCMD_confirmed = false;
             bool isScanDISDETDONE_completed = false;

             bool isAB_tooClose = false;

    public slots:
             void receivefrom();
             void portError(QSerialPort::SerialPortError);
             void dataSendingTimeoutSlot();
             void cmdTimerSlot();
};

#endif // MYSERIAL_H
