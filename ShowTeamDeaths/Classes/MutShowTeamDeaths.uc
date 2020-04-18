class MutShowTeamDeaths extends Mutator;

struct TeamDeathCount {
	var int Deaths;
	var TeamInfo Team;
};

function TeamDeathCount InitTeamDeathCount(TeamInfo NewTeam){
	local TeamDeathCount TDC;
	
	TDC.Team = NewTeam;
	TDC.Deaths = 0;
	
	return TDC;
}

function Mutate(string MutateString, PlayerController Sender)
{
	local array<PlayerReplicationInfo> Players;
	local array<TeamDeathCount> DeathCounts;
	local int i, j;

	Super.Mutate(MutateString, Sender);

	if(InStr(Caps(MutateString),"SHOWTEAMDEATHS") != -1) {
		//it's our command!
		
		
		//fetch all teams...
		for(i = 0; i < WorldInfo.GRI.Teams.Length; i++){
			DeathCounts.AddItem(InitTeamDeathCount(WorldInfo.GRI.Teams[i]));
		}
		
		Players = WorldInfo.GRI.PRIArray;
		
		//count deaths from each player
		for(i = 0; i < Players.Length; i++){
			for(j = 0; j < DeathCounts.Length; j++){
				if(DeathCounts[j].Team.TeamIndex == Players[i].Team.TeamIndex){
					DeathCounts[j].Deaths += Players[i].Deaths;
					break;
				}
			}
		}
		
		for(i = 0; i < DeathCounts.Length; i++){
			Sender.ClientMessage("Deaths from team " $ DeathCounts[i].Team.GetHumanReadableName() $ ", index " $ DeathCounts[i].Team.TeamIndex $ ": " $ DeathCounts[i].Deaths);
		}
	
  }
  
}
