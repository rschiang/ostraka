
.pragma library

function isStartWith(str, chr) {
    return str.charAt(0) == chr
}

function partition(str, sep) {
    var index = str.indexOf(sep)
    if (index < 0)
        return [str, "", ""]
    else
        return [str.substring(0, index), sep, str.substring(index + sep.length)]
}

function padRight(str, len, toPad) {
    str = String(str)
    while (str.length < len)
        str = toPad + str
    return str
}
