class SRVetBerserker extends SRVetBaseClass
	abstract;

static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 5000;
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
	return Min(StatOther.RMeleeDamageStat,FinalInt);
}

//static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, KFMonster DamageTaker, int InDamage, class<DamageType> DmgType)
static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
	{
		return float(InDamage) * 0.75;
	}

	return InDamage;
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
	// If Level 0, give them Machete
	if ( KFPRI.ClientVeteranSkillLevel >= 0 )
		KFHumanPawn(P).CreateInventoryVeterancy(string(class'Machete'), default.StartingWeaponSellPriceLevel5);
}

static function string GetCustomLevelInfo( byte Level )
{
	local string S;

	S = Default.CustomLevelInfo;
	S = Repl(S,"%s",GetPercentStr(0.05 * float(Level)-0.05));
	S = Repl(S,"%d",GetPercentStr(0.1+FMin(0.1 * float(Level),0.8f)));
	S = Repl(S,"%r",GetPercentStr(0.7 + 0.05*float(Level)));
	S = Repl(S,"%l",GetPercentStr(FMin(0.05*float(Level),0.65f)));
	return S;
}

defaultproperties
{
	PerkIndex=4

	OnHUDIcon=Texture'SnTex.Perk.Icon_Berserker'
	OnHUDGoldIcon=Texture'SnTex.Perk.Icon_Berserker'
	VeterancyName="Berserker"
	Requirements(0)="Deal %x damage with Berserker Weapons"

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}