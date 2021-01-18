/****************************************************************************
** Meta object code from reading C++ file 'myserial.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "CCode/myserial.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'myserial.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.9.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_MySerial_t {
    QByteArrayData data[134];
    char stringdata0[2082];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_MySerial_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_MySerial_t qt_meta_stringdata_MySerial = {
    {
QT_MOC_LITERAL(0, 0, 8), // "MySerial"
QT_MOC_LITERAL(1, 9, 17), // "updateDoneChanged"
QT_MOC_LITERAL(2, 27, 0), // ""
QT_MOC_LITERAL(3, 28, 15), // "portOpenChanged"
QT_MOC_LITERAL(4, 44, 17), // "serialDataChanged"
QT_MOC_LITERAL(5, 62, 18), // "receivedCMDChanged"
QT_MOC_LITERAL(6, 81, 20), // "serialSendCMDChanged"
QT_MOC_LITERAL(7, 102, 20), // "progressLevelChanged"
QT_MOC_LITERAL(8, 123, 13), // "caldttChanged"
QT_MOC_LITERAL(9, 137, 10), // "dttChanged"
QT_MOC_LITERAL(10, 148, 10), // "dtrChanged"
QT_MOC_LITERAL(11, 159, 14), // "dipDistChanged"
QT_MOC_LITERAL(12, 174, 18), // "dipAccuracyChanged"
QT_MOC_LITERAL(13, 193, 15), // "dipAngleChanged"
QT_MOC_LITERAL(14, 209, 17), // "scan_angleChanged"
QT_MOC_LITERAL(15, 227, 13), // "levelXChanged"
QT_MOC_LITERAL(16, 241, 13), // "levelYChanged"
QT_MOC_LITERAL(17, 255, 18), // "isConfirmedChanged"
QT_MOC_LITERAL(18, 274, 24), // "isAdminPSWCorrectChanged"
QT_MOC_LITERAL(19, 299, 11), // "unitChanged"
QT_MOC_LITERAL(20, 311, 16), // "toleranceChanged"
QT_MOC_LITERAL(21, 328, 14), // "batteryChanged"
QT_MOC_LITERAL(22, 343, 29), // "spadeA_start_confirmedChanged"
QT_MOC_LITERAL(23, 373, 28), // "spadeA_take_confirmedChanged"
QT_MOC_LITERAL(24, 402, 30), // "spadeA_cancel_confirmedChanged"
QT_MOC_LITERAL(25, 433, 28), // "spadeA_take_completedChanged"
QT_MOC_LITERAL(26, 462, 29), // "spadeB_start_confirmedChanged"
QT_MOC_LITERAL(27, 492, 28), // "spadeB_take_confirmedChanged"
QT_MOC_LITERAL(28, 521, 30), // "spadeB_cancel_confirmedChanged"
QT_MOC_LITERAL(29, 552, 28), // "spadeB_take_completedChanged"
QT_MOC_LITERAL(30, 581, 28), // "pivot_start_confirmedChanged"
QT_MOC_LITERAL(31, 610, 27), // "pivot_take_confirmedChanged"
QT_MOC_LITERAL(32, 638, 29), // "pivot_cancel_confirmedChanged"
QT_MOC_LITERAL(33, 668, 27), // "pivot_take_completedChanged"
QT_MOC_LITERAL(34, 696, 26), // "btn_start_completedChanged"
QT_MOC_LITERAL(35, 723, 33), // "isScanDISDETDONE_confirmedCha..."
QT_MOC_LITERAL(36, 757, 32), // "isScanDISDETDONE_completeChanged"
QT_MOC_LITERAL(37, 790, 34), // "isMode22ndModeCMD_confirmedCh..."
QT_MOC_LITERAL(38, 825, 17), // "level_doneChanged"
QT_MOC_LITERAL(39, 843, 13), // "showErrorPage"
QT_MOC_LITERAL(40, 857, 20), // "isAB_tooCloseChanged"
QT_MOC_LITERAL(41, 878, 11), // "receivefrom"
QT_MOC_LITERAL(42, 890, 9), // "portError"
QT_MOC_LITERAL(43, 900, 28), // "QSerialPort::SerialPortError"
QT_MOC_LITERAL(44, 929, 22), // "dataSendingTimeoutSlot"
QT_MOC_LITERAL(45, 952, 12), // "cmdTimerSlot"
QT_MOC_LITERAL(46, 965, 10), // "systemTime"
QT_MOC_LITERAL(47, 976, 7), // "sysTime"
QT_MOC_LITERAL(48, 984, 12), // "systemRights"
QT_MOC_LITERAL(49, 997, 4), // "path"
QT_MOC_LITERAL(50, 1002, 10), // "systemSync"
QT_MOC_LITERAL(51, 1013, 11), // "shellUpdate"
QT_MOC_LITERAL(52, 1025, 10), // "screenDark"
QT_MOC_LITERAL(53, 1036, 11), // "screenLight"
QT_MOC_LITERAL(54, 1048, 5), // "getIP"
QT_MOC_LITERAL(55, 1054, 13), // "uiSendConfirm"
QT_MOC_LITERAL(56, 1068, 14), // "openAndSetPort"
QT_MOC_LITERAL(57, 1083, 9), // "closePort"
QT_MOC_LITERAL(58, 1093, 8), // "clearPKG"
QT_MOC_LITERAL(59, 1102, 6), // "setPkg"
QT_MOC_LITERAL(60, 1109, 8), // "modeType"
QT_MOC_LITERAL(61, 1118, 5), // "angle"
QT_MOC_LITERAL(62, 1124, 8), // "distance"
QT_MOC_LITERAL(63, 1133, 12), // "OperationCMD"
QT_MOC_LITERAL(64, 1146, 7), // "Operate"
QT_MOC_LITERAL(65, 1154, 16), // "setParametersPkg"
QT_MOC_LITERAL(66, 1171, 5), // "iUnit"
QT_MOC_LITERAL(67, 1177, 10), // "iTolerance"
QT_MOC_LITERAL(68, 1188, 5), // "iYear"
QT_MOC_LITERAL(69, 1194, 6), // "iMonth"
QT_MOC_LITERAL(70, 1201, 5), // "iDate"
QT_MOC_LITERAL(71, 1207, 5), // "iHour"
QT_MOC_LITERAL(72, 1213, 7), // "iMinute"
QT_MOC_LITERAL(73, 1221, 7), // "iSecond"
QT_MOC_LITERAL(74, 1229, 10), // "analyzePkg"
QT_MOC_LITERAL(75, 1240, 4), // "data"
QT_MOC_LITERAL(76, 1245, 10), // "superReset"
QT_MOC_LITERAL(77, 1256, 1), // "i"
QT_MOC_LITERAL(78, 1258, 10), // "adminSetup"
QT_MOC_LITERAL(79, 1269, 3), // "psw"
QT_MOC_LITERAL(80, 1273, 5), // "index"
QT_MOC_LITERAL(81, 1279, 9), // "content_1"
QT_MOC_LITERAL(82, 1289, 9), // "content_2"
QT_MOC_LITERAL(83, 1299, 9), // "content_3"
QT_MOC_LITERAL(84, 1309, 9), // "content_4"
QT_MOC_LITERAL(85, 1319, 9), // "content_5"
QT_MOC_LITERAL(86, 1329, 10), // "portSwitch"
QT_MOC_LITERAL(87, 1340, 17), // "setDataSendingPkg"
QT_MOC_LITERAL(88, 1358, 4), // "type"
QT_MOC_LITERAL(89, 1363, 5), // "state"
QT_MOC_LITERAL(90, 1369, 13), // "DataLen_Array"
QT_MOC_LITERAL(91, 1383, 27), // "DataPackageNumber_Idx_Array"
QT_MOC_LITERAL(92, 1411, 24), // "LastPackageLen_CRC_Array"
QT_MOC_LITERAL(93, 1436, 18), // "getDataCompletePkg"
QT_MOC_LITERAL(94, 1455, 14), // "getDataLastPkg"
QT_MOC_LITERAL(95, 1470, 11), // "sendConfirm"
QT_MOC_LITERAL(96, 1482, 10), // "serialData"
QT_MOC_LITERAL(97, 1493, 11), // "receivedCMD"
QT_MOC_LITERAL(98, 1505, 13), // "serialSendCMD"
QT_MOC_LITERAL(99, 1519, 8), // "portOpen"
QT_MOC_LITERAL(100, 1528, 10), // "updateDone"
QT_MOC_LITERAL(101, 1539, 13), // "progressLevel"
QT_MOC_LITERAL(102, 1553, 3), // "dtt"
QT_MOC_LITERAL(103, 1557, 3), // "dtr"
QT_MOC_LITERAL(104, 1561, 10), // "scan_angle"
QT_MOC_LITERAL(105, 1572, 4), // "unit"
QT_MOC_LITERAL(106, 1577, 9), // "tolerance"
QT_MOC_LITERAL(107, 1587, 11), // "dipDistance"
QT_MOC_LITERAL(108, 1599, 11), // "dipAccuracy"
QT_MOC_LITERAL(109, 1611, 8), // "dipAngle"
QT_MOC_LITERAL(110, 1620, 6), // "levelX"
QT_MOC_LITERAL(111, 1627, 6), // "levelY"
QT_MOC_LITERAL(112, 1634, 8), // "iBattery"
QT_MOC_LITERAL(113, 1643, 22), // "spadeA_start_confirmed"
QT_MOC_LITERAL(114, 1666, 21), // "spadeA_take_confirmed"
QT_MOC_LITERAL(115, 1688, 23), // "spadeA_cancel_confirmed"
QT_MOC_LITERAL(116, 1712, 21), // "spadeA_take_completed"
QT_MOC_LITERAL(117, 1734, 22), // "spadeB_start_confirmed"
QT_MOC_LITERAL(118, 1757, 21), // "spadeB_take_confirmed"
QT_MOC_LITERAL(119, 1779, 23), // "spadeB_cancel_confirmed"
QT_MOC_LITERAL(120, 1803, 21), // "spadeB_take_completed"
QT_MOC_LITERAL(121, 1825, 21), // "pivot_start_confirmed"
QT_MOC_LITERAL(122, 1847, 20), // "pivot_take_confirmed"
QT_MOC_LITERAL(123, 1868, 22), // "pivot_cancel_confirmed"
QT_MOC_LITERAL(124, 1891, 20), // "pivot_take_completed"
QT_MOC_LITERAL(125, 1912, 19), // "btn_start_completed"
QT_MOC_LITERAL(126, 1932, 26), // "isScanDISDETDONE_confirmed"
QT_MOC_LITERAL(127, 1959, 26), // "isScanDISDETDONE_completed"
QT_MOC_LITERAL(128, 1986, 28), // "isMode2_2ndModeCMD_confirmed"
QT_MOC_LITERAL(129, 2015, 13), // "isAB_tooClose"
QT_MOC_LITERAL(130, 2029, 10), // "level_done"
QT_MOC_LITERAL(131, 2040, 11), // "isConfirmed"
QT_MOC_LITERAL(132, 2052, 17), // "isAdminPSWCorrect"
QT_MOC_LITERAL(133, 2070, 11) // "isErrorPage"

    },
    "MySerial\0updateDoneChanged\0\0portOpenChanged\0"
    "serialDataChanged\0receivedCMDChanged\0"
    "serialSendCMDChanged\0progressLevelChanged\0"
    "caldttChanged\0dttChanged\0dtrChanged\0"
    "dipDistChanged\0dipAccuracyChanged\0"
    "dipAngleChanged\0scan_angleChanged\0"
    "levelXChanged\0levelYChanged\0"
    "isConfirmedChanged\0isAdminPSWCorrectChanged\0"
    "unitChanged\0toleranceChanged\0"
    "batteryChanged\0spadeA_start_confirmedChanged\0"
    "spadeA_take_confirmedChanged\0"
    "spadeA_cancel_confirmedChanged\0"
    "spadeA_take_completedChanged\0"
    "spadeB_start_confirmedChanged\0"
    "spadeB_take_confirmedChanged\0"
    "spadeB_cancel_confirmedChanged\0"
    "spadeB_take_completedChanged\0"
    "pivot_start_confirmedChanged\0"
    "pivot_take_confirmedChanged\0"
    "pivot_cancel_confirmedChanged\0"
    "pivot_take_completedChanged\0"
    "btn_start_completedChanged\0"
    "isScanDISDETDONE_confirmedChanged\0"
    "isScanDISDETDONE_completeChanged\0"
    "isMode22ndModeCMD_confirmedChanged\0"
    "level_doneChanged\0showErrorPage\0"
    "isAB_tooCloseChanged\0receivefrom\0"
    "portError\0QSerialPort::SerialPortError\0"
    "dataSendingTimeoutSlot\0cmdTimerSlot\0"
    "systemTime\0sysTime\0systemRights\0path\0"
    "systemSync\0shellUpdate\0screenDark\0"
    "screenLight\0getIP\0uiSendConfirm\0"
    "openAndSetPort\0closePort\0clearPKG\0"
    "setPkg\0modeType\0angle\0distance\0"
    "OperationCMD\0Operate\0setParametersPkg\0"
    "iUnit\0iTolerance\0iYear\0iMonth\0iDate\0"
    "iHour\0iMinute\0iSecond\0analyzePkg\0data\0"
    "superReset\0i\0adminSetup\0psw\0index\0"
    "content_1\0content_2\0content_3\0content_4\0"
    "content_5\0portSwitch\0setDataSendingPkg\0"
    "type\0state\0DataLen_Array\0"
    "DataPackageNumber_Idx_Array\0"
    "LastPackageLen_CRC_Array\0getDataCompletePkg\0"
    "getDataLastPkg\0sendConfirm\0serialData\0"
    "receivedCMD\0serialSendCMD\0portOpen\0"
    "updateDone\0progressLevel\0dtt\0dtr\0"
    "scan_angle\0unit\0tolerance\0dipDistance\0"
    "dipAccuracy\0dipAngle\0levelX\0levelY\0"
    "iBattery\0spadeA_start_confirmed\0"
    "spadeA_take_confirmed\0spadeA_cancel_confirmed\0"
    "spadeA_take_completed\0spadeB_start_confirmed\0"
    "spadeB_take_confirmed\0spadeB_cancel_confirmed\0"
    "spadeB_take_completed\0pivot_start_confirmed\0"
    "pivot_take_confirmed\0pivot_cancel_confirmed\0"
    "pivot_take_completed\0btn_start_completed\0"
    "isScanDISDETDONE_confirmed\0"
    "isScanDISDETDONE_completed\0"
    "isMode2_2ndModeCMD_confirmed\0isAB_tooClose\0"
    "level_done\0isConfirmed\0isAdminPSWCorrect\0"
    "isErrorPage"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MySerial[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      66,   14, // methods
      38,  492, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      39,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,  344,    2, 0x06 /* Public */,
       3,    0,  345,    2, 0x06 /* Public */,
       4,    0,  346,    2, 0x06 /* Public */,
       5,    0,  347,    2, 0x06 /* Public */,
       6,    0,  348,    2, 0x06 /* Public */,
       7,    0,  349,    2, 0x06 /* Public */,
       8,    0,  350,    2, 0x06 /* Public */,
       9,    0,  351,    2, 0x06 /* Public */,
      10,    0,  352,    2, 0x06 /* Public */,
      11,    0,  353,    2, 0x06 /* Public */,
      12,    0,  354,    2, 0x06 /* Public */,
      13,    0,  355,    2, 0x06 /* Public */,
      14,    0,  356,    2, 0x06 /* Public */,
      15,    0,  357,    2, 0x06 /* Public */,
      16,    0,  358,    2, 0x06 /* Public */,
      17,    0,  359,    2, 0x06 /* Public */,
      18,    0,  360,    2, 0x06 /* Public */,
      19,    0,  361,    2, 0x06 /* Public */,
      20,    0,  362,    2, 0x06 /* Public */,
      21,    0,  363,    2, 0x06 /* Public */,
      22,    0,  364,    2, 0x06 /* Public */,
      23,    0,  365,    2, 0x06 /* Public */,
      24,    0,  366,    2, 0x06 /* Public */,
      25,    0,  367,    2, 0x06 /* Public */,
      26,    0,  368,    2, 0x06 /* Public */,
      27,    0,  369,    2, 0x06 /* Public */,
      28,    0,  370,    2, 0x06 /* Public */,
      29,    0,  371,    2, 0x06 /* Public */,
      30,    0,  372,    2, 0x06 /* Public */,
      31,    0,  373,    2, 0x06 /* Public */,
      32,    0,  374,    2, 0x06 /* Public */,
      33,    0,  375,    2, 0x06 /* Public */,
      34,    0,  376,    2, 0x06 /* Public */,
      35,    0,  377,    2, 0x06 /* Public */,
      36,    0,  378,    2, 0x06 /* Public */,
      37,    0,  379,    2, 0x06 /* Public */,
      38,    0,  380,    2, 0x06 /* Public */,
      39,    0,  381,    2, 0x06 /* Public */,
      40,    0,  382,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      41,    0,  383,    2, 0x0a /* Public */,
      42,    1,  384,    2, 0x0a /* Public */,
      44,    0,  387,    2, 0x0a /* Public */,
      45,    0,  388,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      46,    1,  389,    2, 0x02 /* Public */,
      48,    1,  392,    2, 0x02 /* Public */,
      50,    0,  395,    2, 0x02 /* Public */,
      51,    0,  396,    2, 0x02 /* Public */,
      52,    0,  397,    2, 0x02 /* Public */,
      53,    0,  398,    2, 0x02 /* Public */,
      54,    0,  399,    2, 0x02 /* Public */,
      55,    0,  400,    2, 0x02 /* Public */,
      56,    0,  401,    2, 0x02 /* Public */,
      57,    0,  402,    2, 0x02 /* Public */,
      58,    0,  403,    2, 0x02 /* Public */,
      59,    3,  404,    2, 0x02 /* Public */,
      59,    1,  411,    2, 0x02 /* Public */,
      59,    2,  414,    2, 0x02 /* Public */,
      65,    8,  419,    2, 0x02 /* Public */,
      74,    1,  436,    2, 0x02 /* Public */,
      76,    1,  439,    2, 0x02 /* Public */,
      78,    7,  442,    2, 0x02 /* Public */,
      86,    0,  457,    2, 0x02 /* Public */,
      87,    5,  458,    2, 0x02 /* Public */,
      93,    4,  469,    2, 0x02 /* Public */,
      94,    5,  478,    2, 0x02 /* Public */,
      95,    1,  489,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 43,    2,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::QString,   47,
    QMetaType::Void, QMetaType::QString,   49,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Float, QMetaType::Float,   60,   61,   62,
    QMetaType::Void, QMetaType::QString,   63,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   63,   64,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   66,   67,   68,   69,   70,   71,   72,   73,
    QMetaType::Void, QMetaType::QByteArray,   75,
    QMetaType::Void, QMetaType::Int,   77,
    QMetaType::Void, QMetaType::Short, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int, QMetaType::Int,   79,   80,   81,   82,   83,   84,   85,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QByteArray, QMetaType::QByteArray, QMetaType::QByteArray,   88,   89,   90,   91,   92,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QByteArray, QMetaType::QByteArray,   88,   89,   90,   91,
    QMetaType::Void, QMetaType::Int, QMetaType::Int, QMetaType::QByteArray, QMetaType::QByteArray, QMetaType::QByteArray,   88,   89,   90,   91,   92,
    QMetaType::Void, QMetaType::QByteArray,   75,

 // properties: name, type, flags
      96, QMetaType::QByteArray, 0x00495001,
      97, QMetaType::QByteArray, 0x00495001,
      98, QMetaType::QByteArray, 0x00495001,
      99, QMetaType::Bool, 0x00495001,
     100, QMetaType::Int, 0x00495001,
     101, QMetaType::Int, 0x00495001,
     102, QMetaType::Float, 0x00495001,
     103, QMetaType::Float, 0x00495001,
     104, QMetaType::Float, 0x00495001,
     105, QMetaType::Bool, 0x00495001,
     106, QMetaType::Int, 0x00495001,
     107, QMetaType::Float, 0x00495001,
     108, QMetaType::Float, 0x00495001,
     109, QMetaType::Float, 0x00495001,
     110, QMetaType::Float, 0x00495001,
     111, QMetaType::Float, 0x00495001,
     112, QMetaType::Int, 0x00495001,
     113, QMetaType::Bool, 0x00495001,
     114, QMetaType::Bool, 0x00495001,
     115, QMetaType::Bool, 0x00495001,
     116, QMetaType::Bool, 0x00495001,
     117, QMetaType::Bool, 0x00495001,
     118, QMetaType::Bool, 0x00495001,
     119, QMetaType::Bool, 0x00495001,
     120, QMetaType::Bool, 0x00495001,
     121, QMetaType::Bool, 0x00495001,
     122, QMetaType::Bool, 0x00495001,
     123, QMetaType::Bool, 0x00495001,
     124, QMetaType::Bool, 0x00495001,
     125, QMetaType::Bool, 0x00495001,
     126, QMetaType::Bool, 0x00495001,
     127, QMetaType::Bool, 0x00495001,
     128, QMetaType::Bool, 0x00495001,
     129, QMetaType::Bool, 0x00495001,
     130, QMetaType::Bool, 0x00495001,
     131, QMetaType::Bool, 0x00495001,
     132, QMetaType::Bool, 0x00495001,
     133, QMetaType::Bool, 0x00495001,

 // properties: notify_signal_id
       2,
       3,
       4,
       1,
       0,
       5,
       7,
       8,
      12,
      17,
      18,
       9,
      10,
      11,
      13,
      14,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33,
      34,
      35,
      38,
      36,
      15,
      16,
      37,

       0        // eod
};

