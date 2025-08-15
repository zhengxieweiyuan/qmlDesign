import QtQuick
import QtQuick.Controls

Rectangle {
    property real widthCard: 60
    readonly property real heightCard: widthCard*4/3
    property real cost: 50
    property url imageUrl:"../../PVZ/Plants/SunFlower/SunFlower.gif"
    id: card
    width: widthCard
    height:heightCard
    radius: heightCard/10
    color: "#00B0BEC5"
    border.color: "#455A64"
    border.width: heightCard/40
    Item{
        id:components
        Image {
            id: cardImage
            anchors.top: card.top
            anchors.topMargin: widthCard/10
            source: card.imageUrl
            anchors.horizontalCenter: card.horizontalCenter
            width: widthCard
            height: widthCard
            opacity: 1

        }

        // 植物名称

        Row{
            anchors.top: cardImage.bottom
            anchors.topMargin: heightCard/40
            anchors.horizontalCenter: cardImage.horizontalCenter



            Text {
                id:plantname
                text: card.cost
                font.pixelSize:heightCard/10
                font.family: "Comic Sans MS"
                color: "#212121"
            }

            Image {
                id: image
                width: heightCard/5
                height: heightCard/5
                source: "../../PVZ/interface/Sun.gif"
                fillMode: Image.PreserveAspectFit

            }
        }

    }


}

