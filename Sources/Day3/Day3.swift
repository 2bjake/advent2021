import Extensions

enum Bit: Character, CaseIterable {
  case zero = "0"
  case one = "1"
}

extension Array where Element == Bit {
  func inverted() -> [Bit] {
    self.map { $0 == .one ? Bit.zero : .one }
  }
}

extension Int {
  init(_ source: [Bit]) {
    self.init(String(source.map(\.rawValue)), radix: 2)!
  }
}

func mostCommonValue(in array: [Bit]) -> Bit? {
  let onesCount = array.count { $0 == .one }
  let zerosCount = array.count - onesCount

  guard onesCount != zerosCount else { return nil }
  return onesCount > zerosCount ? .one : .zero
}

func leastCommonValue(in array: [Bit]) -> Bit? {
  let onesCount = array.count { $0 == .one }
  let zerosCount = array.count - onesCount

  guard onesCount != zerosCount else { return nil }
  return onesCount < zerosCount ? .one : .zero
}

func inputAsBits() -> [[Bit]] {
  input.map { $0.compactMap(Bit.init) }
}

public func partOne() {
  let gammaBits = inputAsBits()
    .transpose()
    .map { mostCommonValue(in: $0) ?? .one }

  let epsilonBits = gammaBits.inverted()

  print(Int(gammaBits) * Int(epsilonBits)) // 3277364
}

public func partTwo() {
  var values = inputAsBits()

  var columnIndex = 0
  while values.count > 1 {
    let filterBit = mostCommonValue(in: values.column(at: columnIndex)) ?? .one
    values = values.filter { $0[columnIndex] == filterBit }
    columnIndex += 1
  }

  let oxygenRating = Int(values.first!)

  values = inputAsBits()

  columnIndex = 0
  while values.count > 1 {
    let filterBit = leastCommonValue(in: values.column(at: columnIndex)) ?? .zero
    values = values.filter { $0[columnIndex] == filterBit }
    columnIndex += 1
  }

  let scrubberRating = Int(values.first!)

  print(scrubberRating * oxygenRating) // 5736383
}
