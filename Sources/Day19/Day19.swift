import Foundation

func identifyScanner(from unknownScanners: inout [Scanner], with knownScanners: inout [Scanner]) {
  for i in unknownScanners.indices {
    let unknownScanner = unknownScanners[i]
    for knownScanner in knownScanners {
      if let transform = knownScanner.findOverlapTransform(for: unknownScanner) {
        unknownScanners.remove(at: i)
        knownScanners.append(unknownScanner.tranformed(by: transform))
        return
      }
    }
  }
}

func countBeacons(in scanners: [Scanner]) -> Int {
  scanners.reduce(into: Set<Point>()) { result, scanner in
    result.formUnion(scanner.beacons)
  }.count
}

func maxDistance(in scanners: [Scanner]) -> Int {
  let locations = scanners.compactMap(\.location)

  return locations.map {
    var maxDistance = 0
    for location in locations {
      maxDistance = max(maxDistance, distance(from: $0, to: location))
    }
    return maxDistance
  }.max()!
}

public func partOneAndTwo() {
  var unknownScanners: [Scanner] = input.components(separatedBy: "\n\n").map {
    $0.split(separator: "\n").dropFirst().map(Point.init)
  }.enumerated().map(Scanner.init).reversed()

  var startingScanner = unknownScanners.removeLast()
  startingScanner.location = Point(0, 0, 0)
  var knownScanners = [startingScanner]

  while !unknownScanners.isEmpty {
    identifyScanner(from: &unknownScanners, with: &knownScanners)
    print("unknown scanners left: \(unknownScanners.count)")
  }

  print("total number of beacons: \(countBeacons(in: knownScanners))") // 451
  print("largest distance between beacons: \(maxDistance(in: knownScanners))") // 13184
}
