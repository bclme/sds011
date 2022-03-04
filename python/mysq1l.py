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


query = "SELECT * FROM sds011 where guid >= %s and guid <= %s" %(t1, t2)
## getting records from the table
cursor.execute(query)

## fetching all records from the 'cursor' object
records = cursor.fetchall()
df = pd.DataFrame(records)
del df[0]

query1 = "select HOUR(guid) as hour, AVG(pm25) as avg_pm25, AVG(pm10) as avgpm10 from sds011 where guid >= %s and guid <= %s group by HOUR(guid) " %(t1, t2)
#query = "SELECT * FROM sds011 where guid >= %s and guid <= %s" %(t1, t2)
## getting records from the table
cursor.execute(query1)

## fetching all records from the 'cursor' object
records1 = cursor.fetchall()
df5 = pd.DataFrame(records1)

#df[2] = df[2].astype(float)
#df[3] = df[3].astype(float)
df2 = df.rename(columns = {1: 'DateTime', 2: 'PM25', 3: 'PM10'}, inplace = False)
df5 = df5.rename(columns = {0: 'Hour', 1: 'PM25', 2: 'PM10'}, inplace = False)
df5['PM25']=df5['PM25'].apply(lambda x:round(x,2)) 
df5['PM10']=df5['PM10'].apply(lambda x:round(x,2))

print("\n----------- Data Top -----------\n")
data_top1 = df2.head()
print(data_top1)
print("\n----------- Standards Deviation -----------\n")
print(df2['PM25'].std())
print("\n----------- Calculate Mean -----------\n")


print(df2['PM25'].mean())
print("\n----------- Calculate Median -----------\n")
print(df2['PM25'].median())

print("\n----------- Calculate Mode -----------\n")
print(df2['PM25'].mode())

print("\n----------- Describe -----------\n")
print(df2.describe())
## Showing the data


# first convert the DATE column to datetime data type:

#query1 = "select HOUR(guid) as hour, AVG(pm25) as avg_pm25 AVG(pm10) as avgpm10 from sds011 group by HOUR(guid) where guid >= %s and guid <= %s" %(t1, t2)
#query = "SELECT * FROM sds011 where guid >= %s and guid <= %s" %(t1, t2)
## getting records from the table
#cursor.execute(query1)

## fetching all records from the 'cursor' object
#records1 = cursor.fetchall()
#df2 = pd.DataFrame(records1)
#df2.insert(1,'Hour','01', True)
#data_top1 = df5.head()
#print(data_top1)
#print(df5.describe())

# then you group by day and month and get the mean like so:



#for ind in df2.index:
#    df.is_copy = False
#    df2['Hour'][ind] = df2['DateTime'][ind].hour
    
#del df2['DateTime']
#davg_df2m = df2.groupby('Hour').mean()
#data_top1 = davg_df2m.head()
#print(data_top1)

df5.to_csv("hour_ave.csv")

f = open(r'C:\wamp64\www\admin\sds011.php', 'w')

str1 = "<?php include('sds011_head.php'); ?>"
str2 = ''

column_names = ["Hour", "PM25", "PM10"]

df3 = pd.DataFrame(columns = column_names)
n = 24
i=0
for i in range(n):
  # Do something
  df3.loc[i] = [i, 0, 0]
  i = i + 1
for ind in df5.index:
   # print(df['Name'][ind], df['Stream'][ind])
   v = df5['Hour'][ind]
   df3['PM25'][v] = df5['PM25'][ind]
   df3['PM10'][v] = df5['PM10'][ind]

n = 24
i=0
str4 = ''
str5 = ''
str6 = ''

for i in range(n):
  avg = (df3['PM25'][i] + df3['PM10'][i])/2
  if i < 23:
     
    str4 = str4 + str(df3['PM25'][i]) + ","
    str5 = str5 + str(df3['PM10'][i]) + ","
    str6 = str6 + str(avg) + ","
  else:
    str4 = str4 + str(df3['PM25'][i])
    str5 = str5 + str(df3['PM10'][i])
    str6 = str6 + str(avg)
  i = i + 1

