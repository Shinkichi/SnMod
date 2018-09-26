class SnGameType extends KFGameType
	config;

defaultproperties
{
	GameName="Killing Floor : SnMod"
	Description="SnMod Gametype"
	
    MaxZombiesOnce=64//32
    StandardMaxZombiesOnce=64//32
	
    StartingCashBeginner=300
    StartingCashNormal=250
    StartingCashHard=250//200
    StartingCashSuicidal=200//0
    StartingCashHell=100//0

    MinRespawnCashBeginner=250
    MinRespawnCashNormal=200
    MinRespawnCashHard=200//150
    MinRespawnCashSuicidal=150//0
    MinRespawnCashHell=100//0

    TimeBetweenWavesBeginner=75//90
    TimeBetweenWavesNormal=75//60
    TimeBetweenWavesHard=75//60
    TimeBetweenWavesSuicidal=75//60
    TimeBetweenWavesHell=75//60
    
    SpecialEventMonsterCollections(0)=class'SnMod.SnMonstersCollection'
    SpecialEventMonsterCollections(1)=class'SnMod.SnMonstersSummer'
    SpecialEventMonsterCollections(2)=class'SnMod.SnMonstersHalloween'
    SpecialEventMonsterCollections(3)=class'SnMod.SnMonstersXmas'
}
