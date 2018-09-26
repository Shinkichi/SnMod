class BaseWeaponFire extends KFMod.KFShotgunFire;

var()           class<Emitter>  ShellEjectClass;            // class of the shell eject emitter
var()           Emitter         ShellEjectEmitter;          // The shell eject emitter
var()           name            ShellEjectBoneName;         // name of the shell eject bone

simulated function bool AllowFire()
{
	if(KFWeapon(Weapon).bIsReloading)
		return false;
	if(KFPawn(Instigator).SecondaryItem!=none)
		return false;
	if(KFPawn(Instigator).bThrowingNade)
		return false;

	if(KFWeapon(Weapon).MagAmmoRemaining < 1)
	{
    	if( Level.TimeSeconds - LastClickTime>FireRate )
    	{
    		LastClickTime = Level.TimeSeconds;
    	}

		if( AIController(Instigator.Controller)!=None )
			KFWeapon(Weapon).ReloadMeNow();
		return false;
	}

    //log("Spread = "$Spread);

	return super(WeaponFire).AllowFire();
}

simulated function DestroyEffects()
{
    super.DestroyEffects();

    if (ShellEjectEmitter != None)
        ShellEjectEmitter.Destroy();
}

simulated function InitEffects()
{
    super.InitEffects();

    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
    if ( (ShellEjectClass != None) && ((ShellEjectEmitter == None) || ShellEjectEmitter.bDeleteMe) )
    {
        ShellEjectEmitter = Weapon.Spawn(ShellEjectClass);
        Weapon.AttachToBone(ShellEjectEmitter, ShellEjectBoneName);
    }

    if ( FlashEmitter != None )
        Weapon.AttachToBone(FlashEmitter, KFWeapon(Weapon).FlashBoneName);
}

function DrawMuzzleFlash(Canvas Canvas)
{
    super.DrawMuzzleFlash(Canvas);
    // Draw smoke first
    if (ShellEjectEmitter != None )
    {
        Canvas.DrawActor( ShellEjectEmitter, false, false, Weapon.DisplayFOV );
    }
}

function FlashMuzzleFlash()
{
    super.FlashMuzzleFlash();

    if (ShellEjectEmitter != None)
    {
        //ShellEjectEmitter.SpawnParticle(1);//Trigger(Weapon, Instigator);
        ShellEjectEmitter.Trigger(Weapon, Instigator);
    }
}

defaultproperties
{
    ProjectileClass=Class'SnMod.BaseWeaponBullet'
    ProjPerFire=1
	//ShellEjectClass=class'KFMod.KFShellEjectFAL'
	//ShellEjectBoneName=Shell_eject
}