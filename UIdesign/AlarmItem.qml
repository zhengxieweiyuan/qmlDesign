// AlarmItem.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: alarmItem
    width: parent.width
    height: 80
    property string timeText: "00:00"
    property string labelText: "无"
    property bool isActive: false
    Rectangle {
        anchors.fill: parent
        color: "white"
        radius: 10
        border.color: "#e0e0e0"
        border.width: 1

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            spacing: 20

            Text {
                text: timeText
                font.pixelSize: 24
                font.bold: true
                color: "black"
            }

            Text {
                text: labelText
                font.pixelSize: 16
                color: "#757575"
            }

            Item { width: 20; height: 1 } // Spacer

            Switch {
                anchors.verticalCenter: parent.verticalCenter
                checked: alarmItem.isActive
                onCheckedChanged: alarmItem.isActive = checked
            }
        }
    }
}
