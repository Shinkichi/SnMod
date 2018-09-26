class LAWProj extends KFMod.LAWProj;

defaultproperties
{
	ArmDistSquared=200000//250000
	Speed=2600.000000
	MaxSpeed=3000.000000
	Damage=600//950
	DamageRadius=500
	MyDamageType=Class'SnMod.DamTypeLAW'
	ImpactDamageType=Class'SnMod.DamTypeLawRocketImpact'
	ImpactDamage=300//200
	StaticMesh=StaticMesh'KillingFloorStatics.LAWRocket'
	ExplosionSound=Sound'KF_LAWSnd.Rocket_Explode'
	AmbientSound=Sound'KF_LAWSnd.Rocket_Propel'
	DisintegrateSound=Sound'Inf_Weapons.faust_explode_distant02'
}
