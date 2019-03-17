#ifndef DESKFIT_H
#define DESKFIT_H

#include <QBluetoothDeviceDiscoveryAgent>
#include <QBluetoothDeviceInfo>
#include <QLowEnergyController>
#include <QLowEnergyService>
#include <QObject>
#include <QTime>
#include <QTimer>

class DeskFit : public QObject {
    Q_OBJECT
    Q_PROPERTY(ConnectionStatus connectionStatus READ connectionStatus NOTIFY connectionStatusChanged)
    Q_PROPERTY(DeviceStatus deviceStatus READ deviceStatus NOTIFY deviceStatusChanged)
    Q_PROPERTY(QString peripheralUuid READ peripheralUuid WRITE setPeripheralUuid NOTIFY peripheralUuidChanged)
    Q_PROPERTY(QString update READ update WRITE setUpdate NOTIFY updateChanged)

    Q_PROPERTY(double distance READ distance NOTIFY distanceChanged)
    Q_PROPERTY(int countdown READ countdown NOTIFY countdownChanged)
    Q_PROPERTY(int calories READ calories NOTIFY caloriesChanged)
    Q_PROPERTY(int steps READ steps NOTIFY stepsChanged)
    Q_PROPERTY(double speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(int time READ time NOTIFY timeChanged)

    Q_ENUMS(ConnectionStatus DeviceStatus)

public:
    enum class ConnectionStatus {
        DisconnectedStatus,
        DiscoveryStatus,
        DiscoveredStatus,
        ConnectingStatus,
        ConnectedStatus
    };

    enum class DeviceStatus {
        StoppedStatus,
        StartingStatus,
        RunningStatus,
        PausedStatus,
        UnknownStatus
    };

    explicit DeskFit(QObject* parent = nullptr);

    ConnectionStatus connectionStatus() const;
    DeviceStatus deviceStatus() const;
    QString peripheralUuid() const;
    QString update() const;

    double distance() const;
    int countdown() const;
    int calories() const;
    int steps() const;
    double speed() const;
    int time() const;

public slots:
    void startDeviceDiscovery();
    void disconnectDevice();
    void setPeripheralUuid(const QString& peripheralUuid);
    void setUpdate(const QString& update);

    void start();
    void stop();
    void pause();
    void setSpeed(int level);

signals:
    void connectionStatusChanged();
    void deviceStatusChanged();
    void peripheralUuidChanged(const QString& peripheralUuid);
    void updateChanged(const QString& update);
    void distanceChanged(double distance);
    void countdownChanged(int countdown);
    void caloriesChanged(int calories);
    void stepsChanged(int steps);
    void timeChanged(int time);
    void speedChanged(double speed);

private:
    enum class Command {
        Start = 0x01,
        Stop = 0x02,
        Pause = 0x04,
        SetSpeed = 0x03,
        FetchStatus = 0x00
    };

    QBluetoothDeviceDiscoveryAgent* m_discoveryAgent;
    QLowEnergyController* m_controller;
    QLowEnergyService* m_service;
    QLowEnergyCharacteristic m_command;
    QLowEnergyCharacteristic m_status;
    QBluetoothDeviceInfo m_deviceInfo;
    QTimer m_fetchStatusTimer;

    ConnectionStatus m_connectionStatus;
    DeviceStatus m_deviceStatus;
    QString m_peripheralUuid;
    QString m_update;
    double m_distance;
    int m_countdown;
    int m_calories;
    int m_steps;
    double m_speed;
    int m_time;

    QByteArray createCommand(const Command command, quint8 value = 0);
    void updateDeviceStatus(const QByteArray& data);

private slots:
    void fetchStatus();

    // QBluetoothDeviceDiscoveryAgent related
    void deviceDiscovered(const QBluetoothDeviceInfo& info);
    void deviceScanError(QBluetoothDeviceDiscoveryAgent::Error error);
    void deviceScanFinished();

    // QLowEnergyController realted
    void connectPeripheral();
    void deviceConnected();
    void errorReceived(QLowEnergyController::Error);
    void serviceScanDone();
    void deviceDisconnected();

    // QLowEnergyService related
    void serviceDetailsDiscovered(QLowEnergyService::ServiceState newState);
    void characteristicChanged(const QLowEnergyCharacteristic& characteristic, const QByteArray& newValue);
};

#endif // DESKFIT_H
