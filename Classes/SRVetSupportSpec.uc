class SRVetSupportSpec extends SRVetBaseClass
	abstract;

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 1000;
		break;
	case 1:
		FinalInt = 5000;
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
	return Min(StatOther.RShotgunDamageStat,FinalInt);
}

// Reduce Penetration damage with Shotgun slower
static function float GetShotgunPenetrationDamageMulti(KFPlayerReplicationInfo KFPRI, float DefaultPenDamageReduction)
{
	local float PenDamageInverse;

	PenDamageInverse = 1.0 - FMax(0,DefaultPenDamageReduction);

	if ( KFPRI.ClientVeteranSkillLevel == 0 )
		return DefaultPenDamageReduction + (PenDamageInverse / 90.0);

	return DefaultPenDamageReduction + ((PenDamageInverse / 5.5555) * float(Min(KFPRI.ClientVeteranSkillLevel, 5)));
}

/*static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
	if ( ShotgunAmmo(Other) != none || DBShotgunAmmo(Other) != none|| AA12Ammo(Other) != none
		|| BenelliAmmo(Other) != none || KSGAmmo(Other) != none || SPShotgunAmmo(Other) != none)
	{
		return 1.5; // 50% increase in Shotgun ammo carry
	}

	// Multiperk
	if ( NailGunAmmo(Other) != none || TrenchgunAmmo(Other) != none )
	{
		return 1.5; // 50% increase in Shotgun ammo carry
	}

	return 1.0;
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( AmmoType == class'ShotgunAmmo' || AmmoType == class'DBShotgunAmmo' || AmmoType == class'AA12Ammo'
		|| AmmoType == class'BenelliAmmo' || AmmoType == class'KSGAmmo' || AmmoType == class'SPShotgunAmmo' )
    {
		return 1.5; // 50% increase in Shotgun ammo carry
	}

	// Multiperk
	if ( AmmoType == class'NailGunAmmo' || AmmoType == class'TrenchgunAmmo' )
	{
		return 1.5; // 50% increase in Shotgun ammo carry
	}

	return 1.0;
}*/

// Give Extra Items as Default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 0, give them Assault Shotgun
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'Shotgun'), default.StartingWeaponSellPriceLevel5);
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	S = Repl(S,"%s",GetPercentStr(0.1 * float(Level)));
	S = Repl(S,"%g",GetPercentStr(0.1*float(Level)-0.1f));
	S = Repl(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	return S;
}

defaultproperties
{
	PerkIndex=1

	OnHUDIcon=Texture'SnTex.Perk.Icon_Support'
	OnHUDGoldIcon=Texture'SnTex.Perk.Icon_Support'
	VeterancyName="Support Specialist"
	Requirements(0)="Deal %x damage with Support Weapons"

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}