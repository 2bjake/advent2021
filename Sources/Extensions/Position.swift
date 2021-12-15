public struct Position: Hashable {
  public var row: Int
  public var col: Int

  public init(_ row: Int, _ col: Int) {
    self.row = row
    self.col = col
  }
}

public func +(position: Position, change: (row: Int, col: Int)) -> Position {
  Position(position.row + change.row, position.col + change.col)
}

extension Position {
  public func next(toward: Position) -> Position? {
    var next = self
    next.row.advance(toward: toward.row)
    next.col.advance(toward: toward.col)
    return next != self ? next : nil
  }
}

public enum Direction { case up, left, down, right }

extension Position {
  public func moved(_ direction: Direction) -> Position {
    switch direction {
      case .up: return Position(row, col - 1)
      case .down: return Position(row, col + 1)
      case .left: return Position(row - 1, col)
      case .right: return Position(row + 1, col)
    }
  }

  public mutating func move(_ direction: Direction) {
    self = self.moved(direction)
  }
}

extension Array where Element: RandomAccessCollection, Element.Index == Int {
  public typealias BaseElement = Element.Element

  public subscript(_ position: Position) -> BaseElement {
    get { self[position.col][position.row] }
  }

  public var firstPosition: Position { .init(0, 0) }
  public var lastPosition: Position { .init(self[0].count - 1, self.count - 1) }

  public func isValidPosition(_ position: Position) -> Bool {
    indices.contains(position.col) && self[0].indices.contains(position.row)
  }

  public func element(at position: Position) -> BaseElement? {
    guard isValidPosition(position) else { return nil }
    return self[position]
  }

  public func positions(_ directions: [Direction], of position: Position) -> [Position] {
    directions
      .map { position.moved($0) }
      .filter { isValidPosition($0) }
  }

  public func adjacentPositions(of position: Position, includingDiagonals: Bool = false) -> [Position] {
    var changes = [(0, -1), (0, 1), (-1, 0), (1, 0)]
    if includingDiagonals {
      changes.append(contentsOf: [(-1, -1), (-1, 1), (1, -1), (1, 1)])
    }

    return changes.compactMap {
      let newPosition = position + $0
      return isValidPosition(newPosition) ? newPosition : nil
    }
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
