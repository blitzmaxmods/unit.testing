SuperStrict

'	UNIT TESTING HELPER
'	(c) Si Dunford [Scaremonger], Dec 2024, All rights reserved
'	Version 1.2
'

Rem
bbdoc: unit.testing
about: 
End Rem
Module unit.testing
Import BRL.retro

ModuleInfo "Copyright: Si Dunford, Dec 2024, All Rights Reserved"
ModuleInfo "Author:    Si Dunford"
ModuleInfo "Version:   1.2"
ModuleInfo "License:   MIT"

ModuleInfo "History: V1.0, 12 OCT 23"
ModuleInfo "History: Initial test functions"
ModuleInfo "History: V1.1, 15 DEC 24"
ModuleInfo "History: Created module, functions moved into TUnitTest"
ModuleInfo "History: V1.2, 21 DEC 24"
ModuleInfo "History: TUnitTest to object from Singleton"

Type TUnitTest

	Field tabstops:Int[] = [3,4,28,10]
	Field COUNTER:Int = 0					' Test count

	Method New()
		COUNTER = 0
	End Method

	Method New( widths:Int[] )
		COUNTER = 0
		setTab( widths )
	End Method

	' Write a break into the tabular output
	Method break()
		Local cols:String[] = New String[tabstops.Length]
		For Local n:Int = 0 Until tabstops.Length
			cols[n] = Replace(" "[..tabstops[n]]," ","-")
		Next
		write( cols )
	End Method

	' Simple check that two strings are equal
	Method check:Int( title:String, result:String, expected:String )
		COUNTER :+ 1
		If result = expected
			write([ String(COUNTER), "PASS", escape(title), "Strings match" ])
			Return True
		EndIf
		write([ String(COUNTER), "FAIL", escape(title), "Expected '"+expected+"', got '"+result+"'" ])
	End Method
		
	' Allocate a test index
	Method getIndex:Int()
		COUNTER :+ 1
		Return COUNTER
	End Method

	' Write a heading to the output
	Method heading( str:String )
		Print Upper( str )
		Print Replace(" "[..str.Length]," ","=")
	End Method

	' Set a specific column width
	Method setTab( index:Int, width:Int )
		Assert index>=0 And index<tabstops.Length, "UnitTest.SetTab(); Invalid index: "+index
		tabstops[ index ] = width
	End Method

	' Reset all column widths
	Method setTab( widths:Int[] )
		Assert widths.Length=tabstops.Length, "UnitTest.SetTab(); Column count should be: "+tabstops.Length
		tabstops = widths
	End Method
	
	' Write columnar results to output
	Method write( data:String[] )
		Local line:String, error:String
		For Local n:Int = 0 Until tabstops.Length
			If n+1 >= tabstops.Length
				' Last column
				If n<data.Length; line  :+ data[n]
			Else
				' Middle column
				line  :+ data[n][..tabstops[n]] + "|"
				If data[n].Length > tabstops[n]
					If error; error :+ "~n"
					error :+ "* Cannot fit "+data[n].Length+" chars in Column "+(n+1)
				End If
			End If
		Next
		Print line
		If error; Print error
	End Method

	Private Method escape:String( str:String )
		Local s:String = Replace( str, "~t","/t" )
		s = Replace( s, "~t","\t" )
		s = Replace( s, "~r","\r" )
		s = Replace( s, "~n","\n" )
		's = Replace( s, "~q",Chr(34) )
		Return s
	End Method

End Type

