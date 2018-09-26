class DamTypeDBShotgun extends KFMod.DamTypeShotgun
	abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if( KFStatsAndAchievements!=None )
		KFStatsAndAchievements.AddHuntingShotgunKill();
}

defaultproperties
{
	HeadShotDamageMult=1.0
    WeaponClass=Class'SnMod.Crossbuzzsaw'
}
