class LAWFire extends KFMod.LAWFire;

// Overridden to support interrupting the reload
simulated function bool AllowFire()
{
	if( KFWeapon(Weapon).bIsReloading && KFWeapon(Weapon).MagAmmoRemaining < 2)
		return false;

	if(KFPawn(Instigator).SecondaryItem!=none)
		return false;
	if( KFPawn(Instigator).bThrowingNade )
		return false;

	if( Level.TimeSeconds - LastClickTime>FireRate )
	{
		LastClickTime = Level.TimeSeconds;
	}

	if( KFWeaponShotgun(Weapon).MagAmmoRemaining<1 )
	{
    		return false;
	}

	return super(WeaponFire).AllowFire();
}

defaultproperties
{
    KickMomentum=(X=0,Z=0)
    FireRate=3.75//3.250000
    AmmoClass=Class'SnMod.LAWAmmo'
    ProjectileClass=Class'SnMod.LAWProj'
}
