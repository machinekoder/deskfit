import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
import com.machinekoder.live 1.0
import QtQuick.Controls.Material 2.1

ApplicationWindow {
  id: root
  visible: true
  width: 640
  height: 480
  title: qsTr("Live Coding for DeskFit Control")
  flags: liveCoding.flags
  visibility: liveCoding.visibility

  Material.theme: Material.Dark
  Material.accent: Material.Red

  LiveCodingPanel {
    id: liveCoding
    anchors.fill: parent
  }

  Settings {
    id: windowSettings
    category: "window"
    property alias width: root.width
    property alias height: root.height
    property alias x: root.x
    property alias y: root.y
    property alias visibility: liveCoding.visibility
    property alias flags: liveCoding.flags
    property alias hideToolBar: liveCoding.hideToolBar
  }
}
