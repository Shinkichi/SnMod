class DamTypeFlareRevolver extends KFMod.DamTypeBurned
	abstract;

defaultproperties
{
	HeadShotDamageMult=1.0
    WeaponClass=Class'SnMod.FlareRevolver'
    DeathString="%k killed %o (Flare Revolver)."
    FemaleSuicide="%o blew up."
    MaleSuicide="%o blew up."
    bCheckForHeadShots=true
}
