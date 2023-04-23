import requests
from datetime import datetime
from sqlalchemy import create_engine, text
from quicknotifier import notify

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

            