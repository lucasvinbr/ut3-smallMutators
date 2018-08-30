class MutSetPlayerStats extends Mutator
config(MutSetPlayerStats);

var config float moveSpeedMult;
var config float jumpHeightMult;
var config int maxJumps;

var config int startHealth;
var config int maxHealth;

var config float ragdollLifespan;

function ModifyPlayer(Pawn P)
{
	local UTPawn utP;
	
	P.GroundSpeed *= moveSpeedMult;
	P.JumpZ *= jumpHeightMult;
	P.Health = startHealth;
	P.HealthMax = maxHealth;
	
	utP = UTPawn(P);
	if ( utP != None )
	{
		utP.RagdollLifespan = ragdollLifespan;
		utP.MaxMultiJump = maxJumps;
	}
	Super.ModifyPlayer(P);
}

defaultproperties
{
	GroupNames[0]="PAWNSTATS"
	moveSpeedMult=1.0
	jumpHeightMult=1.0
	maxJumps=1
	startHealth=100
	maxHealth=199
	ragdollLifespan=30
}
