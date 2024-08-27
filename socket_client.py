#!/usr/bin/env python3

import socket
import threading
import sys

# Default Unix domain socket path
sock_path = '/userdata/container/android_data/data_3/system/s9_sock'

# Check for input arguments
if len(sys.argv) > 1:
    if sys.argv[1] == 'num' and len(sys.argv) > 2:
        num = int(sys.argv[2])
        if 1 <= num <= 8:
            sock_path = f'/userdata/container/android_data/data_{num}/system/s9_sock'
        else:
            print("Error: num should be between 1 and 8")
            sys.exit(1)
    elif sys.argv[1] == 'path' and len(sys.argv) > 2:
        sock_path = sys.argv[2]
    else:
        print("Error: Invalid arguments")
        sys.exit(1)

print(f"Using socket path: {sock_path}")

#----------------------------
class UnixDomainSocketClient:
    def __init__(self, sock_path):
        self.sock_path = sock_path
        self.sock = None

    def connect(self):
        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.sock.connect(self.sock_path)
        print("Connected to server")

    def send_message(self, message):
        if self.sock:
            message_length = "{:04d}".format(len(message))
            full_message = f"{message_length}!{message}"
            self.sock.sendall(full_message.encode('utf-8'))
            print(f"Sent: {full_message}")

    def receive_messages(self):
        while True:
            try:
                response = self.sock.recv(1024)
                if response:
                    print("Received:", response.decode('utf-8'))
                else:
                    print("Server closed connection")
                    break
            except Exception as e:
                print(f"Error receiving message: {e}")
                break

    def start_receiving(self):
        receive_thread = threading.Thread(target=self.receive_messages)
        receive_thread.daemon = True
        receive_thread.start()

    def close(self):
        if self.sock:
            self.sock.close()
            print("Connection closed")

if __name__ == "__main__":
    client = UnixDomainSocketClient(sock_path)
    try:
        client.connect()
        client.send_message("CNCT")
        client.start_receiving()

        # 发送其他消息
        client.send_message("HELLO")
        
        # 保持程序运行，等待接收消息
        while True:
            user_input = input("Enter message to send (or 'exit' to quit): ")
            if user_input.lower() == 'exit':
                break
            client.send_message(user_input)
    finally:
        client.close()






