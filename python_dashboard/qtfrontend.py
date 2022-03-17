import sys
import os
import time
from PyQt6.QtWidgets import QApplication,  QWidget, QMenu, QProgressBar, QVBoxLayout, QButtonGroup, QSizePolicy, QMessageBox, QPushButton,  QLabel, QHeaderView, QTableWidget, QDateEdit
from PyQt6.QtGui import QPainter, QColor, QFont, QPen
from PyQt6.QtCore import Qt, QDateTime, QTimer

from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure
import matplotlib.pyplot as plt


TIME_LIMIT = 100

class Window(QWidget):

    def __init__(self):
        super(Window, self).__init__()

        self.initUI()

    def initUI(self):

        m = PlotCanvas(self, width=5, height=3)
        m.move(22,45)

        dateEdit = QDateEdit(self)
        dateEdit.setDateTime(QDateTime.currentDateTime())
        dateEdit.setGeometry(70, 525, 110, 22)

        self.progress = QProgressBar(self)
        self.progress.setGeometry(622, 575, 305, 20)
        self.progress.setMaximum(100)
        self.progress.setStyleSheet("QProgressBar::chunk "
                          "{"
                          "background-color: red;text-align: center"
                          "}")
        self.progress.setAlignment(Qt.AlignmentFlag.AlignCenter)
        #timer.timeout.connect(self.handleTimer)
        
        
        lbl1a =  QLabel(' ', self)
        lbl1a.setGeometry(622, 50, 50, 35)
        lbl1a.setStyleSheet('QLabel {background-color: #DFE4DA; color: #191B17;}')
        lbl1a.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl1a =  QLabel('RECS', self)
        lbl1a.setGeometry(622, 90, 50, 35)
        lbl1a.setStyleSheet('QLabel {background-color: #0E95A6; color: #d4d4d4;}')
        lbl1a.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl1a =  QLabel('MIN', self)
        lbl1a.setGeometry(622, 130, 50, 35)
        lbl1a.setStyleSheet('QLabel {background-color: #aa55ff; color: #d4d4d4;}')
        lbl1a.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl1a =  QLabel('MAX', self)
        lbl1a.setGeometry(622, 170, 50, 35)
        lbl1a.setStyleSheet('QLabel {background-color: #E9BA21; color: #191B17;}')
        lbl1a.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl1a =  QLabel('MODE', self)
        lbl1a.setGeometry(622, 210, 50, 35)
        lbl1a.setStyleSheet('QLabel {background-color: #650C50; color: #d4d4d4;}')
        lbl1a.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl1a =  QLabel('MEAN', self)
        lbl1a.setGeometry(622, 250, 50, 35)
        lbl1a.setStyleSheet('QLabel {background-color: #15A233; color: #191B17;}')
        lbl1a.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl1a =  QLabel('MEDN', self)
        lbl1a.setGeometry(622, 290, 50, 35)
        lbl1a.setStyleSheet('QLabel {background-color: #F11E1E; color: #d4d4d4;}')
        lbl1a.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl1a =  QLabel('STD', self)
        lbl1a.setGeometry(622, 330, 50, 35)
        lbl1a.setStyleSheet('QLabel {background-color: #19D3EA; color: #191B17;}')
        lbl1a.setAlignment(Qt.AlignmentFlag.AlignCenter)


        lbl1 =  QLabel('PM2.5', self)
        lbl1.setGeometry(677, 50, 125, 35)
        lbl1.setStyleSheet('QLabel {background-color: #DFE4DA; color: #191B17;}')
        lbl1.setAlignment(Qt.AlignmentFlag.AlignCenter)
        #lbl1.move(620, 31)
        lbl2 =  QLabel('PM10', self)
        lbl2.setGeometry(807, 50, 125, 35)
        lbl2.setStyleSheet('QLabel {background-color: #DFE4DA; color: #191B17;}')
        lbl2.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl3 =  QLabel('7222', self)
        lbl3.setGeometry(677, 90, 125, 35)
        lbl3.setStyleSheet('QLabel {background-color: #0E95A6; color: #d4d4d4;}')
        lbl3.setAlignment(Qt.AlignmentFlag.AlignCenter)
        #lbl1.move(620, 31)
        lbl4 =  QLabel('7222', self)
        lbl4.setGeometry(807, 90, 125, 35)
        lbl4.setStyleSheet('QLabel {background-color: #0E95A6; color: #d4d4d4;}')
        lbl4.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl5 =  QLabel('25.7', self)
        lbl5.setGeometry(677, 130, 125, 35)
        lbl5.setStyleSheet('QLabel {background-color: #aa55ff; color: #d4d4d4;}')
        lbl5.setAlignment(Qt.AlignmentFlag.AlignCenter)
        #lbl1.move(620, 31)
        lbl6 =  QLabel('34.4', self)
        lbl6.setGeometry(807, 130, 125, 35)
        lbl6.setStyleSheet('QLabel {background-color: #aa55ff; color: #d4d4d4;}')
        lbl6.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl7 =  QLabel('145.2', self)
        lbl7.setGeometry(677, 170, 125, 35)
        lbl7.setStyleSheet('QLabel {background-color: #E9BA21; color: #191B17;}')
        lbl7.setAlignment(Qt.AlignmentFlag.AlignCenter)
        #lbl1.move(620, 31)
        lbl8 =  QLabel('451.6', self)
        lbl8.setGeometry(807, 170, 125, 35)
        lbl8.setStyleSheet('QLabel {background-color: #E9BA21; color: #191B17;}')
        lbl8.setAlignment(Qt.AlignmentFlag.AlignCenter)
        #lbl2.move(720, 31)

        lbl9 =  QLabel('29.6', self)
        lbl9.setGeometry(677, 210, 125, 35)
        lbl9.setStyleSheet('QLabel {background-color: #650C50; color: #d4d4d4;}')
        lbl9.setAlignment(Qt.AlignmentFlag.AlignCenter)
        #lbl1.move(620, 31)
        lbl10 =  QLabel('78.9', self)
        lbl10.setGeometry(807, 210, 125, 35)
        lbl10.setStyleSheet('QLabel {background-color: #650C50; color: #d4d4d4;}')
        lbl10.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl11 =  QLabel('70.7', self)
        lbl11.setGeometry(677, 250, 125, 35)
        lbl11.setStyleSheet('QLabel {background-color: #15A233; color: #191B17;}')
        lbl11.setAlignment(Qt.AlignmentFlag.AlignCenter)
        #lbl1.move(620, 31)
        lbl12 =  QLabel('121.9', self)
        lbl12.setGeometry(807, 250, 125, 35)
        lbl12.setStyleSheet('QLabel {background-color: #15A233; color: #191B17;}')
        lbl12.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl13 =  QLabel('72.3', self)
        lbl13.setGeometry(677, 290, 125, 35)
        lbl13.setStyleSheet('QLabel {background-color: #F11E1E; color: #d4d4d4;}')
        lbl13.setAlignment(Qt.AlignmentFlag.AlignCenter)
        #lbl1.move(620, 31)
        lbl14 =  QLabel('124.6', self)
        lbl14.setGeometry(807, 290, 125, 35)
        lbl14.setStyleSheet('QLabel {background-color: #F11E1E; color: #d4d4d4;}')
        lbl14.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl15 =  QLabel('35.8', self)
        lbl15.setGeometry(677, 330, 125, 35)
        lbl15.setStyleSheet('QLabel {background-color: #19D3EA; color: #191B17;}')
        lbl15.setAlignment(Qt.AlignmentFlag.AlignCenter)
        #lbl1.move(620, 31)
        lbl16 =  QLabel('77.4', self)
        lbl16.setGeometry(807, 330, 125, 35)
        lbl16.setStyleSheet('QLabel {background-color: #19D3EA; color: #191B17;}')
        lbl16.setAlignment(Qt.AlignmentFlag.AlignCenter)

        lbl17 =  QLabel('24Hr Air Quality', self)
        lbl17.setGeometry(290, 425, 150, 35)

        lbl18 =  QLabel('Hourly Average', self)
        lbl18.setFont(QFont("Arial", 14))
        lbl18.setGeometry(943, 53, 150, 35)

        lbl19 =  QLabel('Air Quality Analysis Dash Board', self)
        lbl19.setFont(QFont("Arial", 18))
        lbl19.setGeometry(25, 2, 350, 40)

        lbl20 =  QLabel('Air Quality Result:', self)
        lbl20.setFont(QFont("Arial", 13))
        lbl20.setGeometry(650, 385, 190, 30)

        lbl21 =  QLabel('Very Good', self)
        lbl21.setFont(QFont("Arial Black", 19))
        lbl21.setStyleSheet('QLabel {font-weight: bold;}')
        #lbl20.setFont(QFont.setBold(True))
        lbl21.setAlignment(Qt.AlignmentFlag.AlignCenter)
        lbl21.setGeometry(640, 495, 270, 30)

        lbl22 =  QLabel('Enter Date to process:', self)
        lbl22.setFont(QFont("Arial", 13))
        lbl22.setGeometry(40, 485, 190, 30)

        #lbl16.setStyleSheet('QLabel {background-color: #aa55ff; color: #d4d4d4;}')
        #lbl16.setAlignment(Qt.AlignmentFlag.AlignCenter)

        pb1 = QPushButton('Exit', self)
        pb1.setGeometry(350, 550, 250, 30)
        pb1.setStyleSheet('QPushButton {background-color: #2F569B; color: #d4d4d4;}')
        pb1.clicked.connect(onClick_pb1)
        
        pb2 = QPushButton('Display Air Quality Analysis', self)
        pb2.setGeometry(350, 515, 250, 30)
        pb2.setStyleSheet('QPushButton {background-color: #2F569B; color: #d4d4d4;}')
        pb2.clicked.connect(self.onClick_pb2)
        
        pb3 = QPushButton('Launch Air Quality Monitoring', self)
        pb3.setGeometry(350, 480, 250, 30)
        pb3.setStyleSheet('QPushButton {background-color: #2F569B; color: #d4d4d4;}')
        pb3.clicked.connect(onClick_pb3)


  


    
    #    tbl1 = QTableView()
    #    tbl1.setGeometry((935, 45, 280, 545)

        self.setGeometry(25, 45, 1230, 605)
        self.setWindowTitle('SDS011: Air Quality Data Analysis Dash Board')
        self.createTable()
        self.show()
        
 
    def onClick_pb2(self):
       #print checked #<- only used if the button is checkeable
       #print("clicked button is "+b.text())
       #os.popen(r"C:\Users\F1\Desktop\sds011\sds011.exe")
       print("clicked")
       
       count = 0
       while count < TIME_LIMIT:
            count += 1
            time.sleep(0.01)
            self.progress.setValue(count)
       #timer.start(1000)
            
    def createTable(self):
        self.tableWidget = QTableWidget(self)
        self.tableWidget.setRowCount(24)
        self.tableWidget.setColumnCount(2)
        self.tableWidget.setFixedSize(280, 490)
        self.tableWidget.move(935, 100)
        self.tableWidget.setHorizontalHeaderLabels(['PM2.5', 'PM10'])
        #self.tableWidget.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.tableWidget.horizontalHeader().setStretchLastSection(True)
        #self.tableWidget.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        #self.tableWidget.horizontalHeader().setVisible(False)
        self.tableWidget.verticalHeader().setStretchLastSection(True)
        #self.tableWidget.verticalHeader().setSectionResizeMode(QHeaderView.Stretch)


    def paintEvent(self, e):

        qp = QPainter()
        qp.begin(self)
        self.drawRectangles(qp)
        qp.end()
        
    
    
    def drawRectangles(self, qp):


        color = QColor(0, 0, 0)
        color.setNamedColor('#d4d4d4')
        qp.setPen(color)

        qp.setBrush(QColor('#ffffff'))
        qp.drawRect(25, 45, 590, 350)

        qp.setBrush(QColor('#ffffff'))
        qp.drawRect(935, 45, 280, 545)

        qp.setBrush(QColor('#ffffff'))
        qp.drawRect(25, 470, 590, 120)
        pen = QPen()
        pen.setWidth(5)
        qp.setBrush(QColor('#00aa00'))
        qp.drawEllipse(625, 420, 300, 150)

        qp.setBrush(QColor('#d4d4d4'))
        qp.drawEllipse(640, 455, 270, 110)


        ii = 0
        while ii < 24:
            ii = ii + 1
            iii = (ii * 24) + 10
            qp.setBrush(QColor('#00aa00'))
            qp.drawRect(iii, 410, 22, 15)

        #qp.setBrush(QColor('#DFE4DA'))
        #qp.drawRect(590, 25, 100, 30)

        #qp.setBrush(QColor('#DFE4DA'))
        #qp.drawRect(694, 25, 100, 30)

