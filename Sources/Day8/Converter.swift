import Extensions

struct Converter {
  private enum Segment: Character, CaseIterable {
    case top = "a"
    case upperLeft = "b"
    case upperRight = "c"
    case middle = "d"
    case lowerLeft = "e"
    case lowerRight = "f"
    case bottom = "g"
  }

  private let wrongToRight: [Character: Character]

  init(_ signals: [Signal]) {
    self.wrongToRight = Self.buildMapping(signals)
  }

  func convert(_ signal: Signal) -> Signal {
    Set(signal.map { wrongToRight[$0]! })
  }

  func callAsFunction(_ signal: Signal) -> Signal { convert(signal) }

  private static func buildMapping(_ signals: [Signal]) -> [Character: Character] {
    let find = Finder(signalsByWireCount: Dictionary(grouping: signals, by: \.count))

    var wireForSegment: [Segment: Character] = [:]

    let top = find.wire(in: 7, butNotIn: 1)
    wireForSegment[.top] = top

    let lowerRight = find.wire(in: 1, andInAllSignalsWithWireCount: 6)
    wireForSegment[.lowerRight] = lowerRight
    wireForSegment[.upperRight] = find.wire(in: 1, thatIsNot: lowerRight)

    let upperLeftAndMiddle = find.wires(in: 4, butNotIn: 1)
    let middle = find.wire(in: upperLeftAndMiddle, andInAllSignalsWithWireCount: 5)
    wireForSegment[.middle] = middle
    wireForSegment[.upperLeft] = find.wire(in: upperLeftAndMiddle, thatIsNot: middle)

    let mask = find.signalForDigit(4).inserting(top)
    let lowerLeftAndBottom = find.wires(in: 8, butNotIn: mask)
    let bottom = find.wire(in: lowerLeftAndBottom, andInAllSignalsWithWireCount: 5)
    wireForSegment[.bottom] = bottom
    wireForSegment[.lowerLeft] = find.wire(in: lowerLeftAndBottom, thatIsNot: bottom)

    return wireForSegment.flipWithUniqueValues().mapValues(\.rawValue)
  }
}

// helper code to make algorithm code read more fluently
private struct Finder {
  private static let digitToUniqueWireCount = [1: 2, 4: 4, 7: 3, 8: 7]
  private let signalForDigit: [Int : Signal]
  private let signalsByWireCount: [Int: [Signal]]

  init(signalsByWireCount: [Int : [Signal]]) {
    self.signalsByWireCount = signalsByWireCount
    signalForDigit = Self.digitToUniqueWireCount.mapValues { signalsByWireCount[$0]!.only! }
  }

  func signalsForWireCount(_ count: Int) -> [Signal] {
    signalsByWireCount[count] ?? []
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
