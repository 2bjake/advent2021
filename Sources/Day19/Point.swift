struct Point: Hashable {
  var x: Int
  var y: Int
  var z: Int
}

func distance(from: Point, to: Point) -> Int {
  abs(from.x - to.x) + abs(from.y - to.y) + abs(from.z - to.z)
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

  init(_ source: (x: Int, y: Int, z: Int)) {
    self.x = source.x
    self.y = source.y
    self.z = source.z
  }
}
