Class {
	#name : 'SPDModel',
	#superclass : 'CMAbstractModel',
	#instVars : [
		'theCells'
	],
	#category : 'SpatializedPrisonersDilemma-Model',
	#package : 'SpatializedPrisonersDilemma-Model'
}

{ #category : 'as yet unclassified' }
SPDModel class >> modelName [

	^ 'SpatializedPrisonersDilemma'
]

{ #category : 'accessing' }
SPDModel class >> prefix [

	^ 'SPD'
]

{ #category : 'probes' }
SPDModel >> cooperation [

	<probeNamed: 'cooperation rate' color: '0000FF'>
	^ (theCells select: [ :c | c isCooperating ]) size
	  / theCells size
]

{ #category : 'probes' }
SPDModel >> defection [

	<probeNamed: 'defection rate' color: 'FF0000'>
	^ (theCells select: [ :c | c isDefecting ]) size
	  / theCells size
]

{ #category : 'init' }
SPDModel >> init [
	"This method is used to define the initial environment of a simulation. It will be executed once when the simulation is initialized."

	<init>
	self
		createGridNumberOfRows: 61
		numberOfColumns: 61
		neighbourhood: 8
		closed: false.
	self centralCell
		previousState: #defection;
		state: #defection.
	SPDCell setWinningsMatrix.
	theCells := self @@ SPDCell
]

{ #category : 'control' }
SPDModel >> step [
	"This method will be executed at every step of the simulation"

	<control>
	theCells do: [ :a | a setWinnings ]. 
	theCells do: [ :a | a newState ].
	theCells do: [ :a | a updateState ]
]
