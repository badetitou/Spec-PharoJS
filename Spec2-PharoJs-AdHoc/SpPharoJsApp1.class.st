Class {
	#name : #SpPharoJsApp1,
	#superclass : #SpApplication,
	#instVars : [
		'context'
	],
	#category : #'Spec2-PharoJs-AdHoc'
}

{ #category : #constants }
SpPharoJsApp1 class >> applicationName [

	^ self name asString
]

{ #category : #'instance creation' }
SpPharoJsApp1 class >> defaultBackendName [

	^ "#PharoJs" #Morphic
]

{ #category : #'instance creation' }
SpPharoJsApp1 class >> open [

	<script>
	self new
		run
]

{ #category : #accessing }
SpPharoJsApp1 >> context [

	^ context
]

{ #category : #accessing }
SpPharoJsApp1 >> context: anObject [

	context := anObject
]

{ #category : #accessing }
SpPharoJsApp1 >> start [

	self windows do: [ :win | 
		win open.
		^ self ].
	(self new: SpPharoJsPresenter1) open
]

{ #category : #accessing }
SpPharoJsApp1 >> startWindowId: windowId [

	| windowPresenter |
	self windows do: [ :win | 
		win adapter windowId = windowId ifTrue: [ ^ self ] ].
	windowPresenter := (self new: SpPharoJsPresenter1) asWindow.
	windowPresenter open.
	windowPresenter adapter windowId: windowId
]
