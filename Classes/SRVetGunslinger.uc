class SRVetGunslinger extends SRVetBaseClass
	abstract;

static function int GetStatValueInt(ClientPerkRepLink StatOther, byte ReqNum)
{
  return StatOther.GetCustomValueInt(Class'SnMod.Progress_Damage_Gunslinger');
}

static function AddCustomStats( ClientPerkRepLink Other )
{
    super.AddCustomStats(Other); //init achievements

    Other.AddCustomValue(Class'SnMod.Progress_Damage_Gunslinger');
    Other.AddCustomValue(Class'SnMod.Progress_Kill_Gunslinger');
    Other.AddCustomValue(Class'SnMod.Progress_Headshot_Gunslinger');
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
	return Min(StatOther.GetCustomValueInt(Class'SnMod.Progress_Damage_Gunslinger'),FinalInt);
}

/*static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( class<DamTypeDeagle>(DmgType) != none || class<DamTypeMagnum44Pistol>(DmgType) != none 
		|| class<DamTypeMK23Pistol>(DmgType) != none )
	{
		return float(InDamage) * 1.25;
	}

	if ( class<DamTypeDualies>(DmgType) != none || class<DamTypeDualDeagle>(DmgType) != none 
		|| class<DamTypeDual44Magnum>(DmgType) != none || class<DamTypeDualMK23Pistol>(DmgType) != none )
	{
		return float(InDamage) * 1.25;
	}

	// Multi Perks
	if ( class<DamTypeFlareProjectileImpact>(DmgType) != none )
	{
		return float(InDamage) * 1.25;
	}

	return InDamage;
}*/

static function float GetReloadSpeedModifier(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Single(Other) != none || Deagle(Other) != none || Magnum44Pistol(Other) != none || MK23Pistol(Other) != none )
	{
		return 1.25;
	}

	if ( Dualies(Other) != none || DualDeagle(Other) != none || Dual44Magnum(Other) != none || DualMK23Pistol(Other) != none )
	{
		return 1.25;
	}

	// Multi Perks
	if ( FlareRevolver(Other) != none )
	{
		return 1.25;
	}

	if ( DualFlareRevolver(Other) != none )
	{
		return 1.25;
	}

	return 1.0;
}

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 0, give them a Dual9mm
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'Dualies'), default.StartingWeaponSellPriceLevel5);
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

	OnHUDIcon=Texture'SnTex.Perk.Icon_Gunslinger'
	OnHUDGoldIcon=Texture'SnTex.Perk.Icon_Gunslinger'
	VeterancyName="Gunslinger"
	Requirements(0)="Deal %x damage with Gunslinger Weapons"

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}