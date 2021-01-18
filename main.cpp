#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQuickView>
#include <QQmlEngine>
#include <QObject>
#include <QSharedMemory>
#include <QQmlContext>

#include "./CCode/myserial.h"
#include "./CCode/myfileio.h"
#include "./CCode/mytouchscrrenmonitor.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<MyFileIO, 1>("FileIO", 1, 0, "FileIO");
    qmlRegisterSingletonType<MyTouchscrrenMonitor>("MyTouchscrrenMonitor", 1, 0, "MyTouchscrrenMonitor", MyTouchscrrenMonitor::singletonProvider);

    QQmlApplicationEngine engine;

    QQmlContext *context = engine.rootContext();
    MySerial myserialthread;
    //MyThread myserialthread;
    context->setContextProperty("mySerialThread",&myserialthread);

    QSharedMemory mem("UI");
    if(!mem.create(1))
    {
        return 0;
    }

    system("gpio mode 40 pwm");
    system("gpio pwm 40 600");

    QString dbPath = "//home//pi//UI_Log";
    engine.setOfflineStoragePath(dbPath);

    system("chmod 777 /home/pi/UI_Log");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
