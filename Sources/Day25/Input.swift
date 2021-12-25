var input = """
.vvvv>.vv...v.>...>.vv..>..>.....>.v>>v>>.>.>v.vv...v...vv>v.vv....>.v>.v>.>.>v....>v...v>.>vvv..vv>v>......v....v>.vv.>.vv>..vv.....>.....
v.vvv>..v.>.vv..v.v......vv...>....>.v>>v...v..>.v......v...v>.>vv.v.vvvv>...v..>>.vv.....>>..>.vv...v...>v>.>v>.v>.>.v>>>v.>....v.vv..>...
>.>.>vv>v.vv....v.....vvv...v..v>>v.>v.vv>.>>v.>>.vv..vvv>>>..v.>.v>...vvv.v.v.....vvv>..>.v>>.>>>.>>vv>>>.>v....v>vv.>v>v>>v.v>v..>.vvvv>.
vv>....>vv>>.v...v>..>..>..vv>..>.>vv...>...v.>.v>>.>......vv>v>..v..v>>v...>.>..>...>>v>>v.>>>v>vv...>...>..>...v.v...>.vvv....>.>.>.>>.v.
v....>>vvv.v..>v....v.>>v.v.>v>vvv..>>v>v.>.>>..>.v..v>.v>>v>v...vv...v..>.v>.>v...vv.v>.vv..>>...v.v>>vv.vv.v>>>..v>....v...>>>.......>>v>
..vv.....>....>>v>....>.vv....vv.>>.>v.....v>vv..v.>v.>.v..v>>>vv.>..v.vv.>>>...vv.v..>.vv..vv...>.>..v.v.v>v>>v.vvv>......v.>>>.>>...>.>v.
v..>.v.v.>v>.v.>..v>v....vv...v....>v.>.vv..>v.>.>v.>.>>.>v.>..v>..>.v.v.v..vv>v>.v>v>.....vv..>.>....>....v..vv.v.>......v..v.>.v>>.v.>vv.
.v.v..>vvv.v..v>..>.v.v.vv>.>....v>>>>v..v..v..v>.>.vv>...>...>v>>.v>>.v.v........>v...vv.vv.v>>.vvv..>..v...>v.v.v>v.v.v.>.v..v>..v.v.v...
v.>v.v.>v>...>.>..>vv..>vv.vvvv...>>vv...>....>vv.>>>.>.>>v..>>v>vvvv.v.v.vv.>>v>...>v>.>>....>>v.v..>>>v>.>.>.vv..>....>.>>vvv.v..v.vvv.>.
v.>v>v..>v...>vv.v.v.v>.v....v>..>.>>>..>>.>....v..>..v.v...vv>.>....>>..v>>.>..>.v>>v....>v....vv.>vv>v>>vv>....v>>>.v>.>v.>vv.>.v...>.v..
..>...>.>...v.v....>>v>.v.v.>v.>.vv.>v.v..vv.v....>vv>.>vv...v.v...v.vvv..vv.>..>v.>..v...v.vv>>v>v>.v>.v...v.v...v.v.v.v..>>v...>vvv..>>>.
>.v>>>.v.>>v.>v>>...>.v.....>.>...v>>v>vv...v.v....>>vv..>>..vvv...v>>.>.vv..v......v.>>v.>>..>.v.>>>>.v...>>.>vv.>.v..v.v>v>..v.vv.v.>v...
..v>vv>..>>v....v....>>>..>>>vv...>.>.>v>v>.>.....>........>..>.>....v...>>.v>vv.v..v......v.v....>.v...v....>vv.vv....v.....>...>>>v......
>....vv>>.>.>..v.vvv...v>>.v>....vv...v..vv>..v........>....>..vv.>>>.>....v...v..>vvv.>vv.....v.vvv.>>v....vv.>v.v.>..v...v.vv>.v.>vvv....
.>.>....v>.....>..>>>.>.vv>vv..>.>v.vv....vv.>.>v.v..v>..>>v>>>v.>>v>vv.>>>v>v>>v..v...>..v>.>vv.>.>.v.>v>vv.>...v.v.>>v......v.>..>.>v>..>
>v...v..>..v>v.>.>..v.v>...v>vv.v>v..>.>>......>......vv>.>.v>.v..v.v>.>v>vv>..>.v.>.>..v.v.vvv.v..>.v>>>v.v>....v.v>.v.v...v.vv.>...v..>.v
.>v.v...>>.>.>vvv..v>.v.....v.>.....v..v.>v....>.v>....v>>vv..>v>....v>.>.....v.....>>...v>..>>....v..v.>.v.>.v..v.>v.>......vv.v..v>...>..
..>v>v..vv..v..>v>v..v.v...v..v.>>.v.v.>v..vv>...v..v.v.vv>.>>vv.>v.>v>.v...vv.........v.vv.v...v>v>...>vvv.>.>>v..>v>vv.>vvvv>.>v.>v..>>.v
>v>...>v.>>>>....>vv>.v>.vv>>.>v.v..>.vv.vv..v.>.....v>v.>.vv..vvv>...vvvv>v..v.vv.v>.vvv.v>v>...v>.v.v>...vv...v.vvv..vv...>..>..>...>....
>.v.v>..>..v..>.>>vv>>..vvv>.>.>.v.vvv.......>>vvv.vvv.>v>.>.>..v>..>>.....>v.v>>v>.v>.>..>.vv...>>.v.>vv>>v>.>.v>v>vv>.....v....v..>vv...>
.v..>.v>....>v.>>..v.>.vv......v.>>...v.>..v>>.>.>....>>..>.vv>>.v...v.....v..v.>v.v>v.>>.>.v.v...>v....>v>.>>v.>v>.>.>.v...vv.>v...>......
v..v.v..>v.>..>.>>...>v>v..>v>..>..v...v>.v.v.>..>.v.>v>.>>>...v.vv.....>>..v.>..v..vv....>.>...>...>>v..>...v.......v>..v.......>v..v>v...
.v...>v>.>.v>..v...v..>..v>>.>.v>..v..>....>>.v.>.>..v>>>vv>>v>..v..v...>>.>v>vv.>..>v..>>.v.>v..vv>>.v....v>......>v>..vvvv>vvv>vv.v>.v>>>
..vv..>..>v...vv.>.v>.v>.>>vv>>.v..v.v.>v.v>..v....>>.vv.>.v>.v>>.v>v...>.>..vv..v>..>....>>..v>v.>......>vv>...>vv>>....>>>>..vv>v.vv....v
...v>..>.v.v...>.>.>.v......v..>v..v.v.....>>vvv>v>.>.vv..>vv.>>v.vv..v....>..>>..>.....v....v.>......>.v>.v.....vv>...vv.>....v.>.v>v>v>.>
.>.>.>...>v.....vv....>v.v>..>.v.>.>>.v>....>...v.....>vv.>vv..v>...>.v.v..>>>.>.vv..vv...>.>v>v.>...>.v.vv.v....v........v..>>v>..v.>.>.>>
v.v>>...>v.>..v>.>.v..v....vv.>...v>...>>...v.>.......v>.>>.>.v>....v.>>..vv.v>..>v...>vv...vvv.v.v.>v.>>..v>vv..>v.>....v.>>>>v......>v.vv
.v>>..v>.>.v>>v..>vvv.>.>v.v...>>v.>>>...>vv...>.v>>>.v>.>.v..>v.>.>v..v..>..v.....v>...>>>.>.vvv>>>v>.>>v..v>>>..>....>.vv>..>>v>..>>.v...
>>>v.vvv.vv.>>>....vv...>>...vv>v>.>>>v.>.>.>...>v>...>.v>......>.>..v.>>v.>v..>v..>v......>.....>.v..v...v..v....>.>...>>.>>v.v>..>.>v..v>
.v.v....v>.>.>.v>>v......>>v.>.vv>.vvvv.vvvv.v..v..v.>.v.v.>...>...vv>v....vv......v.v>v.>>>>>v>.>>>vv>.v>>..v>.vv>v.>..v>>v.v>>.>..>>.>v..
.vv.>v>>...>.>>v.v..>v...v.v.>..........v...v....v..vv..>v.v...v>>.>.v>vv>.vv>.v.v>.v.>v>.>>>..>..>...>....v.v.>v.vv.vv.....>.vv>>>.>>..>>.
.v..>..>..>>vv.v.....>>.>..v.....v..v..>..v>..v...>.....>>>>..v..vv.v...>>>.v.>..>v.>>>..>...>>>>.v.>.>>>v>v.v.>.v.v>.>>v>....v.>>>..v>...>
>.>.>...>v..>v.v...v>..>>>....>>.v>v>v..>.>>.>v.v.>vv.v..v.v.>v>v......>v>.v>.v.....v>..v...v>v.v>vvv.>.v>....>v.>.>>>.v..>vv>....v..>..>vv
>.v>>>.vv..v..>.vv>v..>>..>...>.v>.v..>vv>....>vv.>.>vvv.vv.v>.v>>.....>>...>.v>.>.v.v.v.v.....v>>..v..>...vv.>.>.vv..v.>>v.....v>vvv>>.v..
>>.>v>>..>..v>..>v...>>v..>vv..>..>..>..>>>>>vv.>..v.v.>>v..>...>>..v>>....v...>..v.v.>..v>.v>vv>.v.v.v...>>....v..>>v>.vv..>.>>>.....vv.v.
...>>....>v...>v.>v>.>>vv..>>>>.v.v.>....v...>>v>.>...v>.v..........v....v.vvv..v>vv...vv.vv>>..>>....>vv.>.>..vv.v>.>v.>>>>v...v.vv.>..>.v
.v.>..>.v.>..vv..>v..>>.v>>>>>vv>.v>.>.>.v.vv.v>.v.v.vvvv>......v....v.vvv...>.>.>.>>.>v>..v>vv.>...vv>>>v>vv.v..........>>v...v>.>>>.>.v>.
.v..vvv.>..>.vvv.>>vv.vv.....>.vv..vvv..vv.v>vv...v.v.>.v>vv.....>vv..>...>.vv.v>v.>.vv.vvv>v..v.v>>>.v.v>>.>>.v.>....>..>v>v.v.v.>>.v>v...
v>.>.v.>..>.>.>>..>v>.v..>...>..v>>.vv...vv.>v.>..>..>.......>..v>>v.>v>v..>v.>v.vv>.>v.vvv>v.v...>.v.v....>>.vv>v>>v.v>>v>>..>>...>v.....>
>>>>>.>....>.v>vv..>.>.vv..vv.v.v...>.>>.v..v..>vv>..v..>v.>>.>>..>.vvv.vv>...v.....v..v>.>>v>v....>........v>>vv.>...v.>v.......vv.>>.....
.vvv.v......>>...>.>..v.>..vv..v>...vv>v>>>.>...>.v..v.v......>...>v......v.vv>...>...>..>.v...v..v>.v.vv>....v......>..v.>.vv....v.v.>>..v
...>v...>>..v.v.>........>>vv>>.>v>>>>v..>.v...v..>v....>>.v.vv>v>v...>>.>vvv>v..>...v>vv..>v..>.>.v.v...>.vv.....>v>.v>v>v>..v.>.>..v.>v..
vvv.>.>v.vv..>>.>v>>..>.v>>.v.>.>>>.>>.v.v.v.>>v.>.>...vv...>....v.>...>.v..>v....v>v..v.>>........v>v.....>..v>v....v.>.>..v.v>v..>...v>.>
.v.>v..v...>>...>....vv.>>.v...v>v>.>v>>>.vv...v.......>>...vv>.>.v.....>>.v.>...>vv>>>>...vvv.>.....v...>>vv...vv>..v.>v>>....v...v>>>.v.v
.>..v>vv>.>v.v.>.v>..>v...v>.>v>>v..vv.>.>vvvvvv.v...>...v>..>.>>>.>v..v..>>.vvv.>...v.>...>>..>........>>.v.vv..vv.>>v..vv>......>v>v.....
...v>>..>..v..v.v>>.v.vv>..v..v...vv..>..>v..>v..v>..v>>...v>.v.>>..>.>>v>...vv..>>.>.vv.vv.>>..v>.v.>.v...v>vv>.....v>.v>....>>v...v.....>
...>>.>.....v..v...>.>>....>>v>.v..>.>v>v...>.>....v.>.>v.v..>v>>vvv..vvv.>>.>.v>v>...v>.v...v.v.>>...v.v>vv>>>>.v>.>>...v.>.>>......>.....
.v..vv.vv..>....vv...vvvv.v..v..v.vv>.vv>v>vvv.>>v>.>v>....v.>.>>v.....v.>......>...v.>>.>.>..>.>..v.v.v...>v.>.v..>.v.>.vvv.>v>.>..>vvv>v.
vvv...vv>v>>vvv..v>..>>>>.>>..v>..>.v.>....>vv.>vv.>>.vv.v.>>..>..vvv>...>..vv>>>..>v...>>v...>>.v.>>..vv>>.vv..v...>>>....>v.>.>>>v.>v.>>v
>>..v..vv>v.>>v.>...>.vvvv..v....v.v.v...>>.>..>v.v>.>>v.....v.v.......>vvvv>.>v>v.v....v.v>.v.v.v>>>v...v...v..>vvv..>.v>>.v.v.>..>>>.>.>.
..>>.>>vv.>v>>.>.v..vv>.v.>..v.v>>>>.v.vv..vvv...v.vv>v...>>..v.vv.>>v.v...>.vvv>..>v..>.v....>>v..>>..>.v.>....v>.v...v..v...>.v>>>v>..v.v
>>.>vv..vvv..v>.>vv...vv.>>>.v>v..>.vv..vvv>.v.v..v.>...v>v.v..v.vvv.>v>....>..>..>.>.v.v..vv..>>>>.vv>>.v>v>v>>.vv>...v.v>>v..>.>>..>..>v>
>>v..v.vv.......v.>>.>.vvv.v...>v.>v>.>>>..>.>v>.vv>>v..>v..>..>v...v..v..>>>>.>>vv>.>.>..>.>.>..v....v.v.v.>.....>v>...>.v>.>>..>vvv>..v.>
v.....>vvv..vv.....>v..vv...>.>.>v..v..v>>>v.>.v>.vvvvvv>vvv...>>>....v...>v>v..>..>....v>.>..>v>vvv.>>.v.v>v>.>.vvvvv.>>vvv.>>...>v>.>>..v
...>.>.>...v...vv..v>.v>.>>.>v>....v.v..>>v..v.>.v..>v>v>>..>vv>>...vv>.v.>>v>v...v....>>.>.v.>>vv......>v......>>.vv..>.v>>..>..>.>>.v.>>.
.>.>>>v.v..>.>..>v.>..>v>>>..vv.vv.>v.>.>.v..v>>v.vv.v..>>...>v>.v>v.v>v.>v.v..v.>.>.>v..>.>v.v>.>v>v>.v.....>....v.>.>v..>.>v.vv.>....>>.v
.>v.>v.>>.>..>>>.>.>.....>.v>...>vvvv.v.>>v>vv..>v.>v>v..v>>.v>v>.>....v..v.vvv.>...vv.vvvv>v..vvv>v.>>>>..v..v.vv>..v.v.v>...>v.....v.>>.>
>>v.v.>>>>.>>...v..>v.v..v..>>...>........>.>.>.v..v>...v....vv.>..vvv>>.vv.....>vvv>..>....vv.v.v>.v>v..v>.>v..v.>..v.vv>>>>....v.v..>..>.
>.vvv>vv...>v>v>.v>>>...vv...v...>.....>>...vv.>..v......vv.....v.>...v.>.vvv..>..>>..v...vv...v.>.v>v>v.>..>>.>.>v....>..v.v....>>.v>...v>
.v..v>.>.>>>..v.>v>..v.v.....>.v..>v>.>vv.>.v>>vv..vv>....v.vv.>..v>v..>..vvv...v...v>>.v..v..>.>>vvv..>vvv..>vv>v>>...v.vv.....>.>...v>..>
.vvv..vv>..>....vv.>...v>....>..>....>..v>.....v..>.>.vv>.vv.v.>>v>>v..v.v.>.......>>....>v..v>>...>....v>vv..>.v..>....>vvvvvv..v>.vvv.v.v
v>>v>...>v..>v..v>..vv>v..v>>.vv.>>>v.v....vv>vv>>>>v.v.v....>>.vv.vv>....>.....v...>.v>>...>.>v>.>v>.>.>>..>....>.v>.....v...vv.vv.v>v.>.v
..>.v>...v.>v..v.>.>.....vv.v..>>..>.>.v.>.>v......>...>.>.>.vv.vv.vv>vv.v>...>>..>>.>..>>....v.>.v>v.v>.v>>..vv>>...v>>v..v>vv>.>.>>...v>.
...vvvv..v.>...vv..v.>.vv>.vv>>.v.>.>.>.v>.vv>>.v>>.>>v..v.v.>vv.v..v.vvvv>..v>..>>>.v.v>..>v...vv.v>v>v..v.v.>v.vv....v.>....vvv..>vvvv>>>
.v>>.v..>>..vv..>v...v..v>.>.v.>>v>...>>.v.v.v.v..>.vv>>.>>....v.v.>v..v.>..>>..v.>...vv.v....>>>v>>v.....>>>>vv....vv..v>v>vv>..>.vv..vv..
>>>>.v>..>.v..vv..v.v..>...>..>.>v.>>>.>..>.>.v>.......>..>.>..v>..v.v..>>...vvv..v...>...vv.>v>.>v.>...vv.>..>..>v>.>>.>vv.v..v.v.vv>>v...
v..>>v.>.>.>>.vv.vv.v.>..>.vv.v...vv.v.>>v..v.v....>v..v..>>...>...v....v>..v..vvv>vv..v..v.v...>.....vv>>v.....>>v..>.>.vv>.>>.>.v..>..vv.
.v....>..v.v.v>..vv.>...v.v>......v.>..>.v....>..vv.vvvvv>>>.v..vv.v>>..vv.v>.>..v..vv.>......>v.v.....v.>.v..vv...>..>v>vvvv>>.v...v.v....
...v.v.>.>....vvv..>vv.>...>>>.v>v.v>>>..>.v>...vvv.>>>>.>>..........v.>......v>...vv...>v....>..>>.v>.>>.v>....>..>..vvv.>.vv..v.>....>..>
.>.v>.>.v.>....>.>>>>.>..vvvv>>.v..>.>.>.v.>>>.>..v.>v...v....>>v.>..>>v..>>v>.>>.>>.>.....vv>.>>>v..>>>v.>..vv..v.>.vv>v>.vvv...vv.>.v.v..
..v>.v..>..>vv...v.v...v...>.......vvvvv>..v.....v...>vv.v...>v.>>v>v>.v>>>.v>.>v>v.>.....v>>vv.>>.>v..>.vv...>.>>..>.v.....v.v.v.vv.v>..>v
vv>.vvv>.>.v.....v..vv>vv...>v...v.v..>.>v.>.>vv.v>..v>vv.....>.v.>.v....v.......v>>..v>vv.v.v>>.....v>v...>>>..vv>v.v.v.v>.v.>.v..v>...v>.
..>v..>..>vv>>.vv.>..>.v...>vv....v>.>........>...>vv.v>>..>vvv.>.v>vv.vv..>.>>>.>v..v>.v.>>...>.>.v>>v....vv>>>....>v.v>v.v....v..v>v>>>>.
.>..v...v..v>.v.vv..>>......vv>>v....v....>>.vv>v..>.v.v....>>vv.v>v>v>v.>.>v..v..v>vvvv..vv>vvv.>.>..>v>>>..v..>.v>>>....>.>.v.>v>>...vv>v
v>..>.v..v.........v.>.>>...>>.vv>vv>....>..>.>>v>...>>>vvv>v...v.>vv....v.>v.v..v.v.vvvv.>>>.>vvv.>..vv..v....>..vvv>vv>v.>v>...v.>v.vvv>v
v..vv>>v...v>.>>...vv.>.>v.v..>...v>>>.>vv.v..v..v....v.v.>>.>>.....v>v..........>>.>vv......>.v.v>v...>>>>>v.>vvv>>.>v.v>v..>.vv>.v>>v.v..
.>>>>..v.....>.>..>..>.>..v>...>..>.>.vvv.v>>>>>.vv.......>.v>>>v>.....>>>...>v..>.>>..v..>.v...v>...v..vvv.....>..>.>.v.v..v.>....vv.v...v
.vv>v.v.>.>..>.>.vv>>>vv...vvv.>.>v.>.v...>>>.vv>>>vv>>vv>v>>..vv>..>.....>.>>v...>.>>>v..>...>v..>>v>.v>.>.>.>.v>.v.>..v.vv.vvv.>v.>...v.>
...>..v....>v.v>.>vv>.>...>.vvv>...v>.vv.>v..v>.>>>..>.v....>>vv....v...>...>>>>.>.....v>v....>..>v.>v>.v..vv.....>>..v.>.>..>.>.v>>>v.>vv.
v>v>....>..>>.>........>....v...>....>.vv>.vv.v..v.....>...v.vvv>vvvv.v.>.>.vv..v.>>.>v>.>v.v.v>>.vvvvv>v>v.v.vvvvv>vv.>..v>v.>..vv>.v..vv.
.>..>>>..v..>>..vv..v.v..>>.v.v>.>.v>vv..>...v.v..v>v..>.v..v...v.v.v.>..>>>>.>vv.vvvvv...vvv....>..v..>...v.>..>.vv>v>>>.v..v>.vvv..>...vv
.v.....>.v.>.>.v>v..v..v.>..>v>.v.>v..>vvv.vv..>v.vvvv>v..v....v>>>vv>v.v>vv..>....>v.......>vvv.>..>vv.>.>>....>.>.........>v>vv>v>>>>..v.
>vvv>.vv.v.v.>.v.v..>v.>>..v>.v>v.v.>..>....>..v..v.v>vv..vv>>.v..>....v....v.>>>vv.....v.v.>>v.vv...>..>>>.>>.vv>.>v....>.>.vv...v>v.>v>vv
>.vvv...>.>....vv.vv..>>vv...v..v>>..>..vv....vv..>v..vvv>vvv.>.>.v.>>>v>..>vv.vv.v.....>v>>v...v.v.v...vv..v>>>v>>v..v>..>>>.>.vv.vv>>..vv
.>.....v....vvv...>v.>.....v.>.>....v>.>v.v>>>>..>.v.>v..v>vv>..>.vv>>>v>>vv>...>......>v..>.>....>.v.>>.v>....>........>>.....>>>vv.v.v>v.
...v>.>>..vv.v........>>>.>.v>v..v...v.v>>...vv...vvv...>vv.>>v.v.>>....>>>..>...v>.>..v.vv.v.v>..v>...v>.vv.>v>.v>..>.>.>>....vv>>>.>v>...
>v>..v...>v....>.>>>v.v....v.>>.>>..v>.v.>v>.>.v>v.v>.>.....>..vv..v>v.>v.>.v..>>...>.>v.v.>>>.>vv>>.>>.v....v.>>.>.v.vvvv.>>v..>.vv.v>.v>v
.v.>.vv.>..v.....v>>v.>>>..v.>.>v>...v.>..>>.>v>.v..>v>v....>v.>..v....>v.>.v>...>>>..>>vv>..v>.v..v>v.vv.>.>v..>....v...v.>...v.v...v>v.>>
v.>vv....>..>v.>vvv..vv.>vv>.>>..v>>>>>v......>>>..v..>v>........v>..>.vvv>>>.vv....v.v....v>.....>..>>vv.>.vv...>.v>......v>>v...v>...v.>.
v>.>.>..>>.....>..>>...>v.v.>>...>.>v>v>vvv.v.v...>.v>vv...>>...>..vvv.v.>.>.>v>.v>>>>.vv...vv>v.vv.>.>>v>.v>v.......v..>>.v>.v>...>.....>v
v.....v....v.v.v>v.v>..>>.v..>....vvvv>.v..v>>vvv.>.v>v>>..>.v..>vv>v.>>..v..v>>..v.>v.v...v..v.>..v>..>v..v>v>...>.>v......v.>.v>..vv.v.>>
>>vv...>v>>>>v..v.v..>.....>..>>>..v>vv.v.vv.v.>...vv>>>v>v...v>.>v..>..v>.v>.vv.v>v.>....>..v.>>..>>>....v>>vv>.>.vv.>>>>>..>.>.vvv..v.>>.
v..v>..>....vv.>..>>.>>.vv...v.....>.vv>.v.>>.>v.....>.v.v....vv.>vv.v>v..>..>...>>.v.>......>.v.>>>.>>v..v.v...v.v.>>....>v..vv>.>.>.v..vv
.v>v>v....>v>v>vv>.......v.v>>v..v.....v...>v..>..v>..v>.......>v>.v....v.v.>>.v...>..vv.>v.v......v...v...>...v.v.....v>..>.>.vv>>v......v
>>..v.....vv>.>>>>....>..v...>v...>.vv>vv......>>.>.>>>vv.v.v>>...v>.>.>>>v>...>..v>vv.v.>>v>....>.v...vvv>v....v>>.>v....vv..v>v.vvv.>.v>v
>..vv>>v>.>v>..v>....>vv>.....>>........>.....v>.v..>..v...v...>v.>....>vv.v>...vvv>vv.>.>v>..v>.>..>>vv.>...>v...>>vv.>>.vv>..>>...v>.>.v.
.v.>.......v>.....>vv..>..vv...>>..vv>v.>..v>.>...v..v.v.>..vv.v....>>...v.v>.>vv..>>>.>v>>>.>>v.v.....>..>v>v.>.v.>>...v>.>>>.>...v...>...
..>v...>...v.v.>.>>>>.v...>..>v..>.v.v>..v>v>>>.v>.v.vv...>v.>v>vv..v...vv>>.>.>...vv.>v>v>.v..v>.v>v.vvv..>.v...v.....>.>>vv>>>..>....vv.>
>..v.v>>v......>>>.>.v>.>vv..v>vv...........>>...>...>v..v.v>..>.>.v.>v.v..v>....>v.>...v..v.vv>..>>>....vv>.>>...v...>>.>>.v>>.v.>.v>.....
.....v....v>>v>..vvv.>v.>..v..>.vv>v>.v.....v.....>>v...>>>.vv.v.>..v>.v.>vv.>v.>.v.v.v.v..>.>>.v.>.v>...>v.vvv.>.>..>.v.>vv..v..>..v.>>..>
..vvv>>>.>>..v..>.v>..>>v.>v>.v>vv..>v.v....>.vv...>>.v.>..vvvv...v>.......v>v>..>.>vvv>>>>.>>......v....v......>vv>.vv>.>....>v..>v.>v....
.>.v.>>v>.>....>>.v.>v..>v....>v.v.v..>.....v>.v..>...>.vv.>.v.vv>v..v..>.v>...>.>..>vvv...>....v...>vvv.>v...v>v>.>...>>..>..v..>.vv.v>v>>
.v>..vvv.....v...>v>v>..v>.>.....v.>.>v.v>.>.>..>..v....>.>>.>vv.>v.>.vv>v>>v.v>v.v.>v.v......>>.>>vv...v>v>..v.v.....>..>...>.....v.vv.>>>
>>>..>.vvv>..vv..>>v...>>.v...vv.....>.v...v.v..v.v>>vvvv>vv>..v>....>...v....>.>v.v>>>.>.>>v.v.vv.vv...>v>.v..vvvvvv...>>.>>.vv..vv....vv>
>.>...>>...>v.>..>>>>...v..>.....v..>>>.v.>..v>v>..v>v>..v..>>..v>>....>...v>vvv>.v>.....vv>..>.>>..>.>..>...v...v>>v.....>>..>>...>......>
v...>v..>..>.>>..v>.>...v>..>v.vv.>.v.v.vv>>v.>v....v...>vv...vvvv.vv...>>>>vvv..v.>.....v.v.v..>...v>.v>.>>>v..v>>...v..>.>.>.>>..v.vvv...
.>v..v..v>.v.v...v.>...vv..>..v.v....>.v.>>..>>.vv>>...v.....v>..v.vvv>.v...>v..v..v.>.>>vvv.>...v>.>.>..v.vv>.>..>v.v..vv>v.>..>>..v.>...v
>>...>.>.....v...v.>.v.....v.>>..vvv.v.>.vv>..v....>....>....v..>>>.v>.>v.>>v...v.>...>...>>>.>>v>...v>..>vv>>.....vv>v..v....>v.>.>>v..v..
v.>>>.>.v......>v>v.>.....vv.>.>.>>v...v.v..v..vv>..v>>vv..>v.vv>....v>...>>>v>v.>.....v.>vv>v.>....>.>.v..>v>>.>....vvv.v.v.v>.vv>..v.....
vv>.>.....>.v..>>>...v.>....>vv....>v>>..v.>.>..>.v..>.....>v..v>v..>.vv>.>.>.v.vv>.>>.....vvv>>v.vvv.>v...vv.v>.>.v>>v....v>..v>..v.>vvvv.
.v.>v.v..>>.v..v>..v..v>.....>.>......>v..v....>.>.>...v>>...>>..v......>v>.>.>>>...v..v>v>.v..>..>v.vv.>.v>...v.>......v>>>....v>>v>>...>.
.v..v....v>v.v.v.>....v.>v>>.v..v>v>.>v.>vv>..>v>v.>v..>v..v.v>v>v..>>>.>.......v.>...>vv.v>.v>v...>vv>..>..v>..vv>...vv...v>>..v.v.vv>..>.
.>...vv>.>....v.v.>..>.>>>.v>>.>.>v..v>.vv..v>.v..v.>.>v..>...v..v...v.>v>>.>..>v>v.>v.>.v>v>v>v>...>.v>..vv.v..>.....v>v>v.v.v>>>...v>.>..
vvv.v.v.>vvvv>.vv.>v.>.>.vv.>..v.vvvv.>..>v>.>v>v.>v.>..v>..>v..>vvv.....vv.v>v.v.>vvv.vv.....v>vv..>.>v.vv.>>>v..vv>.>vv..v>.>v>>.v...vvv>
v>vv.v.>.>.vv>..>...v....>.>vv..v>vv..v.v.v>v.v.....>.>>..v...>.>>.v..v.>.v>.>.>.v>>...v.>v.v>>......v>v>.>>v....vv.v.v..>v.v>.v...>v.v>>..
>...v.....v..v>.>..>>.>..>>.v.v..vv>vvv.>v>>v>...>..>....v..vv>.>..>>.v.vvv>...>>.>v..v.....>..v.v>..v>.v....v>......>..v.vv....>.>....>..v
..>>v>v>..v>>...>>v.....>.>>.>...>>........v>v..>.>>>..>vvv.v.>..v.>v.v..v>>vv....v>..>...v>>..>..v.v.v......>>..v.v>..v..vvvv.>>..>..>vv..
..v.>.>v....>...>..>....>>v..>v..>...>vvv..>v>...>vvv.......>>v....>..vv.v..v.vvv.v......>v.v.>.>.>>v.>.>>>>vvv...>>.>.>.v>vv..>...>.v>v.>.
>v.>..>>.>v..>>..>.vv.>..v.v.>v>..v..>>...>>v.v...vv>.v..>.vv..>.v>>.>....>....>...>.......>>.vv>v>.v>vv..v....>.vvvv>>..v>..v>>.>>v>>.>v..
>....v..>....>v...>..>v....>>>.v>.v......>v.v.v...v>vvv>.>vv.v......>...v..v>>.......v>...>>>...v...>...v...vv>>..v>v.vvv.v..>.v.v>vv.>>>>v
>..vv>.>.>>....vv>..>vvv.vv..>>>v>..>>.....v...v>...v..>.>..>v>.........v>....v....>..>v.v.>>.v.v.>v..>.>v.>...>>..>...>.vvv>..v.>...>v>.v.
>v>v..v.v>v..>...>>vv.>>.v>..>.>>.v...>vv...vv>>.>>..v>v>>vv.v..>>>.>.v.>.>..v..>>.v>>.>>....>.>>v..>vv.>>>v>>....v..vv.>>>.vvv>>.>v.....>v
...v..v...>.>...>.>v....v>...>...>v>v.....v>>>v...v..>v>.>vv>.v...>........>.vv>v..v..v>>v.v.>>v>>..>vv>.>>.vvv.......v.........>..v.>v....
...>v.>>.>.vv..>v.vvv.>..v>vv.>.v>v...>>v.v>.>v.>....v.......v>>v>..>v>..>>....>>>v.>.v>...>..v..v.>>v>>.>>.>>.v.>...vv.vv>vv..v...v..vvv..
.>>.vv.>>..v.>.v>...v>>.>.vv.v>.....v.v.vvvv>..>.>.v.>......>v..>v>.v...>.>>.>....>>>.>......>..>..v>...>.vv..vv.>>..v...>v..vv.>vv>vv..v>>
...v.>v>vv>v.>>......v...vvvv....v>.>.>>v>>..>....>.v.....>>...>>vvv>v>v.>.vv.vv>>>......v..v.v.v....v....vv>vv.>>.>.vv>.v..>.v...vvv>..v.>
.>>..>>..>..vv>>.>..............>v>>.....>vv.>v..>.>v.>>vv.v..>>>v..>>v>v..v>>.v......v>.>>.v.>v>..v.v>..vv...>.>>...vvvv..v..v>>>.......vv
...>v..>v>..v>vv...v.>.v>>.vvv>>>.......v.>...v>..>v......>>..>....>vvv...>..v.vv>>v>v.v.>..>>v>v.>.v.v......vv.....>>..v.>>...v....vv.....
...v.>v>..v..v...v>.v>>>>>...v>v...v>..vv>>v>v....>vvv...>....>>v..>>v>.vv...v.>v....vv.>...>>...v....vv>>........>..v..>vvv.v....>vv....v.
>v>>....>v.v...>.>>.v.>.vv>vv....vv>.>.>>.>..>..>v>v..>>>.>.vv...>>.>v.v>>>..v>>>v.>..>..>..v.....v.v...v>.v.>>vv..>>>....>.v..vvv>.vv..v..
.vv>vvv...>v...>v>v>.>.v>.>.v>.>....vv.>.v..vv..>...>>...vv>v.v.v...>v.v.>..>......>v....v....vv.....>>.>..>.>v.>v..vv>>vvv>..>..>v.v>>..>.
...v>>vvv>...>...v.v...>vv.v.v..v>.vv..>>...>>.v.>..vv>.v.v>>..>>..>..>>vv>v.>...>..>.>v.vv.>...v>>..>...v>.>.vvv.v...v..v...>v..v..>>v>..>
v>.vv>....v>>..v..vv.v.v.v.v.>..vvvv>>>.>v...v>.v..vv>.>>...v>>..>........v.>v>...>.>..>.v....>...>.>.>>...vvvv.>>>..>v.v..>..>v>>>.>.>.vv.
v.v......>>..v>>.vvv.>v..>.>.v.>...>>v..v.....>..>vv.>.>v.>.>.v.v>>>>>...>>.v.v.>>.v>.>..>v..v>>v..>vv..>..>v>.vvv>.>>...>.>....>>>.......>
.>...v>...vv.v.v..v>.v>...>>>..v.>.........>.>...>.>>..>v.v.>vv>.vv....>v.vv.v>vv...>>.v>.........>vvv....>>v>>...>>..>>v.>>v>.v>vvvv>>v>.>
.>>.>..>>v...>.v.v>..vvv..>...v....vvv>..>..v>.>.v>>>v>.>.v.>..v>>...vv..v>v>>.>>.v.......>>>......>..v>...>.v>>>.>.v...v>.v>..>>v..>.>..>v
>.vv.>......>.>.v>>v..>vv>>>.....v>.v>.>..v.>.v>v.v>..>...>v....v.vv>v...v.......v...v>v>>v.v..>v...v.v.vvv>...v...>v.>.......v..>.v.>vvv>>
""".split(separator: "\n")
