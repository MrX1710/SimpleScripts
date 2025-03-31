#!/usr/bin/env bash

##COLOR##
RED='\033[1;31m'
NC='\033[0m'

IS_ROOT(){
    local ID
    ID=${UID}
    if [[ "${ID}" != 0 ]];
    then
        echo -e "${RED}Permission denied${NC}"
        exit 1
    fi
}

IS_INSTALLED(){
    if ! command -v dmidecode &>/dev/null;
    then
        echo "dmidecode is not installed"
        echo "Ubuntu/Debian: sudo apt install dmidecode"
        echo "Fedora: sudo dnf install dmidecode"
        echo "Arch: sudo pacman -S dmidecode"
        exit 127
    fi
}

MAIN(){
    IS_ROOT
    IS_INSTALLED

    #SYSTEM
    system_manufacturer=$(dmidecode -s system-manufacturer)
    system_product_name=$(dmidecode -s system-product-name)
    system_version=$(dmidecode -s system-version)
    system_serial_number=$(dmidecode -s system-serial-number)
    system_uuid=$(dmidecode -s system-uuid)
    system_sku_number=$(dmidecode -s system-sku-number)
    system_family=$(dmidecode -s system-family)
    echo -e "${RED}SYSTEM:${NC}"
    echo "System manufacturer: ${system_manufacturer}"
    echo "System product name: ${system_product_name}"
    echo "System version: ${system_version}"
    echo "System serial number: ${system_serial_number}"
    echo "System uuid: ${system_uuid}"
    echo "System sku number: ${system_sku_number}"
    echo "System family: ${system_family}"

    #MOTHERBOARD
    baseboard_manufacturer=$(dmidecode -s baseboard-manufacturer)
    baseboard_product_name=$(dmidecode -s baseboard-product-name)
    baseboard_version=$(dmidecode -s baseboard-version)
    baseboard_serial_number=$(dmidecode -s baseboard-serial-number)
    baseboard_asset_tag=$(dmidecode -s baseboard-asset-tag)
    echo -e "\n${RED}MOTHERBOARD:${NC}"
    echo "Motherboard manufacturer: ${baseboard_manufacturer}"
    echo "Motherboard product name: ${baseboard_product_name}"
    echo "Motherboard version: ${baseboard_version}"
    echo "Motherboard serial number: ${baseboard_serial_number}"
    echo "Motherboard asset tag: ${baseboard_asset_tag}"

    #CHASSIS
    chassis_manufacturer=$(dmidecode -s chassis-manufacturer)
    chassis_type=$(dmidecode -s chassis-type)
    chassis_version=$(dmidecode -s chassis-version)
    chassis_serial_number=$(dmidecode -s chassis-serial-number)
    chassis_asset_tag=$(dmidecode -s chassis-asset-tag)
    echo -e "\n${RED}CHASSIS:${NC}"
    echo "Chassis manufacturer: ${chassis_manufacturer}"
    echo "Chassis type: ${chassis_type}"
    echo "Chassis version: ${chassis_version}"
    echo "Chassis serial number: ${chassis_serial_number}"
    echo "Chassis asset tag: ${chassis_asset_tag}"

    #BIOS
    bios_vendor=$(dmidecode -s bios-vendor)
    bios_version=$(dmidecode -s bios-version)
    bios_release_date=$(dmidecode -s bios-release-date)
    bios_revision=$(dmidecode -s bios-revision)
    firmware_revision=$(dmidecode -s firmware-revision)
    echo -e "\n${RED}BIOS:${NC}"
    echo "BIOS vendor: ${bios_vendor}"
    echo "BIOS version: ${bios_version}"
    echo "BIOS release date: ${bios_release_date}"
    echo "BIOS revision: ${bios_revision}"
    echo "Firmware revision: ${firmware_revision}"

    #PROCESSOR
    processor_manufacturer=$(dmidecode -s processor-manufacturer)
    processor_version=$(dmidecode -s processor-version)
    processor_frequency=$(dmidecode -s processor-frequency)
    processor_family=$(dmidecode -s processor-family)
    echo -e "\n${RED}PROCESSOR:${NC}"
    echo "Processor manufacturer: ${processor_manufacturer}"
    echo "Processor version: ${processor_version}"
    echo "Processor frequency: ${processor_frequency}"
    echo "Processor family: ${processor_family}"
}

MAIN
