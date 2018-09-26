class DamTypeLAW extends KFMod.DamTypeFrag;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed );

defaultproperties
{
	HeadShotDamageMult=1.0
    WeaponClass=Class'SnMod.Law'
	HumanObliterationThreshhold=350

	DeathOverlayMaterial=Material'Effects_Tex.PlayerDeathOverlay'
	DeathOverlayTime=999
	bIsPowerWeapon=false
	KDeathUpKick=300
}
