class SRVetUboaizm extends SRVetBaseClass
	abstract;

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 0 or Higher, give them Body Armor
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		P.ShieldStrength = 100;
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	S = Repl(S,"%s",GetPercentStr(0.1 * float(Level)));
	S = Repl(S,"%r",GetPercentStr(FMin(0.25f+0.05 * float(Level),0.95f)));
	S = Repl(S,"%d",GetPercentStr(FMin(0.5+0.04 * float(Level),0.99f)));
	S = Repl(S,"%x",string(2+Level));
	S = Repl(S,"%y",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	return S;
}

defaultproperties
{
	PerkIndex=0

	OnHUDIcon=none
	OnHUDGoldIcon=none
	VeterancyName="Uboaizm"
	Requirements[0]="??? %x ???"

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}