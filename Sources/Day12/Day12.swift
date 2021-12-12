import Extensions

let paths: [String: Set<String>] = input.reduce(into: [:]) { result, line in
  let parts = line.split(separator: "-").map(String.init)
  result[parts[0], default: []].insert(parts[1])
  result[parts[1], default: []].insert(parts[0])
}

func isSmall(_ name: String) -> Bool {
  name != "start" && name.lowercased() == name
}

func findPathsToEnd(startingFrom currentPath: [String] = [], havingVisited smallCavesVisited: Set<String> = [], canVisitTwice: Bool = false) -> Set<[String]> {
  let currentCave = currentPath.last ?? "start"
  guard currentCave != "end" else { return [currentPath + [currentCave]] }

  let nextCaves = paths[currentCave, default: []].filter {
    $0 != "start" && (canVisitTwice || !smallCavesVisited.contains($0))
  }

  return nextCaves.reduce(into: []) { result, cave in
    let completePaths = findPathsToEnd(
      startingFrom: currentPath + [cave],
      havingVisited: isSmall(cave) ? smallCavesVisited.inserting(cave) : smallCavesVisited,
      canVisitTwice: canVisitTwice && !smallCavesVisited.contains(cave))
    result.formUnion(completePaths)
  }
}

public func partOne() {
  let pathCount = findPathsToEnd().count
  print(pathCount) // 3292
}

public func partTwo() {
  let pathCount = findPathsToEnd(canVisitTwice: true).count
  print(pathCount) // 89592
}
