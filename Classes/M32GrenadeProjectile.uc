class M32GrenadeProjectile extends KFMod.M32GrenadeProjectile;

defaultproperties
{
    ArmDistSquared=90000 // 6 meters
    Speed=8000.000000
    MaxSpeed=8000.000000
    Damage=225//350
    DamageRadius=400
    MyDamageType=Class'SnMod.DamTypeM32Grenade'
    ImpactDamageType=Class'SnMod.DamTypeM79GrenadeImpact'
    ImpactDamage=150//200
    StaticMesh=StaticMesh'kf_generic_sm.40mm_Warhead'
    ExplosionSound=Sound'KF_GrenadeSnd.Nade_Explode_1'
    DisintegrateSound=Sound'Inf_Weapons.faust_explode_distant02'
}
