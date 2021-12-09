public struct Position: Hashable {
  public var row: Int
  public var col: Int

  public init(_ row: Int, _ col: Int) {
    self.row = row
    self.col = col
  }
}

extension Position {
  public func next(toward: Position) -> Position? {
    var next = self
    next.row.advance(toward: toward.row)
    next.col.advance(toward: toward.col)
    return next != self ? next : nil
  }
}

extension Array where Element: RandomAccessCollection, Element.Index == Int {
  public typealias BaseElement = Element.Element

  public subscript(_ position: Position) -> BaseElement {
    get { self[position.col][position.row] }
  }

  public func element(at position: Position) -> BaseElement? {
    guard indices.contains(position.col) && self[0].indices.contains(position.row) else { return nil }
    return self[position]
  }

  public func adjacentPositions(of position: Position, includingDiagonals: Bool = false) -> [Position] {
    var neighbors = [Position]()
    for x in -1...1 {
      for y in -1...1 {
        // TODO: this all could be better...
        var newPosition = position
        newPosition.row += x
        newPosition.col += y
        if !includingDiagonals && newPosition.row != position.row && newPosition.col != position.col { continue }
        if newPosition != position, element(at: newPosition) != nil {
          neighbors.append(newPosition)
        }
      }
    }
    return neighbors
  }

  public func adjacentElements(of position: Position, includingDiagonals: Bool = false) -> [BaseElement] {
    adjacentPositions(of: position, includingDiagonals: includingDiagonals).map { self[$0] }
  }
}

extension Array where Element: RandomAccessCollection & MutableCollection, Element.Index == Int {
  public subscript(_ position: Position) -> BaseElement {
    get { self[position.col][position.row] }
    set { self[position.col][position.row] = newValue }
  }
}

extension Array where Element: RandomAccessCollection, Element.Index == Int {
  public func positionsInColumn(_ col: Int) -> [Position] {
    guard let first = first, first.indices.contains(col) else { return [] }
    return indices.map { Position($0, col) }
  }

  public func positionsInRow(_ row: Int) -> [Position] {
    guard let first = first, indices.contains(row) else { return [] }
    return first.indices.map { Position(row, $0) }
  }
}
