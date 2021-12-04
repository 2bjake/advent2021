import Extensions

enum Bit: Character {
  case zero = "0"
  case one = "1"

  func inverted() -> Bit {
    self == .zero ? .one : .zero
  }
}

extension Int {
  init(_ source: [Bit]) {
    self.init(String(source.map(\.rawValue)), radix: 2)!
  }
}

public func partOne() {
  let gammaBits = input
    .map { $0.compactMap(Bit.init) }
    .transpose()
    .map { $0.mostCommon()! }

  let epsilonBits = gammaBits.map { $0.inverted() }

  print(Int(gammaBits) * Int(epsilonBits)) // 3277364
}

func filterInput(by bitCriteria: ([Bit]) -> Bit) -> [Bit] {
  var values = input.map { $0.compactMap(Bit.init) }
  var columnIndex = 0
  while values.count > 1 {
    let filterBit = bitCriteria(values.column(at: columnIndex))
    values = values.filter { $0[columnIndex] == filterBit }
    columnIndex += 1
  }
  return values.first!
}

public func partTwo() {
  let oxygenRating = filterInput { $0.mostCommon() ?? .one }
  let scrubberRating = filterInput { $0.leastCommon() ?? .zero }
  print(Int(scrubberRating) * Int(oxygenRating)) // 5736383
}