void MySerial::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        MySerial *_t = static_cast<MySerial *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->updateDoneChanged(); break;
        case 1: _t->portOpenChanged(); break;
        case 2: _t->serialDataChanged(); break;
        case 3: _t->receivedCMDChanged(); break;
        case 4: _t->serialSendCMDChanged(); break;
        case 5: _t->progressLevelChanged(); break;
        case 6: _t->caldttChanged(); break;
        case 7: _t->dttChanged(); break;
        case 8: _t->dtrChanged(); break;
        case 9: _t->dipDistChanged(); break;
        case 10: _t->dipAccuracyChanged(); break;
        case 11: _t->dipAngleChanged(); break;
        case 12: _t->scan_angleChanged(); break;
        case 13: _t->levelXChanged(); break;
        case 14: _t->levelYChanged(); break;
        case 15: _t->isConfirmedChanged(); break;
        case 16: _t->isAdminPSWCorrectChanged(); break;
        case 17: _t->unitChanged(); break;
        case 18: _t->toleranceChanged(); break;
        case 19: _t->batteryChanged(); break;
        case 20: _t->spadeA_start_confirmedChanged(); break;
        case 21: _t->spadeA_take_confirmedChanged(); break;
        case 22: _t->spadeA_cancel_confirmedChanged(); break;
        case 23: _t->spadeA_take_completedChanged(); break;
        case 24: _t->spadeB_start_confirmedChanged(); break;
        case 25: _t->spadeB_take_confirmedChanged(); break;
        case 26: _t->spadeB_cancel_confirmedChanged(); break;
        case 27: _t->spadeB_take_completedChanged(); break;
        case 28: _t->pivot_start_confirmedChanged(); break;
        case 29: _t->pivot_take_confirmedChanged(); break;
        case 30: _t->pivot_cancel_confirmedChanged(); break;
        case 31: _t->pivot_take_completedChanged(); break;
        case 32: _t->btn_start_completedChanged(); break;
        case 33: _t->isScanDISDETDONE_confirmedChanged(); break;
        case 34: _t->isScanDISDETDONE_completeChanged(); break;
        case 35: _t->isMode22ndModeCMD_confirmedChanged(); break;
        case 36: _t->level_doneChanged(); break;
        case 37: _t->showErrorPage(); break;
        case 38: _t->isAB_tooCloseChanged(); break;
        case 39: _t->receivefrom(); break;
        case 40: _t->portError((*reinterpret_cast< QSerialPort::SerialPortError(*)>(_a[1]))); break;
        case 41: _t->dataSendingTimeoutSlot(); break;
        case 42: _t->cmdTimerSlot(); break;
        case 43: _t->systemTime((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 44: _t->systemRights((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 45: _t->systemSync(); break;
        case 46: _t->shellUpdate(); break;
        case 47: _t->screenDark(); break;
        case 48: _t->screenLight(); break;
        case 49: { QString _r = _t->getIP();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 50: _t->uiSendConfirm(); break;
        case 51: _t->openAndSetPort(); break;
        case 52: _t->closePort(); break;
        case 53: _t->clearPKG(); break;
        case 54: _t->setPkg((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< float(*)>(_a[2])),(*reinterpret_cast< float(*)>(_a[3]))); break;
        case 55: _t->setPkg((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 56: _t->setPkg((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 57: _t->setParametersPkg((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5])),(*reinterpret_cast< int(*)>(_a[6])),(*reinterpret_cast< int(*)>(_a[7])),(*reinterpret_cast< int(*)>(_a[8]))); break;
        case 58: _t->analyzePkg((*reinterpret_cast< QByteArray(*)>(_a[1]))); break;
        case 59: _t->superReset((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 60: _t->adminSetup((*reinterpret_cast< qint16(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4])),(*reinterpret_cast< int(*)>(_a[5])),(*reinterpret_cast< int(*)>(_a[6])),(*reinterpret_cast< int(*)>(_a[7]))); break;
        case 61: _t->portSwitch(); break;
        case 62: _t->setDataSendingPkg((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QByteArray(*)>(_a[3])),(*reinterpret_cast< QByteArray(*)>(_a[4])),(*reinterpret_cast< QByteArray(*)>(_a[5]))); break;
        case 63: _t->getDataCompletePkg((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QByteArray(*)>(_a[3])),(*reinterpret_cast< QByteArray(*)>(_a[4]))); break;
        case 64: _t->getDataLastPkg((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< QByteArray(*)>(_a[3])),(*reinterpret_cast< QByteArray(*)>(_a[4])),(*reinterpret_cast< QByteArray(*)>(_a[5]))); break;
        case 65: _t->sendConfirm((*reinterpret_cast< QByteArray(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::updateDoneChanged)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::portOpenChanged)) {
                *result = 1;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::serialDataChanged)) {
                *result = 2;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::receivedCMDChanged)) {
                *result = 3;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::serialSendCMDChanged)) {
                *result = 4;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::progressLevelChanged)) {
                *result = 5;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::caldttChanged)) {
                *result = 6;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::dttChanged)) {
                *result = 7;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::dtrChanged)) {
                *result = 8;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::dipDistChanged)) {
                *result = 9;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::dipAccuracyChanged)) {
                *result = 10;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::dipAngleChanged)) {
                *result = 11;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::scan_angleChanged)) {
                *result = 12;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::levelXChanged)) {
                *result = 13;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::levelYChanged)) {
                *result = 14;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::isConfirmedChanged)) {
                *result = 15;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::isAdminPSWCorrectChanged)) {
                *result = 16;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::unitChanged)) {
                *result = 17;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::toleranceChanged)) {
                *result = 18;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::batteryChanged)) {
                *result = 19;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::spadeA_start_confirmedChanged)) {
                *result = 20;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::spadeA_take_confirmedChanged)) {
                *result = 21;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::spadeA_cancel_confirmedChanged)) {
                *result = 22;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::spadeA_take_completedChanged)) {
                *result = 23;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::spadeB_start_confirmedChanged)) {
                *result = 24;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::spadeB_take_confirmedChanged)) {
                *result = 25;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::spadeB_cancel_confirmedChanged)) {
                *result = 26;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::spadeB_take_completedChanged)) {
                *result = 27;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::pivot_start_confirmedChanged)) {
                *result = 28;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::pivot_take_confirmedChanged)) {
                *result = 29;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::pivot_cancel_confirmedChanged)) {
                *result = 30;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::pivot_take_completedChanged)) {
                *result = 31;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::btn_start_completedChanged)) {
                *result = 32;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::isScanDISDETDONE_confirmedChanged)) {
                *result = 33;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::isScanDISDETDONE_completeChanged)) {
                *result = 34;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::isMode22ndModeCMD_confirmedChanged)) {
                *result = 35;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::level_doneChanged)) {
                *result = 36;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::showErrorPage)) {
                *result = 37;
                return;
            }
        }
        {
            typedef void (MySerial::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MySerial::isAB_tooCloseChanged)) {
                *result = 38;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        MySerial *_t = static_cast<MySerial *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QByteArray*>(_v) = _t->getSerialData(); break;
        case 1: *reinterpret_cast< QByteArray*>(_v) = _t->getReceivedCMD(); break;
        case 2: *reinterpret_cast< QByteArray*>(_v) = _t->getSerialSendCMD(); break;
        case 3: *reinterpret_cast< bool*>(_v) = _t->getPortOpen(); break;
        case 4: *reinterpret_cast< int*>(_v) = _t->getUpdateDone(); break;
        case 5: *reinterpret_cast< int*>(_v) = _t->getProgressLevel(); break;
        case 6: *reinterpret_cast< float*>(_v) = _t->getdtt(); break;
        case 7: *reinterpret_cast< float*>(_v) = _t->getdtr(); break;
        case 8: *reinterpret_cast< float*>(_v) = _t->getScan_angle(); break;
        case 9: *reinterpret_cast< bool*>(_v) = _t->getUnit(); break;
        case 10: *reinterpret_cast< int*>(_v) = _t->getTolerance(); break;
        case 11: *reinterpret_cast< float*>(_v) = _t->getDipDist(); break;
        case 12: *reinterpret_cast< float*>(_v) = _t->getDipAccuracy(); break;
        case 13: *reinterpret_cast< float*>(_v) = _t->getDipAngle(); break;
        case 14: *reinterpret_cast< float*>(_v) = _t->getLevelX(); break;
        case 15: *reinterpret_cast< float*>(_v) = _t->getLevelY(); break;
        case 16: *reinterpret_cast< int*>(_v) = _t->getBattery(); break;
        case 17: *reinterpret_cast< bool*>(_v) = _t->getSpadeA_start_confirmed(); break;
        case 18: *reinterpret_cast< bool*>(_v) = _t->getSpadeA_take_confirmed(); break;
        case 19: *reinterpret_cast< bool*>(_v) = _t->getSpadeA_cancel_confirmed(); break;
        case 20: *reinterpret_cast< bool*>(_v) = _t->getSpadeA_take_completed(); break;
        case 21: *reinterpret_cast< bool*>(_v) = _t->getSpadeB_start_confirmed(); break;
        case 22: *reinterpret_cast< bool*>(_v) = _t->getSpadeB_take_confirmed(); break;
        case 23: *reinterpret_cast< bool*>(_v) = _t->getSpadeB_cancel_confirmed(); break;
        case 24: *reinterpret_cast< bool*>(_v) = _t->getSpadeB_take_completed(); break;
        case 25: *reinterpret_cast< bool*>(_v) = _t->getPivot_start_confirmed(); break;
        case 26: *reinterpret_cast< bool*>(_v) = _t->getPivot_take_confirmed(); break;
        case 27: *reinterpret_cast< bool*>(_v) = _t->getPivot_cancel_confirmed(); break;
        case 28: *reinterpret_cast< bool*>(_v) = _t->getPivot_take_completed(); break;
        case 29: *reinterpret_cast< bool*>(_v) = _t->getBtn_start_completed(); break;
        case 30: *reinterpret_cast< bool*>(_v) = _t->getScanDISDETDONE_confirmed(); break;
        case 31: *reinterpret_cast< bool*>(_v) = _t->getScanDISDETDONE_completed(); break;
        case 32: *reinterpret_cast< bool*>(_v) = _t->getMode22ndModeCMD_confirmed(); break;
        case 33: *reinterpret_cast< bool*>(_v) = _t->getAB2Closed(); break;
        case 34: *reinterpret_cast< bool*>(_v) = _t->getLevel_done(); break;
        case 35: *reinterpret_cast< bool*>(_v) = _t->getConfirmed(); break;
        case 36: *reinterpret_cast< bool*>(_v) = _t->getIsAdminPSWCorrect(); break;
        case 37: *reinterpret_cast< bool*>(_v) = _t->getErrorPage(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject MySerial::staticMetaObject = {
    { &QSerialPort::staticMetaObject, qt_meta_stringdata_MySerial.data,
      qt_meta_data_MySerial,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *MySerial::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MySerial::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_MySerial.stringdata0))
        return static_cast<void*>(const_cast< MySerial*>(this));
    return QSerialPort::qt_metacast(_clname);
}

int MySerial::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QSerialPort::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 66)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 66;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 66)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 66;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 38;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 38;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 38;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 38;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 38;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 38;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void MySerial::updateDoneChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void MySerial::portOpenChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void MySerial::serialDataChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void MySerial::receivedCMDChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void MySerial::serialSendCMDChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void MySerial::progressLevelChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void MySerial::caldttChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void MySerial::dttChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void MySerial::dtrChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, nullptr);
}

