!classDefinition: #LoxScannerTest category: 'LoxInterpreter'!
TestCase subclass: #LoxScannerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LoxInterpreter'!

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:32:42'!
test01NoLexemeNoTokens

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: ''.
	scannedTokens := aLoxScanner tokens.
	
	expectedTokens := OrderedCollection 
									with: (self line1NoLiteralTokenWithType: #EOF forLexeme: '').
	self assert: expectedTokens equals: scannedTokens.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 01:38:37'!
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
	self assertThatALoxScannerGeneratesATokenWithType: #GREATER forLexeme: '>'.
	self assertThatALoxScannerGeneratesATokenWithType: #SLASH forLexeme: '/'.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:32:42'!
test03MultipleOneCharTokens

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: '()'.
	scannedTokens := aLoxScanner tokens.
	
	expectedTokens := OrderedCollection 
									with: (self line1NoLiteralTokenWithType: #LEFT_PAREN forLexeme: '(')
									with: (self line1NoLiteralTokenWithType: #RIGHT_PAREN forLexeme: ')')
									with: (self line1NoLiteralTokenWithType: #EOF forLexeme: '').
	self assert: expectedTokens equals: scannedTokens.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:32:42'!
test04MultipleLines

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: '(
	)'.
	scannedTokens := aLoxScanner tokens.
	
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

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:32:42'!
test06ACommentGeneratesNoTokens

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: '//aaaaaa'.
	scannedTokens := aLoxScanner tokens.
	
	expectedTokens := OrderedCollection 
									with: (self line1NoLiteralTokenWithType: #EOF forLexeme: '').
	self assert: expectedTokens equals: scannedTokens.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:32:42'!
test07String

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: '"aaaaaa"'.
	scannedTokens := aLoxScanner tokens.
	
	expectedTokens := OrderedCollection 
									with: (LoxToken withType: #STRING lexeme: '"aaaaaa"' literal: 'aaaaaa' line: 1)
									with: (self line1NoLiteralTokenWithType: #EOF forLexeme: '').
	self assert: expectedTokens equals: scannedTokens.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:32:42'!
test08Number

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: '1'.
	scannedTokens := aLoxScanner tokens.
	
	expectedTokens := OrderedCollection 
									with: (LoxToken withType: #STRING lexeme: '1' literal: '1' line: 1)
									with: (self line1NoLiteralTokenWithType: #EOF forLexeme: '').
	self assert: expectedTokens equals: scannedTokens.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:32:42'!
test09DecimalNumber

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: '12.34'.
	scannedTokens := aLoxScanner tokens.
	
	expectedTokens := OrderedCollection 
									with: (LoxToken withType: #STRING lexeme: '12.34' literal: '12.34' line: 1)
									with: (self line1NoLiteralTokenWithType: #EOF forLexeme: '').
	self assert: expectedTokens equals: scannedTokens.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:07:33'!
test10ReservedWords

	self assertThatALoxScannerGeneratesATokenWithType: #AND forLexeme: 'and'.
	self assertThatALoxScannerGeneratesATokenWithType: #CLASS forLexeme: 'class'.
	self assertThatALoxScannerGeneratesATokenWithType: #ELSE forLexeme: 'else'.
	self assertThatALoxScannerGeneratesATokenWithType: #FALSE forLexeme: 'false'.
	self assertThatALoxScannerGeneratesATokenWithType: #FOR forLexeme: 'for'.
	self assertThatALoxScannerGeneratesATokenWithType: #FUN forLexeme: 'fun'.
	self assertThatALoxScannerGeneratesATokenWithType: #IF forLexeme: 'if'.
	self assertThatALoxScannerGeneratesATokenWithType: #NIL forLexeme: 'nil'.
	self assertThatALoxScannerGeneratesATokenWithType: #OR forLexeme: 'or'.
	self assertThatALoxScannerGeneratesATokenWithType: #PRINT forLexeme: 'print'.
	self assertThatALoxScannerGeneratesATokenWithType: #RETURN forLexeme: 'return'.
	self assertThatALoxScannerGeneratesATokenWithType: #SUPER forLexeme: 'super'.
	self assertThatALoxScannerGeneratesATokenWithType: #THIS forLexeme: 'this'.
	self assertThatALoxScannerGeneratesATokenWithType: #TRUE forLexeme: 'true'.
	self assertThatALoxScannerGeneratesATokenWithType: #VAR forLexeme: 'var'.
	self assertThatALoxScannerGeneratesATokenWithType: #WHILE forLexeme: 'while'.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:05:11'!
test11Identifier
	
	self assertThatALoxScannerGeneratesATokenWithType: #IDENTIFIER forLexeme: 'random1_text'.! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:52:53'!
test12UnexpectedCharacterThrowsError
	
	| aLoxScanner |
	
	aLoxScanner := LoxScanner withSource: '@'.
	
	self 
		should: [aLoxScanner tokens]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = (LoxScanner unexpectedCharacterErrorMessageLine: 1)].! !

!LoxScannerTest methodsFor: 'tests' stamp: 'JS 10/17/2022 03:54:45'!
test13UnterminatedStringThrowsError
	
	| aLoxScanner |
	
	aLoxScanner := LoxScanner withSource: '"aaaaa'.
	
	self 
		should: [aLoxScanner tokens]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: anError messageText = (LoxScanner unterminatedStringErrorMessageLine: 1)].! !


!LoxScannerTest methodsFor: 'assertions' stamp: 'JS 10/17/2022 03:32:42'!
assertThatALoxScannerGeneratesATokenWithType: aTokenType forLexeme: aLexeme

	| aLoxScanner scannedTokens expectedTokens |
	
	aLoxScanner := LoxScanner withSource: aLexeme.
	scannedTokens := aLoxScanner tokens.
	
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
	instanceVariableNames: 'source tokens start current line reservedWords'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LoxInterpreter'!

!LoxScanner methodsFor: 'initialization' stamp: 'JS 10/17/2022 03:21:46'!
initializeReservedWords

	reservedWords := Dictionary new.
	
	reservedWords at: 'and' put: #AND.
	reservedWords at: 'class' put: #CLASS.
	reservedWords at: 'else' put: #ELSE.
	reservedWords at: 'false' put: #FALSE.
	reservedWords at: 'for' put: #FOR.
	reservedWords at: 'fun' put: #FUN.
	reservedWords at: 'if' put: #IF.
	reservedWords at: 'nil' put: #NIL.
	reservedWords at: 'or' put: #OR.
	reservedWords at: 'print' put: #PRINT.
	reservedWords at: 'return' put: #RETURN.
	reservedWords at: 'super' put: #SUPER.
	reservedWords at: 'this' put: #THIS.
	reservedWords at: 'true' put: #TRUE.
	reservedWords at: 'var' put: #VAR.
	reservedWords at: 'while' put: #WHILE.! !

!LoxScanner methodsFor: 'initialization' stamp: 'JS 10/17/2022 03:06:32'!
initializeWithSource: aSource 
	
	source := aSource.
	tokens := OrderedCollection new.
	start := 1.
	current := 1.
	line := 1.
	self initializeReservedWords.! !


!LoxScanner methodsFor: 'source managment - private' stamp: 'JS 10/17/2022 01:59:41'!
advance

	self incrementCurrent.
	^self currentCharacter 
! !

!LoxScanner methodsFor: 'source managment - private' stamp: 'JS 10/17/2022 02:37:49'!
currentCharacter

	^source at: current - 1.! !

!LoxScanner methodsFor: 'source managment - private' stamp: 'JS 10/17/2022 03:17:57'!
currentLexeme

	^ source copyFrom: start to: current - 1! !

!LoxScanner methodsFor: 'source managment - private' stamp: 'JS 10/7/2022 03:13:56'!
incrementCurrent

	current := current + 1.


	! !

!LoxScanner methodsFor: 'source managment - private' stamp: 'JS 10/7/2022 04:57:04'!
isAtEnd

	^current > source size ! !

!LoxScanner methodsFor: 'source managment - private' stamp: 'JS 10/17/2022 02:36:57'!
match: expectedNextCharacter

	self isAtEnd ifTrue: [^false].
	expectedNextCharacter = (source at: current) ifFalse: [^false].
	
	self incrementCurrent.
	^true


	! !

!LoxScanner methodsFor: 'source managment - private' stamp: 'JS 10/17/2022 02:51:54'!
peek

	self isAtEnd ifTrue: [^Character null].
	^source at: current.! !

!LoxScanner methodsFor: 'source managment - private' stamp: 'JS 10/17/2022 02:51:59'!
peekNext

	current + 1 >= source size ifTrue: [^Character null].
	^source at: current + 1.! !


!LoxScanner methodsFor: 'tokens - private' stamp: 'JS 10/7/2022 03:48:01'!
addTokenWithType: aTokenType

	self addTokenWithType: aTokenType andLiteral: nil


	! !

!LoxScanner methodsFor: 'tokens - private' stamp: 'JS 10/17/2022 03:22:17'!
addTokenWithType: aTokenType andLiteral: aLiteral

	tokens add: (LoxToken withType: aTokenType lexeme: self currentLexeme literal: aLiteral line: line)


	! !

!LoxScanner methodsFor: 'tokens - private' stamp: 'JS 10/7/2022 03:18:15'!
incrementLine

	line := line + 1.


	! !


!LoxScanner methodsFor: 'scanning - private' stamp: 'JS 10/17/2022 03:33:55'!
scanIdentifierOrReservedWordToken

	| tokenType |
	
	[self peek isAlphaNumeric or: [self peek = $_]] whileTrue: [self advance].

	tokenType := reservedWords at: self currentLexeme ifAbsentPut: [#IDENTIFIER].
	self addTokenWithType: tokenType.
	
	
	! !

!LoxScanner methodsFor: 'scanning - private' stamp: 'JS 10/17/2022 03:33:32'!
scanNumberToken

	[self peek isDigit] whileTrue: [self advance].

	(self peek = $. and: [self peekNext isDigit]) ifTrue: [
		self advance.
		[self peek isDigit] whileTrue: [self advance].
	].

	self addTokenWithType: #STRING andLiteral: (self currentLexeme). 

	
	
	
	! !

!LoxScanner methodsFor: 'scanning - private' stamp: 'JS 10/17/2022 03:58:54'!
scanStringToken

	[self peek ~= $"] whileTrue: [
		self isAtEnd ifTrue: [self error: (self class unterminatedStringErrorMessageLine: line)].
		self peek = Character newLineCharacter ifTrue: [self incrementLine].
		self advance.
	].

	self advance.
	self addTokenWithType: #STRING andLiteral: (source copyFrom: start + 1 to: current - 2). 

	
	
	
	! !

!LoxScanner methodsFor: 'scanning - private' stamp: 'JS 10/17/2022 03:48:12'!
scanToken

	| currentCharacter |
	currentCharacter := self advance.
	
	currentCharacter = $( ifTrue: [^self addTokenWithType: #LEFT_PAREN].
	currentCharacter = $) ifTrue: [^self addTokenWithType: #RIGHT_PAREN].
	currentCharacter = ${ ifTrue: [^self addTokenWithType: #LEFT_BRACE].
	currentCharacter = $} ifTrue: [^self addTokenWithType: #RIGHT_BRACE].
	currentCharacter = $, ifTrue: [^self addTokenWithType: #COMMA].
	currentCharacter = $. ifTrue: [^self addTokenWithType: #DOT].
	currentCharacter = $- ifTrue: [^self addTokenWithType: #MINUS].
	currentCharacter = $+ ifTrue: [^self addTokenWithType: #PLUS].
	currentCharacter = $; ifTrue: [^self addTokenWithType: #SEMICOLON].
	currentCharacter = $* ifTrue: [^self addTokenWithType: #STAR].
	
	currentCharacter = $!! ifTrue: [
		(self match: $=)
			ifTrue: [^self addTokenWithType: #BANG_EQUAL]
			ifFalse: [^self addTokenWithType: #BANG]
	].
	currentCharacter = $= ifTrue: [
		(self match: $=)
			ifTrue: [^self addTokenWithType: #EQUAL_EQUAL]
			ifFalse: [^self addTokenWithType: #EQUAL]
	].
	currentCharacter = $< ifTrue: [
		(self match: $=)
			ifTrue: [^self addTokenWithType: #LESS_EQUAL]
			ifFalse: [^self addTokenWithType: #LESS]
	].
	currentCharacter = $> ifTrue: [
		(self match: $=)
			ifTrue: [^self addTokenWithType: #GREATER_EQUAL]
			ifFalse: [^self addTokenWithType: #GREATER]
	].
	
	currentCharacter = $/ ifTrue: [
		(self match: $/)
			ifTrue: [
				[self peek ~= (Character newLineCharacter) & self isAtEnd not] whileTrue: [
					self advance.
				].
				^self
			]
			ifFalse: [^self addTokenWithType: #SLASH]
	].
	
	currentCharacter = $" ifTrue: [^self scanStringToken].
	currentCharacter isDigit ifTrue: [^self scanNumberToken].
	(currentCharacter isLetter or: [currentCharacter = $_]) ifTrue: [^self scanIdentifierOrReservedWordToken].
	
	currentCharacter = Character tab ifTrue: [^self].
	currentCharacter = Character space ifTrue: [^self].
	currentCharacter = Character newLineCharacter ifTrue: [^self incrementLine].
	
	self error: (self class unexpectedCharacterErrorMessageLine: line)
	
	
	! !


!LoxScanner methodsFor: 'scan' stamp: 'JS 10/17/2022 03:32:41'!
tokens

	[self isAtEnd not] whileTrue: [ 
		self scanToken. 
		start := current 
	].
	
	tokens add: (LoxToken withType: #EOF lexeme: '' literal: nil line: line).
	
	^tokens! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoxScanner class' category: 'LoxInterpreter'!
LoxScanner class
	instanceVariableNames: ''!

!LoxScanner class methodsFor: 'instance creation' stamp: 'JS 10/7/2022 01:23:48'!
withSource: aSource 
	
	^self new initializeWithSource: aSource ! !


!LoxScanner class methodsFor: 'error messages' stamp: 'JS 10/17/2022 03:52:04'!
unexpectedCharacterErrorMessageLine: aLineNumber

	^'unexpected character - line: ', aLineNumber asString! !

!LoxScanner class methodsFor: 'error messages' stamp: 'JS 10/17/2022 03:54:10'!
unterminatedStringErrorMessageLine: aLineNumber

	^'unterminated string - line: ', aLineNumber asString! !


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
