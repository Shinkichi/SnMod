class SRVetFirebug extends SRVetBaseClass
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
	return Min(StatOther.RFlameThrowerDamageStat,FinalInt);
}

static function class<Grenade> GetNadeType(KFPlayerReplicationInfo KFPRI)
{
	return class'FlameNade'; // Grenade detonations cause enemies to catch fire

	return super.GetNadeType(KFPRI);
}

static function float GetMagCapacityMod(KFPlayerReplicationInfo KFPRI, KFWeapon Other)
{
	if ( Mac10MP(Other) != none || FlameThrower(Other) != none
		|| FlareRevolver(Other) != none || DualFlareRevolver(Other) != none
		|| Trenchgun(Other) != none || HuskGun(Other) != none )
	{
		return 2.0; // 100% increase in Flame ammo carry
	}

	return 1.0;
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 0, give them a Mac10MP
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'Mac10MP'), default.StartingWeaponSellPriceLevel5);
}

static function class<DamageType> GetMAC10DamageType(KFPlayerReplicationInfo KFPRI)
{
	return class'DamTypeMAC10MPInc';
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	S = Repl(S,"%s",GetPercentStr(0.1 * float(Level)));
	S = Repl(S,"%m",GetPercentStr(0.05 * float(Level)));
	S = Repl(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	return S;
}

defaultproperties
{
	PerkIndex=5

	OnHUDIcon=Texture'SnTex.Perk.Icon_Firebug'
	OnHUDGoldIcon=Texture'SnTex.Perk.Icon_Firebug'
	VeterancyName="Firebug"
	Requirements(0)="Deal %x damage with Firebug Weapons"

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}