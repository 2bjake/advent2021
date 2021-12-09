extension Collection {
  // requires collection to be sorted before calling
  private func firstIfUnique<Subject: Hashable>(on projection: (Element) throws -> Subject) rethrows -> Element? {
    guard let first = self.first else { return nil }
    if let second = self.dropFirst().first, try projection(first) == projection(second) { return nil }
    return first
  }
}

extension Collection where Element: Hashable {
  // requires collection to be sorted before calling
  private func firstIfUnique() -> Element? {
    firstIfUnique { $0 }
  }

  // O(n)
  public func occurrenceCounts() -> [(element: Element, count: Int)] {
    self
      .reduce(into: [:]) { result, value in result[value, default: 0] += 1 }
      .map { $0 }
  }

  public func leastCommon() -> Element? {
    occurrenceCounts()
      .min(count: 2, sortedBy: makeSorter(for: \.count))
      .firstIfUnique(on: \.count)?
      .element
  }

  public func mostCommon() -> Element? {
    return occurrenceCounts()
      .max(count: 2, sortedBy: makeSorter(for: \.count))
      .reversed()
      .firstIfUnique(on: \.count)?
      .element
  }
}

extension Collection {
  public var only: Element? {
    guard self.count == 1 else { return nil }
    return self.first
  }
}
