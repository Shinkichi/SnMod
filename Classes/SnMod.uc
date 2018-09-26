// Editing - by Shinkichi
class SnMod extends Mutator;

//------------------------------------------------------------------------------
// Original code - by ScrnBalance.uc (copyright - [ScrN]PooSH)
//------------------------------------------------------------------------------

struct SPickupReplacement 
{
    var class<Pickup> oldClass;
    var class<Pickup> newClass;
};
var array<SPickupReplacement> pickupReplaceArray;
var const int FragReplacementIndex;
var globalconfig bool bReplacePickups, bReplacePickupsStory;

var bool bStoryMode; // Objective Game mode (KFStoryGameInfo)

var const string BonusCapGroup;

//------------------------------------------------------------------------------
// Original code - by KFModsInit.uc (copyright - Z-MAN)
//------------------------------------------------------------------------------

var() globalconfig array<string> PackageList;

function PostBeginPlay()
{
	local int i;

	// -----------------------------------------------------
	// Start - Added code from CustomSpawnFixMut.uc
	// -----------------------------------------------------
	/*local ACTION_SpawnActor A;
	
	foreach AllObjects(class'ACTION_SpawnActor', A)
	{
		if( A.ActorClass==Class'ZombieBloat' )
			A.ActorClass = Class'SnChar.ZombieBloat_STANDARD';
		else if( A.ActorClass==Class'ZombieClot' )
			A.ActorClass = Class'SnChar.ZombieClot_STANDARD';
		else if( A.ActorClass==Class'ZombieCrawler' )
			A.ActorClass = Class'SnChar.ZombieCrawler_STANDARD';
		else if( A.ActorClass==Class'ZombieFleshpound' )
			A.ActorClass = Class'SnChar.ZombieFleshpound_STANDARD';
		else if( A.ActorClass==Class'ZombieGorefast' )
			A.ActorClass = Class'SnChar.ZombieGorefast_STANDARD';
		else if( A.ActorClass==Class'ZombieHusk' )
			A.ActorClass = Class'SnChar.ZombieHusk_STANDARD';
		else if( A.ActorClass==Class'ZombieScrake' )
			A.ActorClass = Class'SnChar.ZombieScrake_STANDARD';
		else if( A.ActorClass==Class'ZombieSiren' )
			A.ActorClass = Class'SnChar.ZombieSiren_STANDARD';
		else if( A.ActorClass==Class'ZombieStalker' )
			A.ActorClass = Class'SnChar.ZombieStalker_STANDARD';
		else if( A.ActorClass==Class'KFChar.ZombieBoss' )
			A.ActorClass = Class'SnChar.ZombieBoss_STANDARD';
	}*/
	// -----------------------------------------------------
	// End - Added code from CustomSpawnFixMut.uc
	// -----------------------------------------------------

	for( i=0; i<PackageList.Length; i++ )
	{
		if( PackageList[i] != "" )
			AddToPackageMap( PackageList[i] );
	}

	SetTimer(0.1,False);
}

function Timer()
{
	local KFGameType KF;
	local int i;

	KF = KFGameType(Level.Game);
	if ( KF!=None )
	{
		if( Level.NetMode==NM_DedicatedServer )
		{
			Class'KFMod.KFLevelRules'.default.WaveSpawnPeriod = 0;
			Class'KFMod.KFGameType'.default.MaxZombiesOnce = 72;

			// MinDistanceToPlayer default change (short).
			for( i=0; i<KF.ZedSpawnList.Length; i++ )
			{
				if (KF.ZedSpawnList[i].MinDistanceToPlayer>=300.000000)
					KF.ZedSpawnList[i].MinDistanceToPlayer = 200.000000;
			}
		}

	}

	Destroy();
}

//------------------------------------------------------------------------------
// Original code - by ScrnBalance.uc (copyright - [ScrN]PooSH)
//------------------------------------------------------------------------------

