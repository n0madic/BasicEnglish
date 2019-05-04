import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Layouts 1.12
import "../functions.js" as Func

Item {

    SwipeView {
        id: viewTest
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
                    width: viewTest.width
                    height: viewTest.height

                    ColumnLayout {
                        id: column
                        anchors.fill: parent
                        spacing: 15
                        width: parent.width

                        Label {
                            id: englishWord

                            width: parent.width
                            wrapMode: Label.Wrap
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
                            font.pixelSize: 34
                            text: english
                            visible: !settings.blindtest
                        }

                        Image {
                            source: "qrc:/images/sound.png"
                            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
                            Layout.preferredHeight: parent.height / 7
                            Layout.preferredWidth: parent.width / 7
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
                            target: viewTest
                            onCurrentIndexChanged: if (viewTest.currentIndex === model.index) Func.autosound(english)
                        }

                        Connections {
                            target: stackLayout
                            onCurrentIndexChanged: if (viewTest.currentIndex === model.index && stackLayout.currentIndex === 2) Func.autosound(english)
                        }

                        Label {
                            width: parent.width
                            wrapMode: Label.WordWrap
                            text: "Выберите правильный вариант перевода:"
                            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
                            font.pixelSize: 12
                        }

                        Label {
                            id: var1

                            padding: 5
                            width: parent.width * 0.9
                            height: 50
                            text: test1
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
                            Layout.preferredWidth: parent.width - 20
                            Layout.preferredHeight: parent.height / 12
                            font.pointSize: 14
                            background: Rectangle {
                                anchors.fill: parent
                                border.width: 1
                                radius: 10
                                color: "white"
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        tested = true
                                        var1.enabled = false
                                        if (test1 === russian) {
                                            parent.color = 'green';
                                            var1.color = 'white';
                                            countRight = countRight + 1
                                            if (viewTest.currentIndex < listModel.count) {
                                                viewTest.setCurrentIndex(viewTest.currentIndex + 1)
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
                            height: 50
                            text: test2
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
                            Layout.preferredWidth: parent.width - 20
                            Layout.preferredHeight: parent.height / 12
                            font.pointSize: 14
                            background: Rectangle {
                                border.width: 1
                                radius: 10
                                color: "white"
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        tested = true
                                        var2.enabled = false
                                        if (test2 === russian) {
                                            parent.color = 'green';
                                            var2.color = 'white';
                                            countRight = countRight + 1
                                            if (viewTest.currentIndex < listModel.count) {
                                                viewTest.setCurrentIndex(viewTest.currentIndex + 1)
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
                            height: 50
                            text: test3
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            Layout.alignment: Qt.AlignCenter | Qt.AlignTop
                            Layout.preferredWidth: parent.width - 20
                            Layout.preferredHeight: parent.height / 12
                            font.pointSize: 14
                            background: Rectangle {
                                border.width: 1
                                radius: 10
                                color: "white"
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        tested = true
                                        var3.enabled = false
                                        if (test3 === russian) {
                                            parent.color = 'green';
                                            var3.color = 'white';
                                            countRight = countRight + 1
                                            if (viewTest.currentIndex < listModel.count) {
                                                viewTest.setCurrentIndex(viewTest.currentIndex + 1)
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
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignCenter | Qt.AlignBottom
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Label.WordWrap
                            textFormat: Text.StyledText
                            text: (viewTest.currentIndex + 1) + "/" + listModel.count
                                  + "<br/>Правильных ответов: " + countRight
                                  + "<br/>Неправильных ответов: <font color=\"red\">" + countWrong + "</font>"
                            font.pixelSize: 12
                        }
                    }
                }
            }
        }
    }
}
