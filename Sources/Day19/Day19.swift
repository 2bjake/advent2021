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
}

extension Scanner {
  func beacons(rotation: Int) -> Set<Point> {
    Set(beacons.map { $0.rotated(rotation) })
  }
}

struct Transform {
  var rotationNum: Int
  var translation: (x: Int, y: Int, z: Int)
}

func overlapTransform(_ a: Scanner, _ b: Scanner) -> Transform? {
  for rotation in 0..<24 {
    let bBeacons = b.beacons(rotation: rotation)
    for (bBeacon, aBeacon) in product(bBeacons, a.beacons) {
      let difference = aBeacon - bBeacon
      let bNormalizedBeacons = Set(bBeacons.map { $0 + difference })
      let count = bNormalizedBeacons.intersection(a.beacons).count
      if count >= 12 {
        return Transform(rotationNum: rotation, translation: difference)
      }
    }
  }
  return nil
}

public func partOne() {
  let scanners = sampleInput.components(separatedBy: "\n\n").map {
    $0.split(separator: "\n").dropFirst().map(Point.init)
  }.enumerated().map(Scanner.init)

  print(overlapTransform(scanners[0], scanners[1]))
}

public func partTwo() {

}
