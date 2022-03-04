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

Public Static Sub prepare_graph()
Dim row As Integer
Dim col As Integer
Dim hh As Integer
Dim a As Integer
Dim b As Integer
Dim mm As Integer


Form1.Picture1.DrawWidth = 2



read_csv


 Form1.Picture1.CurrentX = 5600
Form1.Picture1.CurrentY = 5800
Form1.Picture1.Print "24Hr Air Quality"
End Sub


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


Public Sub read_csv()
Dim lv_cnt As Integer
Dim rt_pm25 As Integer
Dim rt_pm10 As Integer
Dim rt24 As Integer

 b = 255
 For a = 1050 To 11500 Step 450
    Form1.Picture1.DrawWidth = 1
    Form1.Picture1.FillStyle = vbSolid
    Form1.Picture1.FillColor = vbGreen 'RGB(b, 0, 0)

   Form1.Picture1.Line (a, 5400)-Step(400, 230), vbBlue, B
   b = b - 10
 Next
Dim f As Integer
Dim sLine As String
Dim aFields() As String
Dim bColsSet As Boolean
    f = FreeFile
    lv_cnt = 0
    Open "C:\Users\F1\pyqt6\hour_ave.csv" For Input As #f
        While Not EOF(f)
            Line Input #f, sLine
            aFields() = Split(sLine, ",")
            If lv_cnt <> 0 Then
               If Val(aFields(2)) >= 0 And Val(aFields(2)) <= 12 Then
                  Form1.Picture1.FillColor = vbGreen
                  rt_pm25 = 50
               ElseIf Val(aFields(2)) > 12 And Val(aFields(2)) <= 35.4 Then
                  Form1.Picture1.FillColor = vbYellow
                  rt_pm25 = 100
               ElseIf Val(aFields(2)) > 35.4 And Val(aFields(2)) <= 55.4 Then
                  Form1.Picture1.FillColor = RGB(255, 153, 0)
                  rt_pm25 = 150
               ElseIf Val(aFields(2)) > 55.4 And Val(aFields(2)) <= 150.4 Then
                  Form1.Picture1.FillColor = vbRed
                  rt_pm25 = 200
               ElseIf Val(aFields(2)) > 150.4 And Val(aFields(2)) <= 250.4 Then
                  Form1.Picture1.FillColor = RGB(153, 0, 255)
                  rt_pm25 = 200
               ElseIf Val(aFields(2)) > 250.4 Then
                  Form1.Picture1.FillColor = RGB(179, 0, 71)
                  rt_pm25 = 200
               End If
               If Val(aFields(3)) >= 0 And Val(aFields(3)) <= 54 Then
                  Form1.Picture1.FillColor = vbGreen
                  rt_pm10 = 50
               ElseIf Val(aFields(3)) > 54 And Val(aFields(3)) <= 154 Then
                  Form1.Picture1.FillColor = vbYellow
                  rt_pm10 = 100
               ElseIf Val(aFields(3)) > 154 And Val(aFields(3)) <= 254 Then
                  Form1.Picture1.FillColor = RGB(255, 153, 0)
                  rt_pm10 = 150
               ElseIf Val(aFields(3)) > 254 And Val(aFields(3)) <= 354 Then
                  Form1.Picture1.FillColor = vbRed
                  rt_pm10 = 200
               ElseIf Val(aFields(3)) > 354 And Val(aFields(3)) <= 424 Then
                  Form1.Picture1.FillColor = RGB(153, 0, 255)
                  rt_pm10 = 200
               ElseIf Val(aFields(3)) > 424 Then
                  Form1.Picture1.FillColor = RGB(179, 0, 71)
                  rt_pm10 = 200
               End If
               rt_pm25 = (rt_pm25 + rt_pm10) / 2
               rt_pm10 = 0
               If rt_pm25 >= 0 And rt_pm25 <= 50 Then
                  Form1.Picture1.FillColor = vbGreen
                  rt24 = rt24 + 50
               ElseIf rt_pm25 > 54 And rt_pm25 <= 100 Then
                  Form1.Picture1.FillColor = vbYellow
                  rt24 = rt24 + 100
               ElseIf rt_pm25 > 100 And rt_pm25 <= 150 Then
                  Form1.Picture1.FillColor = RGB(255, 153, 0)
                  rt24 = rt24 + 150
               ElseIf rt_pm25 > 150 And rt_pm25 <= 200 Then
                  Form1.Picture1.FillColor = vbRed
                  rt_pm10 = rt_pm10 + 200
               ElseIf rt_pm25 > 200 And rt_pm25 <= 300 Then
                  Form1.Picture1.FillColor = RGB(153, 0, 255)
                  rt24 = rt24 + 300
               ElseIf rt_pm25 > 300 Then
                  Form1.Picture1.FillColor = RGB(179, 0, 71)
                  rt24 = rt24 + 400
               End If

               Form1.Picture1.DrawWidth = 1
               Form1.Picture1.FillStyle = vbSolid
               'Form1.Picture1.FillColor = vbRed 'RGB(b, 0, 0)
               a = 1050 + 450 * (Val(aFields(1)) - 1)
               Form1.Picture1.Line (a, 5400)-Step(400, 230), vbBlue, B
            End If
             'Form1.Print aFields(1) & " | " & aFields(2) & " | " & aFields(3) & vbCrLf
    
             lv_cnt = lv_cnt + 1
        Wend
    Close #f
             If lv_cnt > 0 Then
                rt24 = rt24 / (lv_cnt - 1)
               If rt_pm10 >= 0 And rt24 <= 50 Then
                  Form1.Label4.BackColor = vbGreen
                  Form1.Shape1.FillColor = vbGreen
                  Form1.Label4.Caption = "Good"
                  Form1.Label4.FontSize = 15
               ElseIf rt24 > 54 And rt24 <= 100 Then
                  Form1.Label4.BackColor = vbYellow
                  Form1.Shape1.FillColor = vbYellow
                  Form1.Label4.Caption = "Moderate"
                  Form1.Label4.FontSize = 15
               ElseIf rt24 > 100 And rt24 <= 150 Then
                  Form1.Label4.BackColor = RGB(255, 153, 0)
                  Form1.Shape1.BackColor = RGB(255, 153, 0)
                  Form1.Shape1.FillColor = RGB(255, 153, 0)
                  Form1.Label4.Caption = "Unhealthy for Certain Group"
                  Form1.Label4.FontSize = 13
               ElseIf rt24 > 150 And rt24 <= 200 Then
                  Form1.Label4.BackColor = vbRed
                  Form1.Shape1.FillColor = vbRed
                  Form1.Label4.Caption = "Unhealthy"
                  Form1.Label4.FontSize = 15
               ElseIf rt24 > 200 And rt24 <= 300 Then
                  Form1.Label4.BackColor = RGB(153, 0, 255)
                  Form1.Shape1.FillColor = RGB(153, 0, 255)
                  Form1.Label4.Caption = "Very Unhealthy"
                  Form1.Label4.FontSize = 15

               ElseIf rt24 > 300 Then
                  Form1.Label4.BackColor = RGB(179, 0, 71)
                  Form1.Shape1.FillColor = RGB(179, 0, 71)
                  Form1.Label4.Caption = "Hazardous"
                  Form1.Label4.FontSize = 15
               End If
               End If

End Sub


