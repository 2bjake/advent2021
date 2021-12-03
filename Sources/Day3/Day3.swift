import Extensions

func mostCommonValue(in array: [Character], tieBreaker: String = "1") -> String {
  let onesCount = array.count { $0 == "1" }
  let zerosCount = array.count - onesCount

  return onesCount > zerosCount ? "1"
  : onesCount < zerosCount ? "0"
  : tieBreaker
}

func leastCommonValue(in array: [Character], tieBreaker: String) -> String {
  let onesCount = array.count { $0 == "1" }
  let zerosCount = array.count - onesCount

  return onesCount < zerosCount ? "1"
  : onesCount > zerosCount ? "0"
  : tieBreaker
}

public func partOne() {
  let gammaChars = input
    .map(Array.init)
    .transpose()
    .map { mostCommonValue(in: $0) }

  let epsilonChars = gammaChars.map { $0 == "1" ? "0" : "1" }

  let gamma = Int(gammaChars.joined(separator: ""), radix: 2)!
  let epsilon = Int(epsilonChars.joined(separator: ""), radix: 2)!

  print(gamma * epsilon) // 3277364
}

public func partTwo() {
  var values = input
    .map(Array.init)

  var columnIndex = 0
  while values.count > 1 {
    let filterBit = mostCommonValue(in: values.column(at: columnIndex), tieBreaker: "1")
    values = values.filter { String($0[columnIndex]) == filterBit }
    columnIndex += 1
  }

  let oxygenRating = Int(values.first!.map(String.init).joined(separator: ""), radix: 2)!

  values = input
    .map(Array.init)

  columnIndex = 0
  while values.count > 1 {
    let filterBit = leastCommonValue(in: values.column(at: columnIndex), tieBreaker: "0")
    values = values.filter { String($0[columnIndex]) == filterBit }
    columnIndex += 1
  }

  let scrubberRating = Int(values.first!.map(String.init).joined(separator: ""), radix: 2)!


  print(scrubberRating * oxygenRating) // 5736383
}
