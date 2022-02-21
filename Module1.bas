Attribute VB_Name = "Module1"

Private Const INFINITE = &HFFFFFFFF
Private Const SYNCHRONIZE = &H100000
Private Const PROCESS_QUERY_INFORMATION = &H400&

Private Declare Function CloseHandle Lib "kernel32" ( _
    ByVal hObject As Long) As Long

Private Declare Function GetExitCodeProcess Lib "kernel32" ( _
    ByVal hProcess As Long, _
    lpExitCode As Long) As Long

Private Declare Function OpenProcess Lib "kernel32" ( _
    ByVal dwDesiredAccess As Long, _
    ByVal bInheritHandle As Long, _
    ByVal dwProcessId As Long) As Long

Private Declare Function WaitForSingleObject Lib "kernel32" ( _
    ByVal hHandle As Long, _
    ByVal dwMilliseconds As Long) As Long

Public retart As Boolean
Public prow25 As Integer
Public pcol25 As Integer
Public prow10 As Integer
Public pcol10 As Integer
Public arrSplitStrings1() As String
Public hrsc As Boolean

Public Static Function ShellSync( _
    ByVal PathName As String, _
    ByVal WindowStyle As VbAppWinStyle) As Long
    'Shell and wait.  Return exit code result, raise an
    'exception on any error.
    Dim lngPid As Long
    Dim lngHandle As Long
    Dim lngExitCode As Long

    lngPid = Shell(PathName, WindowStyle)
    If lngPid <> 0 Then
        lngHandle = OpenProcess(SYNCHRONIZE _
                             Or PROCESS_QUERY_INFORMATION, 0, lngPid)
        If lngHandle <> 0 Then
            WaitForSingleObject lngHandle, INFINITE
            If GetExitCodeProcess(lngHandle, lngExitCode) <> 0 Then
                ShellSync = lngExitCode
                CloseHandle lngHandle
            Else
                CloseHandle lngHandle
                Err.Raise &H8004AA00, "ShellSync", _
                          "Failed to retrieve exit code, error " _
                        & CStr(Err.LastDllError)
            End If
        Else
            Err.Raise &H8004AA01, "ShellSync", _
                      "Failed to open child process"
        End If
    Else
        Err.Raise &H8004AA02, "ShellSync", _
                  "Failed to Shell child process"
    End If
End Function
Public Static Sub prepare_graph()
Dim row As Integer
Dim col As Integer
Dim hh As Integer
Dim a As Integer
Dim b As Integer
Dim mm As Integer
retart = False
Form2.Picture1.CurrentX = 100
Form2.Picture1.CurrentY = 100
Form2.Picture1.Print "µg/m³"
Form2.Picture1.CurrentX = 18000
Form2.Picture1.CurrentY = 6000
Form2.Picture1.Print "T<Seconds>"

Form2.Picture1.DrawWidth = 2
Form2.Picture1.Line (300, 310)-(300, 5800), vbBlack
Form2.Picture1.Line (300, 5800)-(19000, 5800), vbBlack
Form2.Picture1.DrawWidth = 1
Form2.Picture1.Line (200, 4800)-(400, 4800), vbBlue
Form2.Picture1.Line (200, 3800)-(400, 3800), vbBlue
Form2.Picture1.Line (200, 2800)-(400, 2800), vbBlue
Form2.Picture1.Line (200, 1800)-(400, 1800), vbBlue
Form2.Picture1.Line (200, 800)-(400, 800), vbBlue
'Picture1.Line (800, 3000)-(800, 2750), vbBlue
Form2.Picture1.Line (1300, 5950)-(1300, 5650), vbBlue
Form2.Picture1.Line (2300, 5950)-(2300, 5650), vbBlue
Form2.Picture1.Line (3300, 5950)-(3300, 5650), vbBlue
Form2.Picture1.Line (4300, 5950)-(4300, 5650), vbBlue
Form2.Picture1.Line (5300, 5950)-(5300, 5650), vbBlue
Form2.Picture1.Line (6300, 5950)-(6300, 5650), vbBlue
Form2.Picture1.Line (7300, 5950)-(7300, 5650), vbBlue
Form2.Picture1.Line (8300, 5950)-(8300, 5650), vbBlue
Form2.Picture1.Line (9300, 5950)-(9300, 5650), vbBlue
Form2.Picture1.Line (10300, 5950)-(10300, 5650), vbBlue
Form2.Picture1.Line (11300, 5950)-(11300, 5650), vbBlue
Form2.Picture1.Line (12300, 5950)-(12300, 5650), vbBlue
Form2.Picture1.Line (13300, 5950)-(13300, 5650), vbBlue
Form2.Picture1.Line (14300, 5950)-(14300, 5650), vbBlue
Form2.Picture1.Line (15300, 5950)-(15300, 5650), vbBlue
Form2.Picture1.Line (16300, 5950)-(16300, 5650), vbBlue
Form2.Picture1.Line (17300, 5950)-(17300, 5650), vbBlue
For col = 5800 To 300 Step -500
  Form2.Picture1.Line (300, col)-(17300, col), &H80C0FF
