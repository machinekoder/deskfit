import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2

Item {
  id: root

  ColumnLayout {
    anchors.centerIn: parent
    BusyIndicator {
      Layout.alignment: Qt.AlignHCenter
    }
    Label {
      text: qsTr("Searching for Instances...")
    }
  }
}
