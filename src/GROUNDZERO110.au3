;Metadata
#AutoIt3Wrapper_icon = @ScriptDir & "\icon.ico"
Global $AppTitle = "GROUND ZERO - SLIMEBOT APP"
Global $AppVersion = "v1.1"
Global $AppDev = "Legaiabay"

#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include <StaticConstants.au3>
#include <Misc.au3>
#Include <Array.au3>

Opt("GUIOnEventMode", 1)

;SHORTCUT
HotKeySet("{F2}", "StartSoloMode")
HotKeySet("{F4}", "StartDualMode")
HotKeySet("{F8}", "AppExit")

Global $_Last_Green_Phase = 1
Global $RunningPhase = 0
Global $RunningTime = 0
Global $Runner = False
Global $GetKeyMode = 0
Global $ModeCursorPosition;
Global $SlimeMode = 0 ; 0 = Solo | 1 = Dual Box

Global $MousePos[2]
$MousePos[0] = 0
$MousePos[1] = 0

;P1 CURSOR DATA
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

;P1 CURSOR DATA
Global $P2StartButtonPos[2]
$P2StartButtonPos[0] = 0
$P2StartButtonPos[1] = 0

Global $P2MCclickPos[2]
$P2MCclickPos[0] = 0
$P2MCclickPos[1] = 0

Global $P2Skill1ClickPos[2]
$P2Skill1ClickPos[0] = 0
$P2Skill1ClickPos[1] = 0

Global $P2SkipResultEXPButtonPos[2]
$P2SkipResultEXPButtonPos[0] = 0
$P2SkipResultEXPButtonPos[1] = 0

Global $P2SkipResultPageButtonPos[2]
$P2SkipResultPageButtonPos[0] = 0
$P2SkipResultPageButtonPos[1] = 0

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
Local $_ObjectRowPosition_3 = 335;
Local $_ObjectRowPosition_3_1 = 355
Local $_ObjectRowPosition_3_2 = 400
Local $_ObjectRowPosition_3_3 = 420
Local $_ObjectRowPosition_3_4 = 455
Local $_ObjectRowPosition_3_5 = 475
Local $_ObjectRowPosition_4 = 530;
Local $_ObjectRowPosition_5 = 550;
Local $_ObjectRowPosition_5_1 = 570;
Local $_ObjectRowPosition_6 = 580;
Local $_ObjectRowPosition_7 = 600;
Local $_ObjectRowPosition_8 = 620;

Local $_ObjectFirstColumnPosition_1 = 20;
Local $_ObjectFirstColumnPosition_2 = 365;
Local $_ObjectFirstColumnPosition_3 = 480;

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
Local $_Label_1 = "Current : "
Local $_Label_2 = "STATUS : STOPPED"
Local $_Label_3 = "Start/Stop Slimeblast SOLO : F2"
Local $_Label_4 = "Load/Save Latest Config Data"
Local $_Label_5 = "Start/Stop Slimeblast DUAL : F4"
Local $_Label_6 = "SOLO MODE - KILLER : "
Local $_Label_7 = "DUAL MODE - HOST"

Local $_Label_SavedCursor_1 = $StartButtonPos[0] & " , " & $StartButtonPos[1]
Local $_Label_SavedCursor_2 = $MCclickPos[0] & " , " & $MCclickPos[1]
Local $_Label_SavedCursor_3 = $Skill1ClickPos[0] & " , " & $Skill1ClickPos[1]
Local $_Label_SavedCursor_4 = $SkipResultEXPButtonPos[0] & " , " & $SkipResultEXPButtonPos[1]
Local $_Label_SavedCursor_5 = $SkipResultPageButtonPos[0] & " , " & $SkipResultPageButtonPos[1]

Local $_Label_SavedCursor_6 = $P2StartButtonPos[0] & " , " & $P2StartButtonPos[1]
Local $_Label_SavedCursor_7 = $P2MCclickPos[0] & " , " & $P2MCclickPos[1]
Local $_Label_SavedCursor_8 = $P2Skill1ClickPos[0] & " , " & $P2Skill1ClickPos[1]
Local $_Label_SavedCursor_9 = $P2SkipResultEXPButtonPos[0] & " , " & $P2SkipResultEXPButtonPos[1]
Local $_Label_SavedCursor_10 = $P2SkipResultPageButtonPos[0] & " , " & $P2SkipResultPageButtonPos[1]

