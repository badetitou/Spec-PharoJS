Class {
	#name : #SpPharoJsClientSideApp,
	#superclass : #PjDomController,
	#traits : 'PhxPjPromiseTrait + PhxPjLoggingTrait',
	#classTraits : 'PhxPjPromiseTrait classTrait + PhxPjLoggingTrait classTrait',
	#instVars : [
		'messenger'
	],
	#classInstVars : [
		'incrementalExporter',
		'current'
	],
	#category : #'Spec2-PharoJs'
}

{ #category : #css }
SpPharoJsClientSideApp class >> addCssReset [

	<phxCss>
	self appendStyleElementToHeadWith: '
html, body {
font-family: -apple-system, BlinkMacSystemFont,
    “Segoe UI”, “Roboto”, “Oxygen”, “Ubuntu”, “Cantarell”,
    “Fira Sans”, “Droid Sans”, “Helvetica Neue”,
    sans-serif;
  box-sizing: border-box;
}
/* Box sizing rules */
*,
*::before,
*::after {
  box-sizing: border-box;
}

/* Remove default margin */
body,
h1,
h2,
h3,
h4,
p,
figure,
blockquote,
dl,
dd {
  margin: 0;
}

/* Remove list styles on ul, ol elements with a list role, which suggests default styling will be removed */
ul[role="list"],
ol[role="list"] {
  list-style: none;
}

/* Set core root defaults */
html:focus-within {
  scroll-behavior: smooth;
}

/* Set core body defaults */
body {
  font-size: 1rem;
  font-weight: 400;
  color: #212529;
  min-height: 100vh;
  text-rendering: optimizeSpeed;
  line-height: 1.2;
  -webkit-text-size-adjust: 100%;
  -webkit-tap-highlight-color: transparent;
}
 
/* A elements that don"t have a class get default styles */
a:not([class]) {
  text-decoration-skip-ink: auto;
}

/* Make images easier to work with */
img,
picture {
  max-width: 100%;
  display: block;
}

/* Inherit fonts for inputs and buttons */
input,
button,
textarea,
select {
  font: inherit;
}

/* Remove all animations and transitions for people that prefer not to see them */
@media (prefers-reduced-motion: reduce) {
  html:focus-within {
   scroll-behavior: auto;
  }
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}'
]

{ #category : #pharojs }
SpPharoJsClientSideApp class >> appClasses [

	<pharoJsSkip>
	^ SpS2cMessage withAllSubclasses , SpC2sEvent withAllSubclasses , {
		  PhxSpaResponse.
		  PhxWcSpecInputField.
		  PhxWcSpecTabulator.
		  SpTabulatorColumn.
		  SpPharoJsImage }
]

{ #category : #pharojs }
SpPharoJsClientSideApp class >> appLaunchBlock [

	| appClass |
	appClass := self.
	^ [ appClass yourself ] asClosedBlock
]

{ #category : #pharojs }
SpPharoJsClientSideApp class >> appPackages [
	<pharoJsSkip>
	^ #()
]

{ #category : #css }
SpPharoJsClientSideApp class >> appendStyleElementToHeadWith: aString [
	| style |
	style := self createElement: 'style'.
	style innerHTML: aString.
	self document head js_appendChild: style.
	^ style
]

{ #category : #constants }
SpPharoJsClientSideApp class >> applicationName [
	^'spec'
]

{ #category : #private }
SpPharoJsClientSideApp class >> boot [

	window addEventListener: #load block: [ 
		self addCssReset.
		self showSplashScreen.
		self promiseAllExternalResourcesLoaded then: [ 
			self body innerHTML: ''.
			self current messenger setupConnectionWithServer ] ]
]

{ #category : #accessing }
SpPharoJsClientSideApp class >> clientId [

	^ PhxBrowserPersistentClientId value
]

{ #category : #'instance creation' }
SpPharoJsClientSideApp class >> current [
	current ifNil: [ current := self new ].
	^current
]

{ #category : #server }
SpPharoJsClientSideApp class >> exporterClass [
	<pharoJsSkip>
	^ PjExporter
]

{ #category : #pharojs }
SpPharoJsClientSideApp class >> headerLine [
	^ nil
]

{ #category : #server }
SpPharoJsClientSideApp class >> htmlPageWithInitialScript [
	<pharoJsSkip>
	"self incrementalExporter reset."
	"self incrementalExporter javascriptCode"
	^ self htmlPageWithJsScript:  nil 
]

{ #category : #pharojs }
SpPharoJsClientSideApp class >> htmlPageWithJsScript: aScript [
	<pharoJsSkip>
	^ String streamContents: [ :ws | 
		  ws << '<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=2.0, user-scalable=yes"
    />
	<script type="text/javascript" src="' << self applicationName << '.js"></script>
<script type="text/javascript" src="https://unpkg.com/tabulator-tables@5.5.0/dist/js/tabulator.min.js"></script>
 <style>*, *:before, *:after {
    box-sizing: border-box;
	}</style>
  </head>
  <body id="body">
  </body>
</html>' ]
]

{ #category : #server }
SpPharoJsClientSideApp class >> httpPath [ 
	^'/' , self applicationName
]

{ #category : #server }
SpPharoJsClientSideApp class >> initialScript [
	<pharoJsSkip>
	^ (PjExporter newWithAppClass: self) javascriptCode , self name  , '.pj_boot();'
]

{ #category : #server }
SpPharoJsClientSideApp class >> newAppContext [
	<pharoJsSkip>
	^nil
]

{ #category : #server }
SpPharoJsClientSideApp class >> newServerWebSocketHandler [

	<pharoJsSkip>
	| wsh |
	wsh := PhxServerWebSocketHandler new.
	wsh applicationClass: self.
	wsh context: SpPharoJsSessionRegistry.
	^ wsh
]

{ #category : #pharojs }
SpPharoJsClientSideApp class >> pharoJsSelectorPrefix [
	^ 'pj_'
]

{ #category : #pharojs }
SpPharoJsClientSideApp class >> polyfill: aClass withTranspiler: aPjDependentTranspiler unlessIn: aCollection [ 
	
]

{ #category : #private }
SpPharoJsClientSideApp class >> promiseAllExternalResourcesLoaded [

	^ self promiseResolve: nil
]

{ #category : #css }
SpPharoJsClientSideApp class >> promiseCssReset [

	^self promise: [ :resolve :reject | 
		self addCssReset.
		resolve value ]
]

{ #category : #'instance creation' }
SpPharoJsClientSideApp class >> registerAsApplicationAtPjServer [
	<pharoJsSkip>
	<script>
	PhxPjServer registerApplication: self
]

{ #category : #pharojs }
SpPharoJsClientSideApp class >> setupCode [
	<pharoJsSkip>
	^ '	var global=global ?? this'
]

{ #category : #private }
SpPharoJsClientSideApp class >> showSplashScreen [

	| x |
	x := PjDomBuilder newOnElement: self body.
	x div: self applicationName , ' is loading...'
]

{ #category : #accessing }
SpPharoJsClientSideApp class >> webSocketPath [ 
	^self httpPath , '-ws'
]

{ #category : #'accessing derived' }
SpPharoJsClientSideApp >> dialogManager [

	^ self
]

{ #category : #initialization }
SpPharoJsClientSideApp >> initialize [

	super initialize.
	self logSelfAndAll: { 'initialize' }
]

{ #category : #components }
SpPharoJsClientSideApp >> messenger [

	messenger ifNil: [ 
		messenger := PhxClientWebSocketHandler new.
		messenger webSocketUrl: self webSocketUrl.
		messenger tokenProvider: nil.
		messenger client: self.
		messenger onEvent: PhxPseWebSocketOpened do: [ :ev | 
			self log: 'Websocket has been opened.'.
			self onWebSocketOpen: ev payload ].
		messenger
			onEvent: PhxPseWebSocketClosed
			do: [ :ev | self log: 'Websocket has been closed.' ] ].
	^ messenger
]

{ #category : #components }
SpPharoJsClientSideApp >> onWebSocketOpen: ev [

	self promiseAppSession then: [ :uuid | 
		| msg |
		msg := SpC2sStartOrResumeApp new.
		msg clientId: PhxBrowserPersistentClientId value.
		msg sessionId: PhxBrowserExpiringSessionId value.
		msg windowId: PhxBrowserWindowId value.
		self messenger sendMessageToServer: msg ]
]

{ #category : #components }
SpPharoJsClientSideApp >> promiseAppSession [

	^ self promise: [ :resolve :reject | 
		  | msg |
		  self logAll: { 'sending start app session to server' }.
		  msg := SpC2sStartAppSession new.
		  msg clientId: PhxBrowserPersistentClientId value.
		  msg sessionId: PhxBrowserExpiringSessionId value.
"		  msg windowId: PhxBrowserWindowId value."
		  self messenger
			  sendMessageToServer: msg
			  onResponseDo: [ :env | 
				  | sessionId |
				  self logAll: { 
						  'receiving session envelope:'.
						  env }.
				  sessionId := env msg payload.
				  PhxBrowserExpiringSessionId
					  value: sessionId
					  expireInSeconds: 3600.
				  resolve value: sessionId ]
			  isResponseToIncomingEnvelope: nil ]
]

{ #category : #'server messaging' }
SpPharoJsClientSideApp >> webSocketUrl [
	| protocol |
	protocol := window location protocol = 'https:'
		ifTrue: 'wss://'
		ifFalse: [ 'ws://' ].
	
	^ protocol , window location host , self class webSocketPath 
]
