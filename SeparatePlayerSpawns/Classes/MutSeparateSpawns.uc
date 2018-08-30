class MutSeparateSpawns extends Mutator;

var class<GameRules> NewSpawnRules;

function bool MutatorIsAllowed()
{
	return (WorldInfo.NetMode == NM_Standalone);
}

function InitMutator(string Options, out string ErrorMessage)
{
	WorldInfo.Game.AddGameRules(NewSpawnRules);

	Super.InitMutator(Options, ErrorMessage);
}

defaultproperties
{
	NewSpawnRules=class'SeparatePlayerSpawns.Rules_SeparateSpawns'
}
