from flask import Flask
import time
import datetime


app = Flask(__name__)


@app.route('/')
def hello_world():
    print(f"Recieved request by third party app at {datetime.datetime.now()}")
    # doing the sleeping server-side to simulate an accurate client-side processor load
    time.sleep(3)
    return 'Get request processed by third party app'


# main driver function
if __name__ == '__main__':
    app.run(port=5859)
