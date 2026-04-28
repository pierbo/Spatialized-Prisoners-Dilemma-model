Class {
	#name : 'BaselineOfSpatializedPrisonersDilemma',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfSpatializedPrisonersDilemma',
	#package : 'BaselineOfSpatializedPrisonersDilemma'
}

{ #category : 'as yet unclassified' }
BaselineOfSpatializedPrisonersDilemma >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec
			package: 'SpatializedPrisonersDilemma-Model';
		
			package: 'SpatializedPrisonersDilemma-Model-Tests'
			with: [ spec requires: #('SpatializedPrisonersDilemma-Model') ] ].
]
