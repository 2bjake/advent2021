import Extensions
import SwiftPriorityQueue

struct PositionRiskQueue {
  struct Node: Comparable {
    let position: Position
    let risk: Int

    static func < (lhs: Self, rhs: Self) -> Bool {
      lhs.risk < rhs.risk
    }
  }

  private var queue: PriorityQueue<Node> = .init(ascending: true)
  private var positionToNode: [Position: Node] = [:]

  mutating func insertOrUpdate(position: Position, withRisk risk: Int) {
    if let existingNode = positionToNode[position] {
      queue.remove(existingNode)
    }

    let node = Node(position: position, risk: risk)
    positionToNode[position] = node
    queue.push(node)
  }

  mutating func popLowestRisk() -> Position? {
    queue.pop()?.position
  }

  func risk(at position: Position) -> Int? {
    positionToNode[position]?.risk
  }
}
