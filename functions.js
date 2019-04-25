Qt.include("words.js")

function getRandomIndex(lengthOfArray, indexToExclude) {
    var rand = null
    while (rand === null || rand === indexToExclude) {
        rand = Math.round(Math.random() * (lengthOfArray - 1))
    }
    return rand
}

function sortWords(array) {
    listWords.sort(function (a, b) {
        if (a.english > b.english) {
            return 1;
        }
        if (a.english < b.english) {
            return -1;
        }
        return 0;
    })
}

function shuffleList(array) {
    var counter = array.length
    while (counter > 0) {
        var index = Math.floor(Math.random() * counter)
        counter--
        var temp = array[counter]
        array[counter] = array[index]
        array[index] = temp
    }
    return array
}

function shuffleWords(array) {
    listWords = shuffleList(listWords)
}

function fillListModel() {
    var n
    listModel.clear()
    for (n = 0; n < listWords.length; n++) {
        if ((settings.section === 0 || listWords[n].section === settings.section) &&
            (settings.subsection === 0 || listWords[n].subsection === settings.subsection)) {
            var testVars = shuffleList(
                [
                 listWords[n].russian,
                 listWords[getRandomIndex(listWords.length, n)].russian,
                 listWords[getRandomIndex(listWords.length, n)].russian
                ])
            listModel.append({
                "english": listWords[n].english,
                "russian": listWords[n].russian,
                "test1": testVars[0],
                "test2": testVars[1],
                "test3": testVars[2]
            })
        }
    }
}

function pronunciation(word) {
    var playSound = Qt.createQmlObject("\
        import QtMultimedia 5.12;
        Audio {
            source: \"qrc:/audio/" + word.replace("/", "-") + ".mp3\"
        }
        ", view, "")
    playSound.play()
    playSound.destroy(2000)
}