Next
For row = 17300 To 300 Step -500
  Form2.Picture1.Line (row, 300)-(row, 5800), &H80C0FF
Next

'row = 300 + (DateDiff("n", Format(ddat, "hh:mm:ss"), Format(Now, "hh:mm:ss"))) * 100
'col = 300
'Picture1.Line (300, 2900)-(row, col), vbRed
prow25 = 0
pcol25 = 0
prow10 = 0
pcol10 = 0



 b = 255
 For a = 1300 To 16400 Step 600
    Form2.Picture1.DrawWidth = 1
    Form2.Picture1.FillStyle = vbSolid
    Form2.Picture1.FillColor = RGB(b, 0, 0)

    Form2.Picture1.Line (a, 6450)-Step(600, 280), vbBlue, B
   b = b - 10
 Next
 Form2.Picture1.CurrentX = 8600
 Form2.Picture1.CurrentY = 6940
 Form2.Picture1.Print "24Hr Air Quality"
End Sub

Public Static Sub Command3_Click()
Dim FileNumber

Dim Result     As String
 
On Error Resume Next
ShellSync "php c:\wamp64\www\sds011\index.php", vbHide

'Shell "php c:\wamp64\www\sds011\index.php", vbHide
FileNumber = FreeFile
Open "c:\wamp64\www\sds011\47.txt" For Input As FileNumber

Result = Input(LOF(FileNumber), FileNumber)

Close FileNumber
arrSplitStrings1 = Split(Result, "|")
Form2.Label7.Caption = "PM2.5: " & arrSplitStrings1(0) & "  PM10: " & arrSplitStrings1(1)
If Result <> "0|0" Then
  'Text3.Text = Text3.Text & "|" & Result & vbCrLf
  Form2.Text4.Text = Result
'Dim com As String

  plot_graph
Else
' If Option2.Value = True Then
' If Format(Now, "ss") = "00" Then
'    Picture1.Cls
'    prepare_graph
' End If
' Else

 
' End If
End If

Kill "c:\wamp64\www\sds011\47.txt"

'Dim sCommand As String
'sCommand = "php c:\wamp64\www\sds011\index.php"
'Text4.Text = Shell(sCommand & " > c:\wamp64\www\sds011\text1.txt", 1)
End Sub
Public Static Sub plot_graph()
Dim row25 As Integer
Dim col25 As Integer
Dim row10 As Integer
Dim col10 As Integer
Dim ss As Integer

ss = Format(Now, "ss")
'mm = Minute(Now)
'If Option2.Value = True Then

'row25 = 300 + (152 * ss)
'row10 = 300 + (152 * ss)

'Else
 
  row25 = 300 + (4.65 * (Val(Minute(Now)) * 60 + ss))
  row10 = 300 + (4.65 * (Val(Minute(Now)) * 60 + ss))

'End If

'If Option3.Value = False Then
 ' col25 = 2900 - (2.5 * Val(arrSplitStrings1(0)))
 ' col10 = 2900 - (2.5 * Val(arrSplitStrings1(1)))
'Else
  col25 = 5800 - (5 * Val(arrSplitStrings1(0)))
  col10 = 5800 - (5 * Val(arrSplitStrings1(1)))

'End If
'If Option2.Value = True Then
'If ss = 0 Then
' Picture1.Cls
' prepare_graph
'End If
'Else
 If Val(Minute(Now)) = 0 And ss = 0 Then
   Form2.Picture1.Cls
    prepare_graph

 End If
'End If
If pcol25 = 0 And prow25 = 0 Then
    pcol25 = col25
    prow25 = row25
End If

If pcol10 = 0 And prow10 = 0 Then
    pcol10 = col10
    prow10 = row10
End If
Form2.Picture1.DrawWidth = 6
Form2.Picture1.Line (prow25, pcol25)-(row25, col25), vbRed
Form2.Picture1.Line (prow10, pcol10)-(row10, col10), vbBlue
prow25 = row25
pcol25 = col25
prow10 = row10
pcol10 = col10
End Sub


