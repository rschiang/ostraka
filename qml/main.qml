import QtQuick 2.0
import "Config.js" as Config

QtObject {
    id: app

    // Properties
    property string titleText
    property int totalElectors: 13452016
    property int totalSeats: 10
    property string viewState: "chart"

    // Models
    property list<PartyModel> parties: [
        PartyModel { id: party1 },
        PartyModel { id: party2 },
        PartyModel { id: party3 }
    ]

    property list<RegionModel> regions: [
        RegionModel {
            name: "選區一"
            totalBallots: 54
            candidates: [ LocalCandidateModel {}, LocalCandidateModel {}, LocalCandidateModel {} ]
        },
        RegionModel {
            name: "選區二"
            totalBallots: 58
            candidates: [ LocalCandidateModel {}, LocalCandidateModel {}, LocalCandidateModel {} ]
        },
        RegionModel {
            name: "選區三"
            totalBallots: 58
            candidates: [ LocalCandidateModel {}, LocalCandidateModel {}, LocalCandidateModel {} ]
        },
        RegionModel {
            name: "選區四"
            totalBallots: 64
            candidates: [ LocalCandidateModel {}, LocalCandidateModel {}, LocalCandidateModel {} ]
        }
    ]

    // Functions
    function spawn(screen, proto) {
        if (!proto)
            proto = windowPrototype

        var window = proto.createObject(app)
        Native.setScreen(window, screen)

        return window
    }

    // Events
    Component.onCompleted: {
        var path = Native.getFilePath('ostraka.txt')
        var file = Native.readFile(path)
        var settings = Config.parse(file)
        party1.load(settings[0])
        party2.load(settings[1])
        party3.load(settings[2])

        for (var p in parties)
            for (var i in parties[p].localCandidates) {
                var candidate = regions[i].candidates[p]
                candidate.candidateName = parties[p].localCandidates[i]
                candidate.partyName = parties[p].partyName
                candidate.partyColor = parties[p].partyColor
            }

        var screens = Native.getScreens()
        var primaryScreen = Native.getPrimaryScreen()

        if (screens.length < 2)
            spawn(primaryScreen)
        else
            for (var i in screens)
                if (screens[i] !== primaryScreen)
                    spawn(screens[i])

        var editor = spawn(primaryScreen, editorPrototype)
        editor.init()
    }

    // Resources
    property list<Component> resources: [
        Component {
            id: windowPrototype
            DisplayWindow {}
        },
        Component {
            id: editorPrototype
            EditorWindow {}
        }
    ]
}