// SIGNAL 9
void MySerial::dipDistChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}

// SIGNAL 10
void MySerial::dipAccuracyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 10, nullptr);
}

// SIGNAL 11
void MySerial::dipAngleChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 11, nullptr);
}

// SIGNAL 12
void MySerial::scan_angleChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 12, nullptr);
}

// SIGNAL 13
void MySerial::levelXChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 13, nullptr);
}

// SIGNAL 14
void MySerial::levelYChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 14, nullptr);
}

// SIGNAL 15
void MySerial::isConfirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 15, nullptr);
}

// SIGNAL 16
void MySerial::isAdminPSWCorrectChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 16, nullptr);
}

// SIGNAL 17
void MySerial::unitChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 17, nullptr);
}

// SIGNAL 18
void MySerial::toleranceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 18, nullptr);
}

// SIGNAL 19
void MySerial::batteryChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 19, nullptr);
}

// SIGNAL 20
void MySerial::spadeA_start_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 20, nullptr);
}

// SIGNAL 21
void MySerial::spadeA_take_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 21, nullptr);
}

// SIGNAL 22
void MySerial::spadeA_cancel_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 22, nullptr);
}

// SIGNAL 23
void MySerial::spadeA_take_completedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 23, nullptr);
}

// SIGNAL 24
void MySerial::spadeB_start_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 24, nullptr);
}

