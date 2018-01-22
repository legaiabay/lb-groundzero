#AutoIt3Wrapper_icon = @ScriptDir & "\icon.ico"
Global $AppTitle = "GROUND ZERO - SLIMEBOT APP"
Global $AppVersion = "v1.01"
Global $AppDev = "Legaiabay"

#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include <StaticConstants.au3>
#include <Misc.au3>
#Include <Array.au3>

Opt("GUIOnEventMode", 1)

;SHORTCUT
HotKeySet("{F2}", "Start")
HotKeySet("{F4}", "AppExit")

Global $RunningPhase = 0
Global $RunningTime = 0
Global $Runner = False
Global $GetKeyMode = 0
Global $ModeCursorPosition;
Global $SlimeMode
	; 0 = Solo SwordMaster Mode
	; 1 = Solo Sarasa Mode

; Buat Mode Sword Master
Global $MousePos[2]
$MousePos[0] = 0
$MousePos[1] = 0

Global $StartButtonPos[2]
$StartButtonPos[0] = 0
$StartButtonPos[1] = 0

Global $MCclickPos[2]
$MCclickPos[0] = 0
$MCclickPos[1] = 0

Global $Skill1ClickPos[2]
$Skill1ClickPos[0] = 0
$Skill1ClickPos[1] = 0

Global $SkipResultEXPButtonPos[2]
$SkipResultEXPButtonPos[0] = 0
$SkipResultEXPButtonPos[1] = 0

Global $SkipResultPageButtonPos[2]
$SkipResultPageButtonPos[0] = 0
$SkipResultPageButtonPos[1] = 0

$Timer = TimerInit()

;--------------
;GUI
;--------------

;Window
Local $_MainUI_Width = 610;
Local $_MainUI_Height = 600;

;Object Position SetError
Local $_ObjectRowCoverImage = 20
Local $_ObjectRowPosition_1 = 280; +40px
Local $_ObjectRowPosition_2 = 300;
Local $_ObjectRowPosition_3 = 340;
Local $_ObjectRowPosition_3_1 = 370
Local $_ObjectRowPosition_4 = 410;
Local $_ObjectRowPosition_5 = 430;
Local $_ObjectRowPosition_6 = 460;
Local $_ObjectRowPosition_7 = 480;
Local $_ObjectRowPosition_8 = 510;

Local $_ObjectFirstColumnPosition_1 = 20;

;Image Size Set
Local $_ImageWidth_1 = $_MainUI_Width - $_ObjectRowCoverImage * 2;
Local $_ImageHeight_1 = 240;

;Label Size Set
Local $_LabelTitleWidth = 200;
Local $_LabelTitleHeight = 20;
Local $_LabelCursorPosWidth = 110;
Local $_LabelCursorPosHeight = 30;

;Button Size Set
Local $_ButtonOffsetX = 115;
Local $_DefaultButtonWidth_1 = 110;
Local $_DefaultButtonHeight_1 = 30;

;Instantiate Main Window GUI
Local $_MainUI = GUICreate("Ground Zero " & $AppVersion, $_MainUI_Width, $_MainUI_Height)

;Label
Local $_Label_1 = "SET BUTTON POSITION - Current : "
Local $_Label_2 = "STATUS : STOPPED"
Local $_Label_3 = "Start/Stop Slimeblast : F2"
Local $_Label_4 = "Load/Save Latest Config Data"

Local $_Label_SavedCursor_1 = $StartButtonPos[0] & " , " & $StartButtonPos[1]
Local $_Label_SavedCursor_2 = $MCclickPos[0] & " , " & $MCclickPos[1]
Local $_Label_SavedCursor_3 = $Skill1ClickPos[0] & " , " & $Skill1ClickPos[1]
Local $_Label_SavedCursor_4 = $SkipResultEXPButtonPos[0] & " , " & $SkipResultEXPButtonPos[1]
Local $_Label_SavedCursor_5 = $SkipResultPageButtonPos[0] & " , " & $SkipResultPageButtonPos[1]

