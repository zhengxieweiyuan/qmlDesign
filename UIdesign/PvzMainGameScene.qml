import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: 1400
    height: 600


    Image {


        id: backGround
        anchors.fill: parent
        source: "../../PVZ/interface/background1.jpg"
        property real widthScaleXFactor: backGround.width/1400
        property real heightScaleYFactor: backGround.height/600
        //fillMode: Image.PreserveAspectFit
        Grid {
            id: lawn
            x: backGround.widthScaleXFactor*254 +root.x
            y:backGround.heightScaleYFactor*78 +root.y
            rows: 5
            columns: 9
            transformOrigin: Item.Center
            width: backGround.width*0.51428
            height:backGround.height*0.83333
            visible: true

            Repeater {
                id: tileRepeater
                anchors.fill: parent
                enabled: false
                model: 45
                delegate: Rectangle{
                    id: rec1_1; width: backGround.widthScaleXFactor*80 ; height:backGround.heightScaleYFactor*100
                    color: "#00ffffff"
                    border.color: "#808080"
                    border.width: 1

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent

                        Connections {
                            target: mouseArea
                            onPressed:  rec1_1.color="#ffffff"

                        }

                        Connections {
                            target: mouseArea
                            onReleased: rec1_1.color="#00ffffff"
                        }




                    }

                }
            }

            // Rectangle{ id: rec1_1; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_2; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_3; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_4; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_5; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_6; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_7; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_8; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_9; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_10; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_11; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_12; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_13; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_14; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width
            // MouseArea{
            //     anchors.fill: parent
            //     onClicked: {
            //         lawn.opacity=0.3
            //     }
            // }
            // }
            // Rectangle{ id: rec1_15; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }
            // Rectangle{ id: rec1_16; x: 50; y: 10;width: 80; height: 1.25*rec1_1.width }



        }

        Row {
            id: neck
            x: 280*backGround.widthScaleXFactor
            y: 0

            spacing:backGround.heightScaleYFactor*3
            width: backGround.widthScaleXFactor*60*10  //10 is the number of neck
            height: 70*backGround.heightScaleYFactor

            Repeater {
                id: neckRepeater
                anchors.fill: parent

                model: 10
                delegate: SingleNeck{
                    cost: 20;
                    imageUrl: "../../PVZ/Plants/SunFlower/SunFlower.gif";
                    widthCard:backGround.heightScaleYFactor*50 }

            }

        }

        Grid {
            id: shovel
            anchors.left: neck.right
            anchors.top: neck.top
            anchors.leftMargin: 10
            width: 82
            height: 76
        }

        Grid {
            id: grid
            anchors.left: shovel.right
            anchors.top: shovel.top
            anchors.leftMargin: 10
            width: 82
            height: 76
        }
    }
}


