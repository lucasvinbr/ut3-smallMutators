class Rules_SeparateSpawns extends GameRules;

var PlayerStart startOne, startTwo;

var array< PlayerStart > playerStarts;

function SetupIsolatedStarts(){
	local int i, j;
	local PlayerStart P;
		
	local float biggestDist, curEvalDist;
	
	biggestDist = 0;

	foreach WorldInfo.AllNavigationPoints(class'PlayerStart', P)
	{
		playerStarts.insert(0, 1);
		playerStarts[0] = P;
	}
	
	//find and set the farthest as the activated spawns!
	for(i = 0; i < playerStarts.Length; i++){
		for(j = i+1; j < playerStarts.Length; j++){
			curEvalDist = VSize(playerStarts[i].Location - playerStarts[j].Location);
			if(curEvalDist > biggestDist){
				biggestDist = curEvalDist;
				startOne = playerStarts[i];
				startTwo = playerStarts[j];
			}
		}
	}
}

function NavigationPoint FindPlayerStart( Controller Player, optional byte InTeam, optional string incomingName )
{
	local PlayerStart pickedStart;
	local int Team;
	
	if(startOne == None) SetupIsolatedStarts();
	
	Team = ( (Player != None) && (Player.PlayerReplicationInfo != None) && (Player.PlayerReplicationInfo.Team != None) )
		? Player.PlayerReplicationInfo.Team.TeamIndex
		: 0;
		
	if(Team > 0){
		pickedStart = startOne;
	}else if(Team == 0){
		pickedStart = startTwo;
	}

	if ( NextGameRules != None && pickedStart == None ){
		return NextGameRules.FindPlayerStart(Player,InTeam,incomingName);
	}else{
		return pickedStart;
	}
		

	
}

defaultproperties
{
}