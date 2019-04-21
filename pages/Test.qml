import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12
import "../functions.js" as Func

Item {

    SwipeView {
        id: view
        currentIndex: 0
        anchors.fill: parent

        Repeater {
            id: loop
            model: listModel

            Loader {
                property bool tested: false

                active: tested || SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                sourceComponent:

                Pane {
                    width: view.width
                    height: view.height

                    Column {
                        id: column
                        anchors.fill: parent
                        spacing: 15
                        width: parent.width

                        Label {
                            id: englishWord

                            width: parent.width
                            wrapMode: Label.Wrap
                            horizontalAlignment: Qt.AlignHCenter
                            font.pixelSize: 34
                            text: english
                        }

                        Image {
                            source: "qrc:/images/sound.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: view.width / 7
                            fillMode: Image.PreserveAspectFit

                            MouseArea {
                                id: playArea
                                anchors.fill: parent
                                onPressed: {
                                    Func.pronunciation(english)
                                }
                            }
                        }

                        Label {
                            width: parent.width
                            wrapMode: Label.WordWrap
                            text: "Выберите правильный вариант перевода:"
                            horizontalAlignment: Qt.AlignHCenter
                            font.pixelSize: 12
                        }

                        Label {
                            id: var1

                            padding: 5
                            width: parent.width * 0.9
                            height: 40
                            text: test1
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pointSize: 12
                            background: Rectangle {
                                anchors.fill: parent
                                border.width: 1
                                radius: 10
                                color: "white"
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        tested = true
                                        if (test1 === russian) {
                                            parent.color = 'green';
                                            var1.color = 'white';
                                            countRight = countRight + 1
                                            if (view.currentIndex < listModel.count) {
                                                view.setCurrentIndex(view.currentIndex + 1)
                                            }
                                        } else {
                                            parent.color = 'red';
                                            var1.color = 'white';
                                            countWrong = countWrong + 1
                                        }
                                    }
                                }
                            }
                        }

                        Label {
                            id: var2

                            padding: 5
                            width: parent.width * 0.9
                            height: 40
                            text: test2
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pointSize: 12
                            background: Rectangle {
                                border.width: 1
                                radius: 10
                                color: "white"
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        tested = true
                                        if (test2 === russian) {
                                            parent.color = 'green';
                                            var2.color = 'white';
                                            countRight = countRight + 1
                                            if (view.currentIndex < listModel.count) {
                                                view.setCurrentIndex(view.currentIndex + 1)
                                            }
                                        } else {
                                            parent.color = 'red';
                                            var2.color = 'white';
                                            countWrong = countWrong + 1
                                        }
                                    }
                                }
                            }
                        }

                        Label {
                            id: var3

                            padding: 5
                            width: parent.width * 0.9
                            height: 40
                            text: test3
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pointSize: 12
                            background: Rectangle {
                                border.width: 1
                                radius: 10
                                color: "white"
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        tested = true
                                        if (test3 === russian) {
                                            parent.color = 'green';
                                            var3.color = 'white';
                                            countRight = countRight + 1
                                            if (view.currentIndex < listModel.count) {
                                                view.setCurrentIndex(view.currentIndex + 1)
                                            }
                                        } else {
                                            parent.color = 'red';
                                            var3.color = 'white';
                                            countWrong = countWrong + 1
                                        }
                                    }
                                }
                            }
                        }

                        Label {
                            width: parent.width
                            anchors.bottomMargin: 10
                            wrapMode: Label.WordWrap
                            text: (view.currentIndex + 1) + "/" + listModel.count
                                  + "\nПравильных ответов: " + countRight
                                  + "\nНеправильных ответов: " + countWrong
                            horizontalAlignment: Qt.AlignHCenter
                            font.pixelSize: 12
                        }
                    }
                }
            }
        }
    }
}
