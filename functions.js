Qt.include("words.js")

function getRandomIndex(lengthOfArray, indexToExclude) {
    var rand = null
    while (rand === null || rand === indexToExclude) {
        rand = Math.round(Math.random() * (lengthOfArray - 1))
    }
    return rand
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

function shuffleModel(model) {
    var currentIndex = model.count,
        temporaryValue, randomIndex

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {
        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex)
        currentIndex -= 1
        // And swap it with the current element.
        // the dictionaries maintain their reference so a copy should be made
        // https://stackoverflow.com/a/36645492/6622587
        temporaryValue = JSON.parse(JSON.stringify(model.get(currentIndex)))
        model.set(currentIndex, model.get(randomIndex))
        model.set(randomIndex, temporaryValue)
    }
    return model
}

function fillListModel(section, subsection) {
    var n
    listModel.clear()
    for (n = 0; n < listWords.length; n++) {
        if ((section === 0 || listWords[n].section === section) &&
            (subsection === 0 || listWords[n].subsection === subsection)) {
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
        if (settings.shuffle) {
            listModel = shuffleModel(listModel)
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
