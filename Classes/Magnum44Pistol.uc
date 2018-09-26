class Magnum44Pistol extends KFMod.Magnum44Pistol;

function bool HandlePickupQuery( pickup Item )
{
    local int i;
    local class< KFWeaponPickup > KFWP, VariantPickupClass;
    local bool bInInventory;

    // check if Item and Self are the same weapon
    if( Item.InventoryType==Class )
    {
        bInInventory = true;
    }

    // check if Item is a variant of Self
    KFWP = class< KFWeaponPickup >( PickupClass );
    for( i = 0; i < KFWP.default.VariantClasses.Length && !bInInventory; ++i )
    {
        VariantPickupClass = class<KFWeaponPickup>(KFWP.default.VariantClasses[i]);
        if( Item.Class == VariantPickupClass )
        {
            bInInventory = true;
        }
    }

    // check if Self is a variant of Item
    KFWP = class< KFWeaponPickup >( Item.Class );
    if( KFWP != none )
    {
        for( i = 0; i < KFWP.default.VariantClasses.Length && !bInInventory; ++i )
        {
            VariantPickupClass = class<KFWeaponPickup>(KFWP.default.VariantClasses[i]);
            if( PickupClass == VariantPickupClass )
            {
                bInInventory = true;
            }
        }
    }

    if( bInInventory )
	{
		if( LastHasGunMsgTime<Level.TimeSeconds && PlayerController(Instigator.Controller)!=none )
		{
			LastHasGunMsgTime = Level.TimeSeconds+0.5;
			PlayerController(Instigator.Controller).ReceiveLocalizedMessage(Class'KFMainMessages',1);
		}
		return true;
	}
	return Super.HandlePickupQuery(Item);
}

simulated function bool PutDown()
{
	local int Mode;

	InterruptReload();

	if ( bIsReloading )
		return false;

	if( bAimingRifle )
	{
		ZoomOut(False);
	}

	// From Weapon.uc
	if (ClientState == WS_BringUp || ClientState == WS_ReadyToFire)
	{
		if ( (Instigator.PendingWeapon != None) && !Instigator.PendingWeapon.bForceSwitch )
		{
			for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
			{
		    	// if _RO_
				if( FireMode[Mode] == none )
					continue;
				// End _RO_

				if ( FireMode[Mode].bFireOnRelease && FireMode[Mode].bIsFiring )
					return false;
				if ( FireMode[Mode].NextFireTime > Level.TimeSeconds + FireMode[Mode].FireRate*(1.f - MinReloadPct))
					DownDelay = FMax(DownDelay, FireMode[Mode].NextFireTime - Level.TimeSeconds - FireMode[Mode].FireRate*(1.f - MinReloadPct));
			}
		}

		if (Instigator.IsLocallyControlled())
		{
			for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
			{
		    	// if _RO_
				if( FireMode[Mode] == none )
					continue;
				// End _RO_

				if ( FireMode[Mode].bIsFiring )
					ClientStopFire(Mode);
			}

            if (  DownDelay <= 0  || KFPawn(Instigator).bIsQuickHealing > 0)
            {
				if ( ClientState == WS_BringUp || KFPawn(Instigator).bIsQuickHealing > 0 )
					TweenAnim(SelectAnim,PutDownTime);
				else if ( HasAnim(PutDownAnim) )
				{
					if( ClientGrenadeState == GN_TempDown || KFPawn(Instigator).bIsQuickHealing > 0)
                    {
                       PlayAnim(PutDownAnim, PutDownAnimRate * (PutDownTime/QuickPutDownTime), 0.0);
                	}
                	else
                	{
                	   PlayAnim(PutDownAnim, PutDownAnimRate, 0.0);
                	}

				}
			}
        }
		ClientState = WS_PutDown;
		if ( Level.GRI.bFastWeaponSwitching )
			DownDelay = 0;
		if ( DownDelay > 0 )
		{
			SetTimer(DownDelay, false);
		}
		else
		{
			if( ClientGrenadeState == GN_TempDown )
			{
			   SetTimer(QuickPutDownTime, false);
			}
			else
			{
			   SetTimer(PutDownTime, false);
			}
		}
	}
	for (Mode = 0; Mode < NUM_FIRE_MODES; Mode++)
	{
		// if _RO_
		if( FireMode[Mode] == none )
			continue;
		// End _RO_

		FireMode[Mode].bServerDelayStartFire = false;
		FireMode[Mode].bServerDelayStopFire = false;
	}
	Instigator.AmbientSound = None;
	OldWeapon = None;
	return true; // return false if preventing weapon switch
}

defaultproperties
{
    Weight=3.000000//2.000000
    FireModeClass(0)=Class'SnMod.Magnum44Fire'
    PickupClass=Class'SnMod.Magnum44Pickup'
    ItemName="44 Magnum SN"
}
