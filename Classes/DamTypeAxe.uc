class DamTypeAxe extends KFMod.DamTypeMelee;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if( KFStatsAndAchievements!=None )
		KFStatsAndAchievements.AddFireAxeKill();
}

defaultproperties
{
	 HeadShotDamageMult=1.0
     WeaponClass=Class'SnMod.Axe'
     PawnDamageSounds(0)=Sound'KF_AxeSnd.Axe_HitFlesh'
     KDamageImpulse=2000.0//15000.000000
     VehicleDamageScaling=0.700000
}
