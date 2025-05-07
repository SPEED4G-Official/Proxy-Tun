#!/bin/bash

set -e  # Dừng nếu có lỗi

echo "🔧 Cài đặt các gói hệ thống cần thiết..."
sudo yum install epel-release -y
sudo rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
sudo yum update -y
sudo yum groupinstall "Development Tools" -y
sudo yum install -y gcc make wget tar \
    openssl-devel bzip2-devel libffi-devel zlib-devel xz-devel \
    tesseract tesseract-langpack-eng

echo "⬇️ Tải Python 3.10.12..."
cd /usr/src
sudo wget https://www.python.org/ftp/python/3.10.12/Python-3.10.12.tgz
sudo tar xzf Python-3.10.12.tgz
cd Python-3.10.12

echo "⚙️ Biên dịch Python (có hỗ trợ OpenSSL)..."
sudo ./configure --enable-optimizations
sudo make altinstall

echo "🔗 Tạo symlink cho python3 và pip3..."
sudo ln -sf /usr/local/bin/python3.10 /usr/bin/python3
sudo ln -sf /usr/local/bin/pip3.10 /usr/bin/pip3

echo "✅ Cài pip và các thư viện Python..."
python3 -m ensurepip
pip3 install --upgrade pip
pip3 install flask pillow pytesseract
