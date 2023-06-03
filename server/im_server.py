import os
import socket


class IMSelectServer:
    """输入法切换服务"""

    def __init__(self):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.bind(("0.0.0.0", 23333))

    def run(self):
        self.sock.listen(1)
        while True:
            conn, address = self.sock.accept()
            print("Connected by", address)
            data = conn.recv(1)
            print("Received", data)
            if data == b"1":
                self._switch_to_en()
            elif data == b"2":
                self._switch_to_zh()
            conn.close()

    def _switch_to_en(self):
        os.system("im-select com.apple.keylayout.ABC")

    def _switch_to_zh(self):
        pass


if __name__ == "__main__":
    IMSelectServer().run()
