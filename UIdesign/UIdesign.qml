import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
Window {
    width: 360
    height: 640
    visible: true
    title: qsTr("Hello World")

    StackView {
            id: stackView
            anchors.fill: parent
            initialItem: worldTime

            Component {
                id: mainuifile
                MainuiFile {}
            }

            Component {
                id: alarmSettingsPage
                AlarmSettingsPage {}
            }

            Component{
                id:worldTime
                WorldTime{}
            }
        }
}
