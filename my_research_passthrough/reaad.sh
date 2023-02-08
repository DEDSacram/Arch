 #!/bin/sh

modprobe vfio-pci

for dev in "$@"; do
    read -r vendor </sys/bus/pci/devices/$dev/vendor
    read -r device </sys/bus/pci/devices/$dev/device
    if [ -e /sys/bus/pci/devices/$dev/driver ]; then
        echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
    fi
    echo $vendor $device > /sys/bus/pci/drivers/vfio-pci/new_id
done
