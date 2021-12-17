protocol Packet {
  var version: Int { get }
  var versionSum: Int { get }
  var value: Int { get }
}

struct LiteralPacket: Packet {
  var version: Int
  var value: Int
  var versionSum: Int { version }
}

struct OperatorPacket: Packet {
  var version: Int
  var subPackets: [Packet] = []
  var operation: ([Int]) -> Int
  var versionSum: Int { version + subPackets.map(\.versionSum).reduce(0, +) }
  var value: Int { operation(subPackets.map(\.value)) }
}

struct OperatorPacketBuilder {
  private var version: Int
  private var subPackets: [Packet]

  init(version: Int, subPackets: [Packet]) {
    self.version = version
    self.subPackets = subPackets
  }

  func withOperation(_ operation: @escaping ([Int]) -> Int) -> OperatorPacket {
    OperatorPacket(version: version, subPackets: subPackets, operation: operation)
  }

  var sum: Packet { withOperation{ $0.reduce(0, +) } }
  var product: Packet { withOperation { $0.reduce(1, *) } }
  var min: Packet { withOperation { $0.min()! } }
  var max: Packet { withOperation { $0.max()! } }
  var greaterThan: Packet { withOperation { $0[0] > $0[1] ? 1 : 0 } }
  var lessThan: Packet { withOperation { $0[0] < $0[1] ? 1 : 0 } }
  var equal: Packet { withOperation { $0[0] == $0[1] ? 1 : 0 } }
}
