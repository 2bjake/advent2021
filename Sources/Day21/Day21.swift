import Algorithms

public func partOne() {
  var scores = [0, 0]
  var positions = [7, 4]
  var die = 0
  var rollCount = 0

  while scores[0] < 1000 && scores[0] < 1000 {
    let player = die % 2
    rollCount += 3
    die += 3
    if die > 100 { die -= 100 }
    let move = die * 3 - 3

    positions[player] += move
    while positions[player] > 10 { positions[player] -= 10 }

    scores[player] += positions[player]
  }
  print(scores.min()! * rollCount) // 675024
}

struct Game {
  var scores = [0, 0]
  var positions = [7, 4]
  var nextPlayer = 0
  var universeCount = 1

  var isDone: Bool { scores[0] >= 21 || scores[1] >= 21 }
  var winner: Int { scores[0] > scores[1] ? 0 : 1 }
}

let moveToCount = [3: 1, 7: 6, 8: 3, 4: 3, 6: 7, 9: 1, 5: 6]

func takeTurn(game: Game) -> [Game] {
  moveToCount.map { move, count in
    var game = game
    let player = game.nextPlayer
    game.nextPlayer = player == 0 ? 1 : 0

    game.positions[player] += move
    if game.positions[player] > 10 { game.positions[player] -= 10 }

    game.scores[player] += game.positions[player]

    game.universeCount *= count
    return game
  }
}

public func partTwo() {
  var games = [Game()]

  var winCounts = [0, 0]

  while let game = games.popLast() {
    guard !game.isDone else {
      winCounts[game.winner] += game.universeCount
      continue
    }

    games.append(contentsOf: takeTurn(game: game))
  }

  print(winCounts.max()!) // 570239341223618
}
