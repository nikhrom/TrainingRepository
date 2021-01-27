import QtQuick 2.15
import QtQuick.Window 2.14
import QtQuick3D 1.15
//import Qt3D.Extras 2.15


Window {
    id: window
    width: 1280
    height: 720
    visible: true

    View3D {
        id: view
        anchors.fill: parent

        //! [environment]
        environment: SceneEnvironment {
            clearColor: "black"
            backgroundMode: SceneEnvironment.Color
        }
        //! [environment]

        //! [camera]

        MouseArea{
            anchors.fill: parent
            property int pastX: 0
            property int pastY: 0

            onEntered: {
                pastX = mouseX
                pastY = mouseY
            }

            onMouseXChanged: {
                var moving = mouseX - pastX
                //groupModels.eulerRotation.y += (moving) / 5
                groupModels.rotate(moving/5, Qt.vector3d(0, 1, 0), Node.LocalSpace)

                pastX = mouseX

            }

            onMouseYChanged: {
                var moving = mouseY - pastY
                if(!(groupModels.eulerRotation.x + moving > 60) &&
                     !(groupModels.eulerRotation.x + moving < -60)){
                //groupModels.eulerRotation.x += (moving) / 5
                     groupModels.rotate(moving/5, Qt.vector3d(1, 0, 0), Node.SceneSpace)
                //groupModels.rotate(ddd)

                //-36.6995
                }
                pastY = mouseY
                console.debug(groupModels.eulerRotation)
            }


            onWheel: {
                camera.position.z += (wheel.angleDelta.y > 0)? -2 : 2
            }
        }

        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 100, 200)
        }
        //! [camera]


        //! [light]
        DirectionalLight {
            eulerRotation.x: 40
            eulerRotation.y: -20
            brightness: 300

        }
        //! [light]

        //! [objects]
        Model{
            id: groupModels
            position: Qt.vector3d(0, 100, 0)
            //eulerRotation: Qt.vector3d(23.7481, -76.0062, -36.6995)
            rotation: Qt.vector3d(23.7481, -76.0062, -36.6995)
            Model {
                source: "#Sphere"
                position: Qt.vector3d(0, 0, 0)
                scale: Qt.vector3d(2, 2, 2)
                materials: [ PrincipledMaterial {
                           metalness: 0.3
                           opacity: 100
                           baseColorMap: Texture { source: "./earthMax.jpg"}

                       }
                   ]

            }
        }
        //! [objects]
    }
}
