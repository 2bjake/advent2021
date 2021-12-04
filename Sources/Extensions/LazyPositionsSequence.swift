public struct LazyPositionsSequence: LazySequenceProtocol {
  private let rowIndices: Range<Int>
  private let columnIndices: Range<Int>

  init(rowIndices: Range<Int>, columnIndices: Range<Int>) {
    self.rowIndices = rowIndices
    self.columnIndices = columnIndices
  }

  public struct Iterator: IteratorProtocol {
    private var rowIndices: Range<Int>
    private var columnIndices: Range<Int>
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

  public func makeIterator() -> Iterator {
    .init(rowIndices: rowIndices, columnIndices: columnIndices)
  }
}

extension Array where Element: RandomAccessCollection, Element.Indices == Range<Int> {
  public var allPositions: LazyPositionsSequence {
    .init(rowIndices: first?.indices ?? .empty, columnIndices: indices)
  }
}
