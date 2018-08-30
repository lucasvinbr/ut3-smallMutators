class Rules_UTPawn_UnculledBody extends GameRules;


event PreBeginPlay()
{

	WorldInfo.Game.DefaultPawnClass = class'StopCullingCorpses.UTPawn_UnculledBody';

	Super.PreBeginPlay();
}

defaultproperties
{
}