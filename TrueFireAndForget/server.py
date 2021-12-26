from flask import Flask
import time
import socket

app = Flask(__name__)
target_host = "127.0.0.1"
target_port = 5859
request = f"GET / HTTP/1.1\r\n\r\n"


@app.route('/')
def hello_world():
    print("Recieved request by server")

    write_only_client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    write_only_client.connect((target_host, target_port))
    write_only_client.send(request.encode())
    write_only_client.close()

    return 'Hello World'


# main driver function
if __name__ == '__main__':
    app.run()
