VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form2 
   Caption         =   "SDS011 Realtime Monitoring"
   ClientHeight    =   9450
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   19080
   Icon            =   "Form2.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   9450
   ScaleWidth      =   19080
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFC0&
      DrawWidth       =   2
      Height          =   7170
      Left            =   240
      ScaleHeight     =   7110
      ScaleWidth      =   19530
      TabIndex        =   2
      Top             =   1140
      Width           =   19585
      Begin VB.Label Label2 
         BackColor       =   &H00FFFFC0&
         Caption         =   "PM 10"
         Height          =   240
         Left            =   10140
         TabIndex        =   7
         Top             =   6510
         Width           =   870
      End
      Begin VB.Label Label1 
         BackColor       =   &H00FFFFC0&
         Caption         =   "PM 2.5"
         Height          =   240
         Left            =   8535
         TabIndex        =   6
         Top             =   6510
         Width           =   870
      End
      Begin VB.Shape Shape2 
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   360
         Left            =   7935
         Top             =   6450
         Width           =   480
      End
      Begin VB.Shape Shape1 
         FillColor       =   &H00FF0000&
         FillStyle       =   0  'Solid
         Height          =   360
         Left            =   9510
         Top             =   6450
         Width           =   480
      End
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
      Left            =   660
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   0
      Visible         =   0   'False
      Width           =   3144
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   15
      Top             =   330
      _ExtentX        =   979
      _ExtentY        =   979
      _Version        =   393216
      CommPort        =   3
      DTREnable       =   -1  'True
   End
   Begin VB.Label Label7 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   30
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   690
      Left            =   9795
      TabIndex        =   5
      Top             =   180
      Width           =   8145
   End
   Begin VB.Label Label6 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   30
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   675
      Left            =   180
      TabIndex        =   4
      Top             =   210
      Width           =   4950
   End
   Begin VB.Label Label5 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   30
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   660
      Left            =   5265
      TabIndex        =   3
      Top             =   195
      Width           =   4005
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

retart = False
End Sub



Private Sub Form_Unload(Cancel As Integer)
If MSComm1.PortOpen = True Then
MSComm1.PortOpen = False
End If
End Sub

Private Sub MSComm1_OnComm()
Dim FileNum
Dim ss As Integer
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
         ss = Format(Now, "ss")
         If Val(Minute(Now)) = 0 And ss = 0 Then
            Form2.Picture1.Cls
            prepare_graph

          End If
         Command3_Click
 End Select
End Sub





