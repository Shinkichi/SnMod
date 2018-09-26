class ClawsFire extends KFMod.KnifeFire;

defaultproperties
{
	weaponRange=60.000000//70.000000
    FireAnims(0)="fire2"
    FireAnims(1)="fire2"
    FireAnims(2)="fire3"
    FireAnims(3)="fire3"
    MeleeDamage=20//19
    WideDamageMinHitAngle=0.75
    hitDamageClass=Class'SnMod.DamTypeClaws'
    FireRate=0.55//0.6
    BotRefireRate=0.55//0.6
    MeleeHitSounds(0)=Sound'KFWeaponSound.punch1'
    MeleeHitSounds(1)=Sound'KFWeaponSound.punch2'
    MeleeHitSounds(2)=Sound'KFWeaponSound.punch3'
	HitEffectClass=class'KFMeleeHitEffect'
}