static function FillPlayInfo(PlayInfo PlayInfo)
{
    PlayInfo.AddSetting(default.BonusCapGroup,"bReplacePickups","Replace Pickups",1,0, "Check");
    PlayInfo.AddSetting(default.BonusCapGroup,"bReplacePickupsStory","Replace Pickups (Story)",1,0, "Check");
}

static function string GetDescriptionText(string PropName)
{
    switch (PropName)
    {
        case "bReplacePickups":             return "Replaces weapon pickups on a map with their Scrn Editon (SE) versions.";
        case "bReplacePickupsStory":        return "Replaces weapon pickups in Objective Mode with their Scrn Editon (SE) versions.";    }
    return Super.GetDescriptionText(PropName);
}

function SetupStoryRules(KFLevelRules_Story StoryRules)
{
    local int i,j;
    local Class<Inventory> OldInv;

    for( i=0; i<StoryRules.RequiredPlayerEquipment.Length; ++i ) {
        OldInv = StoryRules.RequiredPlayerEquipment[i];
        for ( j=0; j<pickupReplaceArray.length; ++j ) {
            if ( pickupReplaceArray[j].oldClass.default.InventoryType == OldInv ) {
                StoryRules.RequiredPlayerEquipment[i] = pickupReplaceArray[j].NewClass.default.InventoryType;
                break;
            }
        }
    }
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
    local int i;
    //Log("CheckReplacement: " $ String(Other), 'SnMod');

    // first check classes that need to be replaced
    if ( Other.class == class'KFRandomItemSpawn' ) {
        if ( !bReplacePickups )
            return true;
        ReplaceWith(Other, "SnMod.SnRandomItemSpawn");
        return false;
    }
    /*else if ( Other.class == class'KFAmmoPickup' ) {
        AmmoBoxMesh = Other.StaticMesh;
        AmmoBoxDrawScale = Other.DrawScale;
        AmmoBoxDrawScale3D = Other.DrawScale3D;
        ReplaceWith(Other, "ScrnBalanceSrv.ScrnAmmoPickup");
        return false;
    }*/
    else if ( Pickup(Other) != none ) {
        // don't replace pickups placed on the map by the author - replace only dropped ones
        // or spawned by KFRandomItemSpawn
        i = FindPickupReplacementIndex(Pickup(Other));
        if ( i != -1 ) {
            ReplaceWith(Other, string(pickupReplaceArray[i].NewClass));
            return false;
        }
        return true; // no need to replace
    }


    // classes below do not need replacement
    /*if ( PlayerController(Other)!=None ) {
        if ( ScrnPlayerController(Other) != none )
            ScrnPlayerController(Other).Mut = self;
    }
    else if ( KFMonster(Other) != none ) {
        // harder zapping
        if ( ZombieFleshPound(Other) != none )
            KFMonster(Other).ZapThreshold = 3.75;
        else if ( KFMonster(Other).default.Health >= 1000 )
            KFMonster(Other).ZapThreshold = 1.75;

        GameRules.RegisterMonster(KFMonster(Other));
    }
    else if ( SRStatsBase(Other) != none ) {
        SetupRepLink(SRStatsBase(Other).Rep);
    }
    else if ( Other.class == class'ScrnAmmoPickup' ) {
        Other.SetStaticMesh(AmmoBoxMesh);
        Other.SetDrawScale(AmmoBoxDrawScale);
        Other.SetDrawScale3D(AmmoBoxDrawScale3D);
    }*/
    else if ( bStoryMode ) 
    {
        if ( KFLevelRules_Story(Other) != none  ) 
        {
            if ( bReplacePickupsStory )
                SetupStoryRules(KFLevelRules_Story(Other));
        }
        /*else if ( KF_StoryNPC(Other) != none )
        {
            if ( Other.class == class'KF_BreakerBoxNPC' ) // don't alter subclasses
                KF_StoryNPC(Other).BaseAIThreatRating = 20;
            else if ( Other.class == class'KF_RingMasterNPC' )
                KF_StoryNPC(Other).BaseAIThreatRating = 40;
        }*/
    }

    return true;
}

