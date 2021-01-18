#include "myfileio.h"
#include <QFile>
#include <QProcess>
#include <QDate>
#include <QTime>

MyFileIO::MyFileIO(QObject *parent) : QObject(parent)
{

}

QString MyFileIO::read()
{
    if (mSource.isEmpty()){
        emit error("source is empty");
        return QString();
    }

    QFile file(mSource);
    QString fileContent;
    if ( file.open(QIODevice::ReadWrite) ) {
        QString line;
        QTextStream t( &file );
        do {
            //line = t.readLine();
            line = t.readAll();
            fileContent += line;
         } while (!line.isNull());

        file.close();
    } else {
        emit error("Unable to open the file");
        return QString();
    }
    return fileContent;
}

bool MyFileIO::write(const QString& data)
{
    if (mSource.isEmpty())
        return false;

    QFile file(mSource);
    if (!file.open(QFile::ReadWrite  |  QIODevice::Text)) //| QFile::Truncate | QIODevice::Append
        return false;

    QByteArray buffer = file.readAll();
//    QTextStream out(&file);
//    out << data << "\n";

//    out<< buffer;

    file.close();
    QFile tempFile("//home//pi//tempFile.txt");
    //QFile tempFile( "C:\\Users\\Mengfei\\Desktop\\tempFile.txt");
    if(!tempFile.open(QFile::ReadWrite  |  QIODevice::Text))
        return false;
    QTextStream out(&tempFile);
    out << data << "\n";

    out<< buffer;
    tempFile.close();
    file.remove();
    //tempFile.rename("C:\\Users\\Mengfei\\Desktop\\tempFile.txt",mSource);
    tempFile.rename("//home//pi//tempFile.txt",mSource);
    tempFile.close();

    QString tempCmd = "sudo chgrp pi " + mSource;

    system(tempCmd.toStdString().c_str());

    tempCmd = "sudo chown pi "+mSource;
    system(tempCmd.toStdString().c_str());

    system("sync");
    return true;
}

bool MyFileIO::isExists()
{
    QFile file(mSource);
    return file.exists();
}

void MyFileIO::createFile()
{
    QFile file(mSource);
    if (!file.open(QFile::ReadWrite  |  QIODevice::Text  ))
    {
        system("sync");
        return;
    }
//    else if (mSource == "//home//pi//updatefile.txt")
 //   {
//        QString sysCmd = "sudo chmod 777 //home//pi//updatefile.txt";

//        system(qPrintable(sysCmd));
//        system("sync");

        /*QString tempCmd = "sudo chgrp pi " + mSource;

        system(tempCmd.toStdString().c_str());

        tempCmd = "sudo chown pi "+mSource;
        system(tempCmd.toStdString().c_str());

        system("sync");*/
 //   }
}

void MyFileIO::deleteFile()
{
    QFile file;

    file.remove(mSource);
    system("sync");
}

bool MyFileIO::updateSH1()
{
    QFile *file = new QFile;
    QString filePath = "//home//pi//";
    file->setFileName(filePath+"startup1.sh");
    if(file->exists())
    {
        bool isRemoveSuccess = false;
        file->close();
        file->remove(filePath+"startup1.sh");
        isRemoveSuccess = file->copy(":/sh/startup1.sh",filePath+"startup1.sh");
        QString sysCmd = "sudo chmod 777 " +  filePath+"startup1.sh";
        system(qPrintable(sysCmd));
        system("sync");
        return isRemoveSuccess;
    }
}

bool MyFileIO::updateSH2()
{
    QFile *file = new QFile;
    QString filePath = "//home//pi//";
    file->setFileName(filePath+"startup2.sh");
    if(file->exists())
    {
        bool isRemoveSuccess = false;
        file->close();
        file->remove(filePath+"startup2.sh");
        isRemoveSuccess = file->copy(":/sh/startup2.sh",filePath+"startup2.sh");
        QString sysCmd = "sudo chmod 777 " +  filePath+"startup2.sh";
        system(qPrintable(sysCmd));
        system("sync");
        return isRemoveSuccess;
    }
}

bool MyFileIO::removeBackupUI()
{
    bool isRemoveSuccess = false;
       QFile *file = new QFile;
       QString filePath = "//home//pi//";
       file->setFileName(filePath+"Adam_UI_Backup");
       if(file->exists())
       {
           file->close();
           isRemoveSuccess = file->remove(filePath+"Adam_UI_Backup");
           file->close();
           system("sync");
           return isRemoveSuccess;
       }
       else
       {
           isRemoveSuccess = false;
           return isRemoveSuccess;
       }
}

bool MyFileIO::replaceBackupUI()
{
    bool isReplaceSuccess = false;
    QFile *file = new QFile;
    QString filePath = "//home//pi//";
    //QString filePath = "C:\\Users\\Mengfei\\Desktop\\abc\\";


    file->setFileName(filePath+"Adam_UI_Backup");

    if(file->exists())
    {
        file->close();
        QDate mydate;
        QTime mytime;
        bool isRenamed = file->rename(filePath+"Adam_UI_Backup",filePath+"Adam_Backup_Replaced_"+mydate.currentDate().toString("yyyy_MM_dd_")+mytime.currentTime().toString("hh_mm_ss"));
        file->close();
        system("sync");
    }

    file->setFileName(filePath+"Adam_UI_New");
    if(file->exists())
    {
        isReplaceSuccess =  file->copy(filePath+"Adam_UI_New",filePath+"Adam_UI_Backup");
        QString sysCmd = "sudo chmod 777 " +  filePath+"Adam_UI_Backup";
        system(qPrintable(sysCmd));
        system("sync");
    }
    else
    {
        isReplaceSuccess = false;
    }

    return isReplaceSuccess;

}
