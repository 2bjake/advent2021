
public typealias Sorter<T> = (T, T) -> Bool
public typealias ThrowingSorter<T> = (T, T) throws -> Bool

public func makeSorter<Root, Subject: Comparable>(
  for keyPath: KeyPath<Root, Subject>,
  by areInIncreasingOrder: @escaping Sorter<Subject> = (<)) -> Sorter<Root> {
    return {
      return areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
    }
}

public func makeSorter<Root, Subject: Comparable>(
  for keyPath: KeyPath<Root, Subject>,
  by areInIncreasingOrder: @escaping ThrowingSorter<Subject> = (<)) -> ThrowingSorter<Root> {
    return {
      return try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
    }
}
