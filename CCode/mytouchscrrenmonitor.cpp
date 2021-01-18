#include "mytouchscrrenmonitor.h"
#include <QGuiApplication>
#include <QQmlEngine>
#include <QJSEngine>
#include <QEvent>

MyTouchscrrenMonitor::MyTouchscrrenMonitor(QObject *parent) : QObject(parent)
{
    qDebug() << "created Instance";
}

// This implements the SINGLETON PATTERN (*usually evil*)
// so you can get the instance in C++
MyTouchscrrenMonitor* MyTouchscrrenMonitor::instance()
{
    static MyTouchscrrenMonitor* inst;
    if (inst == nullptr)
    {
        // If no instance has been created yet, creat a new and install it as event filter.
        // Uppon first use of the instance, it will automatically
        // install itself in the QGuiApplication
        inst = new MyTouchscrrenMonitor();
        QGuiApplication* app = qGuiApp;
        app->installEventFilter(inst);
    }
    return inst;
}

// This is the method to fullfill the signature required by
// qmlRegisterSingletonType.
QObject* MyTouchscrrenMonitor::singletonProvider(QQmlEngine *, QJSEngine *)
{
    return MyTouchscrrenMonitor::instance();
}

// This is the method is necessary for 'installEventFilter'
bool MyTouchscrrenMonitor::eventFilter(QObject* watched, QEvent* event)
{
    QEvent::Type t = event->type();
//    if ((t == QEvent::MouseButtonDblClick
//         || t == QEvent::MouseButtonPress
//         || t == QEvent::MouseButtonRelease
//         || t == QEvent::MouseMove)
//            && event->spontaneous() // Take only mouse events from outside of Qt
//            )
    if(t == QEvent::TouchBegin)
    {
        emit touchBegin();
    }
    else if (t == QEvent::TouchEnd)
    {
        emit touchEnd();
    }
//    else if(t == QEvent::TouchUpdate)
//    {
//        qDebug()<<"Touch Update Event";

//        emit touchUpdate();
//    }
   // emit touchEventDetected();

    return QObject::eventFilter(watched, event);
}
