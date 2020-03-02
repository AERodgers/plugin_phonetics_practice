# define number of valid activities
validActs = 2
# ^ Lines will be inserted above to define  validActs
#
# Anto's Phonetics Practice
# =========================
# Written for Praat 6.0.40 or later
#
# script by Antoin Eoin Rodgers
# rodgeran@tcd.ie
# Phonetics and speech Laboratory, Trinity College Dublin
# Feb 29, 2020
#
# This script was written to help students in my phonetics and phonology
# classes come to grips with transciption and some elements of acoustic
# phonetics.
#
# If you have installed the "plugin_phonetics_practice" directory correctly,
# you will be able to run [Anto's Phonetic Practice...] from the [Praat] menu.

## version check
version$ = praatVersion$
if number(left$(version$, 1)) < 6
    echo You are running Praat 'praatVersion$'.
    ... 'newline$'This script runs on Praat version 6.0.40 or later.
    ... 'newline$'To run this script, update to the latest
    ... version at praat.org
    exit
endif

## Draw attention to menu window
writeInfoLine:  "Welcome to Anto's Phonetic Practice"
appendInfoLine: "==================================="
appendInfoLine: "Information will appear in this window from time to time."
appendInfoLine: "Keep an eye on it!"

@mainMenu: validActs

# Base Procedures -------------------------------------------------------------v
include ../procs/changeIni.proc
include ../procs/changeIniShow.proc
include ../procs/menus.proc
include ../procs/playShowHide.proc
include ../procs/updateActivities.proc
# -----------------------------------------------------------------------------v^

# Activities ------------------------------------------------------------------v
include ../activities/sawtooth/activity.proc
include ../activities/week_05_transcription/activity.proc
# -----------------------------------------------------------------------------v^