// SIGNAL 25
void MySerial::spadeB_take_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 25, nullptr);
}

// SIGNAL 26
void MySerial::spadeB_cancel_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 26, nullptr);
}

// SIGNAL 27
void MySerial::spadeB_take_completedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 27, nullptr);
}

// SIGNAL 28
void MySerial::pivot_start_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 28, nullptr);
}

// SIGNAL 29
void MySerial::pivot_take_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 29, nullptr);
}

// SIGNAL 30
void MySerial::pivot_cancel_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 30, nullptr);
}

// SIGNAL 31
void MySerial::pivot_take_completedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 31, nullptr);
}

// SIGNAL 32
void MySerial::btn_start_completedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 32, nullptr);
}

// SIGNAL 33
void MySerial::isScanDISDETDONE_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 33, nullptr);
}

// SIGNAL 34
void MySerial::isScanDISDETDONE_completeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 34, nullptr);
}

// SIGNAL 35
void MySerial::isMode22ndModeCMD_confirmedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 35, nullptr);
}

// SIGNAL 36
void MySerial::level_doneChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 36, nullptr);
}

// SIGNAL 37
void MySerial::showErrorPage()
{
    QMetaObject::activate(this, &staticMetaObject, 37, nullptr);
}

// SIGNAL 38
void MySerial::isAB_tooCloseChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 38, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
