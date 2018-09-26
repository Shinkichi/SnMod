class DamTypeKnife extends KFMod.DamTypeMelee
	abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if( KFStatsAndAchievements!=None && Killer.SelectedVeterancy==class'KFVetFieldMedic' )
		KFStatsAndAchievements.AddMedicKnifeKill();
}

defaultproperties
{
	HeadShotDamageMult=1.0
     WeaponClass=Class'SnMod.Knife'
     KDamageImpulse=1500.000000
     VehicleDamageScaling=0.500000
}
