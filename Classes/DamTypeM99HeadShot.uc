class DamTypeM99HeadShot extends KFMod.DamTypeM99SniperRifle
	abstract;

static function AwardKill(KFSteamStatsAndAchievements KFStatsAndAchievements, KFPlayerController Killer, KFMonster Killed )
{
	if ( KFStatsAndAchievements != none )
	{
		if ( Killed.IsA('ZombieScrake'))
		{
			KFStatsAndAchievements.AddM99Kill();
		}
		if (Killed.IsA('ZombieHusk'))
		{
			KFStatsAndAchievements.AddHuskAndZedOneShotKill(true, false);
		}
		else
		{
        	KFStatsAndAchievements.AddHuskAndZedOneShotKill(false, true);
		}
	}
}

defaultproperties
{
	HeadShotDamageMult=1.25
     DeathString="%k put a bullet in %o's head."
     FemaleSuicide="%o shot herself in the head."
     MaleSuicide="%o shot himself in the head."
     bBulletHit=True
     FlashFog=(X=600.000000)
     VehicleDamageScaling=0.6500000
}
