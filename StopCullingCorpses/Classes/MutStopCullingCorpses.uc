class MutStopCullingCorpses extends Mutator;

var class<GameRules> NewPawnRules;

function bool MutatorIsAllowed()
{
	return (WorldInfo.NetMode == NM_Standalone);
}

function InitMutator(string Options, out string ErrorMessage)
{
	WorldInfo.Game.AddGameRules(NewPawnRules);

	Super.InitMutator(Options, ErrorMessage);
}

defaultproperties
{
	NewPawnRules=class'StopCullingCorpses.Rules_UTPawn_UnculledBody'
}