#for ind in df.index:
    #print(df['Name'][ind], df['Stream'][ind])
#    str2 = str2 + "<tr><td>" + str(df['Hour'][ind]) + "</td><td>" + str(df['PM25'][ind]) + "</td><td>" + str(df['PM10'][ind]) + "</td></tr>"

str2 = str2 +    "<button type='button' class='btn btn-block btn-primary '>Records:" + str(df2.shape[0]) + "</button>" 
str2 = str2 +	"<button type='button' class='btn btn-block btn bg-purple'>Min:" + str(df2['PM25'].min()) + "</button>" 
str2 = str2 +	"<button type='button' class='btn btn-block btn-warning'>Max: " + str(df2['PM25'].max()) + "</button>" 
		
str2 = str2 +	"<button type='button' class='btn btn-block btn bg-navy'>Mode: " + str(df2['PM25'].mode().iat[0]) + "</button>" 
str2 = str2 +  "<button type='button' class='btn btn-block btn-success '>Mean: " + str(round(df2['PM25'].mean(),2)) + "</button>" 
str2 = str2 +  "<button type='button' class='btn btn-block btn-danger'>Median: " + str(round(df2['PM25'].median(),2)) + "</button>" 
str2 = str2 +	"<button type='button' class='btn btn-block btn-info'>STD: " + str(round(df2['PM25'].std(),2)) + "5</button>" 
		
str2 = str2 + "</td>"  
str2 = str2 + "  <td> " 
str2 = str2 +  "<button type='button' class='btn btn-block btn bg-default'>PM10</button>"  
	    
str2 = str2 +  "<button type='button' class='btn btn-block btn-primary '>Records:" + str(df2.shape[0]) + "</button> "  
str2 = str2 +	"<button type='button' class='btn btn-block btn bg-purple'>Min:" + str(df2['PM10'].min()) + "</button> " 
str2 = str2 +	"<button type='button' class='btn btn-block btn-warning'>Max: " + str(df2['PM10'].max()) + "</button>" 
str2 = str2 +	"<button type='button' class='btn btn-block btn bg-navy'>Mode: " + str(df2['PM10'].mode().iat[0]) + "</button>" 
str2 = str2 +  "<button type='button' class='btn btn-block btn-success '>Mean: " + str(round(df2['PM10'].mean(),2)) + "</button>" 
str2 = str2 + "<button type='button' class='btn btn-block btn-danger '>Median: " + str(round(df2['PM10'].median(),2)) + "</button> " 
str2 = str2 +	"<button type='button' class='btn btn-block btn-info '>STD: " + str(round(df2['PM10'].std(),2)) + "</button>" 
		
str2 = str2 + "</td>"  
str2 = str2 + "</tr>" 			  
str2 = str2 + "</table>" 
 
 
  
     

str2 = str2 + "<script>" 
str2 = str2 + "var xValues = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24];" 

str2 = str2 + "new Chart('myChart', {" 
str2 = str2 + "  type: 'line'," 
str2 = str2 +  "data: {"
str2 = str2 +   " labels: xValues," 
str2 = str2 +    "datasets: [{ " 
str2 = str2 +	  "label: 'PM2'," 
str2 = str2 +     " data: [" + str4 + "]," 
str2 = str2 +     " borderColor: 'red'," 
str2 = str2 +      "fill: false" 
str2 = str2 +    "}, { " 
str2 = str2 +	  "label: 'PM10'," 
str2 = str2 +      "data: [" + str5 + "]," 
str2 = str2 +      "borderColor: 'blue'," 
str2 = str2 +      "fill: false" 
str2 = str2 +    "}, {" 
str2 = str2 +	  "label: 'Air Quality'," 
str2 = str2 +      "data: [" + str6 + "]," 
str2 = str2 +      "borderColor: 'green'," 
str2 = str2 +      "fill: false" 
str2 = str2 +    "}]" 
str2 = str2 +  "}," 
  

str3 = "<?php include('sds011_foot.php'); ?>"  
f.write(str1 + str2 + str3)
f.close()

  

  
# close the file
f.close()