Local $_LabelInGameButtonPosTitle = GUICtrlCreateLabel($_Label_1, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_1,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_CurrentCursor = GUICtrlCreateLabel("aaaa", 200, $_ObjectRowPosition_1,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_2 = GUICtrlCreateLabel($_Label_2, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_4,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_3 = GUICtrlCreateLabel($_Label_3, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_5,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_4 = GUICtrlCreateLabel($_Label_4, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_6,$_LabelTitleWidth,$_LabelTitleHeight)

GUICtrlSetColor($_LabelGUI_2, $COLOR_RED)

Local $_LabelGUI_SavedCursor_1 = GUICtrlCreateLabel($_Label_SavedCursor_1, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_3,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_2 = GUICtrlCreateLabel($_Label_SavedCursor_2, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 1, $_ObjectRowPosition_3,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_3 = GUICtrlCreateLabel($_Label_SavedCursor_3, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 2, $_ObjectRowPosition_3,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_4 = GUICtrlCreateLabel($_Label_SavedCursor_4, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 3, $_ObjectRowPosition_3,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_5 = GUICtrlCreateLabel($_Label_SavedCursor_5, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 4, $_ObjectRowPosition_3,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)

;Button
Local $_ButtonAbout = "About"
Local $_ButtonText_1_1 = "Start Button"
Local $_ButtonText_1_2 = "MC Image Button"
Local $_ButtonText_1_3 = "Skill 1 Button"
Local $_ButtonText_1_4 = 'Result "Room" Button'
Local $_ButtonText_1_5 = "AP Bar Position (Idle)"
Local $_ButtonText_2_1 = "Load Latest Config"
Local $_ButtonText_2_2 = "Save Config"

Local $_ButtonRow_About = GUICtrlCreateButton($_ButtonAbout, $_ObjectFirstColumnPosition_1 + 450, $_ObjectRowPosition_2 - 80, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_About, "Button_About")
Local $_ButtonRow_1_1 = GUICtrlCreateButton($_ButtonText_1_1, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_2, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_1_1, "Button_1_1")
Local $_ButtonRow_1_2 = GUICtrlCreateButton($_ButtonText_1_2, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 1, $_ObjectRowPosition_2, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_1_2, "Button_1_2")
Local $_ButtonRow_1_3 = GUICtrlCreateButton($_ButtonText_1_3, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 2, $_ObjectRowPosition_2, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_1_3, "Button_1_3")
Local $_ButtonRow_1_4 = GUICtrlCreateButton($_ButtonText_1_4, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 3, $_ObjectRowPosition_2, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_1_4, "Button_1_4")
Local $_ButtonRow_1_5 = GUICtrlCreateButton($_ButtonText_1_5, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 4, $_ObjectRowPosition_2, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_1_5, "Button_1_5")
Local $_ButtonRow_2_1 = GUICtrlCreateButton($_ButtonText_2_1, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_7, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_2_1, "Button_LoadConfig")
Local $_ButtonRow_2_2 = GUICtrlCreateButton($_ButtonText_2_2, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 1, $_ObjectRowPosition_7, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_2_2, "Button_SaveConfig")

;Image
Local $_Phase_Center_Offset = 44

Local $_Image_1 = @ScriptDir & "\image\image_1.jpg"
Local $_Image_Red_Square = @ScriptDir & "\image\red_square.jpg"
Local $_Image_Green_Square = @ScriptDir & "\image\green_square.jpg"
Local $_ImageGui_1 = GUICtrlCreatePic($_Image_1, $_ObjectFirstColumnPosition_1, $_ObjectRowCoverImage, $_ImageWidth_1, $_ImageHeight_1)

Local $_ImageGui_Phase[5]
$_ImageGui_Phase[0] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset, $_ObjectRowPosition_3_1, 20, 20)
$_ImageGui_Phase[1] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 1, $_ObjectRowPosition_3_1, 20, 20)
$_ImageGui_Phase[2] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 2, $_ObjectRowPosition_3_1, 20, 20)
$_ImageGui_Phase[3] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 3, $_ObjectRowPosition_3_1, 20, 20)
$_ImageGui_Phase[4] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 4, $_ObjectRowPosition_3_1, 20, 20)

;Start Show Window
GUISetState(@SW_SHOW, $_MainUI)
GUISetOnEvent($GUI_EVENT_CLOSE, "AppExit")
GUICtrlSetOnEvent($_MainUI,"_sleep")
Sleep(100)

Func RefreshPage()
	Send("{F5}")
 EndFunc

;BUTTON FUNCTION
 func Button_About()
   MsgBox($MB_ICONINFORMATION, "About", $AppTitle & @LF & "Current Version : " & $AppVersion & @LF & "By : " & $AppDev & @LF & "legaiabay@gmail.com")
EndFunc

func Button_LoadConfig()
   LoadConfigData()
EndFunc

func Button_SaveConfig()
   SaveConfigData()
EndFunc

func Button_1_1()
   ConsoleWrite("button1")
		 $ModeCursorPosition = 1
		 SetKeyPos()
EndFunc

func Button_1_2()
   ConsoleWrite("button2")
		 $ModeCursorPosition = 2
		 SetKeyPos()
EndFunc

func Button_1_3()
   ConsoleWrite("button3")
		 $ModeCursorPosition = 3
		 SetKeyPos()
EndFunc

func Button_1_4()
   ConsoleWrite("button4")
		 $ModeCursorPosition = 4
		 SetKeyPos()
EndFunc

func Button_1_5()
   ConsoleWrite("button5")
		 $ModeCursorPosition = 5
		 SetKeyPos()
EndFunc


While 1
   sleep(50)

   $MousePos = MouseGetPos()
   GUICtrlSetData($_LabelGUI_CurrentCursor, $MousePos[0] & " , " & $MousePos[1])

   if $GetKeyMode == 1 Then
	  if _IsPressed("24") Then ; Home Button
		 Switch $ModeCursorPosition
			Case 1
			   $StartButtonPos = MouseGetPos()
			   $info = MsgBox($MB_OK, "Cursor Setting Done", "New position : " & $StartButtonPos[0] & " " & $StartButtonPos[1])
			   GUICtrlSetData($_LabelGUI_SavedCursor_1, $StartButtonPos[0] & " , " & $StartButtonPos[1])
			Case 2
			   $MCclickPos = MouseGetPos()
			   $info = MsgBox($MB_OK, "Cursor Setting Done", "New position : " & $MCclickPos[0] & " " & $MCclickPos[1])
			   GUICtrlSetData($_LabelGUI_SavedCursor_2, $MCclickPos[0] & " , " & $MCclickPos[1])
			Case 3
			   $Skill1ClickPos = MouseGetPos()
			   $info = MsgBox($MB_OK, "Cursor Setting Done", "New position : " & $Skill1ClickPos[0] & " " & $Skill1ClickPos[1])
			   GUICtrlSetData($_LabelGUI_SavedCursor_3, $Skill1ClickPos[0] & " , " & $Skill1ClickPos[1])
			Case 4
			   $SkipResultEXPButtonPos = MouseGetPos()
			   $info = MsgBox($MB_OK, "Cursor Setting Done", "New position : " & $SkipResultEXPButtonPos[0] & " " & $SkipResultEXPButtonPos[1])
			   GUICtrlSetData($_LabelGUI_SavedCursor_4, $SkipResultEXPButtonPos[0] & " , " & $SkipResultEXPButtonPos[1])
			Case 5
			   $SkipResultPageButtonPos = MouseGetPos()
			   $info = MsgBox($MB_OK, "Cursor Setting Done", "New position : " & $SkipResultPageButtonPos[0] & " " & $SkipResultPageButtonPos[1])
			   GUICtrlSetData($_LabelGUI_SavedCursor_5, $SkipResultPageButtonPos[0] & " , " & $SkipResultPageButtonPos[1])
			EndSwitch

		 $ModeCursorPosition = 0
		 GUISetState(@SW_SHOW, $_MainUI)

	  EndIf
   EndIf
WEnd

Func SetKeyPos()
	$info = MsgBox($MB_OK, "Cursor Postition Setting", "Press HOME button while moving cursor to set cursor position")
	GUISetState(@SW_HIDE, $_MainUI)

	if $info == $IDOK Then
	   $GetKeyMode = 1
	   ConsoleWrite($GetKeyMode)
	   GUICtrlSetCursor(-1, 1)
	EndIf
EndFunc

Func Start()

   ConsoleWrite("Runner : " & $Runner)

   Local $_Last_Green_Phase

   if $Runner == False Then
	  $Runner = True
	  GUICtrlSetData($_LabelGUI_2, "STATUS : STARTED")
	  GUICtrlSetColor($_LabelGUI_2, $COLOR_GREEN)
   else
	  $Runner = False
	  GUICtrlSetData($_LabelGUI_2, "STATUS : STOPPED")
	  GUICtrlSetColor($_LabelGUI_2, $COLOR_RED)
   EndIf

   $_MOUSE_MOVE_SPEED = Random (100, 120)

   While $Runner == True

	  ;Klik Button Start
	  ChangePhaseColor(1,5)
	  Sleep(500)
	  if $Runner == False Then
		 ResetPhaseColor()
		 ExitLoop
	  EndIf
	  $_MOUSE_X_1 = $StartButtonPos[0] + Random(-10, 10)
	  $_MOUSE_Y_1 = $StartButtonPos[1] + Random(-10, 10)
	  MouseMove($_MOUSE_X_1, $_MOUSE_Y_1, $_MOUSE_MOVE_SPEED)
	  MouseClick("left", $_MOUSE_X_1, $_MOUSE_Y_1)

	  ;Tunggu Muncul Loading
	  ChangePhaseColor(5,1)
	  WaitUntilBattleStart($_MOUSE_MOVE_SPEED)

	  ;Tunggu Loading Sebelum Battle
	  WaitUntiLoadingScreenFinished($_MOUSE_MOVE_SPEED)

	  ;Klik MC
	  ChangePhaseColor(2,5)
	  $_MOUSE_X_2 = $MCclickPos[0] + Random(-10, 10)
	  $_MOUSE_Y_2 = $MCclickPos[1] + Random(-10, 10)
	  MouseMove($_MOUSE_X_2, $_MOUSE_Y_2, $_MOUSE_MOVE_SPEED)
	  MouseClick("left",$_MOUSE_X_2,$_MOUSE_Y_2)
	  Sleep(500)
	  if $Runner == False Then
		 ResetPhaseColor()
		 ExitLoop
	  EndIf

	  ;Klik Skill
	  ChangePhaseColor(3,2)
	  $_MOUSE_X_3 = $Skill1ClickPos[0] + Random(-10, 10)
	  $_MOUSE_Y_3 = $Skill1ClickPos[1] + Random(-10, 10)
	  MouseMove($_MOUSE_X_3, $_MOUSE_Y_3, $_MOUSE_MOVE_SPEED)
	  MouseClick("left",$_MOUSE_X_3,$_MOUSE_Y_3)
	  Sleep(1000)
	  if $Runner == False Then
		 ResetPhaseColor()
		 ExitLoop
	  EndIf
	  RefreshPage()

	  ;Tunggu muncul loading
	  ChangePhaseColor(5,3)
	  WaitUntilShowLoadingScreen($_MOUSE_MOVE_SPEED)

	  ;Tunggu Loading Setelah Battle
	  WaitUntiLoadingScreenFinished($_MOUSE_MOVE_SPEED)

	  ;Refresh pas masuk result page
	  Sleep(100)
	  if $Runner == False Then
		 ResetPhaseColor()
		 ExitLoop
	  EndIf
	  RefreshPage()

	  ;Tunggu muncul loading
	  WaitUntilShowLoadingScreen($_MOUSE_MOVE_SPEED)

	  ;Tunggu Loading Lagi abis refresh
	  WaitUntiLoadingScreenFinished($_MOUSE_MOVE_SPEED)

	  ;Klik Result Page Button
	  ChangePhaseColor(4,5)
	  Sleep(500)
	  if $Runner == False Then
		 ResetPhaseColor()
		 ExitLoop
	  EndIf
	  $_MOUSE_X_4 = $SkipResultEXPButtonPos[0] + Random(-10, 10)
	  $_MOUSE_Y_4 = $SkipResultEXPButtonPos[1] + Random(-10, 10)
	  MouseMove($_MOUSE_X_4, $_MOUSE_Y_4, $_MOUSE_MOVE_SPEED)
	  MouseClick("left",$_MOUSE_X_4,$_MOUSE_Y_4)

	  ;Tunggu muncul loading
	  ChangePhaseColor(5,4)
	  WaitUntilShowLoadingScreen($_MOUSE_MOVE_SPEED)

	  ;Tunggu Loading Lagi abis refresh
	  WaitUntiLoadingScreenFinished($_MOUSE_MOVE_SPEED)

    WEnd
 EndFunc

 Func LoadConfigData()
   $StartButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "Start Button Position")
   GUICtrlSetData($_LabelGUI_SavedCursor_1, $StartButtonPos[0] & " , " & $StartButtonPos[1])

   $MCclickPos = GetArrayFromSection(@ScriptDir & "\config.ini", "MC Icon Position")
   GUICtrlSetData($_LabelGUI_SavedCursor_2, $MCclickPos[0] & " , " & $MCclickPos[1])

   $Skill1ClickPos = GetArrayFromSection(@ScriptDir & "\config.ini", "Skill 1 Position")
   GUICtrlSetData($_LabelGUI_SavedCursor_3, $Skill1ClickPos[0] & " , " & $Skill1ClickPos[1])

   $SkipResultEXPButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "Result Room Button")
   GUICtrlSetData($_LabelGUI_SavedCursor_4, $SkipResultEXPButtonPos[0] & " , " & $SkipResultEXPButtonPos[1])

   $SkipResultPageButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "AP Bar Position")
   GUICtrlSetData($_LabelGUI_SavedCursor_5, $SkipResultPageButtonPos[0] & " , " & $SkipResultPageButtonPos[1])

   if @error Then
	  MsgBox($MB_ICONERROR, "Load Config Data", "Load config data failed!")
   Else
	  MsgBox($MB_OK, "Load Config Data", "Config data loaded!")
   EndIf

 EndFunc

 Func SaveConfigData()
   SaveArrayToSection(@ScriptDir & "\config.ini", "Start Button Position", $StartButtonPos)
   $StartButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "Start Button Position")

   SaveArrayToSection(@ScriptDir & "\config.ini", "MC Icon Position", $MCclickPos)
   $MCclickPos = GetArrayFromSection(@ScriptDir & "\config.ini", "MC Icon Position")

   SaveArrayToSection(@ScriptDir & "\config.ini", "Skill 1 Position", $Skill1ClickPos)
   $Skill1ClickPos = GetArrayFromSection(@ScriptDir & "\config.ini", "Skill 1 Position")

   SaveArrayToSection(@ScriptDir & "\config.ini", "Result Room Button", $SkipResultEXPButtonPos)
   $SkipResultEXPButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "Result Room Button")

   SaveArrayToSection(@ScriptDir & "\config.ini", "AP Bar Position", $SkipResultPageButtonPos)
   $SkipResultPageButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "AP Bar Position")

   if @error Then
	  MsgBox($MB_ICONERROR, "Save Config Data", "Save config data failed!")
   Else
	  MsgBox($MB_OK, "Save Config Data", "Config data saved!")
   EndIf

 EndFunc

