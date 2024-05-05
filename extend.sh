if cat /etc/os-release | grep PRETTY_NAME | grep "Debian" > /dev/null; then
    parted /dev/sda resizepart $(blkid|grep /dev/sda|sort|tail -n 1|cut -c 9) 100%
    pvresize /dev/sda$(blkid|grep /dev/sda|sort|tail -n 1|cut -c 9)
    lvextend -l +100%FREE /dev/vg0/lv-0
    xfs_growfs /dev/vg0/lv-0
    clear
    echo -e " Upgrade Disk Success. VPS Restart After 3 Seconds"
    sleep 3
    reboot
elif cat /etc/os-release | grep PRETTY_NAME | grep "Ubuntu" > /dev/null; then
    parted /dev/sda resizepart $(blkid|grep /dev/sda|sort|tail -n 1|cut -c 9) 100%
    pvresize /dev/sda$(blkid|grep /dev/sda|sort|tail -n 1|cut -c 9)
    lvextend -l +100%FREE /dev/vg0/lv-0
    resize2fs /dev/vg0/lv-0
    clear
    echo -e " Upgrade Disk Success. VPS Restart After 3 Seconds"
    sleep 3
elif cat /etc/os-release | grep PRETTY_NAME | grep "CentOS" > /dev/null; then
    parted /dev/sda resizepart $(blkid|grep /dev/sda|sort|tail -n 1|cut -c 9) 100%
    pvresize /dev/sda$(blkid|grep /dev/sda|sort|tail -n 1|cut -c 9)
    lvextend -l +100%FREE /dev/centos/root
    xfs_growfs /dev/centos/root
    clear
    echo -e " Upgrade Disk Success. VPS Restart After 3 Seconds"
    sleep 3
elif cat /etc/os-release | grep PRETTY_NAME | grep "AlmaLinux" > /dev/null; then
    parted /dev/sda resizepart $(blkid|grep /dev/sda|sort|tail -n 1|cut -c 9) 100%
    pvresize /dev/sda$(blkid|grep /dev/sda|sort|tail -n 1|cut -c 9)
    lvextend -l +100%FREE /dev/vg0/lv-0
    xfs_growfs /dev/centos/root
    clear
    echo -e " Upgrade Disk Success. VPS Restart After 3 Seconds"
    sleep 3
else
    echo -e "Hệ Điều Hành Không Hợp Lệ"
fi
