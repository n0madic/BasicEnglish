import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12
import Qt.labs.settings 1.0
import QtMultimedia 5.12
import "functions.js" as Func


ApplicationWindow {
    id: window
    width: 360
    height: 520
    visible: true
    title: "Basic English"

    Settings {
        id: settings
        property bool autosound: false
        property bool blindtest: false
        property bool shuffle: false
        property string title: "Basic English"
        property int section: 0
        property int subsection: 0
        property int index: 0
    }

    property int countRight: 0
    property int countWrong: 0

    Shortcut {
        sequences: ["Esc", "Back"]
        enabled: stackView.depth > 1
        onActivated: {
            stackView.pop()
            listView.currentIndex = -1
            trainingButton.enabled = true
            testButton.enabled = true
            titleLabel.text = "Basic English"
        }
    }

    header: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "images/drawer.png"
                }
                onClicked: {
                    drawer.open()
                }
            }

            Label {
                id: titleLabel
                text: listView.currentItem ? listView.currentItem.text : "Basic English"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/menu.png"
                }
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "Настройки"
                        onTriggered: settingsPopup.open()
                    }
                    MenuItem {
                        text: "О программе"
                        onTriggered: aboutDialog.open()
                    }
                }
            }
        }
    }

    footer: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                id: trainingButton
                text: "Обучение"
                highlighted: false
                transformOrigin: Item.Left

                onClicked: {
                    stackView.pop()
                    stackView.push("qrc:/pages/Card.qml")
                    trainingButton.enabled = false
                    testButton.enabled = true
                    titleLabel.text = settings.title
                }
            }

            ToolButton {
                id: testButton
                text: "Тестирование"
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                onClicked: {
                    stackView.pop()
                    stackView.push("qrc:/pages/Test.qml")
                    testButton.enabled = false
                    trainingButton.enabled = true
                    titleLabel.text = settings.title
                }
            }
        }
    }

    Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        dragMargin: stackView.depth > 1 ? 0 : undefined

        ListView {
            id: listView
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    if (model.title === "Грамматика") {
                        stackView.push("qrc:/pages/Grammar.qml")
                        trainingButton.enabled = true
                        testButton.enabled = true
                    } else if (listView.currentIndex != index) {
                        listView.currentIndex = index
                        stackView.pop()
                        if (stackView.depth == 1) {
                            stackView.push("qrc:/pages/Card.qml")
                            trainingButton.enabled = false
                            testButton.enabled = true
                        }
                        settings.section = model.section
                        settings.subsection = model.subsection
                        settings.title = model.title.trim()
                        titleLabel.text = settings.title
                        Func.fillListModel()
                        countRight = 0
                        countWrong = 0
                    }
                    drawer.close()
                }
            }

            model: ListModel {
                ListElement {
                    title: "Предметы и явления"; section: 1; subsection: 0
                }
                ListElement {
                    title: "    200 описательных слов"; section: 1; subsection: 1
                }
                ListElement {
                    title: "    400 общих слов"; section: 1; subsection: 2
                }
                ListElement {
                    title: "Действия и движение"; section: 2; subsection: 0
                }
                ListElement {
                    title: "    100 слов действия"; section: 2; subsection: 0
                }
                ListElement {
                    title: "Выражение качества"; section: 3; subsection: 0
                }
                ListElement {
                    title: "    Общие 100 слов качества"; section: 3; subsection: 1
                }
                ListElement {
                    title: "    Противоположные 50 слов"; section: 3; subsection: 2
                }
                ListElement {
                    title: "Грамматика"; section: 0; subsection: 0
                }
            }

            ScrollIndicator.vertical: ScrollIndicator {}
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Pane {
            id: pane

            Image {
                id: logo
                height: 360
                anchors.bottomMargin: 167
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/logo.png"
            }

            Label {
                text: "Это искусственно созданный базовый английский язык, где используется всего 850 самых необходимых слов, а грамматика представляет собой простую логичную систему. Выучить Basic English можно за несколько дней и смело отправляться в любую англоязычную страну."
                anchors.margins: 20
                anchors.top: logo.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                wrapMode: Label.Wrap
            }
        }
    }

    Popup {
        id: settingsPopup
        x: (window.width - width) / 2
        y: window.height / 7
        width: Math.min(window.width, window.height) / 3 * 2
        height: settingsColumn.implicitHeight + topPadding + bottomPadding
        modal: true
        focus: true

        contentItem: ColumnLayout {
            id: settingsColumn
            spacing: 20

            Label {
                text: "Настройки"
                font.bold: true
            }

            ColumnLayout {
                spacing: 10

                CheckBox {
                    id: shuffleBox
                    text: "Перемешать слова"
                    checked: settings.shuffle
                    Component.onCompleted: {
                        checked = settings.shuffle
                    }
                }

                CheckBox {
                    id: soundBox
                    text: "Автопроизношение"
                    checked: settings.autosound
                    Component.onCompleted: {
                        checked = settings.autosound
                    }
                }

                CheckBox {
                    id: blindBox
                    text: "Тест вслепую"
                    checked: settings.blindtest
                    Component.onCompleted: {
                        checked = settings.blindtest
                    }
                }

            }

            RowLayout {
                spacing: 10

                Button {
                    id: okButton
                    text: "Ok"
                    onClicked: {
                        settings.autosound = soundBox.checked
                        settings.blindtest = blindBox.checked
                        if (settings.shuffle != shuffleBox.checked) {
                            settings.shuffle = shuffleBox.checked
                            if (settings.shuffle) {
                                Func.shuffleWords()
                            } else {
                                Func.sortWords()
                            }
                            Func.fillListModel()
                        }
                        settingsPopup.close()
                    }

                    Material.foreground: Material.primary
                    Material.background: "transparent"
                    Material.elevation: 0

                    Layout.preferredWidth: 0
                    Layout.fillWidth: true
                }

                Button {
                    id: cancelButton
                    text: "Cancel"
                    onClicked: {
                        blindBox.checked = settings.blindtest
                        shuffleBox.checked = settings.shuffle
                        soundBox.checked = settings.autosound
                        settingsPopup.close()
                    }

                    Material.background: "transparent"
                    Material.elevation: 0

                    Layout.preferredWidth: 0
                    Layout.fillWidth: true
                }
            }
        }
    }

    Popup {
        id: aboutDialog
        modal: true
        focus: true
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                text: "О программе"
                font.bold: true
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Изучение английского с помощью Basic English"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

            Label {
                width: aboutDialog.availableWidth
                text: "© Nomadic <nomadic.ua@gmail.com>"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

            Label {
                width: aboutDialog.availableWidth
                text: "Основано на обучающих материалах сайта https://iloveenglish.ru/\n" +
                      "Произношение: https://forvo.com"
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }

    Audio {
        autoLoad: false
    }

    ListModel {
        id: listModel
    }

    Component.onCompleted: {
        if (settings.shuffle) {
            Func.shuffleWords()
        }
        Func.fillListModel()
        if (settings.index > 0) {
            stackView.push("qrc:/pages/Card.qml")
            titleLabel.text = settings.title
            trainingButton.enabled = false
        }
    }
}
