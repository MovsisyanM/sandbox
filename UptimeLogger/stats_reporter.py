import requests
from datetime import datetime
from sqlalchemy import create_engine, text
from sqlalchemy.exc import ResourceClosedError
from quicknotifier import notify
import os

endpoints = ["https://www.movsisyan.info"]

with open("secret.txt") as f:
    engine = create_engine(
        f"mysql+mysqlconnector://{f.read()}@movsisyan.info/movsisya_dashboard")

sql_scripts = {}
for script in os.listdir("scripts"):
    with open("scripts/" + script) as f:
        sql_scripts[script] = f.read()

with engine.connect() as connection:
    for script in sorted(sql_scripts.keys()):
        try: 
            result = connection.execute(text(sql_scripts[script]))
            data = {key: [] for key in result.keys()}
            for i, row in enumerate(result):
                [data[list(data.keys())[col]].append(value)
                for col, value in enumerate(row)]
            
            if "ms" in data.keys():
                notify(f"Latency today:\n\t\tMin\t{str(data['ms'][0]).rjust(5)}ms\n\t\t25%" +
                       f"\t{str(data['ms'][1]).rjust(5)}ms\n\t\t50%\t{str(data['ms'][2]).rjust(5)}ms" +
                       f"\n\t\t75%\t{str(data['ms'][3]).rjust(5)}ms\n\t\tMax\t{str(data['ms'][4]).rjust(5)}ms")
                
            if "n_visits" in data.keys():
                notify("Number of visits:\n" + "\n".join([f"{path}  -  {str(count).rjust(5)}" for path, count in zip(data["path"], data["n_visits"])]))

            if "n_clicks" in data.keys():
                notify("Number of clicks:\n" + "\n".join([f"{url}  -  {str(count).rjust(5)}" for url, count in zip(data["url"], data["n_clicks"])]))
        except ResourceClosedError as e:
            continue