Func SaveArrayToSection($FileName,$NewSectionName,$myArray)
   if Not IsArray($myArray) Then Return SetError(1,0,0)
   Local $SectionData = ""
   Switch UBound($myArray,0)
	  Case 1
		 For $i = 0 To UBound($myArray) - 1
		 $SectionData &= $i & "=" & StringToBinary($myArray[$i]) & @LF
		 Next
	  Case 2
		 For $i = 0 To UBound($myArray) - 1
		 For $j = 0 To UBound($myArray,2) - 1
		 $SectionData &= $i & "|" & $j & "=" & StringToBinary($myArray[$i][$j]) & @LF
	  Next
   Next
   EndSwitch
   Return IniWriteSection($FileName,$NewSectionName,$SectionData)
EndFunc

Func GetArrayFromSection($FileName,$NewSectionName)
   Local $SectionData = "" , $myArray[1]
   $SectionData = IniReadSection($FileName,$NewSectionName)
   if @error Then Return SetError(1,0,0)
   Select
	  Case Not StringInStr($SectionData[1][0],"|")
		 For $i = 1 To $SectionData[0][0]
			$rows = $SectionData[$i][0]
			ReDim $myArray[$rows + 1]
			$myArray[$rows] = BinaryToString($SectionData[$i][1])
		 Next
	  Case Else
		 Local $icols = 0
		 For $i = 1 To $SectionData[0][0]
			$Elements = $SectionData[$i][0]
			$SpArray = StringSplit($Elements,"|")
			$rows = $SpArray[1]
			$cols = $SpArray[2]
			if $cols > $icols Then $icols = $cols
			   ReDim $myArray[$rows + 1][$icols + 1]
			   $myArray[$rows][$cols] = BinaryToString($SectionData[$i][1])
			Next
	  EndSelect
   Return SetError(0,0,$myArray)
