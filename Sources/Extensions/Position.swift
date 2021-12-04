public struct Position: Hashable {
  public let row: Int
  public let col: Int

  public init(_ row: Int, _ col: Int) {
    self.row = row
    self.col = col
  }
}

public extension Array where Element: RandomAccessCollection & MutableCollection, Element.Index == Int {
  typealias BaseElement = Element.Element

  subscript(_ position: Position) -> BaseElement {
    get { self[position.col][position.row] }
    set { self[position.col][position.row] = newValue }
  }

  func element(at position: Position) -> BaseElement? {
    guard indices.contains(position.col) && self[0].indices.contains(position.row) else { return nil }
    return self[position]
  }
}

public extension Array where Element: RandomAccessCollection, Element.Index == Int {
  var allPositions: [Position] {
    var result = [Position]()
    for x in 0..<self[0].count {
      for y in 0..<self.count {
        result.append(Position(x, y))
      }
    }
    return result
  }

  func positionsInColumn(_ col: Int) -> [Position] {
    guard let first = first, first.indices.contains(col) else { return [] }
    return indices.map { Position($0, col) }
  }

  func positionsInRow(_ row: Int) -> [Position] {
    guard let first = first, indices.contains(row) else { return [] }
    return first.indices.map { Position(row, $0) }
  }
}
