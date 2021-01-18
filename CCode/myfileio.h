#ifndef MYFILEIO_H
#define MYFILEIO_H

#include <QObject>
#include <QTextStream>
#include <QFile>

class MyFileIO : public QObject
{
    Q_OBJECT
public:
    explicit MyFileIO(QObject *parent = nullptr);

    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_INVOKABLE QString read();
    Q_INVOKABLE bool write(const QString& data);
    Q_INVOKABLE void createFile();
    Q_INVOKABLE void deleteFile();
    Q_INVOKABLE bool isExists();
    Q_INVOKABLE bool replaceBackupUI();
    Q_INVOKABLE bool removeBackupUI();
    Q_INVOKABLE bool updateSH1();
    Q_INVOKABLE bool updateSH2();
    QString source() { return mSource; }

signals:
    void sourceChanged(const QString& source);
    void error(const QString& msg);

public slots:
    void setSource(const QString& source) { mSource = source; }

private:
    QString mSource;
};

#endif // MYFILEIO_H