EndFunc

func _sleep()
    sleep(5000)
 EndFunc

 func WaitUntilBattleStart($_MOUSE_SPEED) ;Khusus untuk button start
	$Counter = 0
	do
	  $Counter = $Counter + 1;
	  $_MOUSE_LOADING_1_X = $SkipResultPageButtonPos[0] + Random (-50, 50)
	  $_MOUSE_LOADING_1 = + $SkipResultPageButtonPos[1] + Random (-5, 5)
	  MouseMove($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1, $_MOUSE_SPEED)

	  if $Runner == False Then ExitLoop
	  if $Counter >= 30 Then
		 Start()
		 MsgBox($MB_ICONINFORMATION, "App Stopped", "App Stopped." & @LF & "Maybe Captcha/AP run out/Problem with your connection.")
		 if $Runner == False Then ExitLoop
	  EndIf
   until PixelGetColor($SkipResultPageButtonPos[0], $SkipResultPageButtonPos[1]) == "1380111"
 EndFunc

 func WaitUntilShowLoadingScreen($_MOUSE_SPEED)
	do
	  $_MOUSE_LOADING_1_X = $SkipResultPageButtonPos[0] + Random (-50, 50)
	  $_MOUSE_LOADING_1 = + $SkipResultPageButtonPos[1] + Random (-5, 5)
	  MouseMove($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1, $_MOUSE_SPEED)
	  if $Runner == False Then ExitLoop
   until PixelGetColor($SkipResultPageButtonPos[0], $SkipResultPageButtonPos[1]) == "1380111"
 EndFunc

 func WaitUntiLoadingScreenFinished($_MOUSE_SPEED)
	do
	  $_MOUSE_LOADING_1_X = $SkipResultPageButtonPos[0] + Random (-50, 50)
	  $_MOUSE_LOADING_1 = + $SkipResultPageButtonPos[1] + Random (-5, 5)
	  MouseMove($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1, $_MOUSE_SPEED)
	  if $Runner == False Then ExitLoop
   until PixelGetColor($SkipResultPageButtonPos[0], $SkipResultPageButtonPos[1]) <> "1380111"
 EndFunc

func ChangePhaseColor($Phase1, $Phase2)
   GUICtrlSetImage($_ImageGui_Phase[$Phase1-1], $_Image_Green_Square)
   GUICtrlSetImage($_ImageGui_Phase[$Phase2-1], $_Image_Red_Square)
EndFunc

func ResetPhaseColor()
   for $i = 0 to 4
	  GUICtrlSetImage($_ImageGui_Phase[$i], $_Image_Red_Square)
   Next
EndFunc

 Func AppExit()
	GUIDelete()
	Exit
 EndFunc

