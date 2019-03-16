#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "deskfit.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("machinekoder.com");
    app.setOrganizationDomain("machinekoder.com");
    app.setApplicationName("DeskFitControl");
    app.setApplicationDisplayName("DeskFit Control");

    qmlRegisterType<DeskFit>("deskfit", 1, 0, "DeskFit");

    QCommandLineParser parser;
    parser.setApplicationDescription("SportsTech DeskFit DFT200 Control");
    parser.addHelpOption();
#ifdef QT_DEBUG
    QCommandLineOption forceOption(QStringList() << "l" << "live",
    QCoreApplication::translate("live", "Start live coding mode."));
    parser.addOption(forceOption);
#endif
    parser.process(app);

    QString fileName = QStringLiteral("main.qml");
#ifdef QT_DEBUG
    if (parser.isSet(forceOption)) {
        fileName = QStringLiteral("live.qml");
    }
#endif

    QQmlApplicationEngine engine;
    engine.addImportPath(QStringLiteral("."));
    engine.addImportPath(QStringLiteral("qrc:/"));
    QFile file(QStringLiteral("./") + fileName);
    if (file.exists()) {
        engine.load(QStringLiteral("./") + fileName);
    }
    else {
        engine.load(QUrl(QStringLiteral("qrc:/") + fileName));
    }
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
