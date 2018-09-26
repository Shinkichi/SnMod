class SRVetFieldMedic extends SRVetBaseClass
	abstract;
	
static function int GetPerkProgressInt( ClientPerkRepLink StatOther, out int FinalInt, byte CurLevel, byte ReqNum )
{
	switch( CurLevel )
	{
	case 0:
		FinalInt = 100;
		break;
	case 1:
		FinalInt = 200;
		break;
	case 2:
		FinalInt = 750;
		break;
	case 3:
		FinalInt = 4000;
		break;
	case 4:
		FinalInt = 12000;
		break;
	case 5:
		FinalInt = 25000;
		break;
	case 6:
		FinalInt = 100000;
		break;
	default:
		FinalInt = 100000+GetDoubleScaling(CurLevel,20000);
	}
	return Min(StatOther.RDamageHealedStat,FinalInt);
}

static function class<Grenade> GetNadeType(KFPlayerReplicationInfo KFPRI)
{
	return class'MedicNade'; // Grenade detonations heal nearby teammates, and cause enemies to be poisoned

	return super.GetNadeType(KFPRI);
}

static function float GetSyringeChargeRate(KFPlayerReplicationInfo KFPRI)
{
	return 2.5;
}

static function int ReduceDamage(KFPlayerReplicationInfo KFPRI, KFPawn Injured, Pawn Instigator, int InDamage, class<DamageType> DmgType)
{
	if ( DmgType == class'DamTypeVomit' )
	{
		return float(InDamage) * 0.50; // 50% decrease in damage from Bloat's Bile
	}

	return InDamage;
}

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

	OnHUDIcon=Texture'SnTex.Perk.Icon_Medic'
	OnHUDGoldIcon=Texture'SnTex.Perk.Icon_Medic'
	VeterancyName="Field Medic"
	Requirements[0]="Heal %x HP on your teammates"

	SRLevelEffects(0)="test0"
	SRLevelEffects(1)="test1"
	SRLevelEffects(2)="test2"
	SRLevelEffects(3)="test3"
	SRLevelEffects(4)="test4"
	SRLevelEffects(5)="test5"
	SRLevelEffects(6)="test6"
	CustomLevelInfo="test"
}