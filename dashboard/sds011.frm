VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "ieframe.dll"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form Form1 
   Caption         =   "SDS011 "
   ClientHeight    =   8790
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   18765
   Icon            =   "sds011.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8790
   ScaleWidth      =   18765
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   125
      Left            =   8730
      Top             =   90
   End
   Begin VB.CommandButton Command3 
      Caption         =   "è"
      BeginProperty Font 
         Name            =   "Wingdings"
         Size            =   20.25
         Charset         =   2
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Left            =   12270
      TabIndex        =   10
      Top             =   -30
      Width           =   825
   End
   Begin SHDocVwCtl.WebBrowser WebBrowser2 
      Height          =   8085
      Left            =   13260
      TabIndex        =   9
      Top             =   600
      Width           =   5400
      ExtentX         =   9525
      ExtentY         =   14261
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   "http:///"
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Display Air Quality Monitoring"
      Height          =   432
      Left            =   4320
      TabIndex        =   8
      Top             =   8265
      Width           =   2592
   End
   Begin VB.Frame Frame1 
      Caption         =   "Selection Parameters"
      Height          =   1245
      Left            =   195
      TabIndex        =   4
      Top             =   6945
      Width           =   12915
      Begin MSComCtl2.DTPicker DTPicker2 
         Height          =   300
         Left            =   1290
         TabIndex        =   6
         Top             =   405
         Width           =   1395
         _ExtentX        =   2461
         _ExtentY        =   529
         _Version        =   393216
         Format          =   124583937
         CurrentDate     =   44615
      End
      Begin VB.Label Label4 
         Alignment       =   2  'Center
         BackColor       =   &H0000C000&
         Caption         =   "Very Good"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   15
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   390
         Left            =   7095
         TabIndex        =   14
         Top             =   555
         Width           =   3885
      End
      Begin VB.Shape Shape1 
         BackStyle       =   1  'Opaque
         FillColor       =   &H8000000F&
         FillStyle       =   0  'Solid
         Height          =   585
         Left            =   6870
         Top             =   420
         Width           =   4470
      End
      Begin VB.Label Label6 
         Caption         =   "Air Quality Result"
         Height          =   345
         Left            =   6870
         TabIndex        =   13
         Top             =   180
         Width           =   2475
      End
      Begin VB.Label Label1 
         Caption         =   "Date"
         Height          =   195
         Left            =   555
         TabIndex        =   5
         Top             =   465
         Width           =   480
      End
   End
   Begin VB.CommandButton Command10 
      Caption         =   "Display Air Quality Analysis"
      Height          =   432
      Left            =   7065
      TabIndex        =   2
      Top             =   8265
      Width           =   2592
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      Height          =   6210
      Left            =   150
      ScaleHeight     =   6150
      ScaleWidth      =   12885
      TabIndex        =   1
      Top             =   660
      Width           =   12945
      Begin SHDocVwCtl.WebBrowser WebBrowser1 
         Height          =   5190
         Left            =   120
         TabIndex        =   3
         Top             =   30
         Visible         =   0   'False
         Width           =   12840
         ExtentX         =   22648
         ExtentY         =   9155
         ViewMode        =   0
         Offline         =   0
         Silent          =   0
         RegisterAsBrowser=   0
         RegisterAsDropTarget=   1
         AutoArrange     =   0   'False
         NoClientEdge    =   0   'False
         AlignLeft       =   0   'False
         NoWebView       =   0   'False
         HideFileNames   =   0   'False
         SingleClick     =   0   'False
         SingleSelection =   0   'False
         NoFolders       =   0   'False
         Transparent     =   0   'False
         ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
         Location        =   "http:///"
      End
      Begin VB.Label Label5 
         Caption         =   "to Air Quality Dash Board"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   30
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1320
         Left            =   4005
         TabIndex        =   12
         Top             =   1470
         Width           =   7725
      End
      Begin VB.Label Label2 
         Caption         =   "Welcome "
         BeginProperty Font 
            Name            =   "Arial Black"
            Size            =   27.75
            Charset         =   0
            Weight          =   900
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00004000&
         Height          =   1350
         Left            =   3420
         TabIndex        =   11
         Top             =   675
         Width           =   4620
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Exit"
      Height          =   432
      Left            =   9810
      TabIndex        =   0
      Top             =   8280
      Width           =   1704
   End
   Begin VB.Label Label3 
      Caption         =   "Air Quality Analysis"
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
      Left            =   195
      TabIndex        =   7
      Top             =   90
      Width           =   5580
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Dim x_anim As Integer
Dim x_cnt As Integer



Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long _
, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SendMessage Lib "user32.dll" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByRef lParam As Any) As Long

