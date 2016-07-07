import QtQuick 2.0

QtObject {
    property string partyName
    property color partyColor
    property url flagSource
    property string candidateName
    property url candidateSource
    property int majorUnit
    property int minorUnit
    property int seats
    property real candidatePercentage
    property real seatPercentage
    property variant localCandidates
    property variant nationalCandidates
    property bool candidateElected

    function load(settings) {
        console.log(JSON.stringify(settings))
        partyName = settings.name
        partyColor = settings.color
        flagSource = "file://" + Native.getFilePath(settings.flag)
        candidateSource = "file://" + Native.getFilePath(settings.avatar)
        candidateName = settings.candidate
        localCandidates = settings.local_seats
        nationalCandidates = settings.national_seats
    }
}
