import paramiko
import scp
import os
import requests
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed

def connect_proxy(proxy):
    try:
        proxies = {"http": f"http://{proxy}"}
        response = requests.get("http://chinhphu.vn", proxies=proxies, timeout=5)
        
        if response.status_code == 200:
            print(f"Proxy {proxy} Online.")
        else:
            print(f"Proxy {proxy} Offline")
    except Exception as e:
        print(f"Error Check Proxy {proxy}: {e}")

def check_proxy():
    proxy_file = "listproxy.txt"
    if os.path.exists(proxy_file):
        with open(proxy_file, 'r') as file:
            proxy_list = file.read().splitlines()
        for proxy in proxy_list:
            connect_proxy(proxy)
    else:
        print(f"List Proxy Not Found")
        exit(1)
    

def test_ssh_connection(ip, username, password):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    
    try:
        ssh.connect(ip, username=username, password=password, timeout=5)
        print(f"Test Connect SSH {ip} Success")
        return True
    except paramiko.AuthenticationException as auth_error:
        print(f"Test Connect SSH {ip} Error: {auth_error}")
        return False
    except Exception as e:
        print(f"Test Connect SSH {ip} Error: {e}")
        return False
    finally:
        ssh.close()

def run_ssh_command_and_download_file(hostname, port, username, password, command, remote_file_path, local_directory, usernamesquid, passwordsquid):
    ssh = paramiko.SSHClient()
    ssh.load_system_host_keys()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname, port=port, username=username, password=password)
    try:
        stdin, stdout, stderr = ssh.exec_command(command)
        print(f"Run VPS {hostname} ...")
        vps_directory = os.path.join(local_directory, hostname)
        os.makedirs(vps_directory, exist_ok=True)
        with scp.SCPClient(ssh.get_transport()) as scp_client:
            scp_client.get(remote_file_path, os.path.join(vps_directory, os.path.basename(remote_file_path)))
            listproxy_path = 'listproxy.txt'
            if os.path.exists(listproxy_path):
                with open(listproxy_path, 'a') as file:
                    file.write(f"{usernamesquid}:{passwordsquid}@{hostname}:3128\n")
            else:
                with open(listproxy_path, 'w') as file:
                    file.write(f"{usernamesquid}:{passwordsquid}@{hostname}:3128\n")
        print(f"Create Proxy Success IP {hostname}")

    except Exception as e:
        print(f"Error IP {hostname}: {e}")

    finally:
        ssh.close()

def create_proxry():
    ip_list_file = "ip.txt"
    passwordssh = input("Password List VPS: ")
    usernamesquid = input("Username Squid Proxy: ")
    passwordsquid = input("Password Squid Proxy: ")
    command_to_run = f"bash <(curl -Ls https://raw.githubusercontent.com/SPEED4G-Official/Proxy-Tun/main/install.sh) {usernamesquid} {passwordsquid}"
    with open(ip_list_file, 'r') as file:
        ip_list = file.read().splitlines()

    with ThreadPoolExecutor(max_workers=10) as executor:
        futures = {executor.submit(test_ssh_connection, ip, 'root', passwordssh): ip for ip in ip_list}

        for future in as_completed(futures):
            ip = futures[future]
            try:
                success = future.result()
                if not success:
                    exit(1)
            except Exception as e:
                print(f"Test Connect SSH {ip} Error: {e}")
    with ThreadPoolExecutor(max_workers=10) as executor:
        futures = {executor.submit(run_ssh_command_and_download_file, ip, 22, 'root', passwordssh, command_to_run, '/etc/qrcode.png', "qrcode", usernamesquid, passwordsquid): ip for ip in ip_list}

        for future in as_completed(futures):
            ip = futures[future]
            try:
                future.result()
            except Exception as e:
                print(f"Error IP {ip}: {e}")
def main():
    print("   1. Create Proxy")
    print("   2. Check Proxy")
    while True:
        try:
            choice = int(input("Please Choose: "))
            break 
        except ValueError:
            print("Invalid Selection")

    if choice == 1:
        create_proxry()
    elif choice == 2:
        check_proxy()
    else:
        print("Invalid Selection")

if __name__ == "__main__":
    main()