Const WS_MINIMIZEBOX = &H20000
Const WS_MAXIMIZEBOX = &H10000
Const WM_NCPAINT As Long = &H85

Const GWL_STYLE = (-16)



Private Sub Command1_Click()
Dim SHD
SHD = Shell("C:\Users\F1\Desktop\sds011\sds011.exe", vbMaximizedFocus)
End Sub

Private Sub Command10_Click()
  WebBrowser1.Visible = True
  WebBrowser1.Navigate "http://localhost/admin/sds011.php"
  Command3.Enabled = True
  Label4.Visible = True
  prepare_graph
End Sub

Private Sub Command2_Click()
Unload Me
End Sub





Private Sub Command3_Click()

If Command3.Caption = "è" Then
SetWindowLong hwnd, GWL_STYLE, GetWindowLong(hwnd, GWL_STYLE) And Not (WS_MAXIMIZEBOX)
SendMessage Me.hwnd, WM_NCPAINT, 0, 0
SetWindowLong hwnd, GWL_STYLE, GetWindowLong(hwnd, GWL_STYLE) And Not (WS_MINIMIZEBOX)
SendMessage Me.hwnd, WM_NCPAINT, 0, 0
'Command3.Caption = "ç"
'Form1.Width = 18870
Timer1.Enabled = True
Me.Height = 9255
Form1.WindowState = vbNormal
Form1.Left = 165
Form1.Width = 13320
Me.Top = (Screen.Height - Me.Height) \ 2
x_cnt = 0
WebBrowser2.Navigate "http://localhost/admin/sds011_table.php"
WebBrowser2.Visible = True
ElseIf Command3.Caption = "ç" Then
Form1.WindowState = vbNormal
Me.Height = 9255
Form1.Width = 13370
Command3.Caption = "è"
WebBrowser2.Visible = False
Me.Left = (Screen.Width \ 2) - (Me.Width \ 2)
Me.Top = (Screen.Height - Me.Height) \ 2

End If
End Sub

Private Sub Form_Load()
Form1.Width = 13320
WebBrowser2.Visible = False

Command3.Enabled = False
Label4.Visible = False

x_anim = 18870 - 13370
End Sub



Private Sub Timer1_Timer()

x_cnt = x_cnt + 1
If Command3.Caption = "è" And x_cnt = 1 Then
  Form1.Width = Form1.Width + 125
  
ElseIf Command3.Caption = "è" And x_cnt <= 44 Then
  Form1.Width = Form1.Width + 125

ElseIf Command3.Caption = "è" And x_cnt > 22 Then
  x_cnt = 0
  Command3.Caption = "ç"
  SetWindowLong hwnd, GWL_STYLE, GetWindowLong(hwnd, GWL_STYLE) Or (WS_MAXIMIZEBOX)
  SendMessage Me.hwnd, WM_NCPAINT, 0, 0
  SetWindowLong hwnd, GWL_STYLE, GetWindowLong(hwnd, GWL_STYLE) Or (WS_MINIMIZEBOX)
  SendMessage Me.hwnd, WM_NCPAINT, 0, 0
  Timer1.Enabled = False
  Me.Left = (Screen.Width \ 2) - (Me.Width \ 2)
  Me.Top = (Screen.Height - Me.Height) \ 2
  
End If
End Sub

Private Sub WebBrowser1_BeforeNavigate2(ByVal pDisp As Object, URL As Variant, Flags As Variant, TargetFrameName As Variant, PostData As Variant, Headers As Variant, Cancel As Boolean)
WebBrowser1.Silent = True
End Sub

Private Sub WebBrowser2_BeforeNavigate2(ByVal pDisp As Object, URL As Variant, Flags As Variant, TargetFrameName As Variant, PostData As Variant, Headers As Variant, Cancel As Boolean)
WebBrowser2.Silent = True
End Sub

