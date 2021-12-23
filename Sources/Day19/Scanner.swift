import Algorithms

struct Scanner {
  var id: Int
  var beacons: Set<Point>
  var location: Point?

  init(id: Int, beacons: [Point]) {
    self.id = id
    self.beacons = Set(beacons)
  }

  func tranformed(by transform: Transform) -> Scanner {
    var result = self
    result.location = Point(transform.translation)
    result.beacons = transform.apply(to: result.beacons)
    return result
  }
}

extension Scanner {
  func findOverlapTransform(for other: Scanner) -> Transform? {
    for num in 0..<24 {
      for (selfBeacon, otherBeacon) in product(self.beacons, other.beacons) {
        let transform = Transform(rotationNum: num, translating: otherBeacon, to: selfBeacon)
        let normalizedBeacons = transform.apply(to: other.beacons)
        let count = normalizedBeacons.intersection(self.beacons).count
        if count >= 12 {
          return transform
        }
      }
    }
    return nil
  }
}
