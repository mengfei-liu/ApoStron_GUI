/****************************************************************************
** Meta object code from reading C++ file 'myfileio.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "CCode/myfileio.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'myfileio.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.9.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_MyFileIO_t {
    QByteArrayData data[17];
    char stringdata0[149];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_MyFileIO_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_MyFileIO_t qt_meta_stringdata_MyFileIO = {
    {
QT_MOC_LITERAL(0, 0, 8), // "MyFileIO"
QT_MOC_LITERAL(1, 9, 13), // "sourceChanged"
QT_MOC_LITERAL(2, 23, 0), // ""
QT_MOC_LITERAL(3, 24, 6), // "source"
QT_MOC_LITERAL(4, 31, 5), // "error"
QT_MOC_LITERAL(5, 37, 3), // "msg"
QT_MOC_LITERAL(6, 41, 9), // "setSource"
QT_MOC_LITERAL(7, 51, 4), // "read"
QT_MOC_LITERAL(8, 56, 5), // "write"
QT_MOC_LITERAL(9, 62, 4), // "data"
QT_MOC_LITERAL(10, 67, 10), // "createFile"
QT_MOC_LITERAL(11, 78, 10), // "deleteFile"
QT_MOC_LITERAL(12, 89, 8), // "isExists"
QT_MOC_LITERAL(13, 98, 15), // "replaceBackupUI"
QT_MOC_LITERAL(14, 114, 14), // "removeBackupUI"
QT_MOC_LITERAL(15, 129, 9), // "updateSH1"
QT_MOC_LITERAL(16, 139, 9) // "updateSH2"

    },
    "MyFileIO\0sourceChanged\0\0source\0error\0"
    "msg\0setSource\0read\0write\0data\0createFile\0"
    "deleteFile\0isExists\0replaceBackupUI\0"
    "removeBackupUI\0updateSH1\0updateSH2"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_MyFileIO[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       1,   94, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   74,    2, 0x06 /* Public */,
       4,    1,   77,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       6,    1,   80,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
       7,    0,   83,    2, 0x02 /* Public */,
       8,    1,   84,    2, 0x02 /* Public */,
      10,    0,   87,    2, 0x02 /* Public */,
      11,    0,   88,    2, 0x02 /* Public */,
      12,    0,   89,    2, 0x02 /* Public */,
      13,    0,   90,    2, 0x02 /* Public */,
      14,    0,   91,    2, 0x02 /* Public */,
      15,    0,   92,    2, 0x02 /* Public */,
      16,    0,   93,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::QString,    5,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    3,

 // methods: parameters
    QMetaType::QString,
    QMetaType::Bool, QMetaType::QString,    9,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,
    QMetaType::Bool,

 // properties: name, type, flags
       3, QMetaType::QString, 0x00495103,

 // properties: notify_signal_id
       0,

       0        // eod
};

void MyFileIO::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        MyFileIO *_t = static_cast<MyFileIO *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->sourceChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: _t->error((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 2: _t->setSource((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 3: { QString _r = _t->read();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 4: { bool _r = _t->write((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 5: _t->createFile(); break;
        case 6: _t->deleteFile(); break;
        case 7: { bool _r = _t->isExists();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 8: { bool _r = _t->replaceBackupUI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 9: { bool _r = _t->removeBackupUI();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 10: { bool _r = _t->updateSH1();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 11: { bool _r = _t->updateSH2();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (MyFileIO::*_t)(const QString & );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MyFileIO::sourceChanged)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (MyFileIO::*_t)(const QString & );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&MyFileIO::error)) {
                *result = 1;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        MyFileIO *_t = static_cast<MyFileIO *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->source(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        MyFileIO *_t = static_cast<MyFileIO *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setSource(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject MyFileIO::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_MyFileIO.data,
      qt_meta_data_MyFileIO,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *MyFileIO::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MyFileIO::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_MyFileIO.stringdata0))
        return static_cast<void*>(const_cast< MyFileIO*>(this));
    return QObject::qt_metacast(_clname);
}

int MyFileIO::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 12)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 12)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 12;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void MyFileIO::sourceChanged(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void MyFileIO::error(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
