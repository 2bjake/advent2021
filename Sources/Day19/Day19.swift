import Foundation
import Extensions
import Algorithms

struct Point: Hashable {
  var x: Int
  var y: Int
  var z: Int
}

func +(lhs: Point, rhs: (x: Int, y: Int, z: Int)) -> Point {
  Point(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
}

func -(lhs: Point, rhs: Point) -> (x: Int, y: Int, z: Int) {
  (lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
}

extension Point {
  init(_ x: Int, _ y: Int, _ z: Int) {
    self.init(x: x, y: y, z: z)
  }

  func rotated(_ i: Int) -> Point {
    switch i {
      case 0: return Point(x,y,z)
      case 1: return Point(x,z,-y)
      case 2: return Point(x,-y,-z)
      case 3: return Point(x,-z,y)
      case 4: return Point(-x,y,-z)
      case 5: return Point(-x,-z,-y)
      case 6: return Point(-x,-y,z)
      case 7: return Point(-x,z,y)
      case 8: return Point(-y,x,z)
      case 9: return Point(-y,z,-x)
      case 10: return Point(-y,-x,-z)
      case 11: return Point(-y,-z,x)
      case 12: return Point(y,-x,z)
      case 13: return Point(y,z,x)
      case 14: return Point(y,x,-z)
      case 15: return Point(y,-z,-x)
      case 16: return Point(z,x,y)
      case 17: return Point(z,y,-x)
      case 18: return Point(z,-x,-y)
      case 19: return Point(z,-y,x)
      case 20: return Point(-z,-y,-x)
      case 21: return Point(-z,-x,y)
      case 22: return Point(-z,y,x)
      case 23: return Point(-z,x,-y)
      default: fatalError()
    }
  }
}

extension Point: CustomStringConvertible {
  var description: String { "(\(x),\(y),\(z))"}
}

extension Point {
  init(_ line: Substring) {
    let parts = line.split(separator: ",")
    self.init(x: Int(parts[0])!, y: Int(parts[1])!, z: Int(parts[2])!)
  }
}

struct Scanner {
  var id: Int
  var beacons: Set<Point>

  init(id: Int, beacons: [Point]) {
    self.id = id
    self.beacons = Set(beacons)
  }

  func tranformed(by transform: Transform) -> Scanner {
    var result = self
    result.beacons = transform.apply(to: result.beacons)
    return result
  }
}

struct Transform {
  var rotationNum: Int
  var translation: (x: Int, y: Int, z: Int)

  init(rotationNum: Int, translating from: Point, to: Point) {
    self.rotationNum = rotationNum
    self.translation = to - from.rotated(rotationNum)
  }

  func apply(to points: Set<Point>) -> Set<Point> {
    Set(points.map { $0.rotated(rotationNum) + translation })
  }
}

func overlapTransform(_ a: Scanner, _ b: Scanner) -> Transform? {
  for num in 0..<24 {
    for (aBeacon, bBeacon) in product(a.beacons, b.beacons) {
      let transform = Transform(rotationNum: num, translating: bBeacon, to: aBeacon)
      let bNormalizedBeacons = transform.apply(to: b.beacons)
      let count = bNormalizedBeacons.intersection(a.beacons).count
      if count >= 12 {
        return transform
      }
    }
  }
  return nil
}

func identifyScanner(from unknownScanners: inout [Scanner], with knownScanners: inout [Scanner]) {
  for i in unknownScanners.indices {
    let unknownScanner = unknownScanners[i]
    for knownScanner in knownScanners {
      if let transform = overlapTransform(knownScanner, unknownScanner) {
        unknownScanners.remove(at: i)
        knownScanners.append(unknownScanner.tranformed(by: transform))
        return
      }
    }
  }
}

public func partOne() {
  var unknownScanners: [Scanner] = input.components(separatedBy: "\n\n").map {
    $0.split(separator: "\n").dropFirst().map(Point.init)
  }.enumerated().map(Scanner.init).reversed()


  var knownScanners = [unknownScanners.removeLast()]
  while !unknownScanners.isEmpty {
    identifyScanner(from: &unknownScanners, with: &knownScanners)
  }

  let beaconCount = knownScanners.reduce(into: Set<Point>()) { result, scanner in
    result.formUnion(scanner.beacons)
  }.count
  print(beaconCount)
}

public func partTwo() {

}
