class SRVetNewtralizer extends SRVetBaseClass
	abstract;

static function int GetStatValueInt(ClientPerkRepLink StatOther, byte ReqNum)
{
  return StatOther.GetCustomValueInt(Class'SnMod.Progress_Damage_Newtralizer');
}

static function AddCustomStats( ClientPerkRepLink Other )
{
	Other.AddCustomValue(Class'SnMod.Progress_Damage_Newtralizer');
	Other.AddCustomValue(Class'SnMod.Progress_Kill_Newtralizer');
}

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 10;
		break;
	case 1:
		FinalInt = 30;
		break;
	case 2:
		FinalInt = 100;
		break;
	case 3:
		FinalInt = 700;
		break;
	case 4:
		FinalInt = 2500;
		break;
	case 5:
		FinalInt = 5500;
		break;
	case 6:
		FinalInt = 8500;
		break;
	default:
		FinalInt = 8500+GetDoubleScaling(CurLevel,2500);
	}
	return Min(StatOther.GetCustomValueInt(Class'SnMod.Progress_Kill_Newtralizer'),FinalInt);
}

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 0, give them a ZEDMKIIWeapon
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'ZEDMKIIWeapon'), default.StartingWeaponSellPriceLevel5);
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
	PerkIndex=7

	OnHUDIcon=Texture'SnTex.Perk.Icon_OffPerk'
	OnHUDGoldIcon=Texture'SnTex.Perk.Icon_OffPerk'
	VeterancyName="Newtralizer"
	Requirements(0)="Get %x Kills with Newtralizer Weapons"

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}