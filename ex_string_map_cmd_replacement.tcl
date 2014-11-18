#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" ${1+"$@"}
package require Tcl 8.4

# author: Tuyen M. Duong (tmduong2000@yahoo.com)
# website: http://www.tduongsj.com
# date: 2014-11-18
#

proc funct_getYear {} {
	set year [clock format [clock seconds] -format "%Y"]
	if {$year != 2014} {
		set year 2014
	}
	return $year 
}

proc funct_getYearString {year {type 0}} {
	if {$year == "2014"} {
		set year_str [expr {$type ? "two-thousand-and-fourteen" : "two thousands and fourteen"}]
		return "a year of $year_str"
	} else {
		return "a year of an unknown year"
	}
}


proc check_string_map_cmd_replacement {data mapKey replaceStr expected_elements checkType {isHardCode 0}} {

	if {$isHardCode} {
		# assume data is: This year is 2014.
		# and we want to replace "2014" to "a year of two thousands and fourteen"
		set data "This year is 2014."
		puts "data before replacement: $data"
		set new_data [string map {2014 {a year of two thousands and fourteen}} $data]
		puts "+[string repeat - 19]+"
		puts "| Test Result: [expr {$data == $new_data ? {FAIL} : {PASS}} ] |"
		puts "+[string repeat - 19]+"
		puts "data after replacement: $new_data"
		return
	}
	
	puts "data before replacement: $data"
	puts "mapKey data            : $mapKey"
	puts "replceStr data         : $replaceStr"

	if { $checkType eq "STRINGTYPE" } {
		# treat lst_key_value as string type
		set lst_key_value "$mapKey $replaceStr"
	} else {
		# checkType is LISTTYPE
		# treat lst_key_value as list type
		set lst_key_value [list $mapKey $replaceStr]
	}
	
	set total_elements [llength $lst_key_value]
	puts "data of lst_key_value            : $lst_key_value"
	puts "total elements in lst_key_value  : $total_elements"
	puts "is a valid list of key-value pair: [expr {$total_elements % 2 ? {NO} : {YES}}]" 
	
	if { [catch {set data [string map -nocase $lst_key_value $data]} errMsg ]} {
		puts "+[string repeat - 19]+"
		puts "| Test Result: FAIL |"
		puts "+[string repeat - 19]+"
		puts "Error: $errMsg"
		puts "This is error of an invalid key-pair list"
	} else {
		if {$total_elements == $expected_elements} {
			puts "+[string repeat - 19]+"
			puts "| Test Result: PASS |"
			puts "+[string repeat - 19]+"
			puts "data after replacement: $data"
		} else {
			puts "+[string repeat - 19]+"
			puts "| Test Result: FAIL |"
			puts "+[string repeat - 19]+"
			puts "data after replace being unexpected: $data"
			puts "Reason: expected elements is not as same as lst_key_value elements"
			puts "\tTotal elements in lst_key_value: $total_elements"
			puts "\tExpected elements: $expected_elements"
		}
	}
}

set data {This year is 2014.}

# case 1: hard-code mapping key - value
puts "Test case 1: hard-code mapping key-value pairs"
check_string_map_cmd_replacement dontcare dontcare dontcare dontcare dontcare 1

puts "\n[string repeat - 80]"

# case 2: dynamic mapping key-value pair mapString as string
#         using yearString type = 0
set year [funct_getYear]
set yearStr [funct_getYearString $year 0]
puts "Test case 2: dynamic mapping key-value pair mapString as string\
		using yearString type = 0"
check_string_map_cmd_replacement $data $year $yearStr 2 STRINGTYPE

puts "\n[string repeat - 80]"


# case 3: dynamic mapping key-value pair mapString as string
#         using yearString type = 1
set year [funct_getYear]
set yearStr [funct_getYearString $year 1]
puts "Test case 3: dynamic mapping key-value pair mapString as string\
		using yearString type = 1"
check_string_map_cmd_replacement $data $year $yearStr 2 STRINGTYPE

puts "\n[string repeat - 80]"

# case 4: dynamic mapping key-value pair mapString as LIST
#         using yearString type = 0
set year [funct_getYear]
set yearStr [funct_getYearString $year 0]
puts "Test case 4: dynamic mapping key-value pair mapString as LIST\
		using yearString type = 0"
check_string_map_cmd_replacement $data $year $yearStr 2 LISTTYPE

puts "\n[string repeat - 80]"


# case 5: dynamic mapping key-value pair mapString as LIST
#         using yearString type = 1
set year [funct_getYear]
set yearStr [funct_getYearString $year 1]
puts "Test case 5: dynamic mapping key-value pair mapString as LIST\
		using yearString type = 1"
check_string_map_cmd_replacement $data $year $yearStr 2 LISTTYPE

puts "\n[string repeat - 80]"