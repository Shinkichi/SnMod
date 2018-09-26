class DamTypeClaws extends KFMod.DamTypeZombieAttack
	abstract;

defaultproperties
{
	HeadShotDamageMult=1.0
     WeaponClass=Class'SnMod.Knife'//Class'KFMod.Claws'
     DeathString="%o was mauled by ÿ%k."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     bBulletHit=True
     FlashFog=(X=600.000000)
     KDamageImpulse=3500.000000
     VehicleDamageScaling=0.700000
}
