#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" ${1+"$@"}
package require Tcl 8.4

# author: Tuyen M. Duong (tmduong2000@yahoo.com)
# website: http://www.tduongsj.com
# date: 2014-11-17

puts "Hello World!"
puts "----------------------"
puts "Total # arguments: $argc"
for {set i 0} {$i < $argc } {incr i} {
	puts "argument $i: [lindex $argv $i]"
}