function bool ShouldReplacePickups()
{
    if ( bStoryMode )
        return bReplacePickupsStory;

    return bReplacePickups;
}

// replaces weapon pickup's inventory type with ScrN version of that weapon
// returns true of replacement was made
function bool ReplacePickup( Pickup item )
{
    local int i;

    /*if ( FragPickup(item) != none ) {
        if ( !bReplaceNades || ScrnFragPickup(item) != none )
            return false;

        i = FragReplacementIndex; // index of frag replacement
    }
    else {
        if ( !ShouldReplacePickups() )
            return false;
        i = FindPickupReplacementIndex(item);
        if ( i == -1 )
            return false;
    }*/
    item.InventoryType = pickupReplaceArray[i].NewClass.default.InventoryType;
    item.default.InventoryType = pickupReplaceArray[i].NewClass.default.InventoryType; // pistols reset they inventory type to default
    if ( KFWeaponPickup(item) != none ) {
        KFWeaponPickup(item).Weight = class<KFWeaponPickup>(pickupReplaceArray[i].NewClass).default.Weight;
        KFWeaponPickup(item).default.Weight = class<KFWeaponPickup>(pickupReplaceArray[i].NewClass).default.Weight;
    }
    return true;
}

// returns -1, if not found
function int FindPickupReplacementIndex( Pickup item )
{
    local int i;

    for ( i=0; i<pickupReplaceArray.length; ++i ) {
        if ( pickupReplaceArray[i].oldClass == item.class )
            return i;
    }
    return -1;
}

