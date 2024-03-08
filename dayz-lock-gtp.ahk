;#Persistent
;#NoEnv

; Initialize variables
global currentCombination := "0000"
global endCombination := "1000"
global running := true

; Start with F1
F1::StartBruteForce()

; Pause with F2
F2::PauseBruteForce()

; Stop with F3
F3::StopBruteForce()

StartBruteForce() {
    currentCombination := InputBox("Enter the current combination (e.g., 0123):", "Current Combination", "", "0000").Value
    endCombination := InputBox("Enter the end combination for stopping (e.g., 6789):", "End Combination", "", "9999").Value
    focus := InputBox("Enter the focused dial index (0-3):", "Dial Focus", "", "0").Value
    global running
    While (running and (currentCombination != endCombination)) {
        ;9999
        if(currentCombination = 0) {
            focus := SetFocus(focus,0)
            IncrementDial()
            currentCombination+=1
        }
        else if(Mod(currentCombination,9999) = 0) {
            running := false
            MsgBox("Done","9999 reached")
        }
        ;#999
        else if(Mod(currentCombination,999) = 0) {
            focus := SetFocus(focus,3)
            IncrementDial()
            focus := SetFocus(focus,2)
            IncrementDial()
            focus := SetFocus(focus,1)
            IncrementDial()
            focus := SetFocus(focus,0)
            IncrementDial()
            currentCombination+=1
        }
        ;##99
        else if (Mod(currentCombination,99) = 0) {
            focus := SetFocus(focus,2)
            IncrementDial()
            focus := SetFocus(focus,1)
            IncrementDial()
            focus := SetFocus(focus,0)
            IncrementDial()
            currentCombination+=1
        }
        ; ###9
        else if (Mod(currentCombination,9) = 0) {
            focus := SetFocus(focus,1)
            IncrementDial()
            currentCombination+=1
            focus := SetFocus(focus,0)
            IncrementDial9()
            currentCombination+=9
        }
        else{
            focus := SetFocus(focus,0)
            IncrementDial()
            currentCombination+=1
        }
        
        ;MsgBox("Combo ", currentCombination)
        Tooltip("Current combination: " . currentCombination)
        Sleep(100)
    }
    Tooltip  ; Remove the tooltipFF
    if (currentCombination = endCombination) {
        MsgBox("Reached end combination!")
    }
}

PauseBruteForce() {
    running := !running
    if (running) {
        MsgBox("Resuming brute force...")
        Tooltip("Current combination: " . currentCombination)
    } else {
        MsgBox("Pausing brute force...")
        Tooltip  ; Remove the tooltip
    }
}

SetFocus(focus, target) {
    While( focus != target){
        IncrementFocus()
        focus := Mod(focus +1,4 )
    }
    return focus
}

StopBruteForce() {
    running := false
    MsgBox("Stopping brute force...")
    Tooltip  ; Remove the tooltip
}

IncrementFocus(){
    Send("{F down}")
    Sleep(45)
    Send("{F up}")
    Sleep(45)
}

IncrementDial() {
    ; Simulate holding down 'F' key for 900 milliseconds to increment the dial
    Send("{F down}")
    Sleep(900)
    Send("{F up}")
}

IncrementDial10() {
    ; Simulate holding down 'F' key for 900 milliseconds to increment the dial
    Send("{F down}")
    Sleep(6450)
    Send("{F up}")
}

IncrementDial9() {
    ; Simulate holding down 'F' key for 900 milliseconds to increment the dial
    Send("{F down}")
    Sleep(5805)
    Send("{F up}")
}

