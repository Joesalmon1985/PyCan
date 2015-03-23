import sqlite3, csv
from sys import argv 
script, filename = argv
print "This thing will create or open the database %s and muck about with it." % (filename)

# This tells python to start using SQLITE3 with a database called whatever what typed after python joesqlite.py.
conn = sqlite3.connect(filename)

# This tells python to start typing in the running sqlite3 program.
cur = conn.cursor()

print "Have you helpfully renamed your csv files from the council councilfull.csv, council01.csv, council02.csv etc.? y/n"
choice = raw_input (">")

if choice == 'y':
    print "good, this might work"
    cur.execute('drop table if exists councilrawdata;')
    cur.execute('''CREATE TABLE councilrawdata(
  "pd" TEXT,
  "eno" TEXT,
  "status" TEXT,
  "title" TEXT,
  "firstname" TEXT,
  "initals" TEXT,
  "surname" TEXT,
  "suffix" TEXT,
  "dateofattainment" TEXT,
  "franchaiseflat" TEXT,
  "address1" TEXT,
  "address2" TEXT,
  "address3" TEXT,
  "address4",
  "address5" TEXT,
  "address6" TEXT,
  "address7" TEXT,
  "optout" TEXT
);   ''')
    print 'Importing CSV'
    reader = csv.reader( open( 'councilfull.csv', 'r' ), delimiter=',' )

else:
    
    if choice == 'n':
        print "this won't work yet"
    
    else:
        print "you goofed"
    

