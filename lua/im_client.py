import socket


class IMSelectClient:
    """输入法切换客户端"""

    def __init__(self, host, port):
        self.host = host
        self.port = port

    def connect(self):
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.connect((self.host, self.port))
        return self

    def send(self, data):
        self.socket.send(data)
        return self

    def switch(self, im):
        self.send(im.encode())
        return self

    def close(self):
        self.socket.close()

    def __enter__(self):
        self.connect()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()


if __name__ == "__main__":
    IMSelectClient("127.0.0.1", 23333).connect().switch("1").close()
