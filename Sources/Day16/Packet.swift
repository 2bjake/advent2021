protocol Packet {
  var version: Int { get }
  var versionSum: Int { get }
}

struct AnyPacket: Packet {
  let wrapped: Packet
  var version: Int { wrapped.version }
  var versionSum: Int { wrapped.versionSum }

  init(_ wrapped: Packet) {
    self.wrapped = wrapped
  }
}

struct Literal: Packet {
  var version: Int
  var value: Int
  var versionSum: Int { version }
}

struct Operator: Packet {
  var version: Int
  var type: Int
  var subPackets: [AnyPacket] = []
  var versionSum: Int {
    version + subPackets.map(\.versionSum).reduce(0, +)
  }
}
