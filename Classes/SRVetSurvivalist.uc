class SRVetSurvivalist extends SRVetBaseClass
	abstract;

static function int GetStatValueInt(ClientPerkRepLink StatOther, byte ReqNum)
{
  return StatOther.GetCustomValueInt(Class'SnMod.Progress_Damage_Survivalist');
}

static function AddCustomStats( ClientPerkRepLink Other )
{
    super.AddCustomStats(Other); //init achievements

    Other.AddCustomValue(Class'SnMod.Progress_Damage_Survivalist');
    Other.AddCustomValue(Class'SnMod.Progress_Kill_Survivalist');
}

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
	return Min(StatOther.GetCustomValueInt(Class'SnMod.Progress_Damage_Survivalist'),FinalInt);
}

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 0, give them a  Dual44
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'Nailgun'), default.StartingWeaponSellPriceLevel5);
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	S = Repl(S,"%s",GetPercentStr((1.1 + (0.05 * float(Level)))));
	S = Repl(S,"%p",GetPercentStr(0.1 * float(Level)));
	S = Repl(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	return S;
}

defaultproperties
{
	PerkIndex=8

	OnHUDIcon=none
	OnHUDGoldIcon=none
	VeterancyName="Survivalist"
	Requirements(0)="Deal %x damage with Survivalist Weapons"

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}