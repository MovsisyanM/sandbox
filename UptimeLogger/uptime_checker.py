import requests
from datetime import datetime
from sqlalchemy import create_engine, text
from quicknotifier import notify

import pathlib

def getTimestamps(filename):
    fname = pathlib.Path(filename)
    stats = fname.stat()
    if not fname.exists(): # File deleted
        return []
    return(stats.st_ctime,stats.st_mtime,stats.st_atime)
    

def checkTimestamps(filename,create,modify,access):
    stats = getTimestamps(filename)
    if len(stats) == 0:
        return False # File deleted
    (ctime,mtime,atime) = stats
    if float(create) != float(ctime):
        return False    # File creation time is incorrect
    elif float(modify) != float(mtime):
        return False    # File modify time is incorrect
    elif float(access) != float(atime):
        return False    # File access time is incorrect
    return True

def checkDecoyFiles():
    with open("../Honeypot/decoys.txt","r") as f:
        for line in f:
            vals = line.rstrip().split(",")
            if not checkTimestamps(vals[0],vals[1],vals[2],vals[3]):
                notify("%s has been tampered with." % vals[0])

def check_uptime():
    endpoints = ["https://www.movsisyan.info"]

    with open("secret4.txt") as f:
        secret4 = f.read()

    engine = create_engine(
        f"mysql+mysqlconnector://{secret4}@movsisyan.info/movsisya_dashboard")
    
    with engine.connect() as connection:
        for endpoint in endpoints:
            start = datetime.now()
            r = requests.get(endpoint)
            end = datetime.now()

            ms = int((end - start).microseconds /1000)
            print(start, r.status_code, ms, endpoint)
            connection.execute(text(
                f"INSERT INTO `uptime_log`(`time`, `status_code`, `ms`, `endpoint`) \
                    VALUES ('{start.strftime('%Y/%m/%d %H:%M:%S')}','{r.status_code}','{ms}','{endpoint}')"))
            if r.status_code != 200:
                notify(f"Status code {r.status_code} while checking uptime of {endpoint}. {r.content}")
            if ms > 2000:
                notify(f"High response time {ms}ms while checking uptime of {endpoint}.")



try: 
    checkDecoyFiles()
    check_uptime()
except Exception as e:
    notify(e + " error in uptime checker.")


            