defaultproperties
{
     bReplacePickups=True
     bReplacePickupsStory=True
     pickupReplaceArray(0)=(oldClass=Class'KFMod.MP7MPickup',NewClass=Class'SnMod.MP7MPickup')
     pickupReplaceArray(1)=(oldClass=Class'KFMod.MP5MPickup',NewClass=Class'SnMod.MP5MPickup')
     pickupReplaceArray(2)=(oldClass=Class'KFMod.KrissMPickup',NewClass=Class'SnMod.KrissMPickup')
     pickupReplaceArray(3)=(oldClass=Class'KFMod.M7A3MPickup',NewClass=Class'SnMod.M7A3MPickup')
     pickupReplaceArray(4)=(oldClass=Class'KFMod.ShotgunPickup',NewClass=Class'SnMod.ShotgunPickup')
     pickupReplaceArray(5)=(oldClass=Class'KFMod.BoomStickPickup',NewClass=Class'SnMod.BoomStickPickup')
     pickupReplaceArray(6)=(oldClass=Class'KFMod.NailGunPickup',NewClass=Class'SnMod.NailGunPickup')
     pickupReplaceArray(7)=(oldClass=Class'KFMod.KSGPickup',NewClass=Class'SnMod.KSGPickup')
     pickupReplaceArray(8)=(oldClass=Class'KFMod.BenelliPickup',NewClass=Class'SnMod.BenelliPickup')
     pickupReplaceArray(9)=(oldClass=Class'KFMod.AA12Pickup',NewClass=Class'SnMod.AA12Pickup')
     pickupReplaceArray(10)=(oldClass=Class'KFMod.SinglePickup',NewClass=Class'SnMod.DualiesPickup')
     pickupReplaceArray(11)=(oldClass=Class'KFMod.Magnum44Pickup',NewClass=Class'SnMod.Dual44MagnumPickup')
     pickupReplaceArray(12)=(oldClass=Class'KFMod.MK23Pickup',NewClass=Class'SnMod.DualMK23Pickup')
     pickupReplaceArray(13)=(oldClass=Class'KFMod.DeaglePickup',NewClass=Class'SnMod.DualDeaglePickup')
     pickupReplaceArray(14)=(oldClass=Class'KFMod.WinchesterPickup',NewClass=Class'SnMod.WinchesterPickup')
     pickupReplaceArray(15)=(oldClass=Class'KFMod.SPSniperPickup',NewClass=Class'SnMod.SPSniperPickup')
     pickupReplaceArray(16)=(oldClass=Class'KFMod.M14EBRPickup',NewClass=Class'SnMod.M14EBRPickup')
     pickupReplaceArray(17)=(oldClass=Class'KFMod.M99Pickup',NewClass=Class'SnMod.M99Pickup')
     pickupReplaceArray(18)=(oldClass=Class'KFMod.BullpupPickup',NewClass=Class'SnMod.BullpupPickup')
     pickupReplaceArray(19)=(oldClass=Class'KFMod.AK47Pickup',NewClass=Class'SnMod.AK47Pickup')
     pickupReplaceArray(20)=(oldClass=Class'KFMod.M4Pickup',NewClass=Class'SnMod.M4Pickup')
     pickupReplaceArray(21)=(oldClass=Class'KFMod.SPThompsonPickup',NewClass=Class'SnMod.ThompsonPickup') // ThompsonPickup
     pickupReplaceArray(22)=(oldClass=Class'KFMod.ThompsonDrumPickup',NewClass=Class'SnMod.ThompsonPickup') // ThompsonPickup
     pickupReplaceArray(23)=(oldClass=Class'KFMod.SCARMK17Pickup',NewClass=Class'SnMod.SCARMK17Pickup')
     pickupReplaceArray(24)=(oldClass=Class'KFMod.FNFAL_ACOG_Pickup',NewClass=Class'SnMod.FNFAL_ACOG_Pickup')
     pickupReplaceArray(25)=(oldClass=Class'KFMod.MachetePickup',NewClass=Class'SnMod.MachetePickup')
     pickupReplaceArray(26)=(oldClass=Class'KFMod.AxePickup',NewClass=Class'SnMod.AxePickup')
     pickupReplaceArray(27)=(oldClass=Class'KFMod.ChainsawPickup',NewClass=Class'SnMod.ChainsawPickup')
     pickupReplaceArray(28)=(oldClass=Class'KFMod.KatanaPickup',NewClass=Class'SnMod.KatanaPickup')
     pickupReplaceArray(29)=(oldClass=Class'KFMod.ScythePickup',NewClass=Class'SnMod.ScythePickup')
     pickupReplaceArray(30)=(oldClass=Class'KFMod.ClaymoreSwordPickup',NewClass=Class'SnMod.ClaymoreSwordPickup')
     pickupReplaceArray(31)=(oldClass=Class'KFMod.CrossbuzzsawPickup',NewClass=Class'SnMod.CrossbuzzsawPickup')
     pickupReplaceArray(32)=(oldClass=Class'KFMod.MAC10Pickup',NewClass=Class'SnMod.MAC10Pickup')
     pickupReplaceArray(33)=(oldClass=Class'KFMod.FlareRevolverPickup',NewClass=Class'SnMod.FlareRevolverPickup')
     pickupReplaceArray(34)=(oldClass=Class'KFMod.DualFlareRevolverPickup',NewClass=Class'SnMod.DualFlareRevolverPickup')
     pickupReplaceArray(35)=(oldClass=Class'KFMod.FlameThrowerPickup',NewClass=Class'SnMod.FlameThrowerPickup')
     pickupReplaceArray(36)=(oldClass=Class'KFMod.HuskGunPickup',NewClass=Class'SnMod.HuskGunPickup')
     pickupReplaceArray(37)=(oldClass=Class'KFMod.PipeBombPickup',NewClass=Class'SnMod.PipeBombPickup')
     pickupReplaceArray(38)=(oldClass=Class'KFMod.M4203Pickup',NewClass=Class'SnMod.M4203Pickup')
     pickupReplaceArray(39)=(oldClass=Class'KFMod.M32Pickup',NewClass=Class'SnMod.M32Pickup')
     pickupReplaceArray(40)=(oldClass=Class'KFMod.LAWPickup',NewClass=Class'SnMod.LAWPickup')
     pickupReplaceArray(41)=(oldClass=Class'KFMod.Dual44MagnumPickup',NewClass=Class'SnMod.Dual44MagnumPickup')
     pickupReplaceArray(42)=(oldClass=Class'KFMod.DualMK23Pickup',NewClass=Class'SnMod.DualMK23Pickup')
     pickupReplaceArray(43)=(oldClass=Class'KFMod.DualDeaglePickup',NewClass=Class'SnMod.DualDeaglePickup')
     pickupReplaceArray(44)=(oldClass=Class'KFMod.SyringePickup',NewClass=Class'SnMod.SyringePickup')
     pickupReplaceArray(45)=(oldClass=Class'KFMod.FragPickup',NewClass=Class'SnMod.FragPickup')
     pickupReplaceArray(46)=(oldClass=Class'KFMod.M79Pickup',NewClass=Class'SnMod.M79Pickup')
     pickupReplaceArray(47)=(oldClass=Class'KFMod.CrossbowPickup',NewClass=Class'SnMod.CrossbowPickup')
     pickupReplaceArray(49)=(oldClass=Class'KFMod.KnifePickup',NewClass=Class'SnMod.KnifePickup')
     pickupReplaceArray(50)=(oldClass=Class'KFMod.ZEDGunPickup',NewClass=Class'SnMod.ZEDGunPickup')
     pickupReplaceArray(51)=(oldClass=Class'KFMod.ZEDMKIIPickup',NewClass=Class'SnMod.ZEDMKIIPickup')
     pickupReplaceArray(52)=(oldClass=Class'KFMod.SPShotgunPickup',NewClass=Class'SnMod.SPShotgunPickup')
     pickupReplaceArray(53)=(oldClass=Class'KFMod.SPGrenadePickup',NewClass=Class'SnMod.SPGrenadePickup')
     pickupReplaceArray(54)=(oldClass=Class'KFMod.SealSquealPickup',NewClass=Class'SnMod.SealSquealPickup')
     pickupReplaceArray(55)=(oldClass=Class'KFMod.SeekerSixPickup',NewClass=Class'SnMod.SeekerSixPickup')
     pickupReplaceArray(56)=(oldClass=Class'KFMod.WelderPickup',NewClass=Class'SnMod.WelderPickup') // WelderPickup
     pickupReplaceArray(57)=(oldClass=Class'KFMod.ThompsonPickup',NewClass=Class'SnMod.ThompsonPickup')
     pickupReplaceArray(58)=(oldClass=Class'KFMod.BlowerThrowerPickup',NewClass=Class'SnMod.BlowerThrowerPickup')
     pickupReplaceArray(59)=(oldClass=Class'KFMod.DualiesPickup',NewClass=Class'SnMod.DualiesPickup')
     pickupReplaceArray(60)=(oldClass=Class'KFMod.DwarfAxePickup',NewClass=Class'SnMod.DwarfAxePickup')
     pickupReplaceArray(61)=(oldClass=Class'KFMod.TrenchgunPickup',NewClass=Class'SnMod.TrenchgunPickup')
     pickupReplaceArray(62)=(oldClass=Class'KFMod.BatPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(63)=(oldClass=Class'KFMod.CamoShotgunPickup',NewClass=Class'SnMod.ShotgunPickup') //
     pickupReplaceArray(64)=(oldClass=Class'KFMod.CamoMP5MPickup',NewClass=Class'SnMod.MP5MPickup') //
     pickupReplaceArray(65)=(oldClass=Class'KFMod.CamoM32Pickup',NewClass=Class'SnMod.M32Pickup') //
     pickupReplaceArray(66)=(oldClass=Class'KFMod.CamoM4Pickup',NewClass=Class'SnMod.M4Pickup') //
     pickupReplaceArray(67)=(oldClass=Class'KFMod.GoldenDualDeaglePickup',NewClass=Class'SnMod.DualDeaglePickup') //
     pickupReplaceArray(68)=(oldClass=Class'KFMod.GoldenDeaglePickup',NewClass=Class'SnMod.DualDeaglePickup') //
     pickupReplaceArray(69)=(oldClass=Class'KFMod.GoldenBenelliPickup',NewClass=Class'SnMod.BenelliPickup') //
     pickupReplaceArray(70)=(oldClass=Class'KFMod.GoldenM79Pickup',NewClass=Class'SnMod.M79Pickup') //
     pickupReplaceArray(71)=(oldClass=Class'KFMod.GoldenKatanaPickup',NewClass=Class'SnMod.KatanaPickup') //
     pickupReplaceArray(72)=(oldClass=Class'KFMod.GoldenChainsawPickup',NewClass=Class'SnMod.ChainsawPickup') //
     pickupReplaceArray(73)=(oldClass=Class'KFMod.GoldenAK47pickup',NewClass=Class'SnMod.AK47pickup') //
     pickupReplaceArray(74)=(oldClass=Class'KFMod.GoldenAA12Pickup',NewClass=Class'SnMod.AA12Pickup') //
     pickupReplaceArray(75)=(oldClass=Class'KFMod.GoldenFTPickup',NewClass=Class'SnMod.FlameThrowerPickup') //
     pickupReplaceArray(76)=(oldClass=Class'KFMod.NeonSCARMK17Pickup',NewClass=Class'SnMod.SCARMK17Pickup') //
     pickupReplaceArray(77)=(oldClass=Class'KFMod.NeonKrissMPickup',NewClass=Class'SnMod.KrissMPickup') //
     pickupReplaceArray(78)=(oldClass=Class'KFMod.NeonKSGPickup',NewClass=Class'SnMod.KSGPickup') //
     pickupReplaceArray(79)=(oldClass=Class'KFMod.NeonAK47Pickup',NewClass=Class'SnMod.AK47Pickup') //
     pickupReplaceArray(80)=(oldClass=Class'KFMod.ClawsPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     
     /* backup
     pickupReplaceArray(0)=(oldClass=Class'KFMod.MP7MPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(1)=(oldClass=Class'KFMod.MP5MPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(2)=(oldClass=Class'KFMod.KrissMPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(3)=(oldClass=Class'KFMod.M7A3MPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(4)=(oldClass=Class'KFMod.ShotgunPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(5)=(oldClass=Class'KFMod.BoomStickPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(6)=(oldClass=Class'KFMod.NailGunPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(7)=(oldClass=Class'KFMod.KSGPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(8)=(oldClass=Class'KFMod.BenelliPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(9)=(oldClass=Class'KFMod.AA12Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(10)=(oldClass=Class'KFMod.SinglePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(11)=(oldClass=Class'KFMod.Magnum44Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(12)=(oldClass=Class'KFMod.MK23Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(13)=(oldClass=Class'KFMod.DeaglePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(14)=(oldClass=Class'KFMod.WinchesterPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(15)=(oldClass=Class'KFMod.SPSniperPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(16)=(oldClass=Class'KFMod.M14EBRPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(17)=(oldClass=Class'KFMod.M99Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(18)=(oldClass=Class'KFMod.BullpupPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(19)=(oldClass=Class'KFMod.AK47Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(20)=(oldClass=Class'KFMod.M4Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(21)=(oldClass=Class'KFMod.SPThompsonPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(22)=(oldClass=Class'KFMod.ThompsonDrumPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(23)=(oldClass=Class'KFMod.SCARMK17Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(24)=(oldClass=Class'KFMod.FNFAL_ACOG_Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(25)=(oldClass=Class'KFMod.MachetePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(26)=(oldClass=Class'KFMod.AxePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(27)=(oldClass=Class'KFMod.ChainsawPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(28)=(oldClass=Class'KFMod.KatanaPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(29)=(oldClass=Class'KFMod.ScythePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(30)=(oldClass=Class'KFMod.ClaymoreSwordPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(31)=(oldClass=Class'KFMod.CrossbuzzsawPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(32)=(oldClass=Class'KFMod.MAC10Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(33)=(oldClass=Class'KFMod.FlareRevolverPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(34)=(oldClass=Class'KFMod.DualFlareRevolverPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(35)=(oldClass=Class'KFMod.FlameThrowerPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(36)=(oldClass=Class'KFMod.HuskGunPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(37)=(oldClass=Class'KFMod.PipeBombPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(38)=(oldClass=Class'KFMod.M4203Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(39)=(oldClass=Class'KFMod.M32Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(40)=(oldClass=Class'KFMod.LAWPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(41)=(oldClass=Class'KFMod.Dual44MagnumPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(42)=(oldClass=Class'KFMod.DualMK23Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(43)=(oldClass=Class'KFMod.DualDeaglePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(44)=(oldClass=Class'KFMod.SyringePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(45)=(oldClass=Class'KFMod.FragPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(46)=(oldClass=Class'KFMod.M79Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(47)=(oldClass=Class'KFMod.CrossbowPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(48)=(oldClass=Class'KFMod.KnifePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(50)=(oldClass=Class'KFMod.ZEDGunPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(51)=(oldClass=Class'KFMod.ZEDMKIIPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(52)=(oldClass=Class'KFMod.SPShotgunPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(53)=(oldClass=Class'KFMod.SPGrenadePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(54)=(oldClass=Class'KFMod.SealSquealPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(55)=(oldClass=Class'KFMod.SeekerSixPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(56)=(oldClass=Class'KFMod.WelderPickup',NewClass=Class'KFStoryGame.CashPickup_Story') // Test
     pickupReplaceArray(57)=(oldClass=Class'KFMod.ThompsonPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(58)=(oldClass=Class'KFMod.BlowerThrowerPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(59)=(oldClass=Class'KFMod.DualiesPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(60)=(oldClass=Class'KFMod.DwarfAxePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(61)=(oldClass=Class'KFMod.TrenchgunPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(62)=(oldClass=Class'KFMod.BatPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(63)=(oldClass=Class'KFMod.CamoShotgunPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(64)=(oldClass=Class'KFMod.CamoMP5MPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(65)=(oldClass=Class'KFMod.CamoM32Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(66)=(oldClass=Class'KFMod.CamoM4Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(67)=(oldClass=Class'KFMod.GoldenDualDeaglePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(68)=(oldClass=Class'KFMod.GoldenDeaglePickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(69)=(oldClass=Class'KFMod.GoldenBenelliPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(70)=(oldClass=Class'KFMod.GoldenM79Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(71)=(oldClass=Class'KFMod.GoldenKatanaPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(72)=(oldClass=Class'KFMod.GoldenChainsawPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(73)=(oldClass=Class'KFMod.GoldenAK47pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(74)=(oldClass=Class'KFMod.GoldenAA12Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(75)=(oldClass=Class'KFMod.GoldenFTPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(76)=(oldClass=Class'KFMod.NeonSCARMK17Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(77)=(oldClass=Class'KFMod.NeonKrissMPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(78)=(oldClass=Class'KFMod.NeonKSGPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(79)=(oldClass=Class'KFMod.NeonAK47Pickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     pickupReplaceArray(80)=(oldClass=Class'KFMod.ClawsPickup',NewClass=Class'KFStoryGame.CashPickup_Story')
     */
     
     bAddToServerPackages=True
     GroupName="KF-SnMod"
     FriendlyName="SnMod"
     Description="SnMod (Input initial command, etc)"
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}