class MutNewBotAdder extends Mutator;

function Mutate(string MutateString, PlayerController Sender)
{
	local string Command, BotName;
	local array<string> CommandDetails;
	local int i;

	Super.Mutate(MutateString, Sender);

	//possible options:
	//-newbot (bot name) (number of bots to add)
	//-rednewbot (bot name) (num bots to add)
	//-bluenewbot (same)  
	if(InStr(Caps(MutateString),"NEWBOT") != -1) {
		//it's one of the commands of interest then
		ParseStringIntoArray(MutateString, CommandDetails, " ", true);
		
		Command = CommandDetails[0];
		
		CommandDetails.Remove(0, 1);
		
		if(CommandDetails.Length >= 2){
			BotName = CommandDetails[0];
		
			if(CommandDetails.Length > 2){
			  //this is probably a bot name with whitespaces followed by the number.
			  //we must rebuild the bot name then
			  for(i = 1; i < CommandDetails.Length - 1; i++){
				BotName @= CommandDetails[i];
			  }
			}
			
			NewBots(Sender, BotName, int(CommandDetails[CommandDetails.Length - 1]), CommandNameToTeam(Command));
		} else {
			Sender.ClientMessage("Usage: mutate " $ Command $ " botname numberToAdd (numberToAdd is required; use spaces normally if the bot name has them)");
		}
	
  }
  
}

function int CommandNameToTeam(string CommandName)
{
	if(CommandName ~= "rednewbot"){
		return 0;
	} else if(CommandName ~= "bluenewbot"){
		return 1;
	} else{
		return 255;
	}
}

function NewBots(PlayerController Sender, string BotName, int Amount, int Team)
{
	local int i;
	local UTGame Utgame;
	
	Utgame = UTGame(WorldInfo.Game);
	
	if(Utgame != None){
		Sender.ClientMessage("Adding " $ Amount $ " bot(s) of type " $ BotName);
		
		for(i = 0; i < Amount; i++){
			Utgame.AddNamedBot(BotName, Team != 255, Team);
		}
	} else{
		Sender.ClientMessage("Current game is not of the UTGame type, aborting");
	}
}
