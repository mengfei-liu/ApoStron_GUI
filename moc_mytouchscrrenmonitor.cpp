/****************************************************************************
** Meta object code from reading C++ file 'mytouchscrrenmonitor.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "CCode/mytouchscrrenmonitor.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mytouchscrrenmonitor.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.9.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_MyTouchscrrenMonitor_t {
    QByteArrayData data[5];
    char stringdata0[61];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_MyTouchscrrenMonitor_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_MyTouchscrrenMonitor_t qt_meta_stringdata_MyTouchscrrenMonitor = {
    {
QT_MOC_LITERAL(0, 0, 20), // "MyTouchscrrenMonitor"
QT_MOC_LITERAL(1, 21, 18), // "touchEventDetected"
QT_MOC_LITERAL(2, 40, 0), // ""
QT_MOC_LITERAL(3, 41, 10), // "touchBegin"
QT_MOC_LITERAL(4, 52, 8) // "touchEnd"

    },
    "MyTouchscrrenMonitor\0touchEventDetected\0"
    "\0touchBegin\0touchEnd"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MyTouchscrrenMonitor[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       3,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   29,    2, 0x06 /* Public */,
       3,    0,   30,    2, 0x06 /* Public */,
       4,    0,   31,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void MyTouchscrrenMonitor::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        MyTouchscrrenMonitor *_t = static_cast<MyTouchscrrenMonitor *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->touchEventDetected(); break;
        case 1: _t->touchBegin(); break;
        case 2: _t->touchEnd(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (MyTouchscrrenMonitor::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MyTouchscrrenMonitor::touchEventDetected)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (MyTouchscrrenMonitor::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MyTouchscrrenMonitor::touchBegin)) {
                *result = 1;
                return;
            }
        }
        {
            typedef void (MyTouchscrrenMonitor::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MyTouchscrrenMonitor::touchEnd)) {
                *result = 2;
                return;
            }
        }
    }
    Q_UNUSED(_a);
}

const QMetaObject MyTouchscrrenMonitor::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_MyTouchscrrenMonitor.data,
      qt_meta_data_MyTouchscrrenMonitor,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *MyTouchscrrenMonitor::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MyTouchscrrenMonitor::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_MyTouchscrrenMonitor.stringdata0))
        return static_cast<void*>(const_cast< MyTouchscrrenMonitor*>(this));
    return QObject::qt_metacast(_clname);
}

int MyTouchscrrenMonitor::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 3)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 3;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 3)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 3;
    }
    return _id;
}

// SIGNAL 0
void MyTouchscrrenMonitor::touchEventDetected()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void MyTouchscrrenMonitor::touchBegin()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void MyTouchscrrenMonitor::touchEnd()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
