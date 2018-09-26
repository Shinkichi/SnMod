
class DamTypeM7A3M extends KFMod.KFProjectileWeaponDamageType
	abstract;

defaultproperties
{
	HeadShotDamageMult=1.25
     WeaponClass=Class'SnMod.M7A3MMedicGun'
     DeathString="%k killed %o (M7A3)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."

     // Make this bullet move the ragdoll when its shot
     bRagdollBullet=True
     KDeathVel=185.000000
     KDamageImpulse=890.000000
     KDeathUpKick=4.000000
}
