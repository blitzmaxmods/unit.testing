'	UNIT TESTING HELPER
'	(c) Si Dunford [Scaremonger], Dec 2024, All rights reserved
'	Version 1.1
'

Type UnitTest

	Global tabstops:Int[] = [3,4,28,10]
	Global COUNTER:Int = 0					' Test count

	' Set a specific column width
	Function setTab( index:Int, width:Int )
		Assert index>=0 And index<tabstops.Length, "UnitTest.SetTab(); Invalid index: "+index
		tabstops[ index ] = width
	End Function

	' Reset all column widths
	Function setTab( widths:Int[] )
		Assert widths.Length=tabstops.Length, "UnitTest.SetTab(); Column count should be: "+tabstops.Length
		tabstops = widths
	End Function
	
	' Write a heading to the output
	Function heading( str:String )
		Print Upper( str )
		Print Replace(" "[..str.Length]," ","=")
	End Function

	' Allocate a test index
	Function getIndex:Int()
		COUNTER :+ 1
		Return COUNTER
	End function

	' Write columnar results to output
	Function write( data:String[] )
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
	End Function

	' Write a break into the tabular output
	Function break()
		Local cols:String[] = New String[tabstops.Length]
		For Local n:Int = 0 Until tabstops.Length
			cols[n] = Replace(" "[..tabstops[n]]," ","-")
		Next
		write( cols )
	End Function

	' Simple check that two strings are equal
	Function check:Int( title:String, result:String, expected:String )
		COUNTER :+ 1
		If result = expected
			write([ String(COUNTER), "PASS", escape(title), "Strings match" ])
			Return True
		EndIf
		write([ String(COUNTER), "FAIL", escape(title), "Expected '"+expected+"', got '"+result+"'" ])
	End Function

	Function escape:String( str:String )
		Local s:String = Replace( str, "~t","/t" )
		s = Replace( s, "~t","\t" )
		s = Replace( s, "~r","\r" )
		s = Replace( s, "~n","\n" )
		's = Replace( s, "~q",Chr(34) )
		Return s
	End Function

End Type

