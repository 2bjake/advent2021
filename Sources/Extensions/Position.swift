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

public func -(position: Position, change: (row: Int, col: Int)) -> Position {
  Position(position.row - change.row, position.col - change.col)
}

extension Position {
  public func next(toward: Position) -> Position? {
    var next = self
    next.row.advance(toward: toward.row)
    next.col.advance(toward: toward.col)
    return next != self ? next : nil
  }

  public func adjacentPositions(includingDiagonals: Bool = false) -> [Position] {
    var changes = [(0, -1), (0, 1), (-1, 0), (1, 0)]
    if includingDiagonals {
      changes.append(contentsOf: [(-1, -1), (-1, 1), (1, -1), (1, 1)])
    }

    return changes.map { self + $0 }
  }
}

public enum Direction { case up, left, down, right }

public extension Position {
  func moved(_ direction: Direction) -> Position {
    switch direction {
      case .up: return Position(row - 1, col)
      case .down: return Position(row + 1, col)
      case .left: return Position(row, col - 1)
      case .right: return Position(row, col + 1)
    }
  }

  mutating func move(_ direction: Direction) {
    self = self.moved(direction)
  }
}

extension Array where Element: RandomAccessCollection, Element.Index == Int {
  public typealias BaseElement = Element.Element

  public var numberOfRows: Int { self.count }
  public var numberOfColumns: Int { self[0].count }

  public subscript(_ position: Position) -> BaseElement {
    get { self[position.row][position.col] }
  }

  public var firstPosition: Position { .init(0, 0) }
  public var lastPosition: Position { .init(numberOfRows - 1, numberOfColumns - 1) }

  public func isValidPosition(_ position: Position) -> Bool {
    (0..<numberOfRows).contains(position.row) && (0..<numberOfColumns).contains(position.col)
  }

  public func element(at position: Position) -> BaseElement? {
    guard isValidPosition(position) else { return nil }
    return self[position]
  }

  public func adjacentPositions(of position: Position, includingDiagonals: Bool = false) -> [Position] {
    position.adjacentPositions(includingDiagonals: includingDiagonals).filter {
      isValidPosition($0)
    }
  }

  public func adjacentElements(of position: Position, includingDiagonals: Bool = false) -> [BaseElement] {
    adjacentPositions(of: position, includingDiagonals: includingDiagonals).map { self[$0] }
  }

  public func wrap(_ position: Position) -> Position {
    Position(position.row % self.numberOfRows, position.col % self.numberOfColumns)
  }
}

extension Array where Element: RandomAccessCollection & MutableCollection, Element.Index == Int {
  public subscript(_ position: Position) -> BaseElement {
    get { self[position.row][position.col] }
    set { self[position.row][position.col] = newValue }
  }
}

extension Array where Element: RandomAccessCollection, Element.Index == Int {
  public func positionsInColumn(_ col: Int) -> [Position] {
    guard (0..<numberOfColumns).contains(col) else { return [] }
    return (0..<numberOfRows).map { Position($0, col) }
  }

  public func positionsInRow(_ row: Int) -> [Position] {
    guard (0..<numberOfRows).contains(row) else { return [] }
    return (0..<numberOfColumns).map { Position(row, $0) }
  }
}
