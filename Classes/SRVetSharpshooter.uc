class SRVetSharpshooter extends SRVetBaseClass
	abstract;

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
	return Min(StatOther.RHeadshotKillsStat,FinalInt);
}

static function float GetHeadShotDamMulti(KFPlayerReplicationInfo KFPRI, KFPawn P, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeWinchester' || DmgType == class'DamTypeSPSniper' || DmgType == class'DamTypeM14EBR'
		|| DmgType == class'DamTypeM99SniperRifle' || DmgType == class'DamTypeM99HeadShot' )
	{
		return 1.5;
	}

	// Multi perk
	if ( DmgType == class'DamTypeM7A3M' || DmgType == class'DamTypeFNFALAssaultRifle' || DmgType == class'DamTypeCrossbow' || DmgType == class'DamTypeCrossbowHeadShot' )
	{
		return 1.5;
	}

	return 1.0;
}

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 0, give them a  Lever Action Rifle
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'Winchester'), default.StartingWeaponSellPriceLevel5);
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
	PerkIndex=2

	OnHUDIcon=Texture'SnTex.Perk.Icon_SharpShooter'
	OnHUDGoldIcon=Texture'SnTex.Perk.Icon_SharpShooter'
	VeterancyName="Sharpshooter"
	Requirements[0]="Get %x headshot kills with Sharpshooter Weapons"

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}