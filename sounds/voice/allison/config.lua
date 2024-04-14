return {

    -- Commanders
    ['EnemyCommanderDied'] = {
       sound = {
           [1] = {
               file = 'EnemyCommanderDied.wav',
               text = 'tips.notifications.enemyCommanderDied',
           },
       },
       length = 1.7,
       delay = 1,
    },
    ['FriendlyCommanderDied'] = {
       sound = {
           [1] = {
               file = 'FriendlyCommanderDied.wav',
               text = 'tips.notifications.friendlyCommanderDied',
           },
       },
       length = 1.75,
       delay = 1,
    },
    ['FriendlyCommanderSelfD'] = {
       sound = {
           [1] = {
               file = 'AlliedComSelfD.wav',
               text = 'tips.notifications.friendlyCommanderSelfD',
           },
       },
       length = 2,
       delay = 1,
    },
    ['ComHeavyDamage'] = {
       sound = {
           [1] = {
               file = 'ComHeavyDamage.wav',
               text = 'tips.notifications.commanderDamage',
           },
       },
       length = 2.25,
       delay = 12,
    },
    ['TeamDownLastCommander'] = {
       sound = {
           [1] = {
               file = 'Teamdownlastcommander.wav',
               text = 'tips.notifications.teamdownlastcommander',
           },
       },
       length = 3,
       delay = 30,
    },
    ['YouHaveLastCommander'] = {
       sound = {
           [1] = {
               file = 'Youhavelastcommander.wav',
               text = 'tips.notifications.youhavelastcommander',
           },
       },
       length = 3,
       delay = 30,
    },

    -- Game Status


    ['ChooseStartLoc'] = {
       sound = {
           [1] = {
               file = 'ChooseStartLoc.wav',
               text = 'tips.notifications.startingLocation',
           },
       },
       length = 2.2,
       delay = 90,
    },
    ['GameStarted'] = {
       sound = {
           [1] = {
               file = 'GameStarted.wav',
               text = 'tips.notifications.gameStarted',
           },
       },
       length = 2,
       delay = 1,
    },
    ['BattleEnded'] = {
       sound = {
           [1] = {
               file = 'BattleEnded.wav',
               text = 'tips.notifications.battleEnded',
           },
       },
       length = 2,
       delay = 1,
    },
    ['GamePause'] = {
       sound = {
           [1] = {
               file = 'GamePause.wav',
               text = 'tips.notifications.gamePaused',
           },
       },
       length = 1,
       delay = 5,
    },
    ['PlayerLeft'] = {
       sound = {
           [1] = {
               file = 'PlayerDisconnected.wav',
               text = 'tips.notifications.playerLeft',
           },
       },
       length = 1.65,
       delay = 1,
    },
    ['PlayerAdded'] = {
       sound = {
           [1] = {
               file = 'PlayerAdded.wav',
               text = 'tips.notifications.playerAdded',
           },
       },
       length = 2.36,
       delay = 1,
    },
    ['PlayerResigned'] = {
       sound = {
           [1] = {
               file = 'PlayerResigned.wav',
               text = 'tips.notifications.playerResigned',
           },
       },
       length = 2.36,
       delay = 1,
    },
    ['PlayerTimedout'] = {
       sound = {
           [1] = {
               file = 'PlayerTimedout.wav',
               text = 'tips.notifications.playerTimedout',
           },
       },
       length = 2.36,
       delay = 1,
    },
    ['PlayerReconnecting'] = {
       sound = {
           [1] = {
               file = 'PlayerTimedout.wav',
               text = 'tips.notifications.playerReconnecting',
           },
       },
       length = 2.36,
       delay = 1,
    },
    ['RaptorsAndScavsMixed'] = {
        sound = {
            [1] = {
                file = 'RaptorsAndScavsMixed.wav',
                text = 'tips.notifications.raptorsAndScavsMixed',
            },
        },
        length = 12.8,
        delay = 15,
    },

    -- Awareness


	['MaxUnitsReached'] = {
		sound = {
			[1] = {
				--file = 'MaxUnitsReached.wav',
				text = 'tips.notifications.maxUnitsReached',
			},
		},
		length = 3,
		delay = 90,
	},
    ['UnitsReceived'] = {
       sound = {
           [1] = {
               file = 'UnitReceived.wav',
               text = 'tips.notifications.unitsReceived',
           },
       },
       length = 1.75,
       delay = 5,
    },
    ['RadarLost'] = {
       sound = {
           [1] = {
               file = 'RadarLost.wav',
               text = 'tips.notifications.radarLost',
           },
       },
       length = 1,
       delay = 12,
    },
    ['AdvRadarLost'] = {
       sound = {
           [1] = {
               file = 'AdvRadarLost.wav',
               text = 'tips.notifications.advancedRadarLost',
           },
       },
       length = 1.32,
       delay = 12,
    },
    ['MexLost'] = {
       sound = {
           [1] = {
               file = 'MexLost.wav',
               text = 'tips.notifications.metalExtractorLost',
           },
       },
       length = 1.53,
       delay = 10,
    },

    -- Resources


    ['YouAreOverflowingMetal'] = {
       sound = {
           [1] = {
               file = 'YouAreOverflowingMetal.wav',
               text = 'tips.notifications.overflowingMetal',
           },
       },
       length = 1.63,
       delay = 80,
    },
    ['WholeTeamWastingMetal'] = {
       sound = {
           [1] = {
               file = 'WholeTeamWastingMetal.wav',
               text = 'tips.notifications.teamWastingMetal',
           },
       },
       length = 1.82,
       delay = 60,
    },
    ['WholeTeamWastingEnergy'] = {
       sound = {
           [1] = {
               file = 'WholeTeamWastingEnergy.wav',
               text = 'tips.notifications.teamWastingEnergy',
           },
       },
       length = 2.14,
       delay = 120,
    },
    ['LowPower'] = {
       sound = {
           [1] = {
               file = 'LowPower.wav',
               text = 'tips.notifications.lowPower',
           },
       },
       length = 0.95,
       delay = 50,
    },
    ['WindNotGood'] = {
       sound = {
           [1] = {
               file = 'WindNotGood.wav',
               text = 'tips.notifications.lowWind',
           },
       },
       length = 3.76,
       delay = 9999999,
    },

    -- Alerts

    ['NukeLaunched'] = {
       sound = {
           [1] = {
               file = 'NukeLaunched.wav',
               text = 'tips.notifications.nukeLaunched',
           },
       },
       length = 2,
       delay = 3,
    },
    ['LrpcTargetUnits'] = {
       sound = {
           [1] = {
               file = 'LrpcTargetUnits.wav',
               text = 'tips.notifications.lrpcAttacking',
           },
       },
       length = 3.8,
       delay = 9999999,
    },

    -- Unit Ready


    ['VulcanIsReady'] = {
       sound = {
           [1] = {
               file = 'RagnarokIsReady.wav',
               text = 'tips.notifications.vulcanReady',
           },
       },
       length = 1.16,
       delay = 30,
    },
    ['BuzzsawIsReady'] = {
       sound = {
           [1] = {
               file = 'CalamityIsReady.wav',
               text = 'tips.notifications.buzzsawReady',
           },
       },
       length = 1.31,
       delay = 30,
    },
    ['Tech3UnitReady'] = {
       sound = {
           [1] = {
               file = 'Tech3UnitReady.wav',
               text = 'tips.notifications.t3Ready',
           },
       },
       length = 1.78,
       delay = 9999999,
    },

    -- Units Detected

    ['T2Detected'] = {
       sound = {
           [1] = {
               file = 'T2UnitDetected.wav',
               text = 'tips.notifications.t2Detected',
           },
       },
       length = 1.5,
       delay = 9999999,
    },
    ['T3Detected'] = {
       sound = {
           [1] = {
               file = 'T3UnitDetected.wav',
               text = 'tips.notifications.t3Detected',
           },
       },
       length = 1.94,
       delay = 9999999,
    },
    ['AircraftSpotted'] = {
       sound = {
           [1] = {
               file = 'AircraftSpotted.wav',
               text = 'tips.notifications.aircraftSpotted',
           },
       },
       length = 1.25,
       delay = 9999999,
    },
    ['MinesDetected'] = {
       sound = {
           [1] = {
               file = 'MinesDetected.wav',
               text = 'tips.notifications.minesDetected',
           },
       },
       length = 2.6,
       delay = 200,
    },
    ['IntrusionCountermeasure'] = {
       sound = {
           [1] = {
               file = 'StealthyUnitsInRange.wav',
               text = 'tips.notifications.stealthDetected',
           },
       },
       length = 4.8,
       delay = 55,
    },
    ['LrpcDetected'] = {
       sound = {
           [1] = {
               file = 'LrpcDetected.wav',
               text = 'tips.notifications.lrpcDetected',
           },
       },
       length = 2.3,
       delay = 25,
    },
    ['EMPmissilesiloDetected'] = {
       sound = {
           [1] = {
               file = 'EmpSiloDetected.wav',
               text = 'tips.notifications.empSiloDetected',
           },
       },
       length = 2.1,
       delay = 4,
    },
    ['TacticalNukeSiloDetected'] = {
       sound = {
           [1] = {
               file = 'TacticalNukeDetected.wav',
               text = 'tips.notifications.tacticalSiloDetected',
           },
       },
       length = 2,
       delay = 4,
    },
    ['NuclearSiloDetected'] = {
       sound = {
           [1] = {
               file = 'NuclearSiloDetected.wav',
               text = 'tips.notifications.nukeSiloDetected',
           },
       },
       length = 1.7,
       delay = 4,
    },
    ['NuclearBomberDetected'] = {
       sound = {
           [1] = {
               file = 'NuclearBomberDetected.wav',
               text = 'tips.notifications.nukeBomberDetected',
           },
       },
       length = 1.6,
       delay = 60,
    },
    ['JuggernautDetected'] = {
       sound = {
           [1] = {
               file = 'BehemothDetected.wav',
               text = 'tips.notifications.t3MobileTurretDetected',
           },
       },
       length = 1.4,
       delay = 9999999,
    },
    ['KorgothDetected'] = {
       sound = {
           [1] = {
               file = 'JuggernautDetected.wav',
               text = 'tips.notifications.t3AssaultBotDetected',
           },
       },
       length = 1.25,
       delay = 9999999,
    },
    ['BanthaDetected'] = {
       sound = {
           [1] = {
               file = 'TitanDetected.wav',
               text = 'tips.notifications.t3AssaultMechDetected',
           },
       },
       length = 1.25,
       delay = 9999999,
    },
    ['FlagshipDetected'] = {
       sound = {
           [1] = {
               file = 'FlagshipDetected.wav',
               text = 'tips.notifications.flagshipDetected',
           },
       },
       length = 1.4,
       delay = 9999999,
    },
    ['CommandoDetected'] = {
       sound = {
           [1] = {
               file = 'CommandoDetected.wav',
               text = 'tips.notifications.commandoDetected',
           },
       },
       length = 1.28,
       delay = 9999999,
    },
    ['TransportDetected'] = {
       sound = {
           [1] = {
               file = 'TransportDetected.wav',
               text = 'tips.notifications.transportDetected',
           },
       },
       length = 1.5,
       delay = 9999999,
    },
    ['AirTransportDetected'] = {
       sound = {
           [1] = {
               file = 'AirTransportDetected.wav',
               text = 'tips.notifications.airTransportDetected',
           },
       },
       length = 1.38,
       delay = 9999999,
    },
    ['SeaTransportDetected'] = {
       sound = {
           [1] = {
               file = 'SeaTransportDetected.wav',
               text = 'tips.notifications.seaTransportDetected',
           },
       },
       length = 1.95,
       delay = 9999999,
    },

    -- Lava

    ['LavaRising'] = {
       sound = {
           [1] = {
               file = 'Lavarising.wav',
               text = 'tips.notifications.lavaRising',
           },
       },
       length = 3,
       delay = 25,
       unlisted = true,
    },
    ['LavaDropping'] = {
       sound = {
           [1] = {
               file = 'Lavadropping.wav',
               text = 'tips.notifications.lavaDropping',
           },
       },
       length = 2,
       delay = 25,
       unlisted = true,
    },

    -- Tutorials

    ['t_welcome'] = {
       sound = {
           [1] = {
               file = 'tutorial/welcome.wav',
               text = 'tips.notifications.tutorialWelcome',
           },
       },
       length = 9.19,
       delay = 9999999,
       unlisted = true,
    },
    ['t_buildmex'] = {
       sound = {
           [1] = {
               file = 'tutorial/buildmex.wav',
               text = 'tips.notifications.tutorialBuildMetal',
           },
       },
       length = 6.31,
       delay = 9999999,
       unlisted = true,
    },
    ['t_buildenergy'] = {
       sound = {
           [1] = {
               file = 'tutorial/buildenergy.wav',
               text = 'tips.notifications.tutorialBuildenergy',
           },
       },
       length = 6.47,
       delay = 9999999,
       unlisted = true,
    },
    ['t_makefactory'] = {
       sound = {
           [1] = {
               file = 'tutorial/makefactory.wav',
               text = 'tips.notifications.tutorialBuildFactory',
           },
       },
       length = 8.87,
       delay = 9999999,
       unlisted = true,
    },
    ['t_factoryair'] = {
       sound = {
           [1] = {
               file = 'tutorial/factoryair.wav',
               text = 'tips.notifications.tutorialFactoryAir',
           },
       },
       length = 8.2,
       delay = 9999999,
       unlisted = true,
    },
    ['t_factoryairsea'] = {
       sound = {
           [1] = {
               file = 'tutorial/factoryairsea.wav',
               text = 'tips.notifications.tutorialFactorySeaplanes',
           },
       },
       length = 7.39,
       delay = 9999999,
       unlisted = true,
    },
    ['t_factorybots'] = {
       sound = {
           [1] = {
               file = 'tutorial/factorybots.wav',
               text = 'tips.notifications.tutorialFactoryBots',
           },
       },
       length = 8.54,
       delay = 9999999,
       unlisted = true,
    },
    ['t_factoryhovercraft'] = {
       sound = {
           [1] = {
               file = 'tutorial/factoryhovercraft.wav',
               text = 'tips.notifications.tutorialFactoryHovercraft',
           },
       },
       length = 6.91,
       delay = 9999999,
       unlisted = true,
    },
    ['t_factoryvehicles'] = {
       sound = {
           [1] = {
               file = 'tutorial/factoryvehicles.wav',
               text = 'tips.notifications.tutorialFactoryVehicles',
           },
       },
       length = 11.92,
       delay = 9999999,
       unlisted = true,
    },
    ['t_factoryships'] = {
       sound = {
           [1] = {
               file = 'tutorial/factoryships.wav',
               text = 'tips.notifications.tutorialFactoryShips',
           },
       },
       length = 15.82,
       delay = 9999999,
       unlisted = true,
    },
    ['t_readyfortech2'] = {
       sound = {
           [1] = {
               file = 'tutorial/readyfortecht2.wav',
               text = 'tips.notifications.tutorialT2Ready',
           },
       },
       length = 9.4,
       delay = 9999999,
       unlisted = true,
    },
    ['t_duplicatefactory'] = {
       sound = {
           [1] = {
               file = 'tutorial/duplicatefactory.wav',
               text = 'tips.notifications.tutorialDuplicateFactory',
           },
       },
       length = 6.1,
       delay = 9999999,
       unlisted = true,
    },
    ['t_paralyzer'] = {
       sound = {
           [1] = {
               file = 'tutorial/paralyzer.wav',
               text = 'tips.notifications.tutorialParalyzer',
           },
       },
       length = 9.66,
       delay = 9999999,
       unlisted = true,
    },
}
