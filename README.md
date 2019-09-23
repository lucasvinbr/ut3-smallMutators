# ut3-smallMutators
Simple mutators for ut3

Contains 4 mutators:

*SeparatePlayerSpawns* restricts player spawns to only two (the farthest from each other it can find) and makes each team use only one of them.
In more-than-two team matches, it should isolate only the first team from the rest.

*SetPlayerStats* is your basic stat change mutator, allowing you to set players' health, movement speed, jump speed, number of multiJumps and ragdoll Lifespan. The UPK file should be placed in UTGame\Published\CookedPC.

*StopCullingCorpses* stops ragdolls from disappearing when the camera isn't showing them (they should still disappear after their lifespan time)

*NewBotAdder* adds a console command (used with *mutate*) for instantly adding many bots of a specific type to a team or not.
- command example: *mutate rednewbot reaper 32*
