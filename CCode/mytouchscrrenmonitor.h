#ifndef MYTOUCHSCRRENMONITOR_H
#define MYTOUCHSCRRENMONITOR_H

#pragma once
#include <QObject>
#include <QtQml>
#include <QQmlEngine>
#include <QJSEngine>


class MyTouchscrrenMonitor : public QObject
{
    Q_OBJECT
public:
    explicit MyTouchscrrenMonitor(QObject *parent = nullptr);

    static MyTouchscrrenMonitor* instance();
    static QObject* singletonProvider(QQmlEngine* engine, QJSEngine* script);

signals:
    void touchEventDetected(/*Pass meaningfull information to QML?*/);
    void touchBegin();
    void touchEnd();

protected:
    bool eventFilter(QObject* watched, QEvent* event);
};

#endif // MYTOUCHSCRRENMONITOR_H
