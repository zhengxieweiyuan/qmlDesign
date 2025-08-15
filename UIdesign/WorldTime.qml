import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: stopwatchPage
    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: "#f5f5f5"
    }

    // 状态管理常量
    readonly property int state_initial: 0
    readonly property int state_running: 1
    readonly property int state_paused: 2
    property int state: state_initial

    // 顶部工具栏
    ToolBar {
        anchors.top: parent.top
        width: parent.width
        RowLayout {
            anchors.fill: parent
            Text {
                text: qsTr("秒表")
                font.pixelSize: 20
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // 计时显示
    Text {
        id: timeDisplay
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        text: "00:00.00"
        font.pixelSize: 60
        font.bold: true
        color: "#333"
    }

    // 按钮样式组件
    Component {
        id: buttonStyle
        Button {
            background: Rectangle {
                color: (text === qsTr("计次") || text === qsTr("重置")) ? "#e0e0e0" : "#ff3b30"
                radius: 30
                implicitWidth: 80
                implicitHeight: 60
            }
            contentItem: Text {
                text: parent.text
                color: (parent.text === qsTr("计次") || parent.text === qsTr("重置")) ? "#333" : "white"
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    // 按钮容器 - 动态变化
    Row {
        id: buttonContainer
        anchors.top: timeDisplay.bottom
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20

        // 计次/重置按钮（运行中显示计次，暂停时显示重置）
        Button {
            id: lapOrResetBtn
            visible: stopwatchPage.state !== state_initial
            text: stopwatchPage.state === state_running ? qsTr("计次") : qsTr("重置")
            onClicked: {
                if (stopwatchPage.state === state_running) {
                    addLap() // 运行中点击计次
                } else {
                    // 暂停时点击重置：回到初始状态
                    resetTimer()
                }
            }
            Component.onCompleted: {
                loader.sourceComponent = buttonStyle
            }
        }

        // 主控制按钮（开始/暂停/继续）
        Button {
            id: mainControlBtn
            text: stopwatchPage.state === state_initial ? qsTr("开始") :
                  (stopwatchPage.state === state_running ? qsTr("暂停") : qsTr("继续"))
            onClicked: {
                if (stopwatchPage.state === state_initial || stopwatchPage.state === state_paused) {
                    timer.start()
                    stopwatchPage.state = state_running
                } else {
                    timer.stop()
                    stopwatchPage.state = state_paused
                }
            }
            Component.onCompleted: {
                loader.sourceComponent = buttonStyle
            }
        }
    }

    // 计次记录列表
    ListView {
        id: lapList
        anchors.top: buttonContainer.bottom
        anchors.topMargin: 40
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing: 5
        clip: true

        model: ListModel {
            id: lapModel
        }

        delegate: Rectangle {
            width: lapList.width
            height: 40
            RowLayout {
                anchors.fill: parent
                Text {
                    text: qsTr("计次 %1").arg(index + 1)
                    color: "#999"
                    font.pixelSize: 14
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                }
                Item {
                    Layout.fillWidth: true
                }
                Text {
                    text: formatTime(timeMs)
                    font.pixelSize: 14
                    font.bold: index === 0 ? true : false
                    color: index === 0 ? "#ff3b30" : "#333"
                    Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                }
            }
        }
    }

    // 计时器逻辑
    property int currentTime: 0 // 单位：毫秒

    Timer {
        id: timer
        interval: 10
        running: false
        repeat: true
        property var startTime: null
        onTriggered: {
            if (startTime === null) {
                startTime = Date.now()
            }
            currentTime = Date.now() - startTime
            updateTimeDisplay()
        }
    }

    // 更新时间显示格式
    function updateTimeDisplay() {
        timeDisplay.text = formatTime(currentTime)
    }

    // 时间格式化函数
    function formatTime(ms) {
        var minutes = Math.floor(ms / 60000)
        var seconds = Math.floor((ms % 60000) / 1000)
        var milliseconds = Math.floor((ms % 1000) / 10)

        // 格式化数字为两位数
        var minStr = minutes.toString().padStart(2, '0')
        var secStr = seconds.toString().padStart(2, '0')
        var msStr = milliseconds.toString().padStart(2, '0')

        return minStr + ":" + secStr + "." + msStr
    }

    // 添加计次记录
    function addLap() {
        // 插入到列表开头，保持最新记录在上方
        lapModel.insert(0, { timeMs: currentTime })
        // 可选：限制最大记录数以优化性能
        if (lapModel.count > 50) {
            lapModel.remove(lapModel.count - 1)
        }
    }

    // 重置计时器
    function resetTimer() {
        currentTime = 0
        timer.startTime = null
        lapModel.clear()
        updateTimeDisplay()
        stopwatchPage.state = state_initial
    }
}
