import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("DeskFit Control")

    Material.theme: Material.Dark
    Material.accent: Material.Red

    MainPanel {
        anchors.fill: parent
    }
}
