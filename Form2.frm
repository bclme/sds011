VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form2 
   Caption         =   "SDS011 Realtime Monitoring"
   ClientHeight    =   9450
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   19080
   LinkTopic       =   "Form1"
   ScaleHeight     =   9450
   ScaleWidth      =   19080
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFC0&
      DrawWidth       =   2
      Height          =   7650
      Left            =   135
      ScaleHeight     =   7590
      ScaleWidth      =   19530
      TabIndex        =   2
      Top             =   870
      Width           =   19585
   End
   Begin VB.TextBox Text4 
      Height          =   288
      Left            =   3540
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   45
      Visible         =   0   'False
      Width           =   3144
   End
   Begin VB.TextBox Text1 
      Height          =   288
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   15
      Visible         =   0   'False
      Width           =   3144
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   0
      Top             =   0
      _ExtentX        =   979
      _ExtentY        =   979
      _Version        =   393216
      CommPort        =   3
      DTREnable       =   -1  'True
   End
   Begin VB.Label Label7 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   450
      Left            =   6930
      TabIndex        =   5
      Top             =   255
      Width           =   4485
   End
   Begin VB.Label Label6 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   150
      TabIndex        =   4
      Top             =   225
      Width           =   3000
   End
   Begin VB.Label Label5 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   3405
      TabIndex        =   3
      Top             =   240
      Width           =   3150
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Sub Command1_Click()
MSComm1.PortOpen = False
Unload Me

End Sub



Private Sub Form_Load()
'MSComm1.InputLen = 0
Form2.Width = 10800
Dim a As Integer
Dim b As Integer
    With MSComm1
        .InBufferSize = 512
        .OutBufferSize = 512
        .RThreshold = 1
        .SThreshold = 1
        
        .InputMode = comInputModeText
        .Settings = "9600,n,8,1"
        .Handshaking = comRTS
    End With
 MSComm1.CommPort = 5
If MSComm1.PortOpen = False Then
    MSComm1.PortOpen = True
End If
Picture1.Cls
prepare_graph


End Sub



Private Sub Form_Unload(Cancel As Integer)
If MSComm1.PortOpen = True Then
MSComm1.PortOpen = False
End If
End Sub

Private Sub MSComm1_OnComm()
Dim FileNum
On Error Resume Next
Select Case MSComm1.CommEvent
        ' Event messages.
        Case comEvReceive
         
          Text1.Text = MSComm1.Input
            
         FileNum = FreeFile
         Open "C:\wamp64\www\sds011\45.txt" For Append As FileNum
         Print #FileNum, Text1.Text
         Close FileNum
         Label6.Caption = "Date:" & Format(Now, "mm/dd/yyyy")
         Label5.Caption = "Time:" & Format(Now, "hh:mm:ss")
         If Format(Now, "ss") = "00" And Minute(Now()) = "00" Then
              Form2.Picture1.Cls
              prepare_graph
         End If
         Command3_Click
 End Select
End Sub





