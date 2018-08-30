class UI_MutSetPlayerStats extends UTUIFrontEnd;

var transient UINumericEditBox moveSpeedMultBox;
var transient UINumericEditBox jumpHeightMultBox;
var transient UINumericEditBox maxJumpsBox;
var transient UINumericEditBox startHealthBox;
var transient UINumericEditBox maxHealthBox;
var transient UINumericEditBox ragdollLifespanBox;

event SceneActivated(bool bInitialActivation)
{
	Super.SceneActivated(bInitialActivation);

	if (bInitialActivation)
	{
		moveSpeedMultBox = UINumericEditBox(FindChild('moveSpeedMultBox', true));
		jumpHeightMultBox = UINumericEditBox(FindChild('jumpHeightMultBox', true));
		maxJumpsBox = UINumericEditBox(FindChild('maxJumpsBox', true));
		startHealthBox = UINumericEditBox(FindChild('startHealthBox', true));
		maxHealthBox = UINumericEditBox(FindChild('maxHealthBox', true));
		ragdollLifespanBox = UINumericEditBox(FindChild('ragdollLifespanBox', true));

		moveSpeedMultBox.SetNumericValue(class'SetPlayerStats.MutSetPlayerStats'.default.moveSpeedMult, true);
		jumpHeightMultBox.SetNumericValue(class'SetPlayerStats.MutSetPlayerStats'.default.jumpHeightMult, true);
		maxJumpsBox.SetNumericValue(class'SetPlayerStats.MutSetPlayerStats'.default.maxJumps, true);
		startHealthBox.SetNumericValue(class'SetPlayerStats.MutSetPlayerStats'.default.startHealth, true);
		maxHealthBox.SetNumericValue(class'SetPlayerStats.MutSetPlayerStats'.default.maxHealth, true);
		ragdollLifespanBox.SetNumericValue(class'SetPlayerStats.MutSetPlayerStats'.default.ragdollLifespan, true);
		
	}
}  

function SetupButtonBar()
{
	ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.Accept>", OnButtonBar_Accept);
	ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.Back>", OnButtonBar_Back);
}

function bool OnButtonBar_Back(UIScreenObject InButton, int InPlayerIndex)
{
	CloseScene(self);

	return true;
}  

function bool OnButtonBar_Accept(UIScreenObject InButton, int InPlayerIndex)
{
	class'SetPlayerStats.MutSetPlayerStats'.default.moveSpeedMult = moveSpeedMultBox.GetNumericValue();
	class'SetPlayerStats.MutSetPlayerStats'.default.jumpHeightMult = jumpHeightMultBox.GetNumericValue();
	class'SetPlayerStats.MutSetPlayerStats'.default.maxJumps = maxJumpsBox.GetNumericValue();
	class'SetPlayerStats.MutSetPlayerStats'.default.startHealth = startHealthBox.GetNumericValue();
	class'SetPlayerStats.MutSetPlayerStats'.default.maxHealth = maxHealthBox.GetNumericValue();
	class'SetPlayerStats.MutSetPlayerStats'.default.ragdollLifespan = ragdollLifespanBox.GetNumericValue();

	class'SetPlayerStats.MutSetPlayerStats'.static.StaticSaveConfig();

	CloseScene(self);

	return true;
}  

defaultproperties
{
}