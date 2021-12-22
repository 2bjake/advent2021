import Foundation
import Extensions

struct Point {
  var x: Int
  var y: Int
  var z: Int
}

extension Point: CustomStringConvertible {
  var description: String { "(\(x),\(y),\(z))"}
}

private func buildDifferences(_ list: [Int]) -> [Int] {
  list.sorted().adjacentPairs().map { abs($0 - $1) }
}

struct Scanner {
  var id: Int
  var beacons: [Point]

  var differences: [[Int]] {
    [buildDifferences(beacons.map(\.x)), buildDifferences(beacons.map(\.y)), buildDifferences(beacons.map(\.z))]
      .flatMap { [$0, $0.reversed()]}
  }
}

extension Point {
  init(_ line: Substring) {
    let parts = line.split(separator: ",")
    self.init(x: Int(parts[0])!, y: Int(parts[1])!, z: Int(parts[2])!)
  }
}

public func partOne() {
  let scanners = sampleInput.components(separatedBy: "\n\n").map {
    $0.split(separator: "\n").dropFirst().map(Point.init)
  }.enumerated().map(Scanner.init)

  print(scanners)
}

public func partTwo() {

}
