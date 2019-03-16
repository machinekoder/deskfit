import QtQuick 2.0
import deskfit 1.0

Item {
  id: root

  DiscoveryPanel {
    id: disconnectedPanel
    anchors.fill: parent
    visible: deskfit.connectionStatus === DeskFit.DiscoveryStatus || deskfit.connectionStatus === DeskFit.DiscoveredStatus
  }

  DisconnectedPanel {
    anchors.fill: parent
    visible: deskfit.connectionStatus === DeskFit.DisconnectedStatus
    onStartDiscovery: deskfit.startDeviceDiscovery()
  }

  ConnectedPanel {
    id: connectedPanel
    anchors.fill: parent
    visible: deskfit.connectionStatus === DeskFit.ConnectedStatus
    deskfit: DeskFit {
      id: deskfit
      peripheralUuid: "cf:09:15:6d:7b:68"

      Component.onCompleted: startDeviceDiscovery()
    }
  }
}
