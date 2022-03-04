import mysql.connector as mysql
import datetime
import pandas as pd
import matplotlib.pyplot as plt

db = mysql.connect(
    host = "localhost",
    user = "root",
    passwd = "",
    database = "sds011"
)



cursor = db.cursor()

t1 = datetime.datetime(2022, 2, 25, 00, 00, 00)
t2 = datetime.datetime(2022, 2, 25, 23, 59, 59)
t1 = repr(str(t1))
t2 = repr(str(t2))


query = "select HOUR(guid) as hour, AVG(pm25) as avg_pm25, AVG(pm10) as avgpm10 from sds011 where guid >= %s and guid <= %s group by HOUR(guid) " %(t1, t2)
## getting records from the table
cursor.execute(query)

## fetching all records from the 'cursor' object
records = cursor.fetchall()
df = pd.DataFrame(records)
#del df[0]




df2 = df.rename(columns = {0: 'Hour', 1: 'PM25', 2: 'PM10'}, inplace = False)

print("\n----------- Rows -----------\n")
print(df2.shape[0])


print("\n----------- Min -----------\n")
print(df2['PM25'].min())
print("\n----------- Max -----------\n")
print(df2['PM25'].max())


print("\n----------- Standards Deviation -----------\n")
print(round(df2['PM25'].std(),2))

print("\n----------- Calculate Mean -----------\n")
print(round(df2['PM25'].mean(),2))

print("\n----------- Calculate Median -----------\n")
print(round(df2['PM25'].median(),2))

print("\n----------- Calculate Mode -----------\n")
print(df2['PM25'].mode().iat[0])

print("\n----------- Describe -----------\n")
print(df2.describe())
print(df2.head())
df2.loc[0] = [2, 3, 4]  # adding a row
#df2.index = df.index + 1  # shifting index
#df2 = df.sort_index()  # sorting by index
print(df2.describe())
print(df2.head())


column_names = ["Hour", "PM25", "PM10"]

df3 = pd.DataFrame(columns = column_names)
n = 24
i=0
for i in range(n):
  # Do something
  df3.loc[i] = [i, 0, 0]
  i = i + 1

print(df3.describe())
print(df3.head())

for ind in df2.index:
   # print(df['Name'][ind], df['Stream'][ind])
   v = df2['Hour'][ind]
   df3['PM25'][v] = df2['PM25'][ind]
   df3['PM10'][v] = df2['PM10'][ind]
print(df3.describe())
print(df3.head())

n = 24
i=0
str4 = ''
str5 = ''
str6 = ''

for i in  df3.index:
  avg = (df3['PM25'][i] + df3['PM10'][i])/2
  print(str(df3['PM25'][i]) + "\n") 
  if i < 23:    
    str4 = str4 + str(df3['PM25'][i]) + ","
    str5 = str5 + str(df3['PM10'][i]) + ","
    str6 = str6 + str(avg) + ","
  else:
    str4 = str4 + str(df3['PM25'][i])
    str5 = str5 + str(df3['PM10'][i])
    str6 = str6 + str(avg)
 
print("\n----------- PM25 -----------\n")
print(str4)
print("\n----------- PM10 -----------\n")
print(str5)
print("\n----------- AQi -----------\n")
print(str6)
    
