// main.qml
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
Item {
        id: tabbedView
        width: parent.width
        height: parent.height
        //property alias alarmModel: alarmModel
        // 内容区域，使用 StackLayout 配合 TabBar

        StackLayout {
            id: stackLayout
            anchors.top: parent.top
            anchors.bottom: tabBar.top
            width: parent.width

            // 闹钟页面
            Item {
                ListView {
                    id: alarmList
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10
                    model:        ListModel {
                        id: alarmModel
                        ListElement { time: "06:00"; label: "仅一次"; active: true }
                        ListElement { time: "07:10"; label: "仅一次"; active: false }
                        ListElement { time: "08:00"; label: "每天"; active: true }
                        ListElement { time: "08:16"; label: "每天"; active: true }
                        ListElement { time: "09:00"; label: "每天"; active: true }
                        ListElement { time: "15:00"; label: "无"; active: false }
                         }
                    delegate: AlarmItem {
                        timeText: time
                        labelText: label
                        isActive: active
                    }
                }

                ToolBar {
                    anchors.top: parent.top
                    width: parent.width
                    RowLayout {
                        anchors.fill: parent
                        spacing: 10

                        Text {
                            text: qsTr("闹钟")
                            font.pixelSize: 20
                            Layout.alignment: Qt.AlignHCenter
                        }

                        ToolButton {
                            text: "+"
                            Layout.alignment: Qt.AlignRight
                            onClicked: stackView.push(alarmSettingsPage, { alarmModel: alarmModel })
                        }

                        ToolButton {
                            text: "⋯"
                            Layout.alignment: Qt.AlignRight
                            onClicked: console.log("More options")
                        }
                    }
                }
            }

            // 其他页面（暂时留空，之后扩展）
            Item { /* 世界时钟页面 */ }
            Item { /* 秒表页面 */ }
            Item { /* 计时器页面 */ }
        }

        // 底部 TabBar
        TabBar {
            id: tabBar
            width: parent.width
            anchors.bottom: parent.bottom
            currentIndex: stackLayout.currentIndex

            TabButton {
                text: qsTr("闹钟")
                onClicked: stackLayout.currentIndex = 0
            }
            TabButton {
                text: qsTr("世界时钟")
                onClicked: stackLayout.currentIndex = 1
            }
            TabButton {
                text: qsTr("秒表")
                onClicked: stackLayout.currentIndex = 2
            }
            TabButton {
                text: qsTr("计时器")
                onClicked: stackLayout.currentIndex = 3
            }
        }
    }

