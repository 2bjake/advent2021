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

    // top is the wire in 7 that is not in 1
    wireForSegment[.top] = find.wire(in: 7, butNotIn: 1)

    // lowerRight is the wire in 1 that is in all signals where wire count == 6
    let lowerRight = find.wire(in: 1, andInAllSignalsWithWireCount: 6)
    wireForSegment[.lowerRight] = lowerRight

    // upperRight is the wire in 1 that is not the lowerRight
    wireForSegment[.upperRight] = find.wire(in: 1, butNot: lowerRight)

    // middle is the wire in 4 but not in 1 that is in all signals where wire count == 5
    let possibleMiddles = find.wires(in: 4, butNotIn: 1)
    let middle = find.wire(in: possibleMiddles, andInAllSignalsWithWireCount: 5)
    wireForSegment[.middle] = middle

    // upperLeft is the wire in 4 but not in 1 (aka possibleMiddles) that is not the middle
    wireForSegment[.upperLeft] = find.wire(in: possibleMiddles, butNot: middle)

    // remaining wires (bottom & lowerLeft) can be found by subtracting the wires in 4 and the top wire from 8
    let mask = Set(find.signalForDigit(4) + [wireForSegment[.top]!])
    let possibleBottoms = find.wires(in: 8, butNotIn: mask)

    // bottom is the wire in possibleBottoms that is in all signals where wire count = 5
    let bottomSet = find.wires(in: possibleBottoms, andInAllSignalsWithWireCount: 5)
    wireForSegment[.bottom] = bottomSet.only!

    // lowerLeft is the wire in possibleBottoms that is not the bottom
    wireForSegment[.lowerLeft] = find.wire(in: possibleBottoms, butNotIn: bottomSet)

    return wireForSegment.flipWithUniqueValues().mapValues(\.rawValue)
  }
}

// helper code to make algorithm code read more fluently
private struct Finder {
  private static let digitToKnownSignalCount = [1: 2, 4: 4, 7: 3, 8: 7]
  private let signalForDigit: [Int : Signal]
  private let signalsByWireCount: [Int: [Signal]]

  init(signalsByWireCount: [Int : [Signal]]) {
    self.signalsByWireCount = signalsByWireCount
    signalForDigit = Self.digitToKnownSignalCount.mapValues { signalsByWireCount[$0]!.only! }
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

  func wire(in aSet: Set<Character>, butNotIn bSet: Set<Character>) -> Character {
    wires(in: aSet, butNotIn: bSet).only!
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

  func wire(in set: Set<Character>, butNot char: Character) -> Character {
    wires(in: set, butNotIn: [char]).only!
  }

  func wire(in int: Int, butNot char: Character) -> Character {
    wire(in: signalForDigit(int), butNot: char)
  }

  func wire(in int: Int, andInAllSignalsWithWireCount count: Int) -> Character {
    wire(in: signalForDigit(int), andInAllSignalsWithWireCount: count)
  }

  func wire(in set: Set<Character>, andInAllSignalsWithWireCount count: Int) -> Character {
    wires(in: set, andInAllSignalsWithWireCount: count).only!
  }

  func wires(in set: Set<Character>, andInAllSignalsWithWireCount count: Int) -> Set<Character> {
    let signals = signalsForWireCount(count)
    return set.filter { char in
      signals.allSatisfy { $0.contains(char) }
    }
  }
}
