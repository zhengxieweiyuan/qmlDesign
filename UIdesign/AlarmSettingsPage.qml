// AlarmSettingsPage.qml (部分)
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
Item {
    property string alarmTime: "00:00"
    property string alarmLabel: "新闹钟"
    property bool alarmActive: false
    property var alarmModel

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 20

        TextField {
            id: timeField
            text: alarmTime
            placeholderText: "输入时间 (HH:MM)"
            Layout.fillWidth: true
            onAccepted: alarmTime = text
        }

        TextField {
            id: labelField
            text: alarmLabel
            placeholderText: "输入标签"
            Layout.fillWidth: true
            onAccepted: alarmLabel = text
        }

        Switch {
            id: activeSwitch
            checked: alarmActive
            text: "启用"
            onCheckedChanged: alarmActive = checked
        }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: 10

            Button {
                text: "取消"
                onClicked: stackView.pop()
            }

            Button {
                text: "保存"
                onClicked: {
                    // 这里可以添加保存逻辑，例如更新模型

            alarmModel.insert(0, { time: timeField.text, label: labelField.text, active: activeSwitch.checked })
            stackView.pop()
                }
            }
        }
    }
}
