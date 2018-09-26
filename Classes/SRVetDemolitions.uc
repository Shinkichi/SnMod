class SRVetDemolitions extends SRVetBaseClass
	abstract;

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 10000;
		break;
	case 1:
		FinalInt = 25000;
		break;
	case 2:
		FinalInt = 100000;
		break;
	case 3:
		FinalInt = 500000;
		break;
	case 4:
		FinalInt = 1500000;
		break;
	case 5:
		FinalInt = 3500000;
		break;
	case 6:
		FinalInt = 5500000;
		break;
	default:
		FinalInt = 5500000+GetDoubleScaling(CurLevel,500000);
	}
	return Min(StatOther.RExplosivesDamageStat,FinalInt);
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 0, give them a pipe bomb
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'PipeBombExplosive'), default.StartingWeaponSellPriceLevel5);
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
	PerkIndex=6

	OnHUDIcon=Texture'SnTex.Perk.Icon_Demolition'
	OnHUDGoldIcon=Texture'SnTex.Perk.Icon_Demolition'
	VeterancyName="Demolitions"
	Requirements(0)="Deal %x damage with Demolition Weapons"

	StartingWeaponSellPriceLevel5=0

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}