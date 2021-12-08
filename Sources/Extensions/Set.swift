extension Set {
  public func subtracting(_ element: Element) -> Set {
    self.subtracting([element])
  }

  public func inserting(_ element: Element) -> Set {
    self.union([element])
  }
}
