
public typealias Sorter<T> = (T, T) -> Bool
public typealias ThrowingSorter<T> = (T, T) throws -> Bool

public func sorter<Root, Subject: Comparable>(
  for keyPath: KeyPath<Root, Subject>,
  by areInIncreasingOrder: @escaping Sorter<Subject> = (<)) -> Sorter<Root> {
    return { lhs, rhs in
      areInIncreasingOrder(lhs[keyPath: keyPath], rhs[keyPath: keyPath])
    }
}

public func sorter<Root, Subject: Comparable>(
  for keyPath: KeyPath<Root, Subject>,
  by areInIncreasingOrder: @escaping ThrowingSorter<Subject> = (<)) -> ThrowingSorter<Root> {
    return { lhs, rhs in
      try areInIncreasingOrder(lhs[keyPath: keyPath], rhs[keyPath: keyPath])
    }
}
