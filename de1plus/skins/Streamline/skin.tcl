package require de1 1.0

##############################################################################################################################################################################################################################################################################
# STREAMLINE SKIN
##############################################################################################################################################################################################################################################################################

# you should replace the JPG graphics in the 2560x1600/ directory with your own graphics. 
source "[homedir]/skins/default/standard_includes.tcl"

#load_font "Inter-Regular10" "[skin_directory]/Inter-Regular.ttf" 11

# Left column labels
load_font "Inter-Bold16" "[skin_directory]/Inter-SemiBold.ttf" 13

# GHC buttons
load_font "Inter-Bold12" "[skin_directory]/Inter-SemiBold.ttf" 12

# Profile buttons
load_font "Inter-Bold11" "[skin_directory]/Inter-SemiBold.ttf" 11

# status
load_font "Inter-Bold18" "[skin_directory]/Inter-SemiBold.ttf" 11

# status bold
load_font "Inter-SemiBold18" "[skin_directory]/Inter-Bold.ttf" 11

# +/- buttons
load_font "Inter-Bold24" "[skin_directory]/Inter-ExtraLight.ttf" 29

# profile 
load_font "Inter-HeavyBold24" "[skin_directory]/Inter-SemiBold.ttf" 17

# X and Y axis font
load_font "Inter-Regular20" "[skin_directory]/Inter-Regular.ttf" 12

# X and Y axis font
load_font "Inter-Regular12" "[skin_directory]/Inter-Regular.ttf" 11

# Scale disconnected msg
load_font "Inter-Black18" "[skin_directory]/Inter-SemiBold.ttf" 14

# Vertical bar in top right buttons
load_font "Inter-Thin14" "[skin_directory]/Inter-Thin.ttf" 14

set left_label_color #05386c
set scale_disconnected_color #cd5360

set ::pages [list off steam espresso water flush info hotwaterrinse]
set ::pages_not_off [list steam espresso water flush info hotwaterrinse]

dui page add $::pages -bg_color "#FFFFFF"
#add_de1_page $::pages "pumijo2.jpg"

# load a default profile if none is loaded
if {[ifexists ::settings(profile_filename)] == ""} {
	select_profile "default"

}

if {$::android != 1} {
	proc cause_random_data {} {
		set x [steamtemp]
		set x [pressure]
		set x [watertemp]
		set x [waterflow]
		set x [water_mix_temperature]
		after 1000 cause_random_data
	}
	cause_random_data
}



############################################################################################################################################################################################################
# draw the background shapes

# far left grey area where buttons appear
rectangle $::pages 0 0 657 1600 #efefef

# empty area on 2/3rd of the right side
rectangle $::pages 657 0 2560 1600 #ffffff

# lower horizontal bar where shot data is shown
if {$::settings(ghc_is_installed) == 0} { 
	rectangle $::pages 687 1220 2130 1566 #efefef
} else {
	rectangle $::pages 687 1220 2480 1566 #efefef
}

#line separating the left grey box
rectangle $::pages 0 824 660 836 #ffffff

rectangle $::pages 58 603 590 604 #121212
rectangle $::pages 58 1061 590 1062 #121212
rectangle $::pages 58 1282 590 1283 #121212

############################################################################################################################################################################################################

############################################################################################################################################################################################################
# DYE support

set dyebtns ""

if { [plugins enabled DYE] } {
	package require sqlite3
	if { [plugins available SDB] } {
		plugins enable SDB
	}
	dui page load DYE current 

	set dyebtn1 [list -text "DYE" -font "Inter-Bold11" -foreground $left_label_color -exec "show_DYE_page" ]
	set dyebtn2 [list -text "        " -font "Inter-Bold11"]
	set dyebtn3 [list -text "DYE" -font "Inter-Bold11" -foreground $left_label_color -exec "show_DYE_page" ]
	set dyebtn4 [list -text "        " -font "Inter-Bold11"]

	set dyebtns "$dyebtn1 $dyebtn2 $dyebtn3 $dyebtn4"
}

proc show_DYE_page {} {
	if { [plugins enabled DYE] } {
		plugins::DYE::open -which_shot default -theme MimojaCafe -coords {700 250} -anchor nw
	}
}
############################################################################################################################################################################################################



############################################################################################################################################################################################################
# top right line with profile name and various text labels that are buttons


	#[list -text "Tare" -font "Inter-Bold11" -foreground $left_label_color -exec "puts 1" ] \
	#[list -text "        " -font "Inter-Bold11"] \

	#[list -text "Clean" -font "Inter-Bold11" -foreground $left_label_color -exec  { say [translate {settings}] $::settings(sound_button_in); show_settings} ] \
	#[list -text "        " -font "Inter-Bold11"] \
	#[list -text "Grind @ 15" -font "Inter-Bold11" -foreground $left_label_color -exec "puts 1" ] \
	#[list -text "     |     " -font "Inter-Thin14"] \

set toprightbtns [add_de1_rich_text $::pages 2500 44 right 0 40 "#FFFFFF" [list \
	$dyebtns  \
	[list -text "Settings" -font "Inter-Bold12" -foreground $left_label_color -exec  { say [translate {settings}] $::settings(sound_button_in); show_settings} ] \
	[list -text {        } -font "Inter-Bold12"] \
	[list -text "Sleep" -font "Inter-Bold12" -foreground $left_label_color -exec "say [translate {sleep}] $::settings(sound_button_in);start_sleep" ] \
]]

add_de1_variable $::pages 700 54 -justify left -anchor "nw" -font Inter-HeavyBold24 -fill $left_label_color -width [rescale_x_skin 1200] -textvariable {[ifexists settings(profile_title)]} 


############################################################################################################################################################################################################
# The status message on the top right. Might be clickable.

# testing
#after 1000 {set ::streamline_global(status_msg_text) [translate "Scale Disconnected!"]}
#after 1000 {set ::streamline_global(status_msg_clickable) [translate "Reconnect"]}

set ::streamline_global(status_msg_text) ""
set ::streamline_global(status_msg_clickable) ""

proc streamline_status_msg_click {} {
	puts "ERROR TAPPED $::streamline_global(status_msg_clickable)"	
}

