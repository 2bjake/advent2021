public struct PositionSequence: Sequence, IteratorProtocol {
  private var first: Position
  private var last: Position
  private var nextPosition: Position?

  public enum Orientation { case horizontal, vertical, diagonal }
  public var orientation: Orientation {
    first.row == last.row ? .horizontal
    : first.col == last.col ? .vertical
    : .diagonal
  }

  public init(from first: Position, to last: Position) {
    self.first = first
    self.last = last
    self.nextPosition = first
  }

  public mutating func next() -> Position? {
    guard let current = nextPosition else { return nil }
    nextPosition?.row.advance(toward: last.row)
    nextPosition?.col.advance(toward: last.col)
    if nextPosition == current { nextPosition = nil }
    return current
  }
}
