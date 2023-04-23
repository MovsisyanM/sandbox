from urllib.parse import quote
import socket
import ssl

context = ssl.create_default_context()
target_host = "api.telegram.org"
target_port = 443
swo_sock = context.wrap_socket(socket.socket(
    socket.AF_INET, socket.SOCK_STREAM), server_hostname=target_host)

with open("secret2.txt") as f:
    secret2 = f.read()

with open("secret3.txt") as f:
    secret3 = f.read()

def notify(text):
    """Notifies master about an event"""
    global swo_sock
    url = f"/{secret2}/" + \
        f"sendMessage?chat_id={secret3}&text={quote(text)}"
    request = f"GET {url} HTTP/1.1\r\nHost: api.telegram.org\r\n\r\n"

    try:
        swo_sock.send(request.encode())
    except:
        try:
            swo_sock.close()
        except:
            pass

        swo_sock = context.wrap_socket(socket.socket(
            socket.AF_INET, socket.SOCK_STREAM), server_hostname=target_host)
        swo_sock.connect((target_host, target_port))
        swo_sock.send(request.encode())