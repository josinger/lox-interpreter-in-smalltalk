!classDefinition: #LoxScannerTest category: 'LoxInterpreter'!
TestCase subclass: #LoxScannerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LoxInterpreter'!

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/7/2022 02:40:48'!
test01NoLexemeNoTokens

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: ''.
	scannedTokens := aLoxScanner scanTokens.
	
	expectedTokens := OrderedCollection 
									with: (self line1NoLiteralTokenWithType: #EOF forLexeme: '').
	self assert: expectedTokens equals: scannedTokens.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/7/2022 03:56:21'!
test02OneCharTokens

	self assertThatALoxScannerGeneratesATokenWithType: #LEFT_PAREN forLexeme: '('.
	self assertThatALoxScannerGeneratesATokenWithType: #RIGHT_PAREN forLexeme: ')'.
	self assertThatALoxScannerGeneratesATokenWithType: #LEFT_BRACE forLexeme: '{'.
	self assertThatALoxScannerGeneratesATokenWithType: #RIGHT_BRACE forLexeme: '}'.
	self assertThatALoxScannerGeneratesATokenWithType: #COMMA forLexeme: ','.
	self assertThatALoxScannerGeneratesATokenWithType: #DOT forLexeme: '.'.
	self assertThatALoxScannerGeneratesATokenWithType: #MINUS forLexeme: '-'.
	self assertThatALoxScannerGeneratesATokenWithType: #PLUS forLexeme: '+'.
	self assertThatALoxScannerGeneratesATokenWithType: #SEMICOLON forLexeme: ';'.
	self assertThatALoxScannerGeneratesATokenWithType: #STAR forLexeme: '*'.
	self assertThatALoxScannerGeneratesATokenWithType: #BANG forLexeme: '!!'.
	self assertThatALoxScannerGeneratesATokenWithType: #EQUAL forLexeme: '='.
	self assertThatALoxScannerGeneratesATokenWithType: #LESS forLexeme: '<'.
	self assertThatALoxScannerGeneratesATokenWithType: #GREATER forLexeme: '>'.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/7/2022 03:25:21'!
test03MultipleOneCharTokens

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: '()'.
	scannedTokens := aLoxScanner scanTokens.
	
	expectedTokens := OrderedCollection 
									with: (self line1NoLiteralTokenWithType: #LEFT_PAREN forLexeme: '(')
									with: (self line1NoLiteralTokenWithType: #RIGHT_PAREN forLexeme: ')')
									with: (self line1NoLiteralTokenWithType: #EOF forLexeme: '').
	self assert: expectedTokens equals: scannedTokens.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/7/2022 03:20:13'!
test04MultipleLines

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: '(
	)'.
	scannedTokens := aLoxScanner scanTokens.
	
	expectedTokens := OrderedCollection 
									with: (self line1NoLiteralTokenWithType: #LEFT_PAREN forLexeme: '(')
									with: (self line: 2 NoLiteralTokenWithType: #RIGHT_PAREN forLexeme: ')')
									with: (self line: 2 NoLiteralTokenWithType: #EOF forLexeme: '').
	self assert: expectedTokens equals: scannedTokens.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/7/2022 04:42:17'!
test05TwoCharTokens

	self assertThatALoxScannerGeneratesATokenWithType: #BANG_EQUAL forLexeme: '!!='.
	self assertThatALoxScannerGeneratesATokenWithType: #EQUAL_EQUAL forLexeme: '=='.
	self assertThatALoxScannerGeneratesATokenWithType: #LESS_EQUAL forLexeme: '<='.
	self assertThatALoxScannerGeneratesATokenWithType: #GREATER_EQUAL forLexeme: '>='.! !


!LoxScannerTest methodsFor: 'assertions' stamp: 'JS 10/7/2022 02:40:15'!
assertThatALoxScannerGeneratesATokenWithType: aTokenType forLexeme: aLexeme

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: aLexeme.
	scannedTokens := aLoxScanner scanTokens.
	
	expectedTokens := OrderedCollection 
									with: (self line1NoLiteralTokenWithType: aTokenType forLexeme: aLexeme)
									with: (self line1NoLiteralTokenWithType: #EOF forLexeme: '').
	self assert: expectedTokens equals: scannedTokens.! !


!LoxScannerTest methodsFor: 'setUp/tearDown' stamp: 'JS 10/7/2022 02:40:28'!
setUp

! !


!LoxScannerTest methodsFor: 'tokens' stamp: 'JS 10/7/2022 03:19:32'!
line1NoLiteralTokenWithType: aTokenType forLexeme: aLexeme

	^self line: 1 NoLiteralTokenWithType: aTokenType forLexeme: aLexeme! !

!LoxScannerTest methodsFor: 'tokens' stamp: 'JS 10/7/2022 03:19:09'!
line: lineNumber NoLiteralTokenWithType: aTokenType forLexeme: aLexeme

	^LoxToken withType: aTokenType lexeme: aLexeme literal: nil line: lineNumber! !


!classDefinition: #LoxScanner category: 'LoxInterpreter'!
Object subclass: #LoxScanner
	instanceVariableNames: 'source tokens start current line'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LoxInterpreter'!

!LoxScanner methodsFor: 'initialization' stamp: 'JS 10/7/2022 04:54:52'!
initializeWithSource: aSource 
	
	source := aSource.
	tokens := OrderedCollection new.
	start := 1.
	current := 1.
	line := 1.! !


!LoxScanner methodsFor: 'private' stamp: 'JS 10/7/2022 03:48:01'!
addTokenWithType: aTokenType

	self addTokenWithType: aTokenType andLiteral: nil


	! !

!LoxScanner methodsFor: 'private' stamp: 'JS 10/7/2022 05:12:23'!
addTokenWithType: aTokenType andLiteral: aLiteral

	| lexeme |
	lexeme := source copyFrom: start to: current - 1.
	
	tokens add: (LoxToken withType: aTokenType lexeme: lexeme literal: aLiteral line: line)


	! !

!LoxScanner methodsFor: 'private' stamp: 'JS 10/7/2022 05:13:49'!
advance

	self incrementCurrent.
! !

!LoxScanner methodsFor: 'private' stamp: 'JS 10/7/2022 04:28:13'!
currentCharacter

	^source copyFrom: start to: current.! !

!LoxScanner methodsFor: 'private' stamp: 'JS 10/7/2022 03:13:56'!
incrementCurrent

	current := current + 1.


	! !

!LoxScanner methodsFor: 'private' stamp: 'JS 10/7/2022 03:18:15'!
incrementLine

	line := line + 1.


	! !

!LoxScanner methodsFor: 'private' stamp: 'JS 10/7/2022 04:57:04'!
isAtEnd

	^current > source size ! !

!LoxScanner methodsFor: 'private' stamp: 'JS 10/7/2022 05:21:01'!
match: expectedNextCharacter

	self isAtEnd ifTrue: [^false].
	expectedNextCharacter = (source copyFrom: current to: current) ifFalse: [^false].
	
	self incrementCurrent.
	^true


	! !

!LoxScanner methodsFor: 'private' stamp: 'JS 10/7/2022 05:18:50'!
scanToken

	| currentCharacter |
	
	currentCharacter := self currentCharacter.
	self advance. 
	
	currentCharacter = '(' ifTrue: [^self addTokenWithType: #LEFT_PAREN].
	currentCharacter = ')' ifTrue: [^self addTokenWithType: #RIGHT_PAREN].
	currentCharacter = '{' ifTrue: [^self addTokenWithType: #LEFT_BRACE].
	currentCharacter = '}' ifTrue: [^self addTokenWithType: #RIGHT_BRACE].
	currentCharacter = ',' ifTrue: [^self addTokenWithType: #COMMA].
	currentCharacter = '.' ifTrue: [^self addTokenWithType: #DOT].
	currentCharacter = '-' ifTrue: [^self addTokenWithType: #MINUS].
	currentCharacter = '+' ifTrue: [^self addTokenWithType: #PLUS].
	currentCharacter = ';' ifTrue: [^self addTokenWithType: #SEMICOLON].
	currentCharacter = '*' ifTrue: [^self addTokenWithType: #STAR].
	currentCharacter = (String with: Character newLineCharacter) ifTrue: [ ^self incrementLine ].
	
	currentCharacter = '!!' ifTrue: [
		(self match: '=')
			ifTrue: [^self addTokenWithType: #BANG_EQUAL]
			ifFalse: [^self addTokenWithType: #BANG]
	].
	currentCharacter = '=' ifTrue: [
		(self match: '=')
			ifTrue: [^self addTokenWithType: #EQUAL_EQUAL]
			ifFalse: [^self addTokenWithType: #EQUAL]
	].
	currentCharacter = '<' ifTrue: [
		(self match: '=')
			ifTrue: [^self addTokenWithType: #LESS_EQUAL]
			ifFalse: [^self addTokenWithType: #LESS]
	].
	currentCharacter = '>' ifTrue: [
		(self match: '=')
			ifTrue: [^self addTokenWithType: #GREATER_EQUAL]
			ifFalse: [^self addTokenWithType: #GREATER]
	].
	
	! !


!LoxScanner methodsFor: 'scan' stamp: 'JS 10/7/2022 05:13:59'!
scanTokens

	[self isAtEnd not] whileTrue: [ self scanToken. start := current. ].
	
	tokens add: (LoxToken withType: #EOF lexeme: '' literal: nil line: line).
	
	^tokens! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoxScanner class' category: 'LoxInterpreter'!
LoxScanner class
	instanceVariableNames: ''!

!LoxScanner class methodsFor: 'instance creation' stamp: 'JS 10/7/2022 01:23:48'!
withSource: aSource 
	
	^self new initializeWithSource: aSource ! !



!classDefinition: #LoxToken category: 'LoxInterpreter'!
Object subclass: #LoxToken
	instanceVariableNames: 'tokenType lexeme literal line'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LoxInterpreter'!

!LoxToken methodsFor: 'initialization' stamp: 'JS 10/7/2022 01:40:02'!
initializeWithType: aTokenType lexeme: aLexeme literal: aLiteral line: lineNumber 
	
	tokenType := aTokenType.
	lexeme := aLexeme.
	literal := aLiteral.
	line := lineNumber.! !


!LoxToken methodsFor: 'accesing' stamp: 'JS 10/7/2022 01:43:34'!
lexeme

	^lexeme ! !

!LoxToken methodsFor: 'accesing' stamp: 'JS 10/7/2022 01:43:25'!
line

	^line ! !

!LoxToken methodsFor: 'accesing' stamp: 'JS 10/7/2022 01:43:20'!
literal

	^literal ! !

!LoxToken methodsFor: 'accesing' stamp: 'JS 10/7/2022 01:43:14'!
type

	^tokenType ! !


!LoxToken methodsFor: 'comparing' stamp: 'JS 10/7/2022 01:44:48'!
= aLoxToken

	^tokenType = aLoxToken type &
	lexeme = aLoxToken lexeme &
	literal = aLoxToken literal &
	line = aLoxToken line! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoxToken class' category: 'LoxInterpreter'!
LoxToken class
	instanceVariableNames: ''!

!LoxToken class methodsFor: 'instance creation' stamp: 'JS 10/7/2022 01:39:03'!
withType: aTokenType lexeme: aLexeme literal: aLiteral line: lineNumber 
	
	^self new initializeWithType: aTokenType lexeme: aLexeme literal: aLiteral line: lineNumber ! !
