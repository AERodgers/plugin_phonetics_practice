Add menu command: "Objects",
              ... "Praat",
              ... "Anto's Phonetics Practice...",
              ... "",
              ... 0,
              ... "scripts/phonetics_practice.praat"


# Build activity include lines ------------------------------------------------v
# Set define initial variables
validActs = 0
activities = Create Strings as directory list: "activities", "activities"
numActivities = Get number of strings
activitiesTable = Create Table with column names: "activities", 0, "proc title"
# find all valid activities
for curActivity to numActivities
    iAmValid = 0
    selectObject: activities
    curActivity$ = Get string: curActivity
    curAddress$ =  "activities/" + curActivity$ + "/activity.proc"

    if fileReadable(curAddress$)
        curActivityProc = Read Strings from raw text file: curAddress$
        numLines = Get number of strings
        myKindaString$ = Get string: 1
        iAmValid = (myKindaString$  == "#metadataValid")
        iAmValid = (numLines * iAmValid ) > 0
        if iAmValid
            validActs += 1
            actTitle$[validActs] = Get string: 2
            tempLen = length(actTitle$[validActs])
            actTitle$[validActs] = right$ (actTitle$[validActs], tempLen - 1)
            actProc$[validActs] = Get string: 3
            tempLen = length(actProc$[validActs])
            actProc$[validActs] = right$ (actProc$[validActs], tempLen - 1)
            newLine$[validActs] = "include ../activities/" +
                            ... actProc$[validActs] +
                            ... "/activity.proc"

            selectObject: activitiesTable
            Append row
            Set string value: validActs, "proc", actProc$[validActs]
            Set string value: validActs, "title", actTitle$[validActs]
        endif
        removeObject: curActivityProc
    endif
endfor
selectObject: activitiesTable
Save as tab-separated file: "scripts/activities.Table"
removeObject: activitiesTable
removeObject: activities

# generate base phonetics_practice.praat script -------------------------------v
# get original script
origScript =  Read Strings from raw text file: "scripts/original_script.praat"
numLines = Get number of strings
finalScript$ = "scripts/phonetics_practice.praat"
curLine$ = Get string: 1
writeFileLine: finalScript$, "# define number of valid activities"
appendFileLine: finalScript$, "validActs = 'validActs'"

for i to numLines
    curLine$ = Get string: i
    appendFileLine: finalScript$, curLine$
endfor
removeObject: origScript
# -----------------------------------------------------------------------------^

# Add "include" lines to the phonetics_practice.praat script ------------------v
appendFileLine: finalScript$, ""
appendFileLine: finalScript$, "# Base Procedures ----------------------------" +
                          ... "---------------------------------v"
procs = Create Strings as file list: "procs", "procs"
numProcs = Get number of strings
for i to numProcs
    curProc$ = Get string: i
    appendFileLine: finalScript$, "include ../procs/" + curProc$
endfor

removeObject: procs
appendFileLine: finalScript$, "# --------------------------------------------" +
                          ... "---------------------------------v^"

# append activity procedure scripts
appendFileLine: finalScript$, ""
appendFileLine: finalScript$, "# Activities ---------------------------------" +
                          ... "---------------------------------v"
for i to validActs
    appendFileLine:  finalScript$, newLine$[i]
endfor
appendFileLine: finalScript$, "# --------------------------------------------" +
                          ... "---------------------------------v^"
# -----------------------------------------------------------------------------^
