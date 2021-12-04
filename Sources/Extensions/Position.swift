public struct Position: Hashable {
  public var row: Int
  public var col: Int

  public init(_ row: Int, _ col: Int) {
    self.row = row
    self.col = col
  }
}

extension Array where Element: RandomAccessCollection, Element.Index == Int {
  public typealias BaseElement = Element.Element

  public subscript(_ position: Position) -> BaseElement {
    get { self[position.col][position.row] }
  }

  func element(at position: Position) -> BaseElement? {
    guard indices.contains(position.col) && self[0].indices.contains(position.row) else { return nil }
    return self[position]
  }
}

extension Array where Element: RandomAccessCollection & MutableCollection, Element.Index == Int {
  public subscript(_ position: Position) -> BaseElement {
    get { self[position.col][position.row] }
    set { self[position.col][position.row] = newValue }
  }
}

extension Array where Element: RandomAccessCollection, Element.Index == Int {
// Replaced with lazy version
//  public var allPositions: [Position] {
//    var result = [Position]()
//    for x in 0..<self[0].count {
//      for y in 0..<self.count {
//        result.append(Position(x, y))
//      }
//    }
//    return result
//  }

  public func positionsInColumn(_ col: Int) -> [Position] {
    guard let first = first, first.indices.contains(col) else { return [] }
    return indices.map { Position($0, col) }
  }

  public func positionsInRow(_ row: Int) -> [Position] {
    guard let first = first, indices.contains(row) else { return [] }
    return first.indices.map { Position(row, $0) }
  }
}
