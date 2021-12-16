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

extension OperatorPacket {
  static func sum(version: Int, subPackets: [Packet]) -> Packet {
    OperatorPacket(version: version, subPackets: subPackets) { $0.reduce(0, +) }
  }

  static func product(version: Int, subPackets: [Packet]) -> Packet {
    OperatorPacket(version: version, subPackets: subPackets) { $0.reduce(1, *) }
  }

  static func min(version: Int, subPackets: [Packet]) -> Packet {
    OperatorPacket(version: version, subPackets: subPackets) { $0.min()! }
  }

  static func max(version: Int, subPackets: [Packet]) -> Packet {
    OperatorPacket(version: version, subPackets: subPackets) { $0.max()! }
  }

  static func greaterThan(version: Int, subPackets: [Packet]) -> Packet {
    OperatorPacket(version: version, subPackets: subPackets) { $0[0] > $0[1] ? 1 : 0 }
  }

  static func lessThan(version: Int, subPackets: [Packet]) -> Packet {
    OperatorPacket(version: version, subPackets: subPackets) { $0[0] < $0[1] ? 1 : 0 }
  }

  static func equal(version: Int, subPackets: [Packet]) -> Packet {
    OperatorPacket(version: version, subPackets: subPackets) { $0[0] == $0[1] ? 1 : 0 }
  }
}
