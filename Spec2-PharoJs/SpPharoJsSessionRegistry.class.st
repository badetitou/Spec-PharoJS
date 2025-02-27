Class {
	#name : #SpPharoJsSessionRegistry,
	#superclass : #Object,
	#classVars : [
		'sessions'
	],
	#classInstVars : [
		'dict'
	],
	#category : #'Spec2-PharoJs'
}

{ #category : #accessing }
SpPharoJsSessionRegistry class >> appForClientId: clientId sessionId: sessionId [

	^ sessions at: clientId , sessionId
]

{ #category : #accessing }
SpPharoJsSessionRegistry class >> ensureValidExistingOrNewSessionForClientId: clientId sessionId: sessionId [

	| newApp newSessionId |
	sessionId ifNotNil: [ 
	self sessions
		at: clientId , sessionId
		ifPresent: [ :app | "TODO: check if app instance is still ok" ^ sessionId ]].
	newSessionId := UUIDGenerator next asString.
	newApp := SpPharoJsApp1 new.
	newApp useBackend: #PharoJs.
	self sessions at: clientId , newSessionId put: newApp.
	^ newSessionId
]

{ #category : #accessing }
SpPharoJsSessionRegistry class >> prepareForNewRequest [
]

{ #category : #accessing }
SpPharoJsSessionRegistry class >> reset [
	<script>
	sessions := nil
]

{ #category : #accessing }
SpPharoJsSessionRegistry class >> sessions [
	sessions ifNil: [ sessions := Dictionary new ].
	^ sessions
]
