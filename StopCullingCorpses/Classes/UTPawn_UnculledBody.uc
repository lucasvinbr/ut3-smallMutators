class UTPawn_UnculledBody extends UTPawn;


simulated State Dying
{
	simulated function BeginState(Name PreviousStateName)
	{
		Super.BeginState(PreviousStateName);
		if(IsTimerActive()){
			ClearTimer(); //utpawn's timer keeps checking if the corpse is visible in order to remove it
		}
	}
}

defaultproperties
{
}
