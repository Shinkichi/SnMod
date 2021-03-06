class ZombieStalkerBase extends SnMonster
    abstract;

//#exec OBJ LOAD FILE=PlayerSounds.uax
#exec OBJ LOAD FILE=KFX.utx
#exec OBJ LOAD FILE=KF_BaseStalker.uax

var float NextCheckTime;
var KFHumanPawn LocalKFHumanPawn;
var float LastUncloakTime;

// Scales the health this Zed has by the difficulty level
function float DifficultyHealthModifer()
{
	local float AdjustedModifier;

	if ( Level.Game.GameDifficulty >= 2.0 )
	{
		AdjustedModifier = 1.0;
	}
	else //if ( GameDifficulty == 1.0 ) // Beginner
	{
		AdjustedModifier = 0.5;
	}

	return AdjustedModifier;
}

// Scales the head health this Zed has by the difficulty level
function float DifficultyHeadHealthModifer()
{
	local float AdjustedModifier;

	if ( Level.Game.GameDifficulty >= 2.0 )
	{
		AdjustedModifier = 1.0;
	}
	else //if ( GameDifficulty == 1.0 ) // Beginner
	{
		AdjustedModifier = 0.5;
	}

	return AdjustedModifier;
}

//-------------------------------------------------------------------------------
// NOTE: All Code resides in the child class(this class was only created to
//         eliminate hitching caused by loading default properties during play)
//-------------------------------------------------------------------------------

defaultproperties
{
    DrawScale=1.1
    Prepivot=(Z=5.0)

    MeleeAnims(0)="StalkerSpinAttack"
    MeleeAnims(1)="StalkerAttack1"
    MeleeAnims(2)="JumpAttack"
    MeleeDamage=9
    damageForce=5000
    ZombieDamType(0)=Class'KFMod.DamTypeSlashingAttack'
    ZombieDamType(1)=Class'KFMod.DamTypeSlashingAttack'
    ZombieDamType(2)=Class'KFMod.DamTypeSlashingAttack'

    ScoringValue=15
    SoundGroupClass=Class'KFMod.KFFemaleZombieSounds'
    IdleHeavyAnim="StalkerIdle"
    IdleRifleAnim="StalkerIdle"
    GroundSpeed=200.000000
    WaterSpeed=180.000000
    JumpZ=350.000000
    Health=100 // 120
    HealthMax=100 // 120
	HeadHealth=20//25
    MovementAnims(0)="ZombieRun"
    MovementAnims(1)="ZombieRun"
    MovementAnims(2)="ZombieRun"
    MovementAnims(3)="ZombieRun"
    WalkAnims(0)="ZombieRun"
    WalkAnims(1)="ZombieRun"
    WalkAnims(2)="ZombieRun"
    WalkAnims(3)="ZombieRun"
    IdleCrouchAnim="StalkerIdle"
    IdleWeaponAnim="StalkerIdle"
    IdleRestAnim="StalkerIdle"

    AmbientGlow=0
    CollisionRadius=26.000000
    RotationRate=(Yaw=45000,Roll=0)

    PuntAnim="ClotPunt"

    bCannibal=false
    MenuName="Stalker"
    KFRagdollName="Stalker_Trip"

	SeveredHeadAttachScale=1.0
	SeveredLegAttachScale=0.7
	SeveredArmAttachScale=0.8


	MeleeRange=30.000000
	HeadHeight=2.5
	HeadScale=1.1
	CrispUpThreshhold=10
	OnlineHeadshotOffset=(X=18,Y=0,Z=33)
	OnlineHeadshotScale=1.2
	MotionDetectorThreat=0.25
}
