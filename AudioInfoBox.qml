import QtQuick
import QtMultimedia
import com.company.PlayerController
import SongPlayer

Item {
    id: root
    required property AudioInfo infoProvider

    Image {
        id: albumImage
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        width: 150
        height: 150
        source: infoProvider ? infoProvider.imageSource : ""
        //visible: !albumVideo.visible
    }

    // Video {
    //     id: albumVideo
    //     anchors {
    //         verticalCenter: parent.verticalCenter
    //         left: parent.left
    //     }
    //     width: 150
    //     height: 150
    //     loops: MediaPlayer.Infinite
    //     volume: 0.1
    //     source: infoProvider ? infoProvider.videoSource : ""
    //     visible: true//infoProvider && infoProvider.videoSource.toString() !== ""
    // }

    Text {
        id: titleText
        anchors {
            bottom: parent.verticalCenter
            left: albumImage.right
            margins: 20
            right: parent.right
        }
        color: "white"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        text: infoProvider ? infoProvider.title : ""
        font {
            pixelSize: 20
            bold: true
        }
    }

    Text {
        id: authorText
        anchors {
            top: parent.verticalCenter
            left: titleText.left
            topMargin: 5
            right: parent.right
        }
        color: "gray"
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        text: infoProvider ? infoProvider.authorName : ""
        font {
            pixelSize: 16
        }
    }

    // Component.onCompleted: {
    //     if (infoProvider && PlayerController.currentSongIndex === infoProvider.songIndex && infoProvider.audioSource.toString() !== "") {
    //         PlayerController.changeAudioSource(infoProvider.audioSource)
    //     }
    // }
}
