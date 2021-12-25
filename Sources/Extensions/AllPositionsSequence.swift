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
      nextPosition.col += 1
      if !columnIndices.contains(nextPosition.col) {
        nextPosition.col = 0
        nextPosition.row += 1
      }
      return currentPosition
    }
  }

  public var allPositions: AllPositionsSequence {
    .init(rowIndices: 0..<numberOfRows, columnIndices: 0..<numberOfColumns)
  }
}
