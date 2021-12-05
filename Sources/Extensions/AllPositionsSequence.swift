extension Array where Element: RandomAccessCollection, Element.Indices == Range<Int> {
  public struct AllPositionsSequence: Sequence, IteratorProtocol {
    private let rowIndices: Range<Int>
    private let columnIndices: Range<Int>
    private var nextPosition = Position(0, 0)

    init(rowIndices: Range<Int>, columnIndices: Range<Int>) {
      self.rowIndices = rowIndices
      self.columnIndices = columnIndices
    }

    public mutating func next() -> Position? {
      guard rowIndices.contains(nextPosition.row) && columnIndices.contains(nextPosition.col) else { return nil }
      let currentPosition = nextPosition
      nextPosition.row += 1
      if !rowIndices.contains(nextPosition.row) {
        nextPosition.row = 0
        nextPosition.col += 1
      }
      return currentPosition
    }
  }

  public var allPositions: AllPositionsSequence {
    .init(rowIndices: first?.indices ?? .empty, columnIndices: indices)
  }
}
