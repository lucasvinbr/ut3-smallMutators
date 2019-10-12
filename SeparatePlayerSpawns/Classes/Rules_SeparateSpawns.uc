class Rules_SeparateSpawns extends GameRules config(Rules_SeparateSpawns);

var PlayerStart baseStartOne, baseStartTwo;

var() config float extraSpawnsRadius;
var() config bool useAnyNavigationPointAsExtraStart;

var array< NavigationPoint > startsOne, startsTwo;

function SetupIsolatedStarts(){
	local int i, j;
	local PlayerStart P;
	local float biggestDist, curEvalDist;
	local array< PlayerStart > allPStarts;
	
	biggestDist = 0;

	foreach WorldInfo.AllNavigationPoints(class'PlayerStart', P)
	{
		allPStarts.insert(0, 1);
		allPStarts[0] = P;
	}
	
	//find and set the farthest as the activated spawns!
	for(i = 0; i < allPStarts.Length; i++){
		for(j = i+1; j < allPStarts.Length; j++){
			curEvalDist = VSize(allPStarts[i].Location - allPStarts[j].Location);
			if(curEvalDist > biggestDist){
				biggestDist = curEvalDist;
				baseStartOne = allPStarts[i];
				baseStartTwo = allPStarts[j];
			}
		}
	}
	
	startsOne.AddItem(baseStartOne);
	startsTwo.AddItem(baseStartTwo);

	//extra playerStarts inside the provided radius
	if(extraSpawnsRadius > 0){
		if(useAnyNavigationPointAsExtraStart){
		
			AddNearbyNavPointsToStarts();
			
		} else{
		
			for(i = 0; i < allPStarts.Length; i++){
				if(allPStarts[i] == baseStartOne || allPStarts[i] == baseStartTwo){
					continue;
				}
				
				curEvalDist = VSize(baseStartOne.Location - allPStarts[i].Location);
				if(curEvalDist < extraSpawnsRadius){
					startsOne.AddItem(allPStarts[i]);
				}else{
					curEvalDist = VSize(baseStartTwo.Location - allPStarts[i].Location);
					if(curEvalDist < extraSpawnsRadius){
						startsTwo.AddItem(allPStarts[i]);
					}
				}
			}
			
		}
	
		
	}
}

function AddNearbyNavPointsToStarts(){
	local NavigationPoint N;

	foreach WorldInfo.RadiusNavigationPoints(class'NavigationPoint', N, baseStartOne.Location, extraSpawnsRadius){
		if(N == baseStartOne || N == baseStartTwo){
			continue;
		}
		startsOne.AddItem(N);
	}
			
	foreach WorldInfo.RadiusNavigationPoints(class'NavigationPoint', N, baseStartTwo.Location, extraSpawnsRadius){
		if(N == baseStartOne || N == baseStartTwo){
			continue;
		}
		startsTwo.AddItem(N);
	}
}

function NavigationPoint FindPlayerStart( Controller Player, optional byte InTeam, optional string incomingName )
{
	local NavigationPoint pickedStart;
	local int Team;
	
	if(baseStartOne == None) SetupIsolatedStarts();
	
	Team = ( (Player != None) && (Player.PlayerReplicationInfo != None) && (Player.PlayerReplicationInfo.Team != None) )
		? Player.PlayerReplicationInfo.Team.TeamIndex
		: 0;
		
	if(Team > 0){
		pickedStart = startsOne[Rand(startsOne.Length)];
	}else if(Team == 0){
		pickedStart = startsTwo[Rand(startsTwo.Length)];
	}

	if ( NextGameRules != None && pickedStart == None ){
		return NextGameRules.FindPlayerStart(Player,InTeam,incomingName);
	}else{
		return pickedStart;
	}
		

	
}

defaultproperties
{
	extraSpawnsRadius=125.099998
	useAnyNavigationPointAsExtraStart = true
}