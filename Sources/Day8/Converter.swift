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
    let find = Finder(signalsForSegmentCount: Dictionary(grouping: signals, by: \.count))

    var charForSegment: [Segment: Character] = [:]

    // top is the segment in 7 that is not in 1
    charForSegment[.top] = find.char(in: 7, butNotIn: 1)

    // lowerRight is the segment in 1 that is in all signals where segment count = 6
    charForSegment[.lowerRight] = find.char(in: 1, andInAllSignalsWithSegmentCount: 6)

    // upperRight is the segment in 1 that is not lowerRight
    charForSegment[.upperRight] = find.char(in: 1, butNot: charForSegment[.lowerRight]!)

    // middle is the segment in 4 but not in 1 that is in all signals where segment count = 5
    let possibleMiddles = find.chars(in: 4, butNotIn: 1)
    let middleSet = find.chars(in: possibleMiddles, andInAllSignalsWithSegmentCount: 5)
    charForSegment[.middle] = middleSet.first!

    // upperLeft is the segment in 4 but not in 1 (aka possibleMiddles) that is not middle
    charForSegment[.upperLeft] = find.char(in: possibleMiddles, butNotIn: middleSet)

    // zero signal is all segments of 8 + middle
    let zeroSignal = find.signalForDigit(8).union(middleSet)

    // remaining segments (bottom & lowerLeft) can be found by subtracting the segments in 4 and the top segment from zero
    let mask = Set(find.signalForDigit(4) + [charForSegment[.top]!])
    let possibleBottoms = find.chars(in: zeroSignal, butNotIn: mask)

    // bottom is the segment in possibleBottoms that is in all signals where segment count = 5
    let bottomSet = find.chars(in: possibleBottoms, andInAllSignalsWithSegmentCount: 5)
    charForSegment[.bottom] = bottomSet.first!

    // lowerLeft is segment in possibleSegments that is not bottom
    charForSegment[.lowerLeft] = find.char(in: possibleBottoms, butNotIn: bottomSet)

    return charForSegment.flipWithUniqueValues().mapValues(\.rawValue)
  }
}

// helper code to make algorithm code read more fluently
private struct Finder {
  private static let digitToKnownSignalCount = [1: 2, 4: 4, 7: 3, 8: 7]
  private let signalForDigit: [Int : Signal]
  private let signalsForSegmentCount: [Int: [Signal]]

  init(signalsForSegmentCount: [Int : [Signal]]) {
    self.signalsForSegmentCount = signalsForSegmentCount
    signalForDigit = Self.digitToKnownSignalCount.mapValues { signalsForSegmentCount[$0]!.first! }
  }

  func signalsForSegmentCount(_ count: Int) -> [Signal] {
    signalsForSegmentCount[count] ?? []
  }

  func signalForDigit(_ digit: Int) -> Signal {
    guard let signal = signalForDigit[digit] else { fatalError() }
    return signal
  }

  func chars(in aSet: Set<Character>, butNotIn bSet: Set<Character>) -> Set<Character> {
    aSet.subtracting(bSet)
  }

  func char(in aSet: Set<Character>, butNotIn bSet: Set<Character>) -> Character {
    chars(in: aSet, butNotIn: bSet).first!
  }

  func char(in aInt: Int, butNotIn bInt: Int) -> Character {
    chars(in: aInt, butNotIn: bInt).first!
  }

  func chars(in aInt: Int, butNotIn bInt: Int) -> Set<Character> {
    chars(in: signalForDigit(aInt), butNotIn: signalForDigit(bInt))
  }

  func char(in int: Int, butNot char: Character) -> Character {
    chars(in: signalForDigit(int), butNotIn: [char]).first!
  }

  func char(in int: Int, andInAllSignalsWithSegmentCount count: Int) -> Character {
    chars(in: signalForDigit(int), andInAllSignalsWithSegmentCount: count).first!
  }

  func chars(in set: Set<Character>, andInAllSignalsWithSegmentCount count: Int) -> Set<Character> {
    let signals = signalsForSegmentCount(count)
    return set.filter { char in
      signals.allSatisfy { $0.contains(char) }
    }
  }
}
