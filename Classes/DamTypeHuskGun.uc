class DamTypeHuskGun extends KFMod.DamTypeBurned
	abstract;

defaultproperties
{
	HeadShotDamageMult=1.0
    WeaponClass=Class'SnMod.HuskGun'
    DeathString="%k killed %o (Husk Gun)."
    FemaleSuicide="%o blew up."
    MaleSuicide="%o blew up."
    bCheckForHeadShots=true
}
