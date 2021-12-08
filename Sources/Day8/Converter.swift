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

  private let converter: [Character: Character]

  typealias Signal = Set<Character>

  init(_ signals: [Signal]) {
    self.converter = Self.buildConverter(signals)
  }

  func convert(_ pattern: Pattern) -> Pattern {
    Pattern(segments: Set(pattern.segments.map { converter[$0]! }))
  }

  static func buildConverter(_ signals: [Signal]) -> [Character: Character] {
    let segmentCountToSignals: [Int: [Signal]] = signals.reduce(into: [:]) { result, signal in
      result[signal.count, default: []].append(signal)
    }

    let digitToSegmentCount = [1: 2, 4: 4, 7: 3, 8: 7]
    let digitToSignal: [Int: Signal] = digitToSegmentCount.reduce(into: [:]) { result, entry in
      let (digit, count) = entry
      let signal = segmentCountToSignals[count]!.first!
      result[digit] = signal
    }

    var segmentToLetter: [Segment: Character] = [:]

    // top is the segment in 7 that is not in 1
    segmentToLetter[.top] = digitToSignal[7]!.subtracting(digitToSignal[1]!).first!

    // lowerRight is the segment in 1 that is in all signals where segment count = 6
    segmentToLetter[.lowerRight] = digitToSignal[1]!.first { letter in
      segmentCountToSignals[6]!.allSatisfy { $0.contains(letter) }
    }!

    // upperRight is the segment in 1 that is not lowerRight
    segmentToLetter[.upperRight] = digitToSignal[1]!.subtracting([segmentToLetter[.lowerRight]!]).first!

    // middle is the segment in 4 but not in 1 that is in all signals where segment count = 5
    let possibleMiddles = digitToSignal[4]!.subtracting(digitToSignal[1]!)
    let middleSet = possibleMiddles.filter { letter in
      segmentCountToSignals[5]!.allSatisfy { $0.contains(letter) }
    }
    segmentToLetter[.middle] = middleSet.first!

    // upperLeft is the segment in 4 but not in 1 that is not middle
    segmentToLetter[.upperLeft] = possibleMiddles.subtracting(middleSet).first!

    // zero signal is all segments of 8 + middle
    let zeroSignalSet = digitToSignal[8]!.union(middleSet)

    // remaining segments (bottom & lowerLeft) can be found by subtracting from zero, the segments in 4 and the top segment
    let possibleBottoms = zeroSignalSet.subtracting(digitToSignal[4]! + [segmentToLetter[.top]!])

    // bottom is the segment in possibleSegments that is in all signals where count = 5
    let bottomSet = possibleBottoms.filter { letter in
      segmentCountToSignals[5]!.allSatisfy { $0.contains(letter) }
    }
    segmentToLetter[.bottom] = bottomSet.first!

    // lowerLeft is segment in possibleSegments that is not bottom
    segmentToLetter[.lowerLeft] = possibleBottoms.subtracting(bottomSet).first!

    return segmentToLetter.flipWithUniqueValues().mapValues(\.rawValue)
  }
}
