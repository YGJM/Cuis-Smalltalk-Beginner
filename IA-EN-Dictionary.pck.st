'From Cuis 5.0 of 7 November 2016 [latest update: #3485] on 28 November 2018 at 10:41:30 am'!
'Description Please enter a description for this package'!
!provides: 'IA-EN-Dictionary' 1 1!
SystemOrganization addCategory: #'IA-EN-Dictionary'!


!classDefinition: #IEDict category: #'IA-EN-Dictionary'!
Object subclass: #IEDict
	instanceVariableNames: ''
	classVariableNames: 'DictData'
	poolDictionaries: ''
	category: 'IA-EN-Dictionary'!
!classDefinition: 'IEDict class' category: #'IA-EN-Dictionary'!
IEDict class
	instanceVariableNames: ''!


!IEDict commentStamp: '<historical>' prior: 0!
I'm learning Cuis-Smalltalk.!

!IEDict class methodsFor: 'lookup' stamp: 'YA 11/28/2018 10:35:16'!
englishContains: aString
	"Answer all definition pairs which contain aString looking in the English side"

	| matchStr |
	matchStr :=  ('*' , aString , '*' ) .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]
! !

!IEDict class methodsFor: 'lookup' stamp: 'YA 11/28/2018 10:37:06'!
englishStarts: aString
	"Answer all definition pairs which starts with aString looking in the English side"

	| matchStr |
	matchStr :=  aString , '*'  .
	
	^DictData select: [ :pairArray | matchStr match: (pairArray at: 1) ]! !

!IEDict class methodsFor: 'class initialization' stamp: 'YA 11/28/2018 10:22:13'!
initialize
	"Read in my data"
"
	IEDict initialize.
"
	| curIndex aLine |
	DictData := Array new: 46723. "We know the exact size (wc -l iedict.txt) less 1"

	(self package fullFileName asFileEntry parent  // 'ejdic-hand-utf8.txt') readStreamDo: [ :fileStream |
		fileStream nextLine. "Skip initial comment line"
		curIndex := 1.
		aLine := fileStream nextLine. 
		[aLine isNil] whileFalse: [
			DictData at: curIndex 
				  put: ((aLine findBetweenSubStrs: '\t') 
						collect: [:str| str withBlanksTrimmed]). 
			aLine := fileStream nextLine. 
			curIndex := 1 + curIndex.
		]
	] ! !
IEDict initialize!
