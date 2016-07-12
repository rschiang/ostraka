// Imports
Qt.include('Strings.js')

// Definitions
var configNames = {
    "顏色":　"color",
    "旗幟":　"flag",
    "總統候選人":　"candidate",
    "肖像":　"avatar",
    "區域立委候選人":　"local_seats",
    "不分區立委候選人":　"national_seats",
}

// Functions
function parse(buf) {
    var lines = buf.split('\n')
    var parties = []
    var party = {}

    for (var i in lines) {
        var line = lines[i].trim()

        if (isStartWith(line, '#'))
            // Comments and blank lines
            continue

        if (line.length <= 0) {
            // Separator line
            if ('name' in party) {
                parties.push(party)
                party = {}
            }

        } else if (isStartWith(line, '【')) {
            // Name tagline
            party['name'] = line.substring(1, line.indexOf('】'))

        } else {
            // Config
            var parts = partition(line, '：')
            if (!parts[1]) continue

            // Postprocessing
            if (parts[0] in configNames)
                // Replace display names with codenames
                parts[0] = configNames[parts[0]]

            if (parts[2].indexOf('、') >= 0)
                // Create lists
                parts[2] = parts[2].split('、')

            party[parts[0]] = parts[2]
        }
    }

    return parties
}
