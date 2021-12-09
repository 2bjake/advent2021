import Extensions

private enum Segment: Character {
  case top = "a"
  case upperLeft = "b"
  case upperRight = "c"
  case middle = "d"
  case lowerLeft = "e"
  case lowerRight = "f"
  case bottom = "g"
}

struct Converter {
  private static let uniqueWireCountForDigit = [1: 2, 4: 4, 7: 3, 8: 7]

  private let signalForDigit: [Int : Signal]
  private let signalsForWireCount: [Int: [Signal]]

  init(_ signals: [Signal]) {
    let signalsForWireCount = Dictionary(grouping: signals, by: \.count)
    self.signalsForWireCount = signalsForWireCount
    signalForDigit = Self.uniqueWireCountForDigit.mapValues { signalsForWireCount[$0]!.only! }
  }

  func build() -> (Signal) -> Signal {
    let mapping = buildMapping()
    return { signal in
      Set(signal.map { mapping[$0]! })
    }
  }

  private func buildMapping() -> [Character: Character] {
    var wireForSegment = [Segment: Character]()

    let top = wire(in: 7, butNotIn: 1)
    wireForSegment[.top] = top

    let lowerRight = wire(in: 1, andInAllSignalsWithWireCount: 6)
    wireForSegment[.lowerRight] = lowerRight
    wireForSegment[.upperRight] = wire(in: 1, thatIsNot: lowerRight)

    let upperLeftAndMiddle = wires(in: 4, butNotIn: 1)
    let middle = wire(in: upperLeftAndMiddle, andInAllSignalsWithWireCount: 5)
    wireForSegment[.middle] = middle
    wireForSegment[.upperLeft] = wire(in: upperLeftAndMiddle, thatIsNot: middle)

    let mask = signalForDigit(4).inserting(top)
    let lowerLeftAndBottom = wires(in: 8, butNotIn: mask)
    let bottom = wire(in: lowerLeftAndBottom, andInAllSignalsWithWireCount: 5)
    wireForSegment[.bottom] = bottom
    wireForSegment[.lowerLeft] = wire(in: lowerLeftAndBottom, thatIsNot: bottom)

    return wireForSegment.flipWithUniqueValues().mapValues(\.rawValue)
  }
}

// helper code to make algorithm code read more fluently
private extension Converter {
  func signalsForWireCount(_ count: Int) -> [Signal] {
    signalsForWireCount[count] ?? []
  }

  func signalForDigit(_ digit: Int) -> Signal {
    guard let signal = signalForDigit[digit] else { fatalError() }
    return signal
  }

  func wires(in aSet: Set<Character>, butNotIn bSet: Set<Character>) -> Set<Character> {
    aSet.subtracting(bSet)
  }

  func wire(in aInt: Int, butNotIn bInt: Int) -> Character {
    wires(in: aInt, butNotIn: bInt).only!
  }

  func wires(in aInt: Int, butNotIn bInt: Int) -> Set<Character> {
    wires(in: signalForDigit(aInt), butNotIn: signalForDigit(bInt))
  }

  func wires(in int: Int, butNotIn set: Set<Character>) -> Set<Character> {
    wires(in: signalForDigit(int), butNotIn: set)
  }

  func wire(in set: Set<Character>, thatIsNot char: Character) -> Character {
    wires(in: set, butNotIn: [char]).only!
  }

  func wire(in int: Int, thatIsNot char: Character) -> Character {
    wire(in: signalForDigit(int), thatIsNot: char)
  }

  func wire(in int: Int, andInAllSignalsWithWireCount count: Int) -> Character {
    wire(in: signalForDigit(int), andInAllSignalsWithWireCount: count)
  }

  func wire(in set: Set<Character>, andInAllSignalsWithWireCount count: Int) -> Character {
    let signals = signalsForWireCount(count)
    return set.filter { char in
      signals.allSatisfy { $0.contains(char) }
    }.only!
  }
}
