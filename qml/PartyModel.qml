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
    property variant seatCandidates

    function load(settings) {
        partyName = settings.name
        partyColor = settings.color
        flagSource = settings.flag
        candidateSource = settings.candidate.avatar
        candidateName = settings.candidate.name
        seatCandidates = settings.seats
    }
}