Local $_LabelInGameButtonPosTitle = GUICtrlCreateLabel($_Label_1, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_4,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_CurrentCursor = GUICtrlCreateLabel("aaaa", 70, $_ObjectRowPosition_4,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_2 = GUICtrlCreateLabel($_Label_2, $_ObjectFirstColumnPosition_3, $_ObjectRowPosition_1,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_3 = GUICtrlCreateLabel($_Label_3, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_5,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_4 = GUICtrlCreateLabel($_Label_4, $_ObjectFirstColumnPosition_2, $_ObjectRowPosition_4,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_5 = GUICtrlCreateLabel($_Label_5, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_5_1,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_6 = GUICtrlCreateLabel($_Label_6, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_1,$_LabelTitleWidth,$_LabelTitleHeight)
Local $_LabelGUI_7 = GUICtrlCreateLabel($_Label_7, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_3_2,$_LabelTitleWidth,$_LabelTitleHeight)

GUICtrlSetColor($_LabelGUI_2, $COLOR_RED)

Local $_LabelGUI_SavedCursor_1 = GUICtrlCreateLabel($_Label_SavedCursor_1, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_3,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_2 = GUICtrlCreateLabel($_Label_SavedCursor_2, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 1, $_ObjectRowPosition_3,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_3 = GUICtrlCreateLabel($_Label_SavedCursor_3, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 2, $_ObjectRowPosition_3,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_4 = GUICtrlCreateLabel($_Label_SavedCursor_4, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 3, $_ObjectRowPosition_3,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_5 = GUICtrlCreateLabel($_Label_SavedCursor_5, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 4, $_ObjectRowPosition_3,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)

Local $_LabelGUI_SavedCursor_6 = GUICtrlCreateLabel($_Label_SavedCursor_6, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_3_4,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_7 = GUICtrlCreateLabel($_Label_SavedCursor_7, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 1, $_ObjectRowPosition_3_4,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_8 = GUICtrlCreateLabel($_Label_SavedCursor_8, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 2, $_ObjectRowPosition_3_4,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_9 = GUICtrlCreateLabel($_Label_SavedCursor_9, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 3, $_ObjectRowPosition_3_4,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)
Local $_LabelGUI_SavedCursor_10 = GUICtrlCreateLabel($_Label_SavedCursor_10, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 4, $_ObjectRowPosition_3_4,$_LabelCursorPosWidth,$_LabelCursorPosHeight, $SS_CENTER)

;Button
Local $_ButtonAbout = "About"
Local $_ButtonText_1_1 = "P1 Start Button"
Local $_ButtonText_1_2 = "P1 Chara Image"
Local $_ButtonText_1_3 = "P1 Skill Button"
Local $_ButtonText_1_4 = 'P1 Result Button'
Local $_ButtonText_1_5 = "P1 AP Bar (Idle)"

Local $_ButtonText_2_1 = "Load Latest Config"
Local $_ButtonText_2_2 = "Save Config"

Local $_ButtonText_3_1 = "P2 Start Button"
Local $_ButtonText_3_2 = "P2 Chara Image"
Local $_ButtonText_3_3 = "P2 Skill Button"
Local $_ButtonText_3_4 = "P2 Result Button"
Local $_ButtonText_3_5 = "P2 AP Bar (Idle)"

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

Local $_ButtonRow_2_1 = GUICtrlCreateButton($_ButtonText_2_1, $_ObjectFirstColumnPosition_2, $_ObjectRowPosition_5, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_2_1, "Button_LoadConfig")
Local $_ButtonRow_2_2 = GUICtrlCreateButton($_ButtonText_2_2, $_ObjectFirstColumnPosition_2 + $_ButtonOffsetX * 1, $_ObjectRowPosition_5, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_2_2, "Button_SaveConfig")

Local $_ButtonRow_3_1 = GUICtrlCreateButton($_ButtonText_3_1, $_ObjectFirstColumnPosition_1, $_ObjectRowPosition_3_3, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_3_1, "Button_3_1")
Local $_ButtonRow_3_2 = GUICtrlCreateButton($_ButtonText_3_2, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 1, $_ObjectRowPosition_3_3, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_3_2, "Button_3_2")
Local $_ButtonRow_3_3 = GUICtrlCreateButton($_ButtonText_3_3, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 2, $_ObjectRowPosition_3_3, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_3_3, "Button_3_3")
Local $_ButtonRow_3_4 = GUICtrlCreateButton($_ButtonText_3_4, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 3, $_ObjectRowPosition_3_3, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_3_4, "Button_3_4")
Local $_ButtonRow_3_5 = GUICtrlCreateButton($_ButtonText_3_5, $_ObjectFirstColumnPosition_1 + $_ButtonOffsetX * 4, $_ObjectRowPosition_3_3, $_DefaultButtonWidth_1, $_DefaultButtonHeight_1)
GUICtrlSetOnEvent($_ButtonRow_3_5, "Button_3_5")

;Image
Local $_Phase_Center_Offset = 44

Local $_Image_1 = @ScriptDir & "\image\image_1.jpg"
Local $_Image_Red_Square = @ScriptDir & "\image\red_square.jpg"
Local $_Image_Green_Square = @ScriptDir & "\image\green_square.jpg"
Local $_ImageGui_1 = GUICtrlCreatePic($_Image_1, $_ObjectFirstColumnPosition_1, $_ObjectRowCoverImage, $_ImageWidth_1, $_ImageHeight_1)

Local $_ImageGui_Phase[10]
$_ImageGui_Phase[0] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset, $_ObjectRowPosition_3_1, 20, 20)
$_ImageGui_Phase[1] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 1, $_ObjectRowPosition_3_1, 20, 20)
$_ImageGui_Phase[2] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 2, $_ObjectRowPosition_3_1, 20, 20)
$_ImageGui_Phase[3] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 3, $_ObjectRowPosition_3_1, 20, 20)
$_ImageGui_Phase[4] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 4, $_ObjectRowPosition_3_1, 20, 20)
$_ImageGui_Phase[5] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset, $_ObjectRowPosition_3_5, 20, 20)
$_ImageGui_Phase[6] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 1, $_ObjectRowPosition_3_5, 20, 20)
$_ImageGui_Phase[7] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 2, $_ObjectRowPosition_3_5, 20, 20)
$_ImageGui_Phase[8] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 3, $_ObjectRowPosition_3_5, 20, 20)
$_ImageGui_Phase[9] = GUICtrlCreatePic($_Image_Red_Square, $_ObjectFirstColumnPosition_1 + $_Phase_Center_Offset + $_ButtonOffsetX * 4, $_ObjectRowPosition_3_5, 20, 20)

;Start Show Window
GUISetState(@SW_SHOW, $_MainUI)
GUISetOnEvent($GUI_EVENT_CLOSE, "AppExit")
GUICtrlSetOnEvent($_MainUI,"_sleep")
Sleep(100)

Func RefreshPage()
	Send("{F5}")
 EndFunc

 Func RefreshPageP1()
   $_MOUSE_SPEED = Random (100, 120)
   $_MOUSE_LOADING_1_X = $SkipResultPageButtonPos[0] + Random (-50, 50)
   $_MOUSE_LOADING_1 = + $SkipResultPageButtonPos[1] + Random (-5, 5)
   MouseMove($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1, $_MOUSE_SPEED)
   MouseClick("left", $_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1)
   Send("{F5}")
 EndFunc

 func RefreshPageP2()
   $_MOUSE_SPEED = Random (100, 120)
   $_MOUSE_LOADING_2_X = $P2SkipResultPageButtonPos[0] + Random (-50, 50)
   $_MOUSE_LOADING_2 = + $P2SkipResultPageButtonPos[1] + Random (-5, 5)
   MouseMove($_MOUSE_LOADING_2_X, $_MOUSE_LOADING_2, $_MOUSE_SPEED)
   MouseClick("left", $_MOUSE_LOADING_2_X, $_MOUSE_LOADING_2)
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

func Button_3_1()
   ConsoleWrite("button1")
		 $ModeCursorPosition = 6
		 SetKeyPos()
EndFunc

func Button_3_2()
   ConsoleWrite("button2")
		 $ModeCursorPosition = 7
		 SetKeyPos()
EndFunc

func Button_3_3()
   ConsoleWrite("button3")
		 $ModeCursorPosition = 8
		 SetKeyPos()
EndFunc

func Button_3_4()
   ConsoleWrite("button4")
		 $ModeCursorPosition = 9
		 SetKeyPos()
EndFunc

func Button_3_5()
   ConsoleWrite("button5")
		 $ModeCursorPosition = 10
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
			Case 6
			   $P2StartButtonPos = MouseGetPos()
			   $info = MsgBox($MB_OK, "Cursor Setting Done", "New position : " & $P2StartButtonPos[0] & " " & $P2StartButtonPos[1])
			   GUICtrlSetData($_LabelGUI_SavedCursor_6, $P2StartButtonPos[0] & " , " & $P2StartButtonPos[1])
			Case 7
			   $P2MCclickPos = MouseGetPos()
			   $info = MsgBox($MB_OK, "Cursor Setting Done", "New position : " & $P2MCclickPos[0] & " " & $P2MCclickPos[1])
			   GUICtrlSetData($_LabelGUI_SavedCursor_7, $P2MCclickPos[0] & " , " & $P2MCclickPos[1])
			Case 8
			   $P2Skill1ClickPos = MouseGetPos()
			   $info = MsgBox($MB_OK, "Cursor Setting Done", "New position : " & $P2Skill1ClickPos[0] & " " & $P2Skill1ClickPos[1])
			   GUICtrlSetData($_LabelGUI_SavedCursor_8, $P2Skill1ClickPos[0] & " , " & $P2Skill1ClickPos[1])
			Case 9
			   $P2SkipResultEXPButtonPos = MouseGetPos()
			   $info = MsgBox($MB_OK, "Cursor Setting Done", "New position : " & $P2SkipResultEXPButtonPos[0] & " " & $P2SkipResultEXPButtonPos[1])
			   GUICtrlSetData($_LabelGUI_SavedCursor_9, $P2SkipResultEXPButtonPos[0] & " , " & $P2SkipResultEXPButtonPos[1])
			Case 10
			   $P2SkipResultPageButtonPos = MouseGetPos()
			   $info = MsgBox($MB_OK, "Cursor Setting Done", "New position : " & $P2SkipResultPageButtonPos[0] & " " & $P2SkipResultPageButtonPos[1])
			   GUICtrlSetData($_LabelGUI_SavedCursor_10, $P2SkipResultPageButtonPos[0] & " , " & $P2SkipResultPageButtonPos[1])
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

   if $Runner == False Then
	  $Runner = True
	  GUICtrlSetData($_LabelGUI_2, "STATUS : STARTED")
	  GUICtrlSetColor($_LabelGUI_2, $COLOR_GREEN)
   else
	  $Runner = False
	  ResetPhaseColor()
	  GUICtrlSetData($_LabelGUI_2, "STATUS : STOPPED")
	  GUICtrlSetColor($_LabelGUI_2, $COLOR_RED)
   EndIf

   $_MOUSE_MOVE_SPEED = Random (120, 130)

   if $SlimeMode == 0 Then
	  ;========
	  ;SOLO
	  ;========
	  While $Runner == True

		 ;Klik Button Start
		 ChangePhaseColor(1)
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
		 ChangePhaseColor(5)
		 WaitUntilBattleStart($_MOUSE_MOVE_SPEED)

		 ;Tunggu Loading Sebelum Battle
		 WaitUntiLoadingScreenFinished($_MOUSE_MOVE_SPEED)

		 ;Klik MC
		 ChangePhaseColor(2)
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
		 ChangePhaseColor(3)
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
		 ChangePhaseColor(5)
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
		 ChangePhaseColor(4)
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
		 ChangePhaseColor(5)
		 WaitUntilShowLoadingScreen($_MOUSE_MOVE_SPEED)

		 ;Tunggu Loading Lagi abis refresh
		 WaitUntiLoadingScreenFinished($_MOUSE_MOVE_SPEED)
	   WEnd
	Else
	  While $Runner == True
		 ;========
		 ;DUAL
		 ;========

		 ;Klik Button Start P2
		 ChangePhaseColor(6)
		 Sleep(500)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf
		 $_MOUSE_X_1_2 = $P2StartButtonPos[0] + Random(-10, 10)
		 $_MOUSE_Y_1_2 = $P2StartButtonPos[1] + Random(-10, 10)
		 MouseMove($_MOUSE_X_1_2, $_MOUSE_Y_1_2, $_MOUSE_MOVE_SPEED)
		 MouseClick("left", $_MOUSE_X_1_2, $_MOUSE_Y_1_2)
		 Sleep(1500)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf

		 ;Klik Button Start P1
		 ChangePhaseColor(1)
		 Sleep(500)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf
		 $_MOUSE_X_1_1 = $StartButtonPos[0] + Random(-10, 10)
		 $_MOUSE_Y_1_1 = $StartButtonPos[1] + Random(-10, 10)
		 MouseMove($_MOUSE_X_1_1, $_MOUSE_Y_1_1, $_MOUSE_MOVE_SPEED)
		 MouseClick("left", $_MOUSE_X_1_1, $_MOUSE_Y_1_1)

		 ;Tunggu Muncul Loading P1
		 ChangePhaseColor(5)
		 WaitUntilBattleStart($_MOUSE_MOVE_SPEED)

		 ;Tunggu Loading Sebelum Battle
		 WaitUntiLoadingScreenFinished($_MOUSE_MOVE_SPEED)
		 Sleep(1500)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf

		 ;Tunggu Loading Sebelum Battle P2
		 ChangePhaseColor(10)
		 WaitUntiLoadingScreenFinishedP2($_MOUSE_MOVE_SPEED)
		 Sleep(1500)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf

		 ;Klik MC P2
		 ChangePhaseColor(2)
		 $_MOUSE_X_2_2 = $P2MCclickPos[0] + Random(-10, 10)
		 $_MOUSE_Y_2_2 = $P2MCclickPos[1] + Random(-10, 10)
		 MouseMove($_MOUSE_X_2_2, $_MOUSE_Y_2_2, $_MOUSE_MOVE_SPEED)
		 MouseClick("left",$_MOUSE_X_2_2,$_MOUSE_Y_2_2)
		 Sleep(500)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf

		 ;Klik Skill P2
		 ChangePhaseColor(3)
		 $_MOUSE_X_3_2 = $P2Skill1ClickPos[0] + Random(-10, 10)
		 $_MOUSE_Y_3_2 = $P2Skill1ClickPos[1] + Random(-10, 10)
		 MouseMove($_MOUSE_X_3_2, $_MOUSE_Y_3_2, $_MOUSE_MOVE_SPEED)
		 MouseClick("left",$_MOUSE_X_3_2,$_MOUSE_Y_3_2)
		 Sleep(1000)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf

		 ;Klik MC P1
		 ChangePhaseColor(2)
		 $_MOUSE_X_2_1 = $MCclickPos[0] + Random(-10, 10)
		 $_MOUSE_Y_2_1 = $MCclickPos[1] + Random(-10, 10)
		 MouseMove($_MOUSE_X_2_1, $_MOUSE_Y_2_1, $_MOUSE_MOVE_SPEED)
		 MouseClick("left",$_MOUSE_X_2_1,$_MOUSE_Y_2_1)
		 Sleep(500)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf

		 ;Klik Skill P1
		 ChangePhaseColor(3)
		 $_MOUSE_X_3_1 = $Skill1ClickPos[0] + Random(-10, 10)
		 $_MOUSE_Y_3_1 = $Skill1ClickPos[1] + Random(-10, 10)
		 MouseMove($_MOUSE_X_3_1, $_MOUSE_Y_3_1, $_MOUSE_MOVE_SPEED)
		 MouseClick("left",$_MOUSE_X_3_1,$_MOUSE_Y_3_1)
		 Sleep(1000)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf

		 ;Refresh P1 P2
		 ChangePhaseColor(5)
		 RefreshPageP1()
		 sleep(300)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf
		 ChangePhaseColor(10)
		 RefreshPageP2()
		 sleep(300)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf

		 ;
		 ChangePhaseColor(10)
		 WaitUntilShowLoadingScreenP2($_MOUSE_MOVE_SPEED)

		 ;
		 WaitUntiLoadingScreenFinishedP2($_MOUSE_MOVE_SPEED)
		 Sleep(1500)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf

		 ;
		 RefreshPageP2()
		 sleep(300)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf
		 ChangePhaseColor(5)
		 RefreshPageP1()
		 sleep(300)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf

		 ;
		 ChangePhaseColor(10)
		 WaitUntilShowLoadingScreen($_MOUSE_MOVE_SPEED)

		 ;
		 WaitUntiLoadingScreenFinished($_MOUSE_MOVE_SPEED)

		 ;Klik Result Page Button P1
		 ChangePhaseColor(4)
		 Sleep(500)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf
		 $_MOUSE_X_4_1 = $SkipResultEXPButtonPos[0] + Random(-10, 10)
		 $_MOUSE_Y_4_1 = $SkipResultEXPButtonPos[1] + Random(-10, 10)
		 MouseMove($_MOUSE_X_4_1, $_MOUSE_Y_4_1, $_MOUSE_MOVE_SPEED)
		 MouseClick("left",$_MOUSE_X_4_1,$_MOUSE_Y_4_1)

		 ;
		 ChangePhaseColor(10)
		 WaitUntiLoadingScreenFinishedP2($_MOUSE_MOVE_SPEED)

		 ;Klik Result Page Button
		 ChangePhaseColor(9)
		 Sleep(500)
		 if $Runner == False Then
			ResetPhaseColor()
			ExitLoop
		 EndIf
		 $_MOUSE_X_4_2 = $P2SkipResultEXPButtonPos[0] + Random(-10, 10)
		 $_MOUSE_Y_4_2 = $P2SkipResultEXPButtonPos[1] + Random(-10, 10)
		 MouseMove($_MOUSE_X_4_2, $_MOUSE_Y_4_2, $_MOUSE_MOVE_SPEED)
		 MouseClick("left",$_MOUSE_X_4_2,$_MOUSE_Y_4_2)

		 ;
		 ChangePhaseColor(10)
		 WaitUntilShowLoadingScreenP2($_MOUSE_MOVE_SPEED)

		 ;
		 WaitUntiLoadingScreenFinishedP2($_MOUSE_MOVE_SPEED)

	  WEnd
	EndIf

 EndFunc

 Func LoadConfigData()
   ;P1
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

   ;P2

   $P2StartButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "P2 Start Button Position")
   GUICtrlSetData($_LabelGUI_SavedCursor_6, $P2StartButtonPos[0] & " , " & $P2StartButtonPos[1])

   $P2MCclickPos = GetArrayFromSection(@ScriptDir & "\config.ini", "P2 MC Icon Position")
   GUICtrlSetData($_LabelGUI_SavedCursor_7, $P2MCclickPos[0] & " , " & $P2MCclickPos[1])

   $P2Skill1ClickPos = GetArrayFromSection(@ScriptDir & "\config.ini", "P2 Skill 1 Position")
   GUICtrlSetData($_LabelGUI_SavedCursor_8, $P2Skill1ClickPos[0] & " , " & $P2Skill1ClickPos[1])

   $P2SkipResultEXPButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "P2 Result Room Button")
   GUICtrlSetData($_LabelGUI_SavedCursor_9, $P2SkipResultEXPButtonPos[0] & " , " & $P2SkipResultEXPButtonPos[1])

   $P2SkipResultPageButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "P2 AP Bar Position")
   GUICtrlSetData($_LabelGUI_SavedCursor_10, $P2SkipResultPageButtonPos[0] & " , " & $P2SkipResultPageButtonPos[1])

   if @error Then
	  MsgBox($MB_ICONERROR, "Load Config Data", "Load config data failed!")
   Else
	  MsgBox($MB_OK, "Load Config Data", "Config data loaded!")
   EndIf

 EndFunc

 Func SaveConfigData()
   ;P1
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

   ;P2

   SaveArrayToSection(@ScriptDir & "\config.ini", "P2 Start Button Position", $P2StartButtonPos)
   $P2StartButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "P2 Start Button Position")

   SaveArrayToSection(@ScriptDir & "\config.ini", "P2 MC Icon Position", $P2MCclickPos)
   $P2MCclickPos = GetArrayFromSection(@ScriptDir & "\config.ini", "P2 MC Icon Position")

   SaveArrayToSection(@ScriptDir & "\config.ini", "P2 Skill 1 Position", $P2Skill1ClickPos)
   $P2Skill1ClickPos = GetArrayFromSection(@ScriptDir & "\config.ini", "P2 Skill 1 Position")

   SaveArrayToSection(@ScriptDir & "\config.ini", "P2 Result Room Button", $P2SkipResultEXPButtonPos)
   $P2SkipResultEXPButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "P2 Result Room Button")

   SaveArrayToSection(@ScriptDir & "\config.ini", "P2 AP Bar Position", $P2SkipResultPageButtonPos)
   $P2SkipResultPageButtonPos = GetArrayFromSection(@ScriptDir & "\config.ini", "P2 AP Bar Position")

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
		 $Runner = False
		 MsgBox($MB_ICONINFORMATION, "App Stopped", "App Stopped." & @LF & "Maybe Captcha/AP run out/Problem with your connection.")
		 if $Runner == False Then ExitLoop
	  EndIf
   until PixelGetColor($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1) == "1380111"
 EndFunc

 func WaitUntilShowLoadingScreen($_MOUSE_SPEED)
	do
	  $_MOUSE_LOADING_1_X = $SkipResultPageButtonPos[0] + Random (-50, 50)
	  $_MOUSE_LOADING_1 = + $SkipResultPageButtonPos[1] + Random (-5, 5)
	  MouseMove($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1, $_MOUSE_SPEED)
	  if $Runner == False Then ExitLoop
   until PixelGetColor($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1) == "1380111"
 EndFunc

 func WaitUntiLoadingScreenFinished($_MOUSE_SPEED)
	do
	  $_MOUSE_LOADING_1_X = $SkipResultPageButtonPos[0] + Random (-50, 50)
	  $_MOUSE_LOADING_1 = + $SkipResultPageButtonPos[1] + Random (-5, 5)
	  MouseMove($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1, $_MOUSE_SPEED)
	  if $Runner == False Then ExitLoop
   until PixelGetColor($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1) <> "1380111"
