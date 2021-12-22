protocol Shape {
  var count: UInt64 { get }
  func overlaps(_ shape: Shape) -> Bool
}
