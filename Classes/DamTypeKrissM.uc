class DamTypeKrissM extends KFMod.KFProjectileWeaponDamageType
	abstract;

defaultproperties
{
	HeadShotDamageMult=1.0
    WeaponClass=Class'SnMod.KrissMMedicGun'
    DeathString="%k killed %o (Schneidzekk)."
    FemaleSuicide="%o shot herself in the foot."
    MaleSuicide="%o shot himself in the foot."

    // Make this bullet move the ragdoll when its shot
    bRagdollBullet=true
    KDamageImpulse=5500.000000
    KDeathVel=175.000000
    KDeathUpKick=15.000000
}
