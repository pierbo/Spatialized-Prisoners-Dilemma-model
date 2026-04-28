Class {
	#name : 'SPDCell',
	#superclass : 'CMCell',
	#traits : 'TCMCellularAutomaton',
	#classTraits : 'TCMCellularAutomaton classTrait',
	#instVars : [
		'previousState',
		'winnings'
	],
	#classInstVars : [
		'winningsMatrix',
		'coop_coop',
		'coop_defect',
		'defect_coop',
		'defect_defect'
	],
	#category : 'SpatializedPrisonersDilemma-Model',
	#package : 'SpatializedPrisonersDilemma-Model'
}

{ #category : 'accessing' }
SPDCell class >> coop_coop [

	^ coop_coop
]

{ #category : 'accessing' }
SPDCell class >> coop_coop: anObject [

	coop_coop := anObject
]

{ #category : 'accessing' }
SPDCell class >> coop_defect [

	^ coop_defect
]

{ #category : 'accessing' }
SPDCell class >> coop_defect: anObject [

	coop_defect := anObject
]

{ #category : 'accessing' }
SPDCell class >> defect_coop [

	^ defect_coop
]

{ #category : 'accessing' }
SPDCell class >> defect_coop: anObject [

	defect_coop := anObject
]

{ #category : 'accessing' }
SPDCell class >> defect_defect [

	^ defect_defect
]

{ #category : 'accessing' }
SPDCell class >> defect_defect: anObject [

	defect_defect := anObject
]

{ #category : 'initialization' }
SPDCell class >> initializeParameters [

	super initializeParameters.
	coop_coop := 100.
	coop_defect := 0.
	defect_coop := 185.
	defect_defect := 0
]

{ #category : 'initialization' }
SPDCell class >> setWinningsMatrix [
"
						| cooperation |	 defection   |
------------------|------------- |-------------|
cooperation       |   100        |      0      |
defection         |   185        |      0      |
------------------|--------------|-------------|
"
	winningsMatrix := Dictionary new.
	winningsMatrix at: (Array with: #cooperation with: #cooperation) put: self coop_coop.
	winningsMatrix at: (Array with: #cooperation with: #defection) put: self coop_defect.
	winningsMatrix at: (Array with: #defection with: #defection) put: self defect_defect.
	winningsMatrix at: (Array with: #defection with: #cooperation) put: self defect_coop.
	^winningsMatrix
]

{ #category : 'accessing' }
SPDCell class >> winningsMatrix [

	^ winningsMatrix
]

{ #category : 'accessing' }
SPDCell class >> winningsMatrix: anObject [

	winningsMatrix := anObject
]

{ #category : 'initialization' }
SPDCell >> initialize [

	super initialize.
	state := #cooperation.
	previousState := #cooperation.
]

{ #category : 'testing' }
SPDCell >> isCooperating [

	^ state = #cooperation
]

{ #category : 'testing' }
SPDCell >> isDefecting [

	^ state = #defection
]

{ #category : 'control' }
SPDCell >> newState [
	"Determine the best neighbour"

	| bestWinnings bestWinningsState |
	bestWinnings := 0.
	self neighbourhoodAndSelf do: 
			[:c | 
			c winnings >= bestWinnings ifTrue: 
					[bestWinnings := c winnings.
					bestWinningsState := c state]].	

	self bufferState: bestWinningsState
]

{ #category : 'pov' }
SPDCell >> pov [

	(self state = #defection and: [ self previousState = #defection ])
		ifTrue: [ ^ CMPointOfView color: (Color red) ].
	(self state = #cooperation and: [ self previousState = #cooperation ])
		ifTrue: [ ^ CMPointOfView color: (Color blue) ].
	(self state = #cooperation and: [ self previousState = #defection ])
		ifTrue: [ ^ CMPointOfView color: (Color green) ].
	(self state = #defection and: [ self previousState = #cooperation ])
		ifTrue: [ ^ CMPointOfView color: (Color yellow) ].
	^ nil
]

{ #category : 'accessing' }
SPDCell >> previousState [

	^ previousState
]

{ #category : 'accessing' }
SPDCell >> previousState: anObject [

	previousState := anObject
]

{ #category : 'control' }
SPDCell >> setWinnings [

	| aCoupleOfStrategies |
	winnings := 0.
	self neighbourhoodAndSelf do: [ :aNeighbour |
			aCoupleOfStrategies := Array
				                       with: self state
				                       with: aNeighbour state.
			winnings := winnings
			            + (self class winningsMatrix at: aCoupleOfStrategies) ].
	^ winnings
]

{ #category : 'control' }
SPDCell >> updateState [
	self previousState: self state.
	"super updateState. Doen't work because Trait!"
		self state ~= self bufferState
		ifTrue: [ self state: self bufferState ]
]

{ #category : 'accessing' }
SPDCell >> winnings [

	^ winnings
]

{ #category : 'accessing' }
SPDCell >> winnings: anObject [

	winnings := anObject
]
