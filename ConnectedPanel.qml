import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import deskfit 1.0

Item {
    id: root
    property DeskFit deskfit
    width: 400
    height: 600

    QtObject {
        id: d

        function msToTime(s) {
            var ms = s % 1000
            s = (s - ms) / 1000
            var secs = s % 60
            s = (s - secs) / 60
            var mins = s % 60
            var hrs = (s - mins) / 60

            return hrs + ':' + ("0" + mins).slice(
                        -2) + ':' + ("0" + secs).slice(-2)
        }
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Item {
            width: 1
            height: 1
            Layout.fillHeight: true
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Time: %1").arg(d.msToTime(deskfit.time))
            font.pixelSize: 30
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Distance: %1km").arg(deskfit.distance.toFixed(2))
            font.pixelSize: 30
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Calories: %1").arg(deskfit.calories)
            font.pixelSize: 30
        }
        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Steps: %1").arg(deskfit.steps)
            font.pixelSize: 30
        }

        Item {
            width: 1
            height: 1
            Layout.fillHeight: true
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: false

            Button {
                id: decreaseSpeedButton
                Layout.preferredWidth: 40
                Layout.fillHeight: true
                text: "-"
                onClicked: speedSlider.value = (Math.floor(
                                                    speedSlider.value / 10) - 1) * 10
            }

            Slider {
                id: speedSlider
                Layout.fillWidth: true
                from: 10
                to: 80
                stepSize: 1
                live: false
                value: deskfit.speed * 10

                //                background: Item {
                //                    width: speedSlider.availableWidth
                //                    height: implicitHeight
                //                    implicitHeight: 100

                //                    Image {
                //                        anchors.fill: parent
                //                        source: "./icons/speed_1.png"
                //                        mipmap: true
                //                        fillMode: Image.PreserveAspectFit
                //                        visible: true
                //                    }
                //                }
                onValueChanged: deskfit.setSpeed(value)
            }

            Button {
                id: increaseSpeedButton
                Layout.preferredWidth: 40
                Layout.fillHeight: true
                text: "+"
                onClicked: speedSlider.value = (Math.floor(
                                                    speedSlider.value / 10) + 1) * 10
            }
        }

        RowLayout {
            enabled: deskfit.connectionStatus == DeskFit.ConnectedStatus

            Item {
                Layout.preferredWidth: 50
                width: 1
                height: 1
            }

            Repeater {
                model: 8
                Button {
                    Layout.fillWidth: true
                    text: (index + 1)
                    onClicked: deskfit.setSpeed((index + 1) * 10)
                }
            }

            Item {
                Layout.preferredWidth: 50
                width: 1
                height: 1
            }
        }

        Item {
            width: 1
            height: 1
            Layout.fillHeight: true
        }

        Button {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: 100
            visible: deskfit.deviceStatus == DeskFit.StoppedStatus
                     || deskfit.deviceStatus == DeskFit.PausedStatus

            text: deskfit.deviceStatus == DeskFit.PausedStatus ? qsTr("Continue") : qsTr(
                                                                     "Start")
            onClicked: deskfit.start()
        }

        RowLayout {
            id: rowLayout
            width: 100
            height: 100
            Layout.fillWidth: true
            visible: deskfit.deviceStatus === DeskFit.RunningStatus

            Item {
                width: 1
                height: 1
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Stop")
                Layout.preferredHeight: 100
                onClicked: deskfit.stop()
            }

            Button {
                text: qsTr("Pause")
                Layout.preferredHeight: 100
                onClicked: deskfit.pause()
            }

            Item {
                id: element1
                width: 1
                height: 1
                Layout.fillWidth: true
            }
        }

        Item {
            width: 1
            height: 1
            Layout.fillHeight: true
        }
    }
}

/*##^## Designer {
    D{i:3;anchors_height:100;anchors_width:100;anchors_x:189;anchors_y:77}
}
 ##^##*/