set streamline_status_msg [add_de1_rich_text $::pages 2500 164 right 0 40 "#FFFFFF" [list \
	[list -text {$::streamline_global(status_msg_text)}  -font "Inter-Black18" -foreground $scale_disconnected_color  ] \
	[list -text "   " -font "Inter-Black18"] \
	[list -text {$::streamline_global(status_msg_clickable)}  -font "Inter-Black18" -foreground "#1967d4" -exec "streamline_status_msg_click" ] \
]]

trace add variable ::streamline_global(status_msg_clickable) write ::refresh_$streamline_status_msg

############################################################################################################################################################################################################



rectangle $::pages 700 136 2502 136 #121212

############################################################################################################################################################################################################



############################################################################################################################################################################################################
# The Mix/Group/Steam/Tank status line


set btns [list \
	[list -text "Mix" -font "Inter-Bold18" -foreground #121212  ] \
	[list -text " " -font "Inter-Bold18"] \
	[list -text {[mixtemp_text 1]} -font "Inter-SemiBold18" -foreground #121212   ] \
	[list -text "   " -font "Inter-SemiBold18"] \
	[list -text "Group" -font "Inter-Bold18" -foreground #121212  ] \
	[list -text " " -font "Inter-SemiBold18"] \
	[list -text {[group_head_heater_temperature_text 1]} -font "Inter-SemiBold18" -foreground #121212  ] \
	[list -text "   " -font "Inter-Bold16"] \
	[list -text "Steam" -font "Inter-Bold18" -foreground #121212  ] \
	[list -text " " -font "Inter-SemiBold18"] \
	[list -text {[steam_heater_temperature_text 1]} -font "Inter-SemiBold18" -foreground #121212 ] \
	[list -text "   " -font "Inter-Bold16"] \
	[list -text "Tank" -font "Inter-Bold18" -foreground #121212  ] \
	[list -text " " -font "Inter-Bold16"] \
	[list -text {[round_to_tens [water_tank_level_to_milliliters $::de1(water_level)]] [translate ml]} -font "Inter-SemiBold18" -foreground #121212  ] \
	[list -text "   " -font "Inter-Bold16"] \
]

if {$::settings(scale_bluetooth_address) != ""} {
	lappend btns [list -text "Weight" -font "Inter-Bold18" -foreground #1967d4  -exec "::device::scale::tare" ] 
	lappend btns [list -text " " -font "Inter-Bold16"  -exec "puts tare" ]
	lappend btns [list -text {[drink_weight_text]} -font "Inter-Bold18" -foreground #1967d4  -exec "::device::scale::tare" ]
	lappend btns [list -text "   " -font "Inter-Bold16"]



	

}

set streamline_status_msg [add_de1_rich_text $::pages 702 158 left 1 50 "#FFFFFF" $btns ]

# GH temp
#trace add variable ::de1(head_temperature) write ::refresh_$streamline_status_msg

# steam temp
#trace add variable ::de1(steam_heater_temperature) write ::refresh_$streamline_status_msg

# mix temp
#trace add variable ::de1(mix_temperature) write ::refresh_$streamline_status_msg

# tank level
#trace add variable ::de1(water_level) write ::refresh_$streamline_status_msg

if {$::settings(scale_bluetooth_address) == ""} {
	#trace add variable ::de1(scale_weight) write ::refresh_$streamline_status_msg
}
############################################################################################################################################################################################################



############################################################################################################################################################################################################
# draw text labels for the buttons on the left margin

# labels
add_de1_text $::pages 60 318 -justify left -anchor "nw" -text [translate "Dose"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 60 434 -justify left -anchor "nw" -text [translate "Beverage"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 60 655 -justify left -anchor "nw" -text [translate "Temp"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 60 892 -justify left -anchor "nw" -text [translate "Steam"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 60 1117 -justify left -anchor "nw" -text [translate "Flush"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 60 1338 -justify left -anchor "nw" -text [translate "Hot Water"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200]

# tap areas
add_de1_button "off" {puts "Dose"} 37 292 236 388 ""
add_de1_button "off" {puts "Beverage"} 37 407 236 503 ""
add_de1_button "off" {puts "Temp"} 37 628 236 724 ""
add_de1_button "off" {puts "Steam"} 37 866 236 962 ""
add_de1_button "off" {puts "Flush"} 37 1089 236 1185 ""
add_de1_button "off" {toggle_streamline_hot_water_setting} 37 1310 236 1406 ""

############################################################################################################################################################################################################


############################################################################################################################################################################################################
# data card on the bottom center

# labels
add_de1_text $::pages 980 1239 -justify right -anchor "ne" -text [translate "14 Sep, 18:45"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 300]
add_de1_text $::pages 980 1272 -justify right -anchor "ne" -text [translate "Extractamundo"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 300]
add_de1_text $::pages 980 1357 -justify right -anchor "ne" -text [translate "Preinfusion"] -font Inter-Bold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 980 1419 -justify right -anchor "ne" -text [translate "Extraction"] -font Inter-Bold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 980 1484 -justify right -anchor "ne" -text [translate "Total"] -font Inter-Bold18 -fill #121212 -width [rescale_x_skin 200]


# rounded rectangle color 
#dui aspect set -theme default -type dbutton outline "#A0A0A0"

# inside button color
#dui aspect set -theme default -type dbutton fill "#A0A0A0"

# font color
#dui aspect set -theme default -type dbutton label_fill "#121212"

#dui add dbutton $::pages 702 1244 763 1298 -tags profile_back -label "asdf"  -command { puts profile_back } 
#dui add dbutton $::pages 980 1244 1041 1298 -tags profile_fwd -label "asdf"  -command { puts profile_fwd } 
# rounded rectangle color 
#dui aspect set -theme default -type dbutton outline "#D8D8D8"
dui aspect set -theme default -type dbutton outline "#efefef"

# inside button color
dui aspect set -theme default -type dbutton fill "#efefef"

# font color
dui aspect set -theme default -type dbutton label_fill "#121212"

# font to use
dui aspect set -theme default -type dbutton label_font Inter-Bold11

# rounded retangle radius
dui aspect set -theme default -type dbutton radius 18

# rounded retangle line width
dui aspect set -theme default -type dbutton width 2 

# button shape
dui aspect set -theme default -type dbutton shape round_outline 

# label position is higher because we're using a _ as a minus symbol
dui aspect set -theme default -type dbutton label_pos ".50 .5" 



dui aspect set -theme default -type dbutton_symbol fill #121212
dui aspect set -theme default -type dbutton_symbol font_size 12
dui aspect set -theme default -type dbutton_symbol pos ".50 .5"

if {$::android == 1 || $::undroid == 1} {
	dui add dbutton $::pages 705 1244 766 1298 -tags profile_back -symbol "arrow-left"  -command { puts profile_back } 
	dui add dbutton $::pages 1000 1244 1061 1298 -tags profile_fwd -symbol "arrow-right"  -command { puts profile_fwd } 
} else {
	dui add dbutton $::pages 705 1244 766 1298  -tags profile_back -label "<"  -command { puts profile_back } 
	dui add dbutton $::pages 1000 1244 1061 1298  -tags profile_fwd -label ">"  -command { puts profile_fwd } 
}

add_de1_text $::pages 1084 1254 -justify right -anchor "nw" -text [translate "Time"] -font Inter-Bold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1084 1357 -justify right -anchor "nw" -text [translate "15s"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1084 1419 -justify right -anchor "nw" -text [translate "30s"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1084 1483 -justify right -anchor "nw" -text [translate "45s"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]

add_de1_text $::pages 1205 1254 -justify right -anchor "nw" -text [translate "Weight"] -font Inter-Bold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1205 1357 -justify right -anchor "nw" -text [translate "10g"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1205 1419 -justify right -anchor "nw" -text [translate "29g"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1205 1483 -justify right -anchor "nw" -text [translate "39g"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]

add_de1_text $::pages 1346 1254 -justify right -anchor "nw" -text [translate "Volume"] -font Inter-Bold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1346 1357 -justify right -anchor "nw" -text [translate "17ml"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1346 1419 -justify right -anchor "nw" -text [translate "30ml"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1346 1483 -justify right -anchor "nw" -text [translate "47ml"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]

add_de1_text $::pages 1495 1254 -justify right -anchor "nw" -text [translate "Temp"] -font Inter-Bold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1495 1357 -justify right -anchor "nw" -text [translate "90ºC"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1495 1419 -justify right -anchor "nw" -text [translate "90ºC-86ºC"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]

add_de1_text $::pages 1677 1254 -justify right -anchor "nw" -text [translate "Flow"] -font Inter-Bold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1677 1357 -justify right -anchor "nw" -text [translate "1.5ml/s"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]
add_de1_text $::pages 1677 1419 -justify right -anchor "nw" -text [translate "3.8ml/s"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 200]

add_de1_text $::pages 1828 1254 -justify right -anchor "nw" -text [translate "Pressure"] -font Inter-Bold18 -fill #121212 -width [rescale_x_skin 300]
add_de1_text $::pages 1828 1362 -justify right -anchor "nw" -text [translate "0.9 bar (1.3 peak)"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 300]
add_de1_text $::pages 1828 1419 -justify right -anchor "nw" -text [translate "6.0 bar (6.5 peak)"] -font Inter-SemiBold18 -fill #121212 -width [rescale_x_skin 300]

rectangle $::pages 718 1316 2089 1316 #121212


############################################################################################################################################################################################################




############################################################################################################################################################################################################
# draw current setting numbers on the left margin

set left_label_color #121212

if {[ifexists ::settings(grinder_dose_weight)] == "" || [ifexists ::settings(grinder_dose_weight)] == "0"} {
	set ::settings(grinder_dose_weight) 15
}
#	set ::settings(grinder_dose_weight) 15

# labels
add_de1_variable $::pages 426 341 -justify center -anchor "center" -text [translate "20g"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200] -textvariable {[return_weight_measurement $::settings(grinder_dose_weight)]}
add_de1_variable $::pages 426 435 -justify center -anchor "center" -text [translate "45g"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200] -textvariable {[return_weight_measurement [determine_final_weight] 1]}
add_de1_variable $::pages 426 474 -justify center -anchor "center" -text [translate "1:2.3"] -font Inter-Regular12 -fill $left_label_color -width [rescale_x_skin 200] -textvariable {([dose_weight_ratio])}
add_de1_variable $::pages 426 679 -justify center -anchor "center" -text [translate "92ºC"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200] -textvariable {[setting_espresso_temperature_text 1]}   
add_de1_variable $::pages 426 917 -justify center -anchor "center" -text [translate "31s"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200]  -textvariable {[seconds_text_very_abbreviated $::settings(steam_timeout)]}
add_de1_variable $::pages 426 1137 -justify center -anchor "center" -text [translate "5s"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200] -textvariable {[seconds_text_very_abbreviated $::settings(flush_seconds)]}
add_de1_variable $::pages 426 1358 -justify center -anchor "center" -text [translate "75ml"] -font Inter-Bold16 -fill $left_label_color -width [rescale_x_skin 200] -textvariable {[streamline_hot_water_setting]}

# tap areas
add_de1_button "off" {puts "Dose value"} 359 292 496 388 ""
add_de1_button "off" {puts "Beverage value"} 359 407 496 503 ""
add_de1_button "off" {puts "Temp value"} 359 628 496 724 ""
add_de1_button "off" {puts "Steam value"} 359 866 496 962 ""
add_de1_button "off" {puts "Flush value"} 359 1089 496 1185 ""
add_de1_button "off" {puts "Hot Water value"} 359 1310 496 1406 ""

############################################################################################################################################################################################################

############################################################################################################################################################################################################
# draw current setting numbers on the left margin

set left_label_color_selected #121212
set left_label_color #777777

#########
# dose/beverage labels
add_de1_text $::pages 94 552 -justify center -anchor "center" -text [translate "18:36"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 234 552 -justify center -anchor "center" -text [translate "19:39"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 388 552 -justify center -anchor "center" -text [translate "20.5:42"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 554 552 -justify center -anchor "center" -text [translate "21:44"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]

# dose/beverage tap areas
add_de1_button "off" {puts "Dose value 1"} 37 521 169 584 ""
add_de1_button "off" {puts "Dose value 2"} 169 521 301 584 ""
add_de1_button "off" {puts "Dose value 3"} 301 521 466 584 ""
add_de1_button "off" {puts "Dose value 4"} 466 521 613 584 ""
#########

#########
# temp labels
add_de1_text $::pages 94 774 -justify center -anchor "center" -text [translate "75ºC"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 234 774 -justify center -anchor "center" -text [translate "80ºC"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 388 774 -justify center -anchor "center" -text [translate "92ºC"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 554 774 -justify center -anchor "center" -text [translate "85ºC"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]

# temp tap areas
add_de1_button "off" {puts "Temp value 1"} 37 743 169 806 ""
add_de1_button "off" {puts "Temp value 2"} 169 743 301 806 ""
add_de1_button "off" {puts "Temp value 3"} 301 743 466 806 ""
add_de1_button "off" {puts "Temp value 4"} 466 743 613 806 ""
#########

#########
# steam labels
add_de1_text $::pages 94 1014 -justify center -anchor "center" -text [translate "25s"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 234 1014 -justify center -anchor "center" -text [translate "29s"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 388 1014 -justify center -anchor "center" -text [translate "31s"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 554 1014 -justify center -anchor "center" -text [translate "40s"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]

# steam tap areas
add_de1_button "off" {puts "steam value 1"} 37 983 169 1046 ""
add_de1_button "off" {puts "steam value 2"} 169 983 301 1046 ""
add_de1_button "off" {puts "steam value 3"} 301 983 466 1046 ""
add_de1_button "off" {puts "steam value 4"} 466 983 613 1046 ""
#########

#########
# flush labels
add_de1_text $::pages 94 1230 -justify center -anchor "center" -text [translate "2s"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 234 1230 -justify center -anchor "center" -text [translate "5s"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 388 1230 -justify center -anchor "center" -text [translate "10s"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 554 1230 -justify center -anchor "center" -text [translate "15s"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]

# flush tap areas
add_de1_button "off" {puts "flush value 1"} 37 1194 169 1257 ""
add_de1_button "off" {puts "flush value 2"} 169 1194 301 1257 ""
add_de1_button "off" {puts "flush value 3"} 301 1194 466 1257 ""
add_de1_button "off" {puts "flush value 4"} 466 1194 613 1257 ""
#########


#########
# hot water labels
add_de1_text $::pages 94 1454 -justify center -anchor "center" -text [translate "75ml"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 234 1454 -justify center -anchor "center" -text [translate "120ml"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 388 1454 -justify center -anchor "center" -text [translate "180ml"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 554 1454 -justify center -anchor "center" -text [translate "200ml"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]

add_de1_text $::pages 94 1534 -justify center -anchor "center" -text [translate "75ºC"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 234 1534 -justify center -anchor "center" -text [translate "80ºC"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 388 1534 -justify center -anchor "center" -text [translate "85ºC"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]
add_de1_text $::pages 554 1534 -justify center -anchor "center" -text [translate "90ºC"] -font Inter-Bold11 -fill $left_label_color -width [rescale_x_skin 200]


# hot water tap areas
add_de1_button "off" {puts "hot water value 1"} 37 1424 169 1489 ""
add_de1_button "off" {puts "hot water value 2"} 169 1424 301 1489 ""
add_de1_button "off" {puts "hot water value 3"} 301 1424 466 1489 ""
add_de1_button "off" {puts "hot water value 4"} 466 1424 613 1489 ""

add_de1_button "off" {puts "hot water value 5"} 37 1489 169 1566 ""
add_de1_button "off" {puts "hot water value 6"} 169 1489 301 1566 ""
add_de1_button "off" {puts "hot water value 7"} 301 1489 466 1566 ""
add_de1_button "off" {puts "hot water value 8"} 466 1489 613 1566 ""
#########



############################################################################################################################################################################################################



############################################################################################################################################################################################################
# four ESPRESSO PROFILE shotcut buttons at the top left


proc refresh_favorite_profile_button_labels {} {


	set profiles [ifexists ::settings(favorite_profiles)]
	set streamline_selected_favorite_profile ""
	catch {
		set streamline_selected_favorite_profile [dict get $profiles selected number]
	}

	if {$streamline_selected_favorite_profile == ""} {
		after 500 streamline_profile_select 1
		set streamline_selected_favorite_profile 1
	}


	set profiles [ifexists ::settings(favorite_profiles)]

	set b1 ""
	set b2 ""
	set b3 ""
	set b4 ""

	catch {
		set b1 [dict get $profiles 1 title]
		#regsub -all {/} $b1 {:} b1
	}
	catch {
		set b2 [dict get $profiles 2 title]
		#regsub -all {/} $b2 {:} b2
	}
	catch {
		set b3 [dict get $profiles 3 title]
		#regsub -all {/} $b3 {:} b3
	}
	catch {
		set b4 [dict get $profiles 4 title]
		#regsub -all {/} $b4 {:} b4
		#puts "b4: '$b4'"
	}

	set changed 0
	if {$b1 == ""} {
		set b1 "Default"
		set t1 "default"
		dict set profiles 1 name $t1
		dict set profiles 1 title $b1
		set changed 1
	}

	if {$b2 == ""} {
		set b2 "Adaptive (for medium roasts)"
		set t2 "best_practice"		
		dict set profiles 2 name $t2
		dict set profiles 2 title $b2
		set changed 1
	}

	if {$b3 == ""} {
		set b3 "Rao Allongé"
		set t3 "rao_allonge"		
		dict set profiles 3 name $t3
		dict set profiles 3 title $b3
		set changed 1
	}

	if {$b4 == ""} {
		set b4 "Cleaning/ Forward Flush x5"
		set t4 "Cleaning_forward_flush_x5"		
		dict set profiles 4 name $t4
		dict set profiles 4 title $b4
		set changed 1
	}


	if {$changed == 1} {
		set ::settings(favorite_profiles) $profiles	
		save_settings	
	}

	set ::streamline_favorite_profile_buttons(label_1) $b1
	set ::streamline_favorite_profile_buttons(label_2) $b2
	set ::streamline_favorite_profile_buttons(label_3) $b3
	set ::streamline_favorite_profile_buttons(label_4) $b4

	#puts "b1: $b1 / b2: $b2 / b3 : $b3 / b4: $b4"

	set b1c "#d8d8d8"
	set b2c "#d8d8d8"
	set b3c "#d8d8d8"
	set b4c "#d8d8d8"

	set lb1c "#3e5682"
	set lb2c "#3e5682"
	set lb3c "#3e5682"
	set lb4c "#3e5682"

	#regsub -all {/} $::settings(profile_title) {/ } profile_title
	#puts "profile_title: '$profile_title' vs '$b4'"
	#set  $slot

	if {$streamline_selected_favorite_profile == 1} {
		set b1c "#3e5682"
		set lb1c "#ffffff"
	} elseif {$streamline_selected_favorite_profile == 2} {
		set b2c "#3e5682"
		set lb2c "#ffffff"
	} elseif {$streamline_selected_favorite_profile == 3} {
		set b3c "#3e5682"
		set lb3c "#ffffff"
	} elseif {$streamline_selected_favorite_profile == 4} {
		set b4c "#3e5682"
		set lb4c "#ffffff"
	}
	.can itemconfigure profile_1_btn-btn -fill $b1c
	.can itemconfigure profile_2_btn-btn -fill $b2c
	.can itemconfigure profile_3_btn-btn -fill $b3c
	.can itemconfigure profile_4_btn-btn -fill $b4c
	#.can itemconfigure profile_4_btn-out-ne -fill "#ff0000"

	#dui item config "off" profile_4_btn-out-ne  -outline "#ff0000"

	#.can itemconfigure profile_1_btn-out -fill $b1c
	#.can itemconfigure profile_2_btn-out -fill $b2c
	#.can itemconfigure profile_3_btn-out -fill $b3c
	#.can itemconfigure profile_4_btn-out -fill $b4c

	.can itemconfigure profile_1_btn-lbl -fill $lb1c
	.can itemconfigure profile_2_btn-lbl -fill $lb2c
	.can itemconfigure profile_3_btn-lbl -fill $lb3c
	.can itemconfigure profile_4_btn-lbl -fill $lb4c
}


####
# favorite profile buttons


# rounded rectangle color 
dui aspect set -theme default -type dbutton outline "#efefef"

# inside button color
dui aspect set -theme default -type dbutton fill "#d8d8d8"
#d8d8d8


# font to use
dui aspect set -theme default -type dbutton label_font Inter-Bold11

# rounded retangle radius
dui aspect set -theme default -type dbutton radius 18

# rounded rectangle line width
dui aspect set -theme default -type dbutton width 2


# width of the text, to enable auto-wrapping
dui aspect set -theme default -type dbutton_label width [rescale_x_skin 480]

# button shape
dui aspect set -theme default -type dbutton shape round_outline 

# label position
dui aspect set -theme default -type dbutton label_pos ".50 .50" 

####
# the selected profile button

# button color
#dui aspect set -theme default -type dbutton fill "#3e5682"
dui aspect set -theme default -type dbutton fill "#d8d8d8"

# font color
#dui aspect set -theme default -type dbutton label_fill "#ffffff"
dui aspect set -theme default -type dbutton label_fill "#3c5782"

# width of text of profile selection button
dui aspect set -theme default -type dbutton_label width 220


# button color
dui aspect set -theme default -type dbutton fill "#d8d8d8"

# font color
dui aspect set -theme default -type dbutton label_fill "#3c5782"

#  -longpress_cmd { puts "ERRORlongpress" }
dui add dbutton $::pages 58 27 311 136 -tags profile_1_btn -labelvariable {$::streamline_favorite_profile_buttons(label_1)}  -command { streamline_profile_select 1 }
dui add dbutton $::pages 341 27 592 136 -tags profile_2_btn -labelvariable {$::streamline_favorite_profile_buttons(label_2)}  -command { streamline_profile_select 2 } 
dui add dbutton $::pages 58 157 311 267 -tags profile_3_btn -labelvariable {$::streamline_favorite_profile_buttons(label_3)} -command { streamline_profile_select 3 } 
dui add dbutton $::pages 341 157 592 267 -tags profile_4_btn -labelvariable {$::streamline_favorite_profile_buttons(label_4)}   -command { streamline_profile_select 4 } 

refresh_favorite_profile_button_labels

#dui add dbutton "off" 58 157 311 267 -tags profile_3_btn -labelvariable {$::streamline_favorite_profile_buttons(label_3)} -command { streamline_profile_select 3 } 
#.can itemconfigure profile_3_btn-btn -fill "#ff0000"
#.can itemconfigure $::streamline_favorite_profile_buttons(2) -fill "#3e5682"

#dui item config $::streamline_favorite_profile_buttons(1) label -fill "#3e5682"

#puts "ERROR [dui item config $::streamline_favorite_profile_buttons(3)]"


############################################################################################################################################################################################################


############################################################################################################################################################################################################
# plus/minus +/- buttons on the left hand side for changing parameters

# rounded rectangle color 
dui aspect set -theme default -type dbutton outline "#D8D8D8"

# inside button color
set ::plus_minus_flash_on_color  "#a5a5a5"
set ::plus_minus_flash_on_color2  "#c0c0c0"
set ::plus_minus_flash_off_color "#d8d8d8"
set ::plus_minus_flash_refused_color "#e34e4e"

dui aspect set -theme default -type dbutton fill $::plus_minus_flash_off_color

# font color
dui aspect set -theme default -type dbutton label_fill "#121212"

# font to use
dui aspect set -theme default -type dbutton label_font Inter-Bold24 

# rounded retangle radius
dui aspect set -theme default -type dbutton radius 18

# rounded retangle line width
dui aspect set -theme default -type dbutton width 2 

# button shape
dui aspect set -theme default -type dbutton shape round_outline 

# label position is higher because we're using a _ as a minus symbol
dui aspect set -theme default -type dbutton label_pos ".50 .22" 


# the - buttons
dui add dbutton $::pages 262 292 359 388 -tags streamline_minus_dose_btn -label "_"  -command { streamline_dose_btn - } 
dui add dbutton $::pages 262 407 359 503 -tags streamline_minus_beverage_btn -label "_"  -command { streamline_beverage_btn - } 
dui add dbutton $::pages 262 629 359 725 -tags streamline_minus_temp_btn -label "_"  -command { streamline_temp_btn - } 
dui add dbutton $::pages 262 866 359 962 -tags streamline_minus_steam_btn -label "_"  -command { streamline_steam_btn - } 
dui add dbutton $::pages 262 1089 359 1185 -tags streamline_minus_flush_btn -label "_"  -command { streamline_flush_btn - } 
dui add dbutton $::pages 262 1310 359 1406 -tags streamline_minus_hotwater_btn -label "_"  -command { streamline_hotwater_btn - } 

# label position
dui aspect set -theme default -type dbutton label_pos ".50 .44" 

# the + buttons
dui add dbutton $::pages 495 292 591 388 -tags streamline_plus_dose_btn -label "+"  -command { streamline_dose_btn + } 
dui add dbutton $::pages 495 407 591 503 -tags streamline_plus_beverage_btn -label "+"  -command { streamline_beverage_btn + } 
dui add dbutton $::pages 495 629 591 725 -tags streamline_plus_temp_btn -label "+"  -command { streamline_temp_btn + } 
dui add dbutton $::pages 495 866 591 962 -tags streamline_plus_steam_btn -label "+"  -command { streamline_steam_btn + } 
dui add dbutton $::pages 495 1089 591 1185 -tags streamline_plus_flush_btn -label "+"  -command { streamline_flush_btn + } 
dui add dbutton $::pages 495 1310 591 1406 -tags streamline_plus_hotwater_btn -label "+"  -command { streamline_hotwater_btn + } 

############################################################################################################################################################################################################

proc save_profile_and_update_de1 {} {

	set current_title [ifexists ::settings(profile_title)]
	set ::settings(original_profile_title) $current_title
	save_profile 0
	set new_title [ifexists ::settings(profile_title)]
	if {$current_title != $new_title} {
		#puts "ERROR profile title has changed: $current_title vs $new_title, new filename: $::settings(profile_filename)"


		####
		# update the profiles buttons if the title has changed
		set profiles [ifexists ::settings(favorite_profiles)]

		set slot [dict get $profiles selected number]	

		dict set profiles $slot name $::settings(profile_filename)
		dict set profiles $slot title $::settings(profile_title)

		set ::settings(favorite_profiles) $profiles
		set var "label_$slot"
		set ::streamline_favorite_profile_buttons($var) $::settings(profile_title)
		####


	}

	#puts "ERROR save_profile_and_update_de1 '$new_title' '$::settings(profile_filename)'"

	save_settings_to_de1
}

proc save_profile_and_update_de1_soon {} {

	if {[info exists ::streamline_save_update_id] == 1} {
		after cancel $::streamline_save_update_id; 
		unset -nocomplain ::streamline_save_update_id
	}

	set ::streamline_save_update_id [after 1000 save_profile_and_update_de1]
}

proc flash_button {buttontag firstcolor finalcolor} {
	.can itemconfigure $buttontag-btn -fill $::plus_minus_flash_on_color2 
	after 50 "flash2_button $buttontag $firstcolor $finalcolor"
}

proc flash2_button {buttontag firstcolor finalcolor} {
	.can itemconfigure $buttontag-btn -fill $::plus_minus_flash_on_color
	after 100 "flash3_button $buttontag $firstcolor ::plus_minus_flash_off_color"
}
proc flash3_button {buttontag firstcolor finalcolor} {
	.can itemconfigure $buttontag-btn -fill $::plus_minus_flash_on_color2 
	after 50 ".can itemconfigure $buttontag-btn -fill $::plus_minus_flash_off_color"
}

proc streamline_dose_btn { args } {
	if {$args == "-"} {
		if {$::settings(grinder_dose_weight) > 1} {
			set ::settings(grinder_dose_weight) [expr {$::settings(grinder_dose_weight) - .1}]
			flash_button "streamline_minus_dose_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
			save_profile_and_update_de1_soon
		}
	} elseif {$args == "+"} {
		if {$::settings(grinder_dose_weight) < 30} {
			set ::settings(grinder_dose_weight) [expr {$::settings(grinder_dose_weight) + .1}]
			flash_button "streamline_plus_dose_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
			save_profile_and_update_de1_soon
		}
	}
}

proc streamline_beverage_btn { args } {
	if {$args == "-"} {
		if {[determine_final_weight] > 0} {
			determine_final_weight -1
			flash_button "streamline_minus_beverage_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
			save_profile_and_update_de1_soon
		}
	} elseif {$args == "+"} {
		if {[determine_final_weight] < 1000} {
			determine_final_weight 1
			flash_button "streamline_plus_beverage_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
			save_profile_and_update_de1_soon
		}
	}
}


proc streamline_temp_btn { args } {
	if {$args == "-"} {
		if {$::settings(espresso_temperature) > 1} {
			set ::settings(espresso_temperature) [expr {$::settings(espresso_temperature) - 1}]
			flash_button "streamline_minus_temp_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
			save_profile_and_update_de1_soon
		}
	} elseif {$args == "+"} {
		if {$::settings(espresso_temperature) < 110} {
			set ::settings(espresso_temperature) [expr {$::settings(espresso_temperature) + 1}]
			flash_button "streamline_plus_temp_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
			save_profile_and_update_de1_soon
		}
	}
}

proc streamline_steam_btn { args } {
	if {$args == "-"} {
		if {$::settings(steam_timeout) > 1} {
			set ::settings(steam_timeout) [expr {$::settings(steam_timeout) - 1}]
			flash_button "streamline_minus_steam_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
			save_profile_and_update_de1_soon
		}
	} elseif {$args == "+"} {
		if {$::settings(steam_timeout) < 254} {
			set ::settings(steam_timeout) [expr {$::settings(steam_timeout) + 1}]
			flash_button "streamline_plus_steam_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
			save_profile_and_update_de1_soon
		}
	}
}
proc streamline_flush_btn { args } {
	if {$args == "-"} {
		if {$::settings(flush_seconds) > 3} {
			set ::settings(flush_seconds) [expr {$::settings(flush_seconds) - 1}]
			flash_button "streamline_minus_flush_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
			save_profile_and_update_de1_soon
		} else {
			#flash_button "streamline_minus_flush_btn" $::plus_minus_flash_refused_color $::plus_minus_flash_off_color
		}
	} elseif {$args == "+"} {
		if {$::settings(flush_seconds) < 254} {
			set ::settings(flush_seconds) [expr {$::settings(flush_seconds) + 1}]
			flash_button "streamline_plus_flush_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
			save_profile_and_update_de1_soon
		} else {
			#flash_button "streamline_plus_flush_btn" $::plus_minus_flash_refused_color $::plus_minus_flash_off_color
		}
	}
}

set ::streamline_hotwater_btn_mode "ml"
proc streamline_hotwater_btn { args } {

	if {$::streamline_hotwater_btn_mode == "ml"} {
		# ui mode is set to change the hot water volume
		if {$args == "-"} {
			if {$::settings(water_volume) > 1} {
				set ::settings(water_volume) [expr {$::settings(water_volume) - 1}]
				flash_button "streamline_minus_hotwater_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
				save_profile_and_update_de1_soon
			}
		} elseif {$args == "+"} {
			if {$::settings(water_volume) < 1000} {
				set ::settings(water_volume) [expr {$::settings(water_volume) + 1}]
				flash_button "streamline_plus_hotwater_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
				save_profile_and_update_de1_soon
			}
		}
	} else {
		# the UI mode is set to change the temperature
		if {$args == "-"} {
			if {$::settings(water_temperature) > 1} {
				set ::settings(water_temperature) [expr {$::settings(water_temperature) - 1}]
				flash_button "streamline_minus_hotwater_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
				save_profile_and_update_de1_soon
			}
		} elseif {$args == "+"} {
			if {$::settings(water_volume) < 110} {
				set ::settings(water_temperature) [expr {$::settings(water_temperature) + 1}]
				flash_button "streamline_plus_hotwater_btn" $::plus_minus_flash_on_color $::plus_minus_flash_off_color
				save_profile_and_update_de1_soon
			}
		}
	}
}

proc streamline_hot_water_setting {} {
	if {$::streamline_hotwater_btn_mode == "ml"} {
		#return [return_liquid_measurement $::settings(water_volume)]
		return [subst {[return_liquid_measurement $::settings(water_volume)]\n([return_temperature_measurement $::settings(water_temperature) 1])}]
	}

	return [subst {[return_temperature_measurement $::settings(water_temperature) 1]\n([return_liquid_measurement $::settings(water_volume)])}]
	#return [return_temperature_measurement $::settings(water_temperature) 1]
}

proc toggle_streamline_hot_water_setting {} {
	if {$::streamline_hotwater_btn_mode == "ml"} {
		set ::streamline_hotwater_btn_mode "temp"
	} else {
		set ::streamline_hotwater_btn_mode "ml"
	}

}

streamline_hot_water_setting

############################################################################################################################################################################################################
# Profile QuickSettings

# font to use
dui aspect set -theme default -type dbutton label_font Inter-Bold24 

# label position
dui aspect set -theme default -type dbutton label_pos ".50 .5" 

# font color
dui aspect set -theme default -type dbutton label_fill "#ffffff"

# rounded rectangle color 
dui aspect set -theme default -type dbutton outline "#b9bcdd"

# inside button color
dui aspect set -theme default -type dbutton fill "#b9bcdd"

dui aspect set -theme default -type dbutton radius 26

dui add dbutton "settings_1" 80 1460 200 1580  -tags profile_btn_1 -label "1"  -command { save_favorite_profile 1 } 
dui add dbutton "settings_1" 220 1460 340 1580   -tags profile_btn_2 -label "2"  -command { save_favorite_profile 2 } 
dui add dbutton "settings_1" 360 1460 480 1580  -tags profile_btn_3 -label "3"  -command { save_favorite_profile 3} 
dui add dbutton "settings_1" 500 1460 620 1580  -tags profile_btn_4 -label "4"  -command { save_favorite_profile 4 } 

proc streamline_profile_select { slot } {

	if {[dui page current] != "off"} {
		return ""
	}

	set profiles [ifexists ::settings(favorite_profiles)]
	select_profile [dict get $profiles $slot name]
	dict set profiles selected number $slot
	set ::settings(favorite_profiles) $profiles

	streamline_adjust_chart_x_axis
	refresh_favorite_profile_button_labels
}

proc save_favorite_profile { slot } {
	set profiles [ifexists ::settings(favorite_profiles)]

	dict set profiles $slot name $::settings(profile_filename)
	dict set profiles $slot title $::settings(profile_title)

	set ::settings(favorite_profiles) $profiles
	#refresh_favorite_profile_button_labels
	refresh_favorite_profile_button_labels
	#save_settings
	borg toast [translate "Saved favorite profile"]
}

############################################################################################################################################################################################################



############################################################################################################################################################################################################
# Four GHC buttons on bottom right

if {$::settings(ghc_is_installed) == 0} { 

	# color of the button icons
	dui aspect set -theme default -type dbutton_symbol fill #121212

	# font size of the button icons
	dui aspect set -theme default -type dbutton_symbol font_size 24

	# position of the button icons
	dui aspect set -theme default -type dbutton_symbol pos ".50 .38"

	# rounded rectangle color 
	dui aspect set -theme default -type dbutton outline "#121212"

	# inside button color
	dui aspect set -theme default -type dbutton fill "#FFFFFF"

	# font color
	dui aspect set -theme default -type dbutton label_fill "#121212"

	# font to use
	dui aspect set -theme default -type dbutton label_font Inter-Bold12 

	# rounded retangle radius
	dui aspect set -theme default -type dbutton radius 18

	# rounded retangle line width
	dui aspect set -theme default -type dbutton width 2 

	# button shape
	dui aspect set -theme default -type dbutton shape round_outline 

	# label position
	dui aspect set -theme default -type dbutton label_pos ".50 .75" 


	# Four GHC buttons on bottom right
	if {$::android == 1 || $::undroid == 1} {
		set s1 "mug"
		set s2 "clouds"
		set s3 "droplet"
		set s4 "shower-down"
		set s5 "hand"
	} else {
		set s1 "C"
		set s2 "S"
		set s3 "W"
		set s4 "F"
		set s5 "S"
	}
	dui add dbutton "off" 2159 1216 2316 1384 -tags espresso_btn -symbol $s1 -label [translate "Coffee"]   -command {say [translate {Espresso}] $::settings(sound_button_in); start_espresso} 
	dui add dbutton "off" 2159 1401 2316 1566 -tags steam_btn -symbol $s2 -label [translate "Steam"]   -command {say [translate {Steam}] $::settings(sound_button_in); start_steam} 
	dui add dbutton "off" 2336 1216 2497 1384 -tags water_btn -symbol $s3 -label [translate "Water"]   -command {say [translate {Water}] $::settings(sound_button_in); start_water} 
	dui add dbutton "off" 2336 1401 2497 1566 -tags flush_btn -symbol $s4 -label [translate "Flush"]  -command {say [translate {Flush}] $::settings(sound_button_in); start_flush} 

	# stop button
	#dui add dbutton "espresso water steam hotwaterrinse" 2159 1216 2494 1566 -tags espresso_btn -symbol $s5  -label [translate "Stop"] -command {say [translate {Stop}] $::settings(sound_button_in); start_idle} 
	dui aspect set -theme default -type dbutton outline "#d9505e"
	dui aspect set -theme default -type dbutton label_fill "#d9505e"
	dui aspect set -theme default -type dbutton_symbol fill #d9505e
	dui add dbutton "espresso water steam hotwaterrinse" 2200 1256 2470 1526 -tags espresso_btn -symbol $s5  -label [translate "Stop Coffee"] -command {say [translate {Stop Coffee}] $::settings(sound_button_in); start_idle} 
}

############################################################################################################################################################################################################



############################################################################################################################################################################################################
# the espresso chart

set ::pressurelinecolor "#0ba581"
set ::flow_line_color "#1e67c7"
set ::temperature_line_color "#bb5f6b"

set ::pressurelinecolor_god "#5deea6"
set ::flow_line_color_god "#a7d1ff"
set ::temperature_line_color_god "#ffafb4"
set ::weightlinecolor_god "#edd4c1"
set ::chart_background "#FFFFFF"

set ::pressurelabelcolor "#121212"
set ::temperature_label_color "#ff7880"
set ::flow_label_color "#1e67c7"
set ::grid_color "#E0E0E0"

set charts_width 1830

add_de1_widget $::pages graph 680 250 { 

	set ::streamline_chart $widget

	$widget element create line_espresso_pressure_goal -xdata espresso_elapsed -ydata espresso_pressure_goal -symbol none -label "" -linewidth [rescale_x_skin 2] -color $::pressurelinecolor  -smooth $::settings(live_graph_smoothing_technique)  -pixels 0 -dashes {5 5}; 
	$widget element create line_espresso_pressure -xdata espresso_elapsed -ydata espresso_pressure -symbol none -label "" -linewidth [rescale_x_skin 6] -color $::pressurelinecolor  -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes $::settings(chart_dashes_pressure); 
	
	$widget element create line_espresso_state_change_1 -xdata espresso_elapsed -ydata espresso_state_change -label "" -linewidth [rescale_x_skin 2] -color #121212  -pixels 0 ; 

	$widget element create line_espresso_flow_goal  -xdata espresso_elapsed -ydata espresso_flow_goal -symbol none -label "" -linewidth [rescale_x_skin 2] -color $::flow_line_color -smooth $::settings(live_graph_smoothing_technique) -pixels 0  -dashes {5 5}; 
	$widget element create line_espresso_flow  -xdata espresso_elapsed -ydata espresso_flow -symbol none -label "" -linewidth [rescale_x_skin 6] -color $::flow_line_color -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes $::settings(chart_dashes_flow);  

	$widget element create line_espresso_temperature_goal -xdata espresso_elapsed -ydata espresso_temperature_goal10th -symbol none -label ""  -linewidth [rescale_x_skin 2] -color $::temperature_line_color -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes {5 5}; 
	$widget element create line_espresso_temperature_basket -xdata espresso_elapsed -ydata espresso_temperature_basket10th -symbol none -label ""  -linewidth [rescale_x_skin 6] -color $::temperature_line_color -smooth $::settings(live_graph_smoothing_technique) -pixels 0 -dashes $::settings(chart_dashes_temperature);  

	$widget element create line_espresso_de1_explanation_chart_temp -xdata espresso_de1_explanation_chart_elapsed -ydata espresso_de1_explanation_chart_temperature  -label "" -linewidth [rescale_x_skin 15] -color $::temperature_line_color  -smooth $::settings(preview_graph_smoothing_technique) -pixels 0; 

	# show the explanation
	$widget element create line_espresso_de1_explanation_chart_pressure -xdata espresso_de1_explanation_chart_elapsed -ydata espresso_de1_explanation_chart_pressure  -label "" -linewidth [rescale_x_skin 15] -color $::pressurelinecolor  -smooth $::settings(preview_graph_smoothing_technique) -pixels 0; 
	$widget element create line_espresso_de1_explanation_chart_flow -xdata espresso_de1_explanation_chart_elapsed_flow -ydata espresso_de1_explanation_chart_flow -label "" -linewidth [rescale_x_skin 15] -color $::flow_line_color  -smooth $::settings(preview_graph_smoothing_technique) -pixels 0; 

	gridconfigure $widget 

	$widget axis configure x -color $::pressurelabelcolor -tickfont Inter-Regular20 -linewidth [rescale_x_skin 2] -subdivisions 5 -majorticks {0 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250} 
	$widget axis configure y -color $::pressurelabelcolor -tickfont Inter-Regular20 -min 0 -max [expr {$::de1(max_pressure) + 0.01}] -subdivisions 5 -majorticks {1 2 3 4 5 6 7 8 9 10 11 12} 
} -plotbackground $::chart_background -width [rescale_x_skin $charts_width] -height [rescale_y_skin 943] -borderwidth 1 -background $::chart_background -plotrelief flat -plotpady 10 -plotpadx 10  
############################################################################################################################################################################################################


proc streamline_adjust_chart_x_axis {} {

	set widget $::streamline_chart
	set sz [espresso_pressure length]

	#puts "streamline_adjust_chart_x_axis $sz"
	if {$sz < 2} {
		$widget axis configure x -majorticks {0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160 165 170 175 180 185 190 195 200 205 210 215 220 225 230 235 240 245 250 255} 
		#-subdivisions 4
	} elseif {$sz < 99} {
		$widget axis configure x -majorticks {1 2 3 4 5 6 7 8 9 10 11 12 13 14} 
		#-subdivisions 2
	} elseif {$sz < 300} {
		$widget axis configure x -majorticks {1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 } 
		#$widget axis configure x -majorticks {1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60} 
		#-subdivisions 5
	} elseif {$sz < 600} {
		$widget axis configure x -majorticks {0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64} 
		#-subdivisions 5
	} elseif {$sz < 1200} {
		$widget axis configure x -majorticks {0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64} 
		#-subdivisions 5
	} else  {
		$widget axis configure x -majorticks {} 
		#-subdivisions 5
	}

	after 1000 streamline_adjust_chart_x_axis
	
}
streamline_adjust_chart_x_axis

add_de1_button "saver descaling cleaning" {say [translate {awake}] $::settings(sound_button_in); set_next_page off off; page_show off; start_idle; de1_send_waterlevel_settings;} 0 0 2560 1600 "buttonnativepress"

#add_de1_button "sleep" {say [translate {sleep}] $::settings(sound_button_in);set_next_page off off; after 1000 start_idle} 0 0 2560 1600


#after 100 "show_settings settings_1"


