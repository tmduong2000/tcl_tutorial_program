#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" ${1+"$@"}
package require Tcl 8.4

# author: Tuyen M. Duong (tmduong2000@yahoo.com)
# website: http://www.tduongsj.com
# date: 2014-11-18
#

proc check_diff_betw_str_n_list {expect_val {checkType STRINGTYPE} } {
	# string
	set str " \"Hello World\"     \"foo  bar\"   \"testing string and list\"  "
	puts "variable str value: $str"
	
	# string len of $str: 59
	set str_len [string length $str]  ; # str_len value: 59
	puts "total characters of str: $str_len"
	 
	# list
	# assign str value to variable lst
	set lst $str
	
	# verify 1: check string length of this list
	set len [string length $lst]  ; # len value: 59
	
	# verify 2: check total element in this list
	set  lst_len [llength $lst]   ; # lst_len value: 3
	
	puts "variable lst value     : $lst"
	puts "total characters of lst: $len"
	puts "total elements in lst  : $lst_len"
	puts [string repeat - 50]
	
	# verify 3: check string length of each element in lst
	#    11 + 8 + 23 = 42
	set first_element      [lindex $lst 0]
	set second_element [lindex $lst 1]
	set third_element     [lindex $lst 2]
	set len_1st_element [string length $first_element]  ; # len_1st_element value: 11
	set len_2nd_element [string length $second_element]  ; # len_2nd_element value: 8
	set len_3rd_element [string length $third_element]  ; # len_3rd_3lement value: 23
	
	puts "Now, print data and string length of each element in lst"
	puts "first element value                    : $first_element"
	puts "first element length                   : $len_1st_element"
	puts "second element value                   : $second_element"
	puts "second element length                  : $len_2nd_element"
	puts "third element value                    : $third_element"
	puts "third element length                   : $len_3rd_element"
	puts "sum of len (1st, 2nd, 3rd) elements + 2:\
		[expr {$len_1st_element + $len_2nd_element + $len_3rd_element}]"
		
	if {$checkType eq "STRINGTYPE"} {
		# join this list to make this lst as a clean list
		set new_lst [join $lst " "]
		# verify 4: check string length of new_lst
		set new_len [string length $new_lst]  ; #  new_len value: 44    YES, this is expected.
		# verify 5: check total elements of new_lst
		set new_lst_len [llength $new_lst] ; # new_lst_len value: 8    FAIL, we expect 3 elements
		puts "+--------------------------+"
		puts "| After using join command |"
		puts "+--------------------------+"
		puts "variable new_lst value                 : $new_lst"
		puts "total characters of new_list           : $new_len"
		puts "total elements in new_list             : $new_lst_len"
		set result "Test Result: (result: $new_lst_len\) , \(expected value: $expect_val\) ->\
			[expr {$new_lst_len == $expect_val ? {PASS} : {FAIL}}]"
		puts "+[string repeat - [expr {[string length $result] + 2}]]+"
		puts "| $result |"
		puts "+[string repeat - [expr {[string length $result] + 2}]]+"
	} else {
		# checkkType = "LISTTYPE"
		# using built-in function list to construct a new_lst
		set new_lst [list   $first_element     $second_element  $third_element  ]
		# verify 4: check string length of new_lst
		set new_len [string length $new_lst]  ; #  new_len value: 44    YES, this is expected.
		# verify 5: check total elements of new_lst
		set new_lst_len [llength $new_lst] ; # new_lst_len value: 3    YES, we expect 3 elements
		puts "+--------------------------+"
		puts "| After using list command |"
		puts "+--------------------------+"
		puts "variable new_lst value                 : $new_lst"
		puts "total characters of new_list           : $new_len"
		puts "total elements in new_list             : $new_lst_len"
		set result "Test Result: (result: $new_lst_len\) , \(expected value: $expect_val\) ->\
			[expr {$new_lst_len == $expect_val ? {PASS} : {FAIL}}]"
		puts "+[string repeat - [expr {[string length $result] + 2}]]+"
		puts "| $result |"
		puts "+[string repeat - [expr {[string length $result] + 2}]]+"
	}
	
}

puts [string repeat # 80]
puts [string repeat # 80]
puts "## Begin Test case 1:\
	\n##\ttesting string type deals with join command, and expect element = 8"
puts [string repeat # 80]
puts [string repeat # 80]
check_diff_betw_str_n_list 8 STRINGTYPE

puts "\n"
puts [string repeat # 80]
puts [string repeat # 80]
puts "## Begin Test case 2:\
	\n##\ttesting list type dealing with list function, and expect element = 3"
puts [string repeat # 80]
puts [string repeat # 80]
check_diff_betw_str_n_list 3 LISTTYPE

