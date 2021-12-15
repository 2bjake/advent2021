//import Collections
//import Extensions
//
//enum DownAndRightOnly {
//  func downAndRight(of position: Position) -> [Position] {
//    riskGrid.positions([.down, .right], of: position)
//  }
//  
//  func upAndLeft(of position: Position) -> [Position] {
//    riskGrid.positions([.up, .left], of: position)
//  }
//  
//  public func partOne() {
//    let row: [Int?] = Array(repeating: nil, count: riskGrid[0].count)
//    var costGrid = Array(repeating: row, count: riskGrid.count)
//    
//    costGrid[costGrid.lastPosition] = 0
//    var visitQueue = Deque(upAndLeft(of: costGrid.lastPosition))
//    while let currentPos = visitQueue.popFirst() {
//      guard costGrid[currentPos] == nil else { continue }
//      let currentCost = downAndRight(of: currentPos).map { costGrid[$0]! + riskGrid[$0] }.min()!
//      costGrid[currentPos] = currentCost
//      visitQueue.append(contentsOf: upAndLeft(of: currentPos))
//    }
//    print(costGrid[costGrid.firstPosition]!) 
//  }
//
//  func bigDownAndRight(of position: Position) -> [Position] {
//    [position.moved(.down), position.moved(.right)].filter {
//      $0.row <= riskGrid[0].count * 5 - 1 && $0.col <= riskGrid.count * 5 - 1
//    }
//  }
//
//  func bigUpAndLeft(of position: Position) -> [Position] {
//    [position.moved(.up), position.moved(.left)].filter {
//      $0.row >= 0 && $0.col >= 0
//    }
//  }
//
//  public func partTwo() {
//    var costGrid = [Position: Int]()
//
//    let lastPos = Position(riskGrid[0].count * 5 - 1, riskGrid.count * 5 - 1)
//
//    costGrid[lastPos] = 0
//    var visitQueue = Deque(bigUpAndLeft(of: lastPos))
//    while let currentPos = visitQueue.popFirst() {
//      guard costGrid[currentPos] == nil else { continue }
//      let currentCost = bigDownAndRight(of: currentPos).map { costGrid[$0]! + value(at: $0) }.min()!
//      costGrid[currentPos] = currentCost
//      visitQueue.append(contentsOf: bigUpAndLeft(of: currentPos))
//    }
//    print(costGrid[riskGrid.firstPosition]!)
//  }
//}
