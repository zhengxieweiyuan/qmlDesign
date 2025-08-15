import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 400
    height: 200
    visible: true
    title: qsTr("2048 Merge Animation")

    Rectangle {
        id: board
        width: 180
        height: 90
        anchors.centerIn: parent
        color: "#bbada0"
        radius: 5

        // 方块1（初始值为2）
        Rectangle {
            id: tile1
            x: 5
            y: 5
            width: 80
            height: 80
            radius: 5
            color: "#eee4da"
            Text {
                anchors.centerIn: parent
                text: "2"
                font.pixelSize: 24
                color: "black"
            }
            Behavior on x { NumberAnimation { duration: 100; easing.type: Easing.InOutQuad } }
        }

        // 方块2（初始值为2，合并后消失）
        Rectangle {
            id: tile2
            x: 95
            y: 5
            width: 80
            height: 80
            radius: 5
            color: "#eee4da"
            Text {
                anchors.centerIn: parent
                text: "2"
                font.pixelSize: 24
                color: "black"
            }
            Behavior on x { NumberAnimation { duration: 100; easing.type: Easing.InOutQuad } }
        }

        // 目标方块（合并后显示4）
        Rectangle {
            id: mergedTile
            x: 5
            y: 5
            width: 80
            height: 80
            radius: 5
            color: "#ede0c8" // 4的颜色
            visible: false
            Text {
                anchors.centerIn: parent
                text: "4"
                font.pixelSize: 24
                color: "black"
            }
            SequentialAnimation {
                id: mergeAnimation
                running: false
                NumberAnimation { target: mergedTile; property: "scale"; to: 1.2; duration: 50 }
                NumberAnimation { target: mergedTile; property: "scale"; to: 1.0; duration: 50 }
            }
        }
    }

    // 触发合并动画
    MouseArea {
        anchors.verticalCenter: board.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: board.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: -290
        anchors.rightMargin: -290
        anchors.topMargin: -145
        anchors.bottomMargin: -145
        anchors.horizontalCenter: board.horizontalCenter
        onClicked: {
            // 方块2滑动到方块1位置
            tile2.x = 5
            // 等待滑动完成
            let timer = Qt.createQObject(null, board, "Timer", {
                interval: 100,
                running: true,
                repeat: false,
                onTriggered: function() {
                    tile1.visible = false // 隐藏原方块
                    tile2.visible = false
                    mergedTile.visible = true // 显示合并方块
                    mergeAnimation.start() // 触发放大动画
                }
            })
        }
    }
}
