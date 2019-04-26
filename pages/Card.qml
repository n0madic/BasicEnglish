import QtQuick 2.12
import QtQuick.Controls 2.12
import "../functions.js" as Func

Item {

    SwipeView {
        id: view
        currentIndex: settings.shuffle ? 0 : settings.index
        anchors.fill: parent

        onCurrentIndexChanged: settings.index = view.currentIndex

        Repeater {
            id: loop
            model: listModel

            Loader {
                active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                sourceComponent:

                Pane {
                    width: view.width
                    height: view.height

                    Column {
                        id: column
                        anchors.fill: parent
                        spacing: 40
                        width: parent.width

                        Label {

                            width: parent.width
                            wrapMode: Label.Wrap
                            horizontalAlignment: Qt.AlignHCenter
                            font.pixelSize: 34
                            text: english
                        }

                        Label {
                            width: parent.width
                            wrapMode: Label.Wrap
                            horizontalAlignment: Qt.AlignHCenter
                            font.pixelSize: 24
                            text: russian
                        }

                        Image {
                            source: "qrc:/images/sound.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: parent.height / 5
                            width: view.width / 5
                            fillMode: Image.PreserveAspectFit

                            MouseArea {
                                id: playArea
                                anchors.fill: parent
                                onPressed: {
                                    Func.pronunciation(english)
                                }
                            }
                        }

                        Connections {
                            target: view

                            function autosound() {
                                if (settings.autosound && view.currentIndex === model.index) {
                                    Func.pronunciation(english)
                                }
                            }

                            onCurrentIndexChanged: autosound()
                            Component.onCompleted: autosound()
                        }

                        Label {
                            id: count

                            width: parent.width
                            text: (view.currentIndex + 1) + "/" + listModel.count
                            horizontalAlignment: Qt.AlignHCenter
                            font.pixelSize: 12
                        }

                        Image {
                            source: "qrc:/images/arrows.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: view.width / 5
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                }
            }
        }
    }
}
