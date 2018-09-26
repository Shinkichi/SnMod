class SRVetCommando extends SRVetBaseClass
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
	return Min(StatOther.RBullpupDamageStat,FinalInt);
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Bullpup(Other) != none || AK47AssaultRifle(Other) != none
		|| SCARMK17AssaultRifle(Other) != none || M4AssaultRifle(Other) != none
		|| MKb42AssaultRifle(Other) != none || FNFAL_ACOG_AssaultRifle(Other) != none )
	{
		return 1.5;
	}

	// Multiperk
	if ( M7A3MMedicGun(Other) != none || M14EBRBattleRifle(Other) != none
		 || M4203AssaultRifle(Other) != none )
	{
		return 1.5;
	}

	return 1.0;
}

static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
	if ( BullpupAmmo(Other) != none || AK47Ammo(Other) != none
		|| SCARMK17Ammo(Other) != none || M4Ammo(Other) != none || MKb42Ammo(Other) != none || FNFALAmmo(Other) != none)
	{
		return 1.5;
	}

	// Multiperk
	if ( M7A3MAmmo(Other) != none || M14EBRAmmo(Other) != none
		 || M4203Ammo(Other) != none )
	{
		return 1.5;
	}

	return 1.0;
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
	if ( AmmoType == class'BullpupAmmo' || AmmoType == class'AK47Ammo'
		|| AmmoType == class'SCARMK17Ammo' || AmmoType == class'M4Ammo' || AmmoType == class'MKb42Ammo' || AmmoType == class'FNFALAmmo')
	{
		return 1.5;
	}

	// Multiperk
	if ( AmmoType == class'M7A3MAmmo' || AmmoType == class'M14EBRAmmo'
		 || AmmoType == class'M4203Ammo'  )
	{
		return 1.5;
	}

	return 1.0;
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 0, give them Bullpup
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'Bullpup'), default.StartingWeaponSellPriceLevel5);
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	S = Repl(S,"%s",GetPercentStr(0.05 * float(Level)+0.05));
	S = Repl(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	S = Repl(S,"%z",string(Level-2));
	S = Repl(S,"%r",GetPercentStr(FMin(0.05 * float(Level)+0.1,1.f)));
	return S;
}

defaultproperties
{
	PerkIndex=3

	OnHUDIcon=Texture'SnTex.Perk.Icon_Commando'
	OnHUDGoldIcon=Texture'SnTex.Perk.Icon_Commando'
	VeterancyName="Commando"
	Requirements(0)="Deal %x damage with Commando Weapons"

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}