EndFunc

 func WaitUntilBattleStartP2($_MOUSE_SPEED) ;Khusus untuk button start
	$Counter = 0
	do
	  $Counter = $Counter + 1;
	  $_MOUSE_LOADING_1_X = $P2SkipResultPageButtonPos[0] + Random (-50, 50)
	  $_MOUSE_LOADING_1 = + $P2SkipResultPageButtonPos[1] + Random (-5, 5)
	  MouseMove($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1, $_MOUSE_SPEED)

	  if $Runner == False Then ExitLoop
	  if $Counter >= 30 Then
		 Start()
		 MsgBox($MB_ICONINFORMATION, "App Stopped", "App Stopped." & @LF & "Maybe Captcha/AP run out/Problem with your connection.")
		 if $Runner == False Then ExitLoop
	  EndIf
   until PixelGetColor($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1) == "1380111"
 EndFunc

func WaitUntilShowLoadingScreenP2($_MOUSE_SPEED)
	do
	   ConsoleWrite("MASUK WAIT SHOW LOADING P2 " & @LF)
	  $_MOUSE_LOADING_1_X = $P2SkipResultPageButtonPos[0] + Random (-50, 50)
	  $_MOUSE_LOADING_1 = + $P2SkipResultPageButtonPos[1] + Random (-5, 5)
	  MouseMove($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1, $_MOUSE_SPEED)
	  if $Runner == False Then ExitLoop
   until PixelGetColor($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1) == "1380111"
 EndFunc

 func WaitUntiLoadingScreenFinishedP2($_MOUSE_SPEED)
	do
	   ConsoleWrite("MASUK WAIT FINISHT LOADING P2 " & @LF)
	  $_MOUSE_LOADING_1_X = $P2SkipResultPageButtonPos[0] + Random (-50, 50)
	  $_MOUSE_LOADING_1 = + $P2SkipResultPageButtonPos[1] + Random (-5, 5)
	  MouseMove($_MOUSE_LOADING_1_X, $_MOUSE_LOADING_1, $_MOUSE_SPEED)
	  if $Runner == False Then ExitLoop
   until PixelGetColor($P2SkipResultPageButtonPos[0], $P2SkipResultPageButtonPos[1]) <> "1380111"
 EndFunc

func ChangePhaseColor($Phase1)
   GUICtrlSetImage($_ImageGui_Phase[$_Last_Green_Phase-1], $_Image_Red_Square)
   GUICtrlSetImage($_ImageGui_Phase[$Phase1-1], $_Image_Green_Square)

   $_Last_Green_Phase = $Phase1
EndFunc

func ResetPhaseColor()
   for $i = 0 to 4
	  GUICtrlSetImage($_ImageGui_Phase[$i], $_Image_Red_Square)
   Next
EndFunc

func StartSoloMode()
   $SlimeMode = 0
   Start()
EndFunc

func StartDualMode()
   $SlimeMode = 1
   Start()
EndFunc

 Func AppExit()
	GUIDelete()
	Exit
 EndFunc