class PlotCanvas(FigureCanvas):

    def __init__(self, parent=None, width=5, height=3, dpi=115):
        fig = Figure(figsize=(width, height), dpi=dpi)
        #self.axes = fig.add_subplot(111)

        FigureCanvas.__init__(self, fig)
        self.setParent(parent)

#        FigureCanvas.setSizePolicy(self,
#                QSizePolicy.Expanding,
#                QSizePolicy.Expanding)
        FigureCanvas.updateGeometry(self)
        self.plot()


    def plot(self):
        x = [0, 0, 25, 22, 0, 0, 0, 50, 78, 260, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        z = [0, 0, 75, 42, 0, 0, 0, 150, 165, 400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        a = [0, 0, 1005, 72, 0, 0, 0, 350, 350, 650, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        y = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
        ax = self.figure.add_subplot(111)
        ax.plot(y,x)
        ax.plot(y,z)
        ax.plot(y,a)
        #ax.set_title('PyQt Matplotlib Example')
        self.draw()
        
def onClick_pb3():
    #print checked #<- only used if the button is checkeable
    #print("clicked button is "+b.text())
    os.popen(r"C:\Users\F1\Desktop\sds011\sds011.exe")


    
def onClick_pb1():
    exit()

def main():

    app = QApplication(sys.argv)
    ex = Window()
    sys.exit(app.exec())


if __name__ == '__main__':
